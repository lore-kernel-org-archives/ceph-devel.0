From: Marcus Watts <mwatts@redhat.com>
Subject: ceph: building out of tree
Date: Wed, 24 Feb 2016 00:48:20 -0500
Message-ID: <20160224054820.GB6585@degu.b.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42201 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbcBXFsX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 24 Feb 2016 00:48:23 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 0FAFE8E3D4
	for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 05:48:23 +0000 (UTC)
Received: from degu.b.linuxbox.com (vpn-60-96.rdu2.redhat.com [10.10.60.96])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u1O5mLYp014072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 00:48:22 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When I was working on "wip-openssl", I quickly found myself bogged down
dealing with build issues.

1. why I do out of tree builds
2. changes for out of tree builds
3. doing an out of tree build
4. well, not quite

____ 1. why I do out of tree builds

So, as a matter of habit, I do most of my large project builds doing
"out of tree" builds.  There are a variety of reasons I have adopted
this habit.  For many years, I was supporting multiple architectures
in a shared filesystem, and it was a lot easier to not lose changes
if I had one source tree shared between several build trees. (especially
when my source control system was rcs!)  Today, I still like to do this;
it means I can more easily test out several different configurations
in parallel, efficiently put an old build aside for later reference,
and quickly discard older stuff without fear of losing an important
source change.

And so, with wip-openssl, I find myself with several different build
configurations: with cmake, and with automake.  Cmake is my preferred
solution: it works faster, and excepting for one recent change it supports
out of tree builds just fine.
	[ the one exception is rocksdb, and I'll post separately on that. ]
For automake, I found myself looking at a much longer list of things
that didn't quite work.

____ 2. changes for out of tree builds

List of commits from wip-openssl that together do most of what I want,
96f16f9c61b8f96ddb86c3b3630078c4a28058ec
0a60a5fa3582a97a2a8914dc96abe469f3244fbe
	WITH_DLIBROCKSDB
	I'm used to other automake based systems where one can say things
	like "with-krb5=yes" and have it find the external (system) copy of krb5.
	I am not sure "with-rocksdb" ever really worked right in ceph,
	but it kind of looked like it wanted a dynamic version of rocksdb
	(again, I'll post more on that separately.) So I wound up repurposing
	this to mean just that.
ddca62ffdb3b7908140f7c4072692b6148bd54a0
	src/ceph.in is a classic sort of "out of tree" build problem.
	The proper automake way to reference src/ceph.in is
	$(srcdir)/ceph.in .   With gnu make, it's possible to cheat
	and just call it $< .  Do we support other makes?
e51fd743587454cf0b08aaea4977eee253a71664
	build version files are another ubiquitious "out of tree" build problem.
	In ceph, the use of "FORCE" for this logic means every make run
	wants to relink every library and executable, which really slows
	things down.   I left .git_version in the source tree
	but moved ceph_ver.h to the object tree.  This doesn't make
	me completely happy, but it at least gave me something buildable.
1ddd0ed672d1a8a8201b1bf65cf6a173456320c6
c8792d96e5c2cfbdaf555e9ae545cb2aa0d7c8e6
	pybind/setup.py wanted to read ceph_ver.h.  I should probably
	have taught it to read ceph_ver.h in the build tree,
	but instead I taught it to find .git_version.  I did put
	logic in it to construct "PEP-440" friendly version tags,
	which got rid of one build warning.

____ 3. doing an out of tree build

With this set of changes, I can now make a "readonly" source tree
and build with it this way,
	git clone -b wip-openssl git@github.com:ceph/ceph.git ceph-ssl
	cd ceph-ssl
	git clean -fdx
	git submodule update --init --recursive
	sh autogen.sh
	sleep 1; touch src/acconfig.h.in src/gmock/build-aux/config.h.in
	rm -f src/.git_version src/ceph_ver.h
	src/make_version -g src/.git_version
	find .  \! -type l -print0 | xargs -0 chmod a-w
	mkdir ../td ; cd ../td
	CFLAGS="-fno-omit-frame-pointer -g -O2" CXXFLAGS="-fno-omit-frame-pointer -g" \
	../ceph-ssl/configure --with-debug --with-radosgw \
	--with-libatomic-ops --without-lttng --disable-static \
	--with-librocksdb=yes --with-librocksdb-static=no

The "sleep 1" business is because it turns out that
src/acconfig.h.in src/gmock/build-aux/config.h.in
have to be at least 1 second newer than other stuff
in the source tree, and my build machine is fast
enough at running autogen.sh that that's never true.

I think autogen.sh could also be making .git_version directly,
but I didn't bother here.

____ 4. well, not quite

This will still blow up late in the build process.  There's
something that makes 2 python virtual environments in the
source tree.  They should be in the build tree, and
also this should be part of "make check", not "make all".

But other than that, I have something that works, and that
doesn't blow up git builder.

					-Marcus Watts
