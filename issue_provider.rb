class IssueProvider
  def raise_method_error(method)
    raise NoMethodError, "Non implemented method #{method} from interface IssueProvider"
  end

  def get_version
    self.raise_method_error "get_version"
  end

  def get_open_bugs
    self.raise_method_error "get_backlog"
  end
end
