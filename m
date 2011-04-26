From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Java-rados announcement
Date: Tue, 26 Apr 2011 16:22:36 -0700
Message-ID: <BANLkTimWCgtkpMfLX3HsMCAqacYkF=oydg@mail.gmail.com>
References: <D20F8B6A-0A44-41BA-B98C-5956E8CBA55E@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37080 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab1DZXWn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Apr 2011 19:22:43 -0400
Received: by fxm17 with SMTP id 17so782185fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Apr 2011 16:22:41 -0700 (PDT)
In-Reply-To: <D20F8B6A-0A44-41BA-B98C-5956E8CBA55E@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org, Noah Watkins <noahwatkins@gmail.com>

Hi Noah,

Thanks for putting this together! It looks pretty good.

I see that at the moment you have it as part of the Ceph source tree.
Well, we're not planning on integrating language bindings into the
source tree.

The reason we integrated the python bindings into the main source tree
is because we have a lot of python code. We have a tool called obsync,
a testing framework called autotest, and some other stuff that is
written in python. In my opinion, Python allows us to write scripts
and tools at a higher level of abstraction than what is provided by
shell scripting. (although shell scripts can be useful sometimes.)

PHPRados has its own wiki page and a separate repo. It's at:
http://ceph.newdream.net/wiki/Phprados

We should set up something similar for this, I think.

P.S. It would be nice to have a simple script that runs through the
bindings and ensures that they still work. This would be helpful in
case we make a minor revision to the Rados API. Basically, any time we
bump the librados version number, we should consider sending a patch
to add the new function or revise the old function in the
Java/python/PHP API.

That's a lot easier if there's a little script that just runs all the
functions. That's what ceph-pybind-test.py. Is it possible to make
something like that for the Java and PHP bindings?

cheers,
Colin


On Sun, Apr 17, 2011 at 6:34 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wro=
te:
> I've put together Java bindings for RADOS available at:
>
> =A0git://github.com/noahdesu/ceph.git java-rados
>
> Contains:
> =A0- Bindings with JNI
> =A0- Full set of unit tests
> =A0- JavaDoc markup
>
> Thanks,
> Noah
>
> =A0.gitignore =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0configure.ac =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0src/bindings/java/.gitignore =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A04 +
> =A0src/bindings/java/README =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 45 ++
> =A0src/bindings/java/build.xml =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 83 +++
> =A0.../java/java/net/newdream/ceph/rados/Cluster.java | =A0249 ++++++=
+++
> =A0.../java/net/newdream/ceph/rados/ClusterStats.java | =A0 75 +++
> =A0.../java/net/newdream/ceph/rados/IOContext.java =A0 =A0| =A0332 ++=
+++++++++
> =A0.../net/newdream/ceph/rados/ObjectIterator.java =A0 =A0| =A0 77 ++=
+
> =A0.../java/net/newdream/ceph/rados/PoolStats.java =A0 =A0| =A0130 ++=
+++
> =A0.../net/newdream/ceph/rados/RadosException.java =A0 =A0| =A0 28 +
> =A0.../java/net/newdream/ceph/rados/RadosObject.java =A0| =A0169 ++++=
++
> =A0.../java/net/newdream/ceph/rados/RadosVersion.java | =A0 54 ++
> =A0src/bindings/java/native/Makefile.am =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 30 +
> =A0src/bindings/java/native/common.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 19 +
> =A0src/bindings/java/native/exceptions.c =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 78 +++
> =A0.../java/native/net_newdream_ceph_rados_Cluster.c =A0| =A0520 ++++=
+++++++++++++
> =A0.../java/native/net_newdream_ceph_rados_Cluster.h =A0| =A0125 ++++=
+
> =A0.../native/net_newdream_ceph_rados_ClusterStats.c =A0| =A0 41 ++
> =A0.../native/net_newdream_ceph_rados_ClusterStats.h =A0| =A0 21 +
> =A0.../native/net_newdream_ceph_rados_IOContext.c =A0 =A0 | =A0588 ++=
++++++++++++++++++
> =A0.../native/net_newdream_ceph_rados_IOContext.h =A0 =A0 | =A0125 ++=
+++
> =A0.../net_newdream_ceph_rados_ObjectIterator.c =A0 =A0 =A0 | =A0 63 =
+++
> =A0.../net_newdream_ceph_rados_ObjectIterator.h =A0 =A0 =A0 | =A0 37 =
++
> =A0.../native/net_newdream_ceph_rados_PoolStats.c =A0 =A0 | =A0 50 ++
> =A0.../native/net_newdream_ceph_rados_PoolStats.h =A0 =A0 | =A0 21 +
> =A0.../native/net_newdream_ceph_rados_RadosVersion.c =A0| =A0 31 +
> =A0.../native/net_newdream_ceph_rados_RadosVersion.h =A0| =A0 21 +
> =A0src/bindings/java/test/ClusterStatsTest.java =A0 =A0 =A0 | =A0 31 =
+
> =A0src/bindings/java/test/ClusterTest.java =A0 =A0 =A0 =A0 =A0 =A0| =A0=
139 +++++
> =A0src/bindings/java/test/IOContextTest.java =A0 =A0 =A0 =A0 =A0| =A0=
190 +++++++
> =A0src/bindings/java/test/PoolStatsTest.java =A0 =A0 =A0 =A0 =A0| =A0=
 47 ++
> =A0src/bindings/java/test/RadosObjectTest.java =A0 =A0 =A0 =A0| =A010=
5 ++++
> =A0src/bindings/java/test/RadosTestUtils.java =A0 =A0 =A0 =A0 | =A0 1=
1 +
> =A0src/bindings/java/test/RadosVersionTest.java =A0 =A0 =A0 | =A0 14 =
+
> =A035 files changed, 3555 insertions(+), 0 deletions(-)
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
