def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie
    .select(:title, :id)
    .joins(:actors)
    .where('actors.name in (?)', those_actors)


end

def golden_age
  # Find the decade with the highest average movie score.
  Movie
    .select(:yr, 'AVG(score)')
    .group(:yr)

end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  Actor
    .select(:name)
    .joins(:movies)
    .where('movies.title IN (select
                        movies.title
                      from
                       actors join castings on castings.actor_id = actors.id
                              join movies on movies.id = castings.movie_id
                      where
                        actors.name = ? ) and actors.name != ?', name, name)
    .distinct
    .pluck(:name)

end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
    .select('COUNT(*)')
    .where('(actors.id NOT IN (select castings.actor_id FROM castings))')
    .pluck('COUNT(*)')[0]
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  whazzername = "%#{whazzername.split(' ').join('').split('').join('%')}%"

  Movie
    .select(:id, :title, :yr, :score, :votes, :director_id)
    .joins(:actors)
    .where('actors.name ilike (?)', whazzername)

end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  
end
