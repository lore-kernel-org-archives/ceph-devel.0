From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Does anyone know if Automake has a way of expressing dependencies?
Date: Thu, 16 Jun 2011 17:31:44 -0700
Message-ID: <BANLkTikD=VCqf+JDK=21yhMwx6mir0mN6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65435 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416Ab1FQAbp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jun 2011 20:31:45 -0400
Received: by fxm17 with SMTP id 17so1451911fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Jun 2011 17:31:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Does anyone know if Automake has a way of expressing dependencies between
libraries?

For instance, currently our code has this set of (logical) dependencies:
rbd -> librbd -> librados -> libcommon

Where a -> b means "a depends on symbols found in b".

Unfortunately, the problem that I've run into is that automake seems to have
no way of expressing dependencies between libraries.

You can do:
> librbd_la_LIBADD += librados.la

This line does seem to take care of the business of making the final librbd.so
depend on librados.so.

But you'll still get undefined symbols if you try to use librbd.la later in
the Makefile.am without also remembering to include librados. So remembering
the dependencies is up to the developer, which could be a problem if we decide
to create more libraries (say, by splitting libcommon.) Is there a workaround
for this?

Another problem that I've experienced is that Automake seems to view a
particular library as either 'shared' or 'static' inherently, and can't handle
mixing the two. For example, if you do:

> librbd_la_LIBADD += libcommon.a

You'll get this strange message:

> *** Warning: Linking the shared library librgw.la against the
> *** static library libcommon.a is not portable!

I was afraid to go with this solution because I'm worried it's not setting
-fPIC correctly.

I really view the whole -fPIC situation as something that should be handled by
the build system. If I say that librbd depends on libcommon, and gceph depends
on libcommon, it should figure out what flags to use where, and build
libcommon with those flags. If it needs to build libcommon once with -fPIC and
once without, it should handle that internally.

This is how you would write that in CMake:
> add_library(libcommon ...)
> add_library(librados ...)
> target_link_libraries(librados libcommon)
> add_library(librbd ...)
> target_link_libraries(librbd librados)
> add_program(rbd rbd.c)
> target_link_libraries(rbd librbd)
> target_link_libraries(gceph libcommon)

Does anyone know if there is a way to get an equivalent level of functionality
in automake? Currently we're directly injecting the sources of libcommon into
the other libraries. libcommon doesn't even really exist from the perspective
of the build system, except as an m4 macro which contains a list of file names.
I don't think this approach will scale very well if we start adding more
libraries.

Colin
