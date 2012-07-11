From: Sage Weil <sage@inktank.com>
Subject: Re: Ceph status for Wheezy
Date: Wed, 11 Jul 2012 09:18:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207110916020.693@cobra.newdream.net>
References: <1341122210.10000.46.camel@julia> <Pine.LNX.4.64.1206302303580.11497@cobra.newdream.net> <1341786172.24592.49.camel@julia> <Pine.LNX.4.64.1207082132170.13271@cobra.newdream.net> <1342020952.12180.28.camel@julia>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38108 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755656Ab2GKQSx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 12:18:53 -0400
In-Reply-To: <1342020952.12180.28.camel@julia>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 11 Jul 2012, Laszlo Boszormenyi (GCS) wrote:
> On Sun, 2012-07-08 at 21:39 -0700, Sage Weil wrote:
> > On Sun, 8 Jul 2012, Laszlo Boszormenyi (GCS) wrote:
> > >  It was released since then. But there are several files that I don't
> > > know where to install. First are some headers under /usr/include/crush :
> > > crush.h , hash.h , mapper.h and types.h .
> > I don't think these need to be installed anywhere; they're not currently 
> > packaged.  Why do you mention them?
>  They are installed to /usr/include on 'make install'. Didn't know the
> reason, but will ignore them then.

Oh, that old.. fixed it up.

> > > What about ceph-disk-activate , ceph-disk-prepare exists , boto_tool and
> > > ceph-coverage ? They are python scripts except the latter being a shell
> > > script.
> > ceph-disk-* are already in ceph.  The other two shouldn't be packaged.
>  OK, added them to my packaging as well. Adds a python dependency to the
> base package.
>
> > Is there anything missing on this end?
>  Just checked, the python scripts are installed in your git tree.
> Adjusted my packaging to match that. What do I miss? Manpages for
> ceph-disk-activate , ceph-disk-prepare , rest-bench and maybe
> librados-config .

Okay, those should be pretty simple.  There will be a point release before 
too long that includes all of this stuff.  If there is anything in your 
packaging that isn't fixed upstream let me know.

Thanks!
sage
