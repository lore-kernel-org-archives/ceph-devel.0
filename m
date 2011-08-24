From: Sage Weil <sage@newdream.net>
Subject: Re: ceph/rbd benchmarks
Date: Wed, 24 Aug 2011 09:46:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108240943460.20147@cobra.newdream.net>
References: <CALFpzo5NuPHxqtj0qtP7mafy5TG2BTSo-2=Y+jCPsy5xUm42PQ@mail.gmail.com>
 <CAF3hT9BdUqoCzSEYYWfa0dckVOzDgKVP2s3zyGK5EeAqNR8AFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48757 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab1HXQlG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2011 12:41:06 -0400
In-Reply-To: <CAF3hT9BdUqoCzSEYYWfa0dckVOzDgKVP2s3zyGK5EeAqNR8AFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Marcus Sorensen <shadowsor@gmail.com>, ceph-devel@vger.kernel.org

On Wed, 24 Aug 2011, Gregory Farnum wrote:
> On Wed, Aug 24, 2011 at 8:29 AM, Marcus Sorensen <shadowsor@gmail.com> wrote:
> > Just thought I'd share this basic testing I did, comparing cephfs 0.32
> > on 3.1-rc1 to nfs as well as rbd to iscsi. I'm sure you guys see a lot
> > of this. Any feedback would be appreciated.
> >
> > The data is here:
> >
> > http://learnitwithme.com/wp-content/uploads/2011/08/ceph-nfs-iscsi-benchmarks.ods
> >
> > and the writeup is here:
> >
> > http://learnitwithme.com/?p=303
> 
> We see less of it than you'd think, actually. Thanks!
> 
> To address a few things specifically
> Ceph is both the name of the project and of the POSIX-compliant
> filesystem. RADOS stands for Reliable Autonomous Distributed Object
> Store. Apparently we should publish this a bit more. :)
> 
> Looks like most of the differences in your tests have to do with our
> relatively lousy read performance -- this is probably due to lousy
> readahead, which nobody's spent a lot of time optimizing as we focus
> on stability. Sage made some improvements a few weeks ago but I don't
> remember what version of stuff they ended up in. :) (Optimizing
> cross-server reads is hard!)

The readahead improvements are in the 'master' branch of ceph-client.git, 
and will go upstream for Linux 3.2-rc1 (I just missed the 3.1-rc1 cutoff).  
In my tests I was limited by the wire speed with these patches.  I'm 
guessing you were using 3.0 or earlier kernel?

The file copy test was also surprising.  I think there is a regression 
there somewhere, taking a look.

sage

