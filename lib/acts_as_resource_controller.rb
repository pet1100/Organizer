module ActsAsResourceController
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def acts_as_resource_controller(options = {})
      singular_name = options[:singular_name] || controller_name.singularize
      class_name = options[:class_name] || singular_name.camelize
      plural_name = options[:plural_name] || singular_name.pluralize
      module_eval <<-"end_eval", __FILE__, __LINE__
      def index
        @search = scope.ransack(params[:q] || {s: '#{options[:default_search]}'})
        @#{plural_name} = @search.result
        @page_title = #{class_name}.model_name.human(:count=>2)
      end

      def show
        @#{singular_name} = scope.find(params[:id])
        @page_title = #{class_name}.model_name.human
      end

      def new
        @#{singular_name} = scope.new
        @page_title = translated_title('helpers.titles.new')
        render "shared/new"
      end

      def edit
        @#{singular_name} = scope.find(params[:id])
        @page_title = translated_title('helpers.titles.edit')
        render "shared/edit"
      end

      def create
        @#{singular_name} = scope.new(permitted_attributes)
        if @#{singular_name}.save
          redirect_to @#{singular_name}, :notice=>translated_title("helpers.flash.created")
        else
          @page_title = translated_title('helpers.titles.new')
          render "shared/new"
        end
      end

      def update
        @#{singular_name} = scope.find(params[:id])
        if @#{singular_name}.update(permitted_attributes)
          after_update_path
        else
          @page_title = translated_title('helpers.titles.edit')
          render "shared/edit"
        end
      end

      def destroy
        @#{singular_name} = scope.find(params[:id])
        @#{singular_name}.destroy
        redirect_to :action=>'index', :notice=>translated_title("helpers.flash.destroyed")
      end

      private

      def translated_title tag
        t(tag, :model=>#{class_name}.model_name.human).upcase_first
      end

      def scope
        #{class_name}.all
      end

      def after_update_path
        redirect_to @#{singular_name}, :notice=>translated_title("helpers.flash.updated")
      end

      end_eval
    end
  end
end
