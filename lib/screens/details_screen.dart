import 'package:flutter/material.dart';
import 'package:movies/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
   
  const DetailsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _CustomAppBar(),
          SliverList(delegate: SliverChildListDelegate(
            [
              const _PosterAndTitle(),
              const _Overview(),
              const _Overview(),
              const _Overview(),
              const _Overview(),
              const _Overview(),
              const CastingCards()
            ]
          ))
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 15),
          color: Colors.black12,
          child: const Text('Detalles', style: TextStyle(fontSize: 16))
          ),
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final textTheme = Theme.of( context ).textTheme;

    return Container(
      margin: const EdgeInsets.only( top: 20 ),
      padding: const EdgeInsets.symmetric( horizontal: 20 ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular( 20 ),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),

          const SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title',
              style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2
              ),
              Text('Original title',
              style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2
              ),
              Row(
                children: [
                  const Icon(Icons.star_outline, size: 15, color: Colors.grey,),
                  const SizedBox(width: 5),
                  Text('Original title',
                  style: textTheme.caption, overflow: TextOverflow.ellipsis, maxLines: 2
                  ),
                ]
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of( context ).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text('Quis mollit adipisicing velit aliqua adipisicing amet dolor ut. Occaecat irure quis dolore anim commodo officia minim aliqua minim laborum in. Deserunt culpa quis velit cupidatat excepteur adipisicing nulla incididunt cupidatat. Culpa ullamco eu ullamco cupidatat consequat cillum eu sint cillum.',
      textAlign: TextAlign.justify,
      style: Theme.of( context ).textTheme.subtitle1,
      )
    );
  }
}