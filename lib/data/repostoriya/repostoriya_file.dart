import 'package:vazifa31/data/model/file_model.dart';

class FileRepository {
  final List<FileModel> _files = [
    FileModel(
      id: 1,
      title: "Harry Potter",
      description: """The two men appeared out of nowhere, a few yards apart
in the narrow, moonlit lane. For a second they stood
quite still, wands directed at each other’s chests; then,
recognizing each other, they stowed their wands beneath their cloaks and started walking briskly in the same direction""",
      image:
          'https://static0.srcdn.com/wordpress/wp-content/uploads/2023/08/harry-potter-movies-length-runtime.jpg',
      url:
          "https://vidyaprabodhinicollege.edu.in/VPCCECM/ebooks/ENGLISH%20LITERATURE/Harry%20potter/(Book%207)%20Harry%20Potter%20And%20The%20Deathly%20Hallows.pdf",
      reting: 4.8,
      aufter: 'J. K. Rowling',
      price: 9.99,
    ),
    FileModel(
      id: 2,
      title: "To Kill a Mockingbir",
      description:
          """When he was nearly thirteen, my brother Jem got his arm badly
broke at the elbow. When it healed, and Jem's fears of
never being able to play football were assuaged, he was
able to walk again""",
      image:
          'https://i.pinimg.com/originals/78/77/9c/78779c1bd13e5292bda4a01692f07661.jpg',
      url:
          "https://dracarys983.github.io/library/to-read/To-Kill-a-Mockingbird.pdf",
      reting: 4.7,
      aufter: 'Harper Lee',
      price: 7.99,
    ),
    FileModel(
      id: 3,
      title: "1984",
      description:
          """It was a bright cold day in April, and the clocks were striking
thirteen. Winston Smith, his chin nuzzled into his breast
in an effort to escape the vile wind, slipped quickly
through the glass doors of Victory Mansions, though not
quickly enough to prevent a swirl of gritty dust from
entering along with him""",
      image: 'https://cv0.litres.ru/pub/c/cover_415/70603705.jpg',
      url:
          "https://blacksun.deathofcommunism.com/wp-content/uploads/2019/08/1984.pdf",
      reting: 4.6,
      aufter: 'George Orwell',
      price: 8.99,
    ),
    FileModel(
      id: 4,
      title: "The Great Gatsby PDF",
      description: """In my younger and more vulnerable years my father gave me
some advice that I've been turning over in my mind ever
since. 'Whenever you feel like criticizing any one,' he
told me, 'just remember that all the people in this world
haven't had the advantages that you've had'""",
      image: 'https://i.artfile.ru/2880x1800_715426_[www.ArtFile.ru].jpg',
      url: "https://dracarys983.github.io/library/to-read/The-Great-Gatsby.pdf",
      reting: 4.4,
      aufter: 'F. Scott Fitzgerald',
      price: 6.99,
    ),
    FileModel(
      id: 5,
      title: "Moby Dick",
      description:
          """Call me Ishmael. Some years ago—never mind how long precisely—
having little or no money in my purse, and nothing particular
to interest me on shore, I thought I would sail about a little
and see the watery part of the world""",
      image: 'https://i.ytimg.com/vi/rfMEExOXDKw/maxresdefault.jpg',
      url: "https://gosafir.com/mag/books/moby-dick.pdf",
      reting: 4.3,
      aufter: 'Herman Melville',
      price: 5.99,
    ),
    FileModel(
      id: 6,
      title: "Pride and Prejudice",
      description:
          """It is a truth universally acknowledged, that a single man in
possession of a good fortune, must be in want of a wife.
However little known the feelings or views of such a man
may be on his first entering a neighbourhood, this truth
is so well fixed in the minds of the surrounding families,
that he is considered as the rightful property of some
one or other of their daughters""",
      image:
          'https://images.kinorium.com/movie/poster/101974/w1500_48090166.jpg',
      url:
          "https://paulinoposada.github.io/web/websites/paulino/books/literature/pride_prejudice.pdf",
      reting: 4.5,
      aufter: 'Jane Austen',
      price: 7.49,
    ),
  ];

  List<FileModel> getFiles() {
    return [..._files];
  }
}
