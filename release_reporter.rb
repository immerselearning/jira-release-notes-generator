class ReleaseReporter
  def raise_method_error(method)
    raise(
      NoMethodError,
      "Non implemented method #{method} from interface #{name}"
    )
  end

  def open_section(_name)
    raise_method_error 'open_section'
  end

  def close_section
    raise_method_error 'close_section'
  end

  def <<(_issue)
    raise_method_error '<<'
  end
end
