module Jekyll

  class CategoryPage < Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'category_index.html')

      self.data['iscat'] = true

      if category != 'index.html'
        self.data['category'] = category
        category_title_prefix = site.config['category_title_prefix'] || 'Category: '
        self.data['title'] = "#{category_title_prefix}#{category}"
        self.data['category_root'] = false # juzraai
      else
        self.data['title'] = 'Categories:'
        self.data['category_root'] = true # juzraai
      end

    end
  end

  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      dir = site.config['category_dir'] || 'categories'
      if site.layouts.key? 'category_index'
        site.categories.each_key do |category|
          newpage = CategoryPage.new(site, site.source, File.join(dir, category), category)
          site.pages << newpage
          #categories << newpage.title
        end
      end
      site.pages << CategoryPage.new(site, site.source, dir, "index.html")
    end
  end

end
