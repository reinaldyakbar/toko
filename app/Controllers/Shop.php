<?php

namespace App\Controllers;

use App\Models\DiskonModel;

class Shop extends BaseController
{
    private $url = "https://api.rajaongkir.com/starter/";
	private $apiKey = "96f4e938e738a8591585c27c6e72ce95";

    public function __construct()
	{ 
        helper('form'); 
		$this->session = session();
        $this->diskon = new DiskonModel();

	}

	public function index()
	{
		$barangModel = new \App\Models\BarangModel();
        $kategoriModel = new \App\Models\KategoriModel();
        // $diskonModel = new \App\Models\DiskonModel();
		$barang = $barangModel->select('barang.*, kategori.nama AS kategori')->join('kategori', 'barang.id_kategori=kategori.id')->findAll();
        $kategori = $kategoriModel->findAll();
        $diskon = $this->diskon->findAll();
		return view('shop/index',[
			'barangs' => $barang,
            'kategoris' => $kategori,
            'diskon' => $diskon,
		]);
	}

    public function category()
	{
		$id = $this->request->uri->getSegment(3);

		$barangModel = new \App\Models\BarangModel(); 
        $kategoriModel = new \App\Models\KategoriModel();
		$barang = $barangModel->select('barang.*, kategori.nama AS kategori')->where('id_kategori', $id)->join('kategori', 'barang.id_kategori=kategori.id')->where('id_kategori', $id)->findAll(); 
        $kategori = $kategoriModel->findAll();
		return view('shop/index',[
			'barangs' => $barang, 
            'kategoris' => $kategori,
		]);
	} 

    public function product()
	{
		$id = $this->request->uri->getSegment(3);

		$barangModel = new \App\Models\BarangModel(); 
        $kategoriModel = new \App\Models\KategoriModel();
        $komentarModel = new \App\Models\KomentarModel();
        $diskonModel = new \App\Models\DiskonModel();
		$barang = $barangModel->find($id); 
        $kategori = $kategoriModel->findAll();
        $komentar = $komentarModel->select('komentar.*, user.username')->where('id_barang', $id)->join('user', 'komentar.id_user=user.id')->where('id_barang', $id)->findAll();
        $diskon = $diskonModel->findAll();
        $diskons = $diskonModel->find($id);
		$provinsi = $this->rajaongkir('province');
        
		return view('shop/product',[
            'diskon' => $diskon,
            'diskons' =>  $diskons,
			'barang' => $barang, 
            'kategoris' => $kategori,
            'komentars' => $komentar,
            'provinsi'=> json_decode($provinsi)->rajaongkir->results,
		]);
	}
    
    public function getCity()
	{
		if ($this->request->isAJAX()){
			$id_province = $this->request->getGet('id_province');
			$data = $this->rajaongkir('city', $id_province);
			return $this->response->setJSON($data);
		}
	}

	public function getCost()
	{
		if ($this->request->isAJAX()){
			$origin = $this->request->getGet('origin');
			$destination = $this->request->getGet('destination');
			$weight = $this->request->getGet('weight');
			$courier = $this->request->getGet('courier');
			$data = $this->rajaongkircost($origin, $destination, $weight, $courier);
			return $this->response->setJSON($data);
		}
	}

	private function rajaongkircost($origin, $destination, $weight, $courier)
	{

		$curl = curl_init();

		curl_setopt_array($curl, array(
		  CURLOPT_URL => "https://api.rajaongkir.com/starter/cost",
		  CURLOPT_RETURNTRANSFER => true,
		  CURLOPT_ENCODING => "",
		  CURLOPT_MAXREDIRS => 10,
		  CURLOPT_TIMEOUT => 30,
		  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		  CURLOPT_CUSTOMREQUEST => "POST",
		  CURLOPT_POSTFIELDS => "origin=".$origin."&destination=".$destination."&weight=".$weight."&courier=".$courier,
		  CURLOPT_HTTPHEADER => array(
		    "content-type: application/x-www-form-urlencoded",
		    "key: ".$this->apiKey,
		  ),
		));

		$response = curl_exec($curl);
		$err = curl_error($curl);

		curl_close($curl);

		return $response;
	}


	private function rajaongkir($method, $id_province=null)
	{
		$endPoint = $this->url.$method;

		if($id_province!=null)
		{
			$endPoint = $endPoint."?province=".$id_province;
		}

		$curl = curl_init();

		curl_setopt_array($curl, array(
		  CURLOPT_URL => $endPoint,
		  CURLOPT_RETURNTRANSFER => true,
		  CURLOPT_ENCODING => "",
		  CURLOPT_MAXREDIRS => 10,
		  CURLOPT_TIMEOUT => 30,
		  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		  CURLOPT_CUSTOMREQUEST => "GET",
		  CURLOPT_HTTPHEADER => array(
		    "key: ".$this->apiKey
		  ),
		));

		$response = curl_exec($curl);
		$err = curl_error($curl);

		curl_close($curl);

		return $response;
	} 
    public function diskon()
    {
        $diskonModel = new \App\Models\DiskonModel();
        $diskon = $diskonModel->findAll();
        // $barang = $this->barang->select('barang.*, kategori.nama AS kategori')->where('id_kategori', $id)->join('kategori', 'barang.id_kategori=kategori.id')->where('id_kategori', $id)->findAll();
        // $kategori = $this->kategoriModel->findAll();
        return view('shop/index', [
            'diskon' => $diskon,
        ]);
    }
}