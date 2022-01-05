desc "Prepare app before anything else happens"
task prepare_app: :enviroment do
  Rake::Task['build_shopping_cart'].invoke
  Rake::Task['load_products_json'].invoke
end


desc "Ensure at least one shopping cart object exists."
task build_shopping_cart: :environment do
  if ShoppingCart.count == 0
    ShoppingCart.create!
  end
end

desc "Attempt to create a Product from each entry in products.json"
task load_products_json: :environment do
  file = File.read Rails.root.join('products.json')
  products_json = JSON.parse(file)

  new_products_count = 0
  existing_products_count = 0

  products_json.each do |product_json|
    product = Product.find_or_initialize_by(id: product_json['uuid']) do |p|
      p.name = product_json['name']
      p.price = product_json['price'].to_f
    end

    new_record = product.new_record?

    if product.save
      if new_record
        new_products_count += 1
      else
        existing_products_count += 1
      end
    end
  end

  puts "products.json loaded into DB, #{new_products_count} products created, #{existing_products_count} products updated"
end