<?php

namespace App\Models;

use CodeIgniter\Model;

class DiskonModel extends Model
{
    protected $table = 'diskon';
    protected $primaryKey = 'id';
    protected $allowedFields = [
        'Kode_voucher', 'tanggal_mulai_berlaku', 'Tanggal_akhir_berlaku', 'Besar_diskon', 'aktif'
    ];

    protected $returnType = 'App\Entities\Kategori';
    protected $useTimestamps = false;
}
