class JobDecorator

  def initialize(jobs)
    @jobs = jobs
  end

  def get_by_request(q, type, val, a1, a2)
    if q.present? && type.present? && val.present? && a1.present?
      query_type_remote_and_amount(q, type, val, a1, a2)

    elsif q.present? && type.present? && val.present?
      query_type_and_remote(q, type, val)

    elsif q.present? && type.present? && a1.present?
      query_type_and_amount(q, type, a1, a2)

    elsif q.present? && val.present? && a1.present?
      query_remote_and_amount(q, val, a1, a2)

    elsif type.present? && val.present? && a1.present?
      type_remote_and_amount(type, val, a1, a2)

    elsif q.present? && type.present?
      query_and_type(q, type)

    elsif q.present? && val.present?
      query_and_remote(q, val)

    elsif q.present? && a1.present?
      query_and_amount(q, a1, a2)

    elsif type.present? && val.present?
      type_and_remote(type, val)

    elsif type.present? && a1.present?
      type_and_amount(type, a1, a2)

    elsif val.present? && a1.present?
      remote_and_amount(val, a1, a2)

    elsif q.present?
      find_by_query(q)

    elsif type.present?
      find_by_type(type)

    elsif val.present?
      find_by_remote(val)

    elsif a1.present?
      find_by_amount(a1, a2)

    else
      @jobs
    end
  end

  private

  def find_by_query(q)
    Job.search_by_title(q)
  end

  def find_by_type(type)
    Job.filter_by_type(type)
  end

  def find_by_remote(val)
    Job.filter_by_remote(val)
  end

  def find_by_amount(a1, a2)
    Job.filter_by_amount_range(a1, a2)
  end

  def query_and_type(q, type)
    find_by_query(q).filter_by_type(type)
  end

  def query_and_remote(q, val)
    find_by_query(q).filter_by_remote(val)
  end

  def query_and_amount(q, a1, a2)
    find_by_query(q).filter_by_amount_range(a1, a2)
  end

  def type_and_remote(type, val)
    find_by_type(type).filter_by_remote(val)
  end

  def type_and_amount(type, a1, a2)
    find_by_type(type).filter_by_amount_range(a1, a2)
  end

  def remote_and_amount(val, a1, a2)
    find_by_remote(val).filter_by_amount_range(a1, a2)
  end

  def query_type_and_remote(q, type, val)
    query_and_type(q, type).filter_by_remote(val)
  end

  def query_type_and_amount(q, type, a1, a2)
    query_and_type(q, type).filter_by_amount_range(a1, a2)
  end

  def query_remote_and_amount(q, val, a1, a2)
    query_and_remote(q, val).filter_by_amount_range(a1, a2)
  end

  def type_remote_and_amount(type, val, a1, a2)
    type_and_remote(type, val).filter_by_amount_range(a1, a2)
  end

  def query_type_remote_and_amount(q, type, val, a1, a2)
    query_type_and_remote(q, type, val).filter_by_amount_range(a1, a2)
  end
end
