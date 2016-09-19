From: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Subject: Cmake build. C compiler.
Date: Mon, 19 Sep 2016 21:37:55 +0000
Message-ID: <D405A8C2.12B32%evgeniy.firsov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0047.outbound.protection.outlook.com ([104.47.40.47]:43779
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932346AbcISVxL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 19 Sep 2016 17:53:11 -0400
Content-Language: en-US
Content-ID: <F9526F9E816E5649AB587A15493BA6F8@namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, Guys,

When I build Ceph using ./do_cmake.sh && cd build && make -j32, looks like
everything is compiled using C++ compiler, even files with .c extension.
This fails ZetaScale compilation, which is pure C.

In oppose to that if I am building =B3in tree=B2, with cmake . && make -j32=
,
Ceph build fails, because it uses proper C compiler for .c extension, but
they include Ceph=B9s assert.h which is C++.

So, probably, I need to configure compiler on per directory basis, is
there known way to do that?
Also, can somebody point me where in the CMakeList.txt compiler is
configured for =B3out of tree=B2 build? I mean C++ for everything.

=8B
Evgeniy


PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
