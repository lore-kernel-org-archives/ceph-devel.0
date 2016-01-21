From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: inconsistent rados semantics between automake/cmake builds
Date: Thu, 21 Jan 2016 08:03:00 -0800
Message-ID: <CADRKj5RFKdLWWAaWg1EtTtJB+g3FigoEm3=xJ2+FCostq7fp4A@mail.gmail.com>
References: <CAB2gnbUxzE7z6ec39=cPg2sqNOtMc6cS8_GN9ybxxdvB7zXW+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:34709 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965482AbcAUQDB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jan 2016 11:03:01 -0500
Received: by mail-ob0-f180.google.com with SMTP id vt7so38406826obb.1
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jan 2016 08:03:00 -0800 (PST)
In-Reply-To: <CAB2gnbUxzE7z6ec39=cPg2sqNOtMc6cS8_GN9ybxxdvB7zXW+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Casey Bodley <cbodley@redhat.com>, Adam Emerson <aemerson@redhat.com>, Orit Wasserman <owasserm@redhat.com>

On Thu, Jan 21, 2016 at 7:53 AM, Noah Watkins <noahwatkins@gmail.com> wrote:
> I'm seeing an anomaly of semantics between Ceph built with Automake
> and with CMake. I've not been lucky so far tracking this down so I
> thought I'd toss it out here.
>
> Here is the basic test description to reproduce (patch below, and
> available at mtime branch: github.com/noahdesu/ceph mtime):
>
> 0. create object class method to return object mtime via stat
> 1. from librados client, create an object with write_full
> 2. print mtime1 returned from ioctx.stat
> 3. print mtime2 returned from object class method via exec (step [0])
> 4. compare mtime1,2: values should be equal (step [3] didn't modify anything)
>
> The first valid question is assertion [4] true?
>
> In either case, what is weird, is that this test works (ie both mtime
> values are equal) when I build with automake, and does not work when I
> build with cmake. The times have a large difference, and the mtime on
> the OSD seems to travel back in time w.r.t. to the time on the client.
> Tests are the same machine.


This sounds somewhat like an issue Casey and Orit had seen, one that I
wasn't able to replicate (both of them are using cmake, I'm using
automake). I think they tracked it to Adam's c++11 time change.

Yehuda

>
> Automake Steps:
>
> ./autogen.sh
> ./configure
> make
> cd src
> vstart.sh -x -n -l
> ./ceph_test_cls_hello --gtest_filter=ClsHello.ReturnMtime
>
> [ RUN      ] ClsHello.ReturnMtime
> from client: 1453391360
>    from osd: 1453391360 (EQUAL)
>
> CMake Steps:
>
> mkdir build
> cd build
> cmake ..
> make
> ./src/vstart.sh -x -n -l
> ./src/test/test_cls_hello --gtest_filter=ClsHello.ReturnMtime
>
> [ RUN      ] ClsHello.ReturnMtime
> from client: 1453528535
>    from osd: 1453388425 (OLDER)
>
> -----
>
> diff --git a/src/cls/hello/cls_hello.cc b/src/cls/hello/cls_hello.cc
> index 878130f..1c2d00c 100644
> --- a/src/cls/hello/cls_hello.cc
> +++ b/src/cls/hello/cls_hello.cc
> @@ -47,6 +47,7 @@ cls_method_handle_t h_writes_dont_return_data;
>  cls_method_handle_t h_turn_it_to_11;
>  cls_method_handle_t h_bad_reader;
>  cls_method_handle_t h_bad_writer;
> +cls_method_handle_t h_return_mtime;
>
>  /**
>   * say hello - a "read" method that does not depend on the object
> @@ -291,6 +292,22 @@ PGLSFilter *hello_filter()
>    return new PGLSHelloFilter();
>  }
>
> +static int return_mtime(cls_method_context_t hctx, bufferlist *in,
> bufferlist *out)
> +{
> +  uint64_t size;
> +  time_t mtime;
> +
> +  int ret = cls_cxx_stat(hctx, &size, &mtime);
> +  if (ret) {
> +    CLS_ERR("ERROR: return_mtime %d", ret);
> +    return ret;
> +  }
> +
> +  ::encode(mtime, *out);
> +
> +  return 0;
> +}
> +
>
>  /**
>   * initialize class
> @@ -339,6 +356,11 @@ void __cls_init()
>    cls_register_cxx_method(h_class, "bad_writer", CLS_METHOD_RD,
>    bad_writer, &h_bad_writer);
>
> +  // mtime test
> +  cls_register_cxx_method(h_class, "return_mtime",
> +      CLS_METHOD_RD | CLS_METHOD_WR, return_mtime,
> +      &h_return_mtime);
> +
>    // A PGLS filter
>    cls_register_cxx_filter(h_class, "hello", hello_filter);
>  }
> diff --git a/src/test/cls_hello/test_cls_hello.cc
> b/src/test/cls_hello/test_cls_hello.cc
> index efd9fc7..70364d0 100644
> --- a/src/test/cls_hello/test_cls_hello.cc
> +++ b/src/test/cls_hello/test_cls_hello.cc
> @@ -183,3 +183,32 @@ TEST(ClsHello, Filter) {
>    ASSERT_EQ(0, destroy_one_pool_pp(pool_name, cluster));
>  }
>
> +TEST(ClsHello, ReturnMtime) {
> +  Rados cluster;
> +  std::string pool_name = get_temp_pool_name();
> +  ASSERT_EQ("", create_one_pool_pp(pool_name, cluster));
> +  IoCtx ioctx;
> +  cluster.ioctx_create(pool_name.c_str(), ioctx);
> +
> +  char buf[128];
> +  memset(buf, 0xcc, sizeof(buf));
> +  bufferlist obj_content;
> +  obj_content.append(buf, sizeof(buf));
> +
> +  ASSERT_EQ(0, ioctx.write_full("oid", obj_content));
> +
> +  uint64_t size;
> +  time_t mtime;
> +
> +  ASSERT_EQ(0, ioctx.stat("oid", &size, &mtime));
> +  std::cout << "from client: " << mtime << std::endl;
> +
> +  bufferlist in, out;
> +  ASSERT_EQ(0, ioctx.exec("oid", "hello", "return_mtime", in, out));
> +
> +  bufferlist::iterator it = out.begin();
> +  ::decode(mtime, it);
> +  std::cout << "   from osd: " << mtime << std::endl;
> +
> +  ASSERT_EQ(0, destroy_one_pool_pp(pool_name, cluster));
> +}
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
