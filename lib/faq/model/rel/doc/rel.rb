# encoding: utf-8
module Faq::Model::Rel::Doc::Rel
  def rel_docs(cond = {})
    docs = []
    ids = rel_doc_ids.to_s.split(' ').uniq
    return docs if ids.size == 0
    ids.each do |id|
      cond[:id] = id
      doc = Faq::Doc.find_by(cond)
      docs << doc if doc
    end
    docs
  end

  def in_rel_doc_ids
    unless val = @in_rel_doc_ids
      @in_rel_doc_ids = rel_doc_ids.to_s.split(' ').uniq
    end
    @in_rel_doc_ids
  end

  def in_rel_doc_ids=(ids)
    _ids = []
    if ids.class == Array
      ids.each { |val| _ids << val }
      self.rel_doc_ids = _ids.join(' ')
    elsif ids.class == Hash || ids.class == HashWithIndifferentAccess || ids.class == ActionController::Parameters
      ids.each { |_key, val| _ids << val }
      self.rel_doc_ids = _ids.join(' ')
    else
      self.rel_doc_ids = ids
    end
  end
end
