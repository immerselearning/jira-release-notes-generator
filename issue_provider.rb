class IssueProvider
  def raise_method_error(method)
    raise(
      NoMethodError,
      "Non implemented method #{method} from interface IssueProvider"
    )
  end

  def version
    raise_method_error 'get_version'
  end

  def open_bugs
    raise_method_error 'get_backlog'
  end
end
