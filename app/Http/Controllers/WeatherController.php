<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;

class WeatherController extends Controller
{
    private $apiKey;

    public function __construct()
    {
        $this->apiKey = config('services.weatherapi.key');
    }

    public function getWeather(Request $request)
    {
        try {
            $lat = $request->query('lat');
            $lon = $request->query('lon');

            Log::info('Weather request params:', [
                'lat' => $lat,
                'lon' => $lon
            ]);

            // Get weather data from WeatherAPI.com
            $response = Http::get("http://api.weatherapi.com/v1/forecast.json", [
                'key' => $this->apiKey,
                'q' => "$lat,$lon",
                'days' => 1,
                'aqi' => 'no',
                'lang' => 'id'
            ]);

            Log::info('WeatherAPI response:', [
                'status' => $response->status(),
                'body' => $response->body()
            ]);

            if (!$response->successful()) {
                throw new \Exception('Failed to fetch weather data: ' . $response->body());
            }

            $weatherData = $response->json();
            $currentHour = now()->format('H');
            
            // Get current weather from hourly forecast
            $currentWeather = collect($weatherData['forecast']['forecastday'][0]['hour'])
                ->first(function($hour) use ($currentHour) {
                    return date('H', strtotime($hour['time'])) == $currentHour;
                });
            
            return response()->json([
                'success' => true,
                'location' => [
                    'name' => $weatherData['location']['name'],
                    'state' => $weatherData['location']['region'],
                    'country' => $weatherData['location']['country'],
                    'lat' => $weatherData['location']['lat'],
                    'lon' => $weatherData['location']['lon']
                ],
                'current_weather' => [
                    'datetime' => $currentWeather['time'],
                    'temp' => round($currentWeather['temp_c']),
                    'humidity' => $currentWeather['humidity'],
                    'description' => $currentWeather['condition']['text'],
                    'icon' => $currentWeather['condition']['icon'],
                ],
                'weather' => array_map(function($hour) {
                    return [
                        'datetime' => $hour['time'],
                        'temp' => round($hour['temp_c']),
                        'humidity' => $hour['humidity'],
                        'description' => $hour['condition']['text'],
                        'icon' => $hour['condition']['icon'],
                    ];
                }, $weatherData['forecast']['forecastday'][0]['hour'])
            ]);
        } catch (\Exception $e) {
            Log::error('Weather API error:', [
                'message' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Gagal mengambil data cuaca',
                'error' => $e->getMessage()
            ], 500);
        }
    }
} 