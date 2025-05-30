<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateLaporanJalanTable extends Migration
{
    public function up()
    {
        Schema::create('laporan_jalan', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->string('lokasi');
            $table->double('latitude');
            $table->double('longitude');
            $table->enum('jenis_rusak', ['jalan rusak ringan', 'jalan rusak berat']);
            $table->text('deskripsi')->nullable();
            $table->string('foto')->nullable();
            $table->enum('status', ['menunggu', 'dalam_proses', 'selesai'])->default('menunggu');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('laporan_jalan');
    }
} 