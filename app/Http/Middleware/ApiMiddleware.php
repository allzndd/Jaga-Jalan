<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class ApiMiddleware
{
    public function handle(Request $request, Closure $next)
    {
        // Disable session and CSRF for API routes
        config(['session.driver' => 'array']);
        
        return $next($request);
    }
} 