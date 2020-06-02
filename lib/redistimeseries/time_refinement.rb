module RefineTime
  refine Time do
    def to_ms
      (self.to_f * 1000.0).to_i
    end
  end
end
