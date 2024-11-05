class ProductsController < ApplicationController
  # Hiển thị danh sách tất cả các sản phẩm
  def index

  end

  # Hiển thị một sản phẩm cụ thể
  def show
    @product = Product.find(params[:id])
  end

  # Hiển thị form tạo sản phẩm mới
  def new
    @product = Product.new
  end

  # Tạo sản phẩm mới
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Sản phẩm đã được tạo thành công.'
    else
      render :new
    end
  end

  # Hiển thị form chỉnh sửa sản phẩm
  def edit
    @product = Product.find(params[:id])
  end

  # Cập nhật sản phẩm
  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product, notice: 'Sản phẩm đã được cập nhật thành công.'
    else
      render :edit
    end
  end

  # Xóa sản phẩm
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: 'Sản phẩm đã bị xóa.'
  end

  private

  # Chỉ cho phép các trường cần thiết
  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :image_url)
  end
end
