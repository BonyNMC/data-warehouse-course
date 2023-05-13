WITH dim_product__source AS
(SELECT
  *
FROM `vit-lam-data.wide_world_importers.warehouse__stock_items` 
)

, dim_product__rename_column AS(
SELECT 
  stock_item_id AS product_key
  , stock_item_name AS product_name
  , brand AS brand_name
  , is_chiller_stock AS is_chiller_stock
  , supplier_id AS supplier_key
FROM dim_product__source
)

, dim_product__cast_type AS (
SELECT 
  CAST(product_key AS INTEGER) AS product_key
  , CAST(product_name AS STRING) AS product_name
  , CAST(brand_name AS STRING) AS brand_name
  , CAST(is_chiller_stock AS BOOLEAN) AS is_chiller_stock
  , CAST(supplier_key AS INTEGER) AS supplier_key
FROM dim_product__rename_column
)
SELECT 
  dim_product.product_key
  , dim_product.supplier_key
  , dim_product.product_name
  , dim_product.brand_name
  , dim_product.is_chiller_stock
  , dim_supplier.supplier_name
FROM dim_product__cast_type AS dim_product
LEFT JOIN {{ ref('dim_supplier') }} AS dim_supplier
ON dim_product.supplier_key = dim_supplier.supplier_key