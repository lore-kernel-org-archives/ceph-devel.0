From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: enabling shared ccache dirs in default builds
Date: Wed, 7 Dec 2016 10:26:27 +0100
Message-ID: <fde7b31e-75ba-9c71-a0d2-1467e65b1d54@digiware.nl>
References: <CAJ4mKGZSnN+RE7d5wrzghmtWZA1w1e7NT8JeW4nArwVdijggkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:42837 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752374AbcLGJ0b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 7 Dec 2016 04:26:31 -0500
In-Reply-To: <CAJ4mKGZSnN+RE7d5wrzghmtWZA1w1e7NT8JeW4nArwVdijggkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 7-12-2016 01:09, Gregory Farnum wrote:
> The default (or at least, ./do_cmake.sh-setup) Ceph build makes use of
> cmake. This is nice for speeding up builds, but as the amount of disk
> space increases it really explodes disk usage on dev boxes. As of
> today, a Ceph repo with build artifacts is ~30GB, and my ccache
> directory is ~32GB.
> 
> For me and many of the other Red Hat devs, that's a significant
> fraction of the 256GB available on our (shared box) home-dir SSDs, and
> I don't think there's *too* much advantage to be gained by giving each
> dev their own ccache dir. If anybody has expertise configuring ccache
> and wants to tweak our build scripts to make setting that up easy,
> it'd be cool — I started in on the ccache man page and it doesn't look
> too hard but I've never configured any of it. Created a ticket at
> http://tracker.ceph.com/issues/18160

From the ccache site:
"Another reason to use ccache is that the same cache is used for builds
in different directories. If you have several versions or branches of a
software stored in different directories, many of the object files in a
build directory can probably be taken from the cache even if they were
compiled for another version or branch
"

So why not have a shared/global ccache. I would expect the larger part
of the project to generate the same code over and over for most of the
users? On average only a small fraction of the compile is different
between developers, and even that will be absorbed by a large general
cache. The trick with a cache is that the benifits increase if there are
more users doing/reusing more of the same. So the advantage of 300G
cache is better that 10*30G. Note that ccache can even compress data in
the cache, leading to even more objects in your cache. With an even
better hit ratio.

Get ride of all personal ccache.conf files and
in global /etc/ccache.conf
cache_dir = /somewhere/you/want/then/ccache
max_size = as large as possible
umask = 777
# or 775 if devs are all in the same group.

--WjW



