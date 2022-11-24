import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;



    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(title: movie.title, poster: movie.fullBackdropPath,),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(title:  movie.title, poster: movie.fullPosterImg, vote: movie.voteAverage, ogTitle: movie.originalTitle, id: movie.heroId,),
              _Overview(info: movie.overview,),
              //_Overview(),
              //_Overview(),
              const SizedBox(height: 20),
              CastingCards( movie.id ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final title;
  final poster;

  const _CustomAppBar({Key? key, required this.title, required this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.grey[900],
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
          color: Colors.black12,
          child: Text(
            title,
            style: const TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(poster),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final title;
  final ogTitle;
  final poster;
  final vote;
  final id;

  const _PosterAndTitle({Key? key, required this.title, required this.poster, required this.vote, this.ogTitle, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only( top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(poster),
                height: 150,
              ),
            ),
          ),

          const SizedBox(width: 20,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width - 200),
                child: Text(title, style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2,)
              ),
              
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width - 200),
                child: Text(ogTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2,)
              ),
              Row(
                children: [
                  const Icon(Icons.star_outline, size: 20, color: Colors.grey,),
                  const SizedBox(width: 5,),
                  Text(vote.toString(), style: const TextStyle(fontSize: 15),)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final info;

  const _Overview({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        info, //'Keep in mind that publishing is forever. As soon as you publish your package, users can depend on it. Once they start doing that, removing the package would break theirs. To avoid that, the pub.dev policy disallows unpublishing packages except for very few cases.If you are no longer maintaining a package, you can mark it discontinued, and it will disappear from pub.dev search.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
