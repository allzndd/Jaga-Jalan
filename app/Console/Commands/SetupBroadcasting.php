<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;

class SetupBroadcasting extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'setup:broadcasting';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Setup broadcasting configuration for real-time notifications';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $this->info('Setting up broadcasting for real-time notifications...');

        // 1. Update .env file
        $this->updateEnvFile();

        // 2. Clear configuration cache
        $this->call('config:clear');
        
        // 3. Clear application cache
        $this->call('cache:clear');

        // 4. Publish vendor files if needed
        if ($this->confirm('Do you want to publish vendor files for Laravel Echo and Pusher?', true)) {
            $this->call('vendor:publish', ['--provider' => 'Laravel\Ui\UiServiceProvider']);
        }

        $this->info('Broadcasting setup completed successfully!');
        $this->info('Remember to set your PUSHER_APP_ID, PUSHER_APP_SECRET in your .env file');
        $this->info('PUSHER_APP_KEY is already set as d82783da6b2fe32e1dec');
        $this->info('PUSHER_APP_CLUSTER is already set as ap1');

        return 0;
    }

    /**
     * Update the .env file with broadcasting configuration
     */
    protected function updateEnvFile()
    {
        $envPath = base_path('.env');
        
        if (File::exists($envPath)) {
            $envContent = File::get($envPath);
            
            // Check if broadcasting driver is already set
            if (strpos($envContent, 'BROADCAST_DRIVER=') === false) {
                $this->info('Adding BROADCAST_DRIVER to .env file');
                $envContent .= "\nBROADCAST_DRIVER=pusher\n";
            } else {
                $this->info('Updating BROADCAST_DRIVER in .env file');
                $envContent = preg_replace('/BROADCAST_DRIVER=(.*)/i', 'BROADCAST_DRIVER=pusher', $envContent);
            }
            
            // Check if Pusher credentials are already set
            if (strpos($envContent, 'PUSHER_APP_KEY=') === false) {
                $this->info('Adding Pusher configuration to .env file');
                $envContent .= "PUSHER_APP_ID=\n";
                $envContent .= "PUSHER_APP_KEY=d82783da6b2fe32e1dec\n";
                $envContent .= "PUSHER_APP_SECRET=\n";
                $envContent .= "PUSHER_APP_CLUSTER=ap1\n";
            } else {
                $this->info('Updating Pusher configuration in .env file');
                $envContent = preg_replace('/PUSHER_APP_KEY=(.*)/i', 'PUSHER_APP_KEY=d82783da6b2fe32e1dec', $envContent);
                $envContent = preg_replace('/PUSHER_APP_CLUSTER=(.*)/i', 'PUSHER_APP_CLUSTER=ap1', $envContent);
            }
            
            File::put($envPath, $envContent);
            $this->info('.env file has been updated.');
        } else {
            $this->error('.env file does not exist!');
        }
    }
} 