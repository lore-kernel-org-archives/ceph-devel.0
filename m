From: Sage Weil <sage@inktank.com>
Subject: Re: Ceph status for Wheezy
Date: Sat, 30 Jun 2012 23:12:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206302303580.11497@cobra.newdream.net>
References: <1341122210.10000.46.camel@julia>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38917 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab2GAGMj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Jul 2012 02:12:39 -0400
In-Reply-To: <1341122210.10000.46.camel@julia>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Laszlo,

On Sun, 1 Jul 2012, Laszlo Boszormenyi (GCS) wrote:
> Hi Sage,
> 
> As previously noted, using leveldb caused some trouble with Ceph could
> be included in Wheezy or not.
> I've proposed that the supported architectures should be limited in Ceph
> and leveldb to the ones the latter supports. I got a release critical
> bugreport[1] that it should be reversed. Alessio Treglia, the leveldb
> maintainer in Debian wrote the following:
> "I'm going to test leveldb on powerpc and then I'll report my results
> to upstream.
> Hence I cannot promise it will be ready in time for Wheezy, of course
> I'll upload a patch as soon as a fix becomes available.".
> 
> Upstream was asked[2], noted that it fails on big-endian architectures,
> but no answer until now.
> 
> Then, as it was previously announced, the freeze of Wheezy started some
> hours ago[3].
> 
> Soon, after that Julien Cristau, one of our Release Assistant noted
> about Ceph doesn't build on all architectures due to leveldb:
> "Unless this gets fixed we'll have to remove ceph from wheezy.  Which
> means qemu and qemu-kvm need to drop their build-deps on ceph packages.
> They can always be re-added if/when leveldb/ceph are fixed.".
> 
> It seems everything is up to leveldb upstream/maintainer now. It is
> fixed in time on big-endian machines or the package will be limited to
> little-endian machines as I wanted to do with Ceph.

Fingers crossed!

> But please look into the reason why Ceph fails to build on ia64[4].

Argh, this looks like a (silly) problem with libatomic-ops-dev.  We should 
have a configure/build option to use the new c++11 atomic types instead; 
that may be less painful than dealing with it.

> Also, how 0.48 goes? Will it contain big differences to 0.47.2? As you
> can read, even 0.47.2 is in question for Wheezy. But would you propose
> 0.48 for inclusion when it's released?

Barring any last-minute catastrophies, 0.48 should be released Monday.  
Packaging-wise it will be pretty similar to 0.47.2, except for the stuff 
from you I've pulled upstream over the last couple of weeks (separate 
ceph-fs-common package, small fixups).  0.48 will also be our first 
longer-term stable release, so it is much better-suited than 0.4.2 for 
inclusion in wheezy.

sage
