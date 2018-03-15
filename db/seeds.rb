Movie.destroy_all
Posting.destroy_all
Show.destroy_all
Theater.destroy_all
User.destroy_all


p "Clean DB"

def round_to_5_minutes(t)
  rounded = Time.at((t.to_time.to_i / 300.0).round * 300)
  t.is_a?(DateTime) ? rounded.to_datetime : rounded
end


movies = [{title: "Que Le Diable Nous Emporte ", director: "Jean-Claude Brisseau", remote_poster_url: "https://images-na.ssl-images-amazon.com/images/M/MV5BMmM0ODE2MWUtNzliMS00NWY4LWEwYTUtMzNmYTYyMzUxYjRkXkEyXkFqcGdeQXVyMTc5OTQwMzk@._V1_UY1200_CR109,0,630,1200_AL_.jpg", remote_frame_url: "http://www.cinemaldito.com/wp-content/uploads/2017/12/Que-le-diable-nous-emporte-1-e1513873876751.jpg" },\
  {title: "Lady Bird", director: "Greta Gerwig", remote_poster_url: "http://medeiafilmes.com/media/images/c071c67e2bae8829138f1de095bd791f.jpg", remote_frame_url: "http://ladybird.movie/assets/fav/share2.jpg" },\
  {title: "Jusqu'à la garde", director: "Xavier Legrand", remote_poster_url: "https://filmspot.com.pt/images/filmes/posters/big/451657_pt.jpg", remote_frame_url: "https://www.cinergie.be/images/actualite/breve/2018_02/jusqua-la-garde.jpg" },\
  {title:"The Seven Samurai",director:"Akira Kurosawa", remote_poster_url: "https://images-na.ssl-images-amazon.com/images/I/91OOTyd4ToL._SL1500_.jpg", remote_frame_url: "http://akirakurosawa.info/wp-content/uploads/2016/08/Seven-Samurai.jpg" },\
  {title: "Bonnie and Clyde", director: "Arthur Penn", remote_poster_url: "https://fffmoviepostermuseum.com/wp-content/uploads/2016/05/bonnie-clyde-french-movie-poster.jpg", remote_frame_url: "http://www.arte-factos.net/wp-content/uploads/2017/02/bonnieclyde1.jpg" },\
  {title: "Reservoir Dogs", director: "Quentin Tarantino", remote_poster_url: "https://sites.psu.edu/filmsforall/files/2016/11/poster-370-1dzsy8z.jpg", remote_frame_url: "http://pixel.nymag.com/imgs/daily/vulture/2015/08/27/27-reservoir-dogs.w710.h473.2x.jpg" },\
  {title: "Airplane!", director: "Jim Abrahams", remote_poster_url: "https://images-na.ssl-images-amazon.com/images/I/51zWRLrTz3L._SY450_.jpg", remote_frame_url: "https://i.ytimg.com/vi/YzE0w6-aPM4/maxresdefault.jpg" },\
  {title: "Pan's Labyrinth", director: "Guillermo del Toro", remote_poster_url: "https://www.dvdsreleasedates.com/posters/800/P/Pans-Labyrinth-movie-poster.jpg", remote_frame_url: "http://cdn.bloody-disgusting.com/wp-content/uploads/2012/12/Pans-Labyrinth.jpg" },\
  {title: "Doctor Zhivago", director: "David Lean", remote_poster_url: "https://i.pinimg.com/originals/5a/bd/f9/5abdf9b6b0f2c68a0598de290f91d2d0.jpg", remote_frame_url: "http://lwlcdn.lwlies.com/wp-content/uploads/2015/11/doctor-zhivago-review.jpg" },\
  {title: "The Deer Hunter", director: "Michael Cimino", remote_poster_url: "https://raginggoodfellas.files.wordpress.com/2013/11/large_the_deer_hunter.jpg", remote_frame_url: "https://nofilmschool.com/sites/default/files/styles/facebook/public/the_deer_hunter_2_christopher_walken.jpg?itok=sbROPux8" },\
  {title: "Close Encounters of the Third Kind", director: "Steven Spielberg", remote_poster_url: "https://i.pinimg.com/736x/b5/d2/02/b5d2025feca0a81a23b5094017f6fd99--epic-movie-movie-posters.jpg", remote_frame_url: "https://cdn-images-1.medium.com/max/1920/1*W4kC3tVkSYwKha41klUcRA.jpeg" },\
  {title: "Ramiro", director: "Manuel Mozos", remote_poster_url: "http://imagens.publico.pt/imagens.aspx/611860?tp=KM", remote_frame_url: "https://i.ytimg.com/vi/MBrlhdFR1u0/maxresdefault.jpg" },\
  {title: "Visages Villages", director: "Agnès Varda", remote_poster_url: "https://medias.unifrance.org/medias/64/203/183104/format_page/media.jpg", remote_frame_url: "http://razaodeaspecto.com/wp-content/uploads/2018/01/B9714095563Z.1_20171211141302_000GNJAAM9O2.2-0.jpg" },\

  #{title: "Up", director: "Pete Docter", remote_poster_url: "https://vignette.wikia.nocookie.net/transcripts/images/9/97/Disney_and_Pixar%27s_Up_-_iTunes_Movie_Poster.jpg/revision/latest?cb=20170206002656", remote_frame_url: "https://i.pinimg.com/originals/12/7c/33/127c3333cd75e6024f04d59561bfea95.jpg" }\
  # {title: "Rocky", director: "John G. Avildsen", remote_poster_url: "https://www.posterduniya.com/wp-content/uploads/2016/10/Rocky.jpg", remote_frame_url: "" },\
  # {title: "Memento", director: "Christopher Nolan", remote_poster_url: "https://i0.wp.com/www.movie-poster-artwork-finder.com/posters/memento-poster-artwork-guy-pearce-carrie-anne-moss-joe-pantoliano.jpg", remote_frame_url: "" },\
  # {title: "Braveheart", director: "Mel Gibson", remote_poster_url: "https://ae01.alicdn.com/kf/HTB1fmsjHVXXXXX2XXXXq6xXFXXXM/Free-shipping22-X35-inch-Braveheart-Movie-Poster-Custom-ART-PRINT.jpg", remote_frame_url: "" },\
  # {title: "Slumdog Millionaire", director: "Danny Boyle", remote_poster_url: "http://www.freemovieposters.net/posters/slumdog_millionaire_2008_342_poster.jpg", remote_frame_url: "" },\
  # {title: "The Lord of the Rings", director: "Peter Jackson", remote_poster_url: "https://www.allaboutmovies.com.au/media/k2/items/cache/6ecf1cbf700e3690cd5560547677892b_XL.jpg", remote_frame_url: "" },\
  # {title: "Beauty and the Beast", director: "Gary Trousdale", remote_poster_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoWbaoDWWwma1KVQWncLxJlQiHMQ_ACbifIhWxVjErxgJ8gHQK", remote_frame_url: "" },\
  # {title: "Seven", director: "David Fincher", remote_poster_url: "https://i.pinimg.com/736x/53/9e/47/539e475b4f7621e4da516e3425c60c90--seen--graphic-posters.jpg", remote_frame_url: "" },\
  # {title: "Inception", director: "Christopher Nolan", remote_poster_url: "https://ae01.alicdn.com/kf/HTB1OlDhl8DH8KJjy1zeq6xjepXa4/Inception-Movie-Art-Poster-Canvas-Print-Wall-Art-Picture-for-Home-Decor.jpg", remote_frame_url: "" },\
  # {title: "Die Hard", director: "John McTiernan", remote_poster_url: "https://vignette.wikia.nocookie.net/diehard/images/c/c3/DieHard.jpg/revision/latest?cb=20110515165526", remote_frame_url: "" },\
  # {title: "Amadeus", director: "Milos Forman", remote_poster_url: "https://c1.staticflickr.com/9/8014/7271129204_e5e84c2240_b.jpg", remote_frame_url: "" },\
  # {title: "Wall-E", director:"Andrew Stanton", remote_poster_url: "http://live-timely-kxd9sfz2in.time.ly/wp-content/uploads/2017/06/walle-5543a08739869.jpg", remote_frame_url: "" }
]
p "On to Movies"
movies.each do |mov|
  Movie.create(title: mov[:title], director: mov[:director], remote_poster_url: mov[:remote_poster_url], remote_frame_url: mov[:remote_frame_url] )
