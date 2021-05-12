<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function get(Request $request)
    {
        if (empty($request->id)) {
            $product = Product::all();
        } else {
            $product = Product::where('id',$request->id)->first();
        }
        return $this->responseJson(200,"Success",$product);
    }

    public function post(Request $request)
    {
        //validate incoming request 
        $this->validate($request, [
            'user_id' => 'required',
            'name' => 'required|string',
            'price' => 'required|integer',
        ]);

        try {

            $product = new Product;
            $product->user_id = $request->input('user_id');
            $product->name = $request->input('name');
            $product->price = $request->input('price');

            $product->save();

            //return successful response
            return $this->responseJson(200,'Success', $product);

        } catch (\Exception $e) {
            //return error message
            return $this->responseJson(409,'Product Registration Failed!', $e);
        }
    }

    public function put(Request $request)
    {
        //validate incoming request 
        $this->validate($request, [
            'user_id' => 'required',
            'product_id' => 'required',
            'name' => 'required|string',
            'price' => 'required|integer',
        ]);

        try {

            $product = Product::where('id',$request->product_id);
            $product->update([
                'user_id' => $request->input('user_id'),
                'name' => $request->input('name'),
                'price' => $request->input('price'),
            ]);

            //return successful response
            return $this->responseJson(200,'Success', $product);

        } catch (\Exception $e) {
            //return error message
            return $this->responseJson(409,'Product Registration Failed!', $e);
        }
    }

    public function delete(Request $request)
    {
        try {

            $product = Product::findOrFail($request->product_id)->delete();

            //return successful response
            return $this->responseJson(200,'Success', $product);

        } catch (\Exception $e) {
            //return error message
            return $this->responseJson(409,'Product Registration Failed!', $e);
        }
    }
}
