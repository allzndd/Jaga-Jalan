<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class EmailVerification extends Mailable
{
    use Queueable, SerializesModels;

    public $user;
    public $verificationUrl;

    public function __construct($user, $verificationUrl)
    {
        $this->user = $user;
        $this->verificationUrl = $verificationUrl;
    }

    public function build()
    {
        $this->verificationUrl = route('email.verify', ['token' => $this->user->verification_token]);
        
        return $this->view('emails.verification')
                    ->subject('Verifikasi Email Anda - Jaga Jalan');
    }
} 