end

genres = ["French Nouvelle Vague", "Italian neorealism", "Soviet Avantgarde", "B-movies", "Horror classics"]

50.times do
  favmovies_ind = (0...movies.size).to_a.sample((1..5).to_a.sample)
  favdir_ind = (0...movies.size).to_a.sample((1..5).to_a.sample)
  favgenre_ind = (0...genres.size).to_a.sample((1..3).to_a.sample)

  gender = %w(m f).sample
  first_name = gender == 'f' ? FactoryHelper::Name.female_first_name : FactoryHelper::Name.male_first_name
  remote_photo_url = gender == 'f' ? UiFaces.woman : UiFaces.man
  user = User.new(
    first_name: first_name,
    last_name: FactoryHelper::Name.last_name,
    email: "#{first_name}@#{FactoryHelper::Internet.domain_name}",
    password: "xxxxxx",
    city: "Lisbon",
    remote_photo_url: remote_photo_url
  )
  user.favmovies = favmovies_ind.map{ |i| Favmovie.new(title: movies[i][:title]) }
  user.favdirectors = favdir_ind.map{ |i| Favdirector.new(name: movies[i][:director]) }
  user.genres = favgenre_ind.map{ |i| Genre.new(name: genres[i]) }
  user.save
end

p "Almost there"

names = ["Sao Jorge", "Monumental", "Cinemateca", "Cinema Ideal"]
locations =["Av. da Liberdade 175, Lisbon","Av. Praia da Vitória, 72, Lisbon","R. Barata Salgueiro 39, Lisbon","Rua do Loreto 15, Lisbon"]

(0...4).each do |i|
  Theater.create(name: names[i], location: locations[i])
end

Movie.all.each do |movie|
  10.times do
    Show.create(
      date: FactoryHelper::Date.forward(10), # random dates in the next months
      time: round_to_5_minutes(FactoryHelper::Time.between(Date.today, Date.today, :evening)) ,
      movie: movie,
      theater: Theater.all.sample
      )
  end
end

150.times do
  Posting.create(user: User.all.sample,show: Show.all.sample)
end

p "Seeded"

