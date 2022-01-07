class LawyersController < ApplicationController
  def index
    require "net/http"

    url = "https://api.workon.law/technical_challenge/get_lawyers"
    resp = Net::HTTP.get_response(URI.parse(url))
    candidates = JSON.parse(resp.body)['candidates']
    email = JSON.parse(request.raw_post)['email']
    experiences = Array.new

    lawyer = candidates.select { |candidate| candidate['email']  == email }[0]
    if lawyer == nil
      render json: {
        email: email,
        msg: 'Error, abogado no encontrado'
      }
      return 
    end

    works = lawyer['works']
    for work in works do
      if work['end'] != nil
        finish = Date.parse(work['end'])
      else
        finish = Date.today  
      end
      start = Date.parse(work['start'])
      fulltime = (finish - start).to_f/365
      experiences.push(fulltime)
    end

    render json: {
      email: email,
      work_experience_years: experiences.max().truncate(2)
    }
  end
end
