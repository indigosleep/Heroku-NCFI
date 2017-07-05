def skuConvert(indigoSku)
  barnhardtSkus = {
    "C-MAT-TW-01": "IND-CL-TW",
    "C-MAT-TX-01": "IND-CL-TL",
    "C-MAT-FL-01": "IND-CL-FU",
    "C-MAT-QU-01": "IND-CL-QU",
    "C-MAT-KG-01": "IND-CL-KG",
    "C-MAT-CK-01": "IND-CL-CK",

    "L-MAT-TW-01": "IND-LU-TW",
    "L-MAT-TX-01": "IND-LU-TL",
    "L-MAT-FL-01": "IND-LU-FU",
    "L-MAT-QU-01": "IND-LU-QU",
    "L-MAT-KG-01": "IND-LU-KG",
    "L-MAT-CK-01": "IND-LU-CK"
  }

  return barnhardtSkus[indigoSku]
end


merfSku = "C-MAT-FL-01"

bhSku = skuConvert(merfSku.to_sym)

puts(bhSku)
