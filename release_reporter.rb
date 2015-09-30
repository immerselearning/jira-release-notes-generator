class ReleaseReporter
  def raise_method_error(method)
    raise NoMethodError, "Non implemented method #{method} from interface ReleaseReporter"
  end

  def open_section(name)
    self.raise_method_error "open_section"
  end

  def close_section
    self.raise_method_error "close_section"
  end

  def <<(issue)
    self.raise_method_error "<<"
  end
end
