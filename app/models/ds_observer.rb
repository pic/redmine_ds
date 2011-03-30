class DsObserver <  ActiveRecord::Observer
  observe :journal, :issue

  def split_line(s, limit = 120)
    lines = []
    i = 0
    r = s
    while true
      i = r.index(/ /, limit)
      if i.nil?
        lines << r
        break
      else
        p = r[0...i]
        lines <<  p
        r = r[(i+1)..-1].sub(/^ +/, '')
      end
    end
    lines
  end
  def split(s, limit = 120)
    s.split(/\n|\r\n/).inject([]) do |ls, l|
      ls += split_line(l, limit)
    end
  end

  def add_line_breaks(s, limit = 120)
    split(s, limit).join("\n")
  end

  def before_save(observed)
    %w(description notes).each do |f|
      if observed.respond_to?(f)
        observed.send("#{f}=", add_line_breaks(observed.send(f))) if observed.send("#{f}_changed?")
      end
    end
  end

  def reload_observer
    observed_classes.each do |klass|
      klass.name.constantize.add_observer(self)
    end
  end
  
end

