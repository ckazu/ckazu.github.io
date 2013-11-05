---
title: "rake notes で，spec, js, coffee, scss, haml, slim のファイルも対象にする"
date: 2011-12-06
tags: rails
---

```ruby

class SourceAnnotationExtractor
  def find_with_custom_directories
    find_without_custom_directories(%w|app lib spec|)
  end
  alias_method_chain :find, :custom_directories

  def find_in_with_custom_files(dir)
    results = find_in_without_custom_files(dir)

    Dir.glob("#{dir}/*") do |item|
      next if File.basename(item)[0] == ?.

      if File.directory?(item)
        results.update(find_in(item))
      elsif item =~ /\.(coffee)$/
        results.update(extract_annotations_from(item, /#\s*\[?(#{tag})\]?\s*:?\s*(.*)$/))
      elsif item =~ /\.(js|scss)$/
        results.update(extract_annotations_from(item, /\/\/\s*\[?(#{tag})\]?\s*:?\s*(.*)$/))
      elsif item =~ /\.(haml)$/
        results.update(extract_annotations_from(item, /[\/|(\-\#)]\s*\[?(#{tag})\]?\s*:?\s*(.*)$/))
      elsif item =~ /\.(slim)$/
        results.update(extract_annotations_from(item, /\/\!?\s*\[?(#{tag})\]?\s*:?\s*(.*)$/))
      end
    end
    results
  end
  alias_method_chain :find_in, :custom_files
end
```
