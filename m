From: Sage Weil <sage@inktank.com>
Subject: Re: Keys & caps
Date: Tue, 10 Jul 2012 16:25:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207101619230.693@cobra.newdream.net>
References: <4183318.yLl07ggMzS@mranderson> <1968682.cis2SWxC6X@mranderson> <CAPYLRzgn6NC9193y4HsH7ASevtX-QWq9P=RrYJpmD3uvyoi8LA@mail.gmail.com> <1619446.aT01BgUE1G@mranderson>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33209 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008Ab2GJXZt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 19:25:49 -0400
In-Reply-To: <1619446.aT01BgUE1G@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

On Wed, 11 Jul 2012, Sz?kelyi Szabolcs wrote:
> > >> The problem is that the mount.ceph command doesn't understand keyrings;
> > >> it
> > >> only understands secret= and secretfile=.  There is a longstanding
> > >> feature
> > >> bug open for this
> > >> 
> > >>       http://tracker.newdream.net/issues/266
> > >> 
> > >> but it hasn't been prioritized.  Sorry for the confusion!  It will happen
> > >> soon.
> > >> 
> > >> In the meantime, you need
> > >> 
> > >>        -o secretfile=/path/to/secretfile,name=access_fs
> > > 
> > > Is this also true for the FUSE client? I have obscure memories about big
> > > differences between the kernel and the FUSE client, for example the latter
> > > being able to read ceph.conf, and get the necessary info, including the
> > > keyring file, from there. Maybe I didn't emphasize it, but that's what I'm
> > > using.
> > 
> > When using ceph-fuse, you want to specify the name with
> > --name=access_fs ? no -o required.
> 
> Okay, so I don't need the "client." prefix for the key name, but how can I 
> specify the --name= option in fstab? Or is it possible to specify it in 
> ceph.conf, so it can be read by ceph-fuse when called by mount?

Er sorry, you actually want either --id foo or --name client.foo (they are 
equivalent) when dealing with ceph-fuse (or other userland daemons/tools).

I'm not sure what the best way of putting fuse-based file systems in fstab 
is, though.  One way or another, though, ceph-fuse needs to be told on the 
command line who to authenticate as (and which sections of ceph.conf to 
pay attention to).

sage
