# Assumes votes association, with a bool 'vote' column
# This module is accessible by all models (not controllers)
module Voteable
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def total_votes
      self.votes.where(vote: true).size - self.votes.where(vote: false).size
    end
  end
end