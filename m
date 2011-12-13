From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: ceph/hadoop benchmarking
Date: Tue, 13 Dec 2011 12:12:03 -0800
Message-ID: <CAORUGqA-oiwC4E2QGTeMweacJNJaS7A0CXDN-3ay2Vwc6Q7WrA@mail.gmail.com>
References: <193464577.4390.1319657347846.JavaMail.root@mail-01.cse.ucsc.edu>
 <Pine.LNX.4.64.1110261425320.18909@cobra.newdream.net> <4EE77DAA.5070900@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39678 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830Ab1LMUMZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2011 15:12:25 -0500
Received: by eekc4 with SMTP id c4so52074eek.19
        for <ceph-devel@vger.kernel.org>; Tue, 13 Dec 2011 12:12:24 -0800 (PST)
In-Reply-To: <4EE77DAA.5070900@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Sage Weil <sage@newdream.net>, Noah Watkins <jayhawk@soe.ucsc.edu>, Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On Tue, Dec 13, 2011 at 08:30, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> The debhelper tool and friends seem to do a good job of packaging up the
> Java in this way, but integrating this into Ceph's default Debian scripts
> means that anyone would now need a JDK to build Ceph with
> dpkg-buildpackages.
>
> Is there a way to parametrize the Debian build process so people who don't
> care about Java bindings can proceed? An alternative approach is to say have
> another set of Debian build scripts in src/client/java/debian.

The only parametrization I'm aware of is DEB_BUILD_OPTIONS, and it's
not really meant to be used for toggling off bits of functionality.
And if we would support DEB_BUILD_OPTIONS=nojava, would that mean not
listing the java sdk in Build-Dependencies? That sounds like a bad
road to take.

The clean options I see are:

1. require anyone building the debs to have the java sdk debs installed
2. split the java bindings into a separate source package

Frankly, I think 2. is decent option. Make ceph provide libcephfs-dev
etc, make that a build-dependency of the java bindings. It complicates
"build everything" but simplifies the common case. It lets these
things evolve at different rates. It acts as a good check on whether
we did a good job on libcephfs-dev packaging and API/ABI changes.

I personally dislike it a lot when some upstream project tries to
maintain all the language bindings in the world in the single master
repository. That leads to a "one size fits nobody" world. For example,
even our python bindings are *miserably* maintained compared to most
true-Python projects; for example, they are not PyPI/pip-friendly. The
reason why I've been ok with the python bindings is we use them
internally, for tests etc, and I want to push more in that direction..
but we already have the PHP bindings in a separate repo. We don't need
all the worlds bindings in ceph.git.
