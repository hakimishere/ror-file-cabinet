class DocsController < ApplicationController

	before_action :find_doc, only: [:show, :edit, :update, :destroy]

	def index
		@docs = Doc.all.order("created_at DESC")
	end

	def show
	end

	def new
		@doc = Doc.new
	end

	# Does not have a view for itself
	def create
		@doc = Doc.new(doc_params)

		if @doc.save
			redirect_to @doc #redirect refreshes page, input lost
		else
			render 'new' # keeps input, ready to reattempt save
		end
	end

	def edit
	end

	# Does not have a view itself. Makes changes to databse through edit view.
	def update
	end

	def destroy
	end

	private

	def find_doc
		@doc = Doc.find(params[:id])
	end

	def doc_params
		# Requires the Doc model and permit two attributes
		params.require(:doc).permit(:title, :content)
	end

end
