From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph status for Wheezy
Date: Sun, 1 Jul 2012 08:15:29 -0700
Message-ID: <7261D0EFF7E14D449A42FDD4C3632870@inktank.com>
References: <1341122210.10000.46.camel@julia>
 <Pine.LNX.4.64.1206302303580.11497@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56635 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734Ab2GAPPb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Jul 2012 11:15:31 -0400
Received: by dady13 with SMTP id y13so6373113dad.19
        for <ceph-devel@vger.kernel.org>; Sun, 01 Jul 2012 08:15:31 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206302303580.11497@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>, Ceph Development <ceph-devel@vger.kernel.org>

On Saturday, June 30, 2012 at 11:12 PM, Sage Weil wrote:
> Hi Laszlo,
> 
> On Sun, 1 Jul 2012, Laszlo Boszormenyi (GCS) wrote:
> > Hi Sage,
> > 
> > As previously noted, using leveldb caused some trouble with Ceph could
> > be included in Wheezy or not.
> > I've proposed that the supported architectures should be limited in Ceph
> > and leveldb to the ones the latter supports. I got a release critical
> > bugreport[1] that it should be reversed. Alessio Treglia, the leveldb
> > maintainer in Debian wrote the following:
> > "I'm going to test leveldb on powerpc and then I'll report my results
> > to upstream.
> > Hence I cannot promise it will be ready in time for Wheezy, of course
> > I'll upload a patch as soon as a fix becomes available.".
> > 
> > Upstream was asked[2], noted that it fails on big-endian architectures,
> > but no answer until now.
> > 
> > Then, as it was previously announced, the freeze of Wheezy started some
> > hours ago[3].
> > 
> > Soon, after that Julien Cristau, one of our Release Assistant noted
> > about Ceph doesn't build on all architectures due to leveldb:
> > "Unless this gets fixed we'll have to remove ceph from wheezy. Which
> > means qemu and qemu-kvm need to drop their build-deps on ceph packages.
> > They can always be re-added if/when leveldb/ceph are fixed.".
> > 
> > It seems everything is up to leveldb upstream/maintainer now. It is
> > fixed in time on big-endian machines or the package will be limited to
> > little-endian machines as I wanted to do with Ceph.
> 
> 
> 
> Fingers crossed!
> 
> > But please look into the reason why Ceph fails to build on ia64[4].
> 
> Argh, this looks like a (silly) problem with libatomic-ops-dev. We should 
> have a configure/build option to use the new c++11 atomic types instead; 
> that may be less painful than dealing with it.

This part at least shouldn't take long to get fixed for us; it's already in the Debian bug system and upstream accepted a patch:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=679680 
-Greg

