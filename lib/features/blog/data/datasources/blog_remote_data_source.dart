import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<Blog> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<Blog> uploadBlog(BlogModel blog) async {
    try {
      // upload ke db dengan toJson
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blog.tojson())
          .select();

      // ambil hasil upload ke sistem untuk ditampilkan dengan fromJson
      return BlogModel.fromJson(blogData.first);
    } catch (err) {
      throw ServerException(err.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.id, image);

      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (err) {
      throw ServerException(err.toString());
    }
  }
}
