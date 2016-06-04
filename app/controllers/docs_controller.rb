class DocsController < ApplicationController

	before_action :find_doc, only: [:show, :edit, :update, :destroy]

	def index
		@docs = Doc.where(user_id: current_user)
	end

	def show
	end

	def new
		@doc = current_user.docs.build

	end

	# Does not have a view for itself
	def create
		@doc = current_user.docs.build(doc_params)

		if @doc.save
			redirect_to @doc #redirect refreshes page, input lost
		else
			render 'new' # keeps input, ready to reattempt save
		end
	end

	# Only responsible for view file.
	def edit
	end

	# Does not have a view itself. Makes changes to databse through edit view.
	# Fetches doc with the before action and then change the params and updates the doc.
	def update
		if @doc.update(doc_params)
			redirect_to @doc
		else
			render 'edit' # Again renders retains filled fields
		end
	end

	def destroy
		@doc.destroy
		redirect_to docs_path
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
