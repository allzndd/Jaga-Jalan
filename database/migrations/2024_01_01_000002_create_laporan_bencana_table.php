<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateLaporanBencanaTable extends Migration
{
    public function up()
    {
        Schema::create('laporan_bencana', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->string('lokasi');
            $table->double('latitude');
            $table->double('longitude');
            $table->enum('jenis_bencana', [
                'Banjir',
                'Longsor', 
                'Erupsi',
                'Lahar Panas',
                'Lahar Dingin',
                'Gempa',
                'Angin Topan'
            ]);
            $table->text('deskripsi')->nullable();
            $table->string('foto')->nullable();
            $table->enum('status', ['menunggu', 'dalam_proses', 'selesai'])->default('menunggu');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('laporan_bencana');
    }
} 