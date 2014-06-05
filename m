From: Sage Weil <sage@inktank.com>
Subject: Re: Mon backing store
Date: Thu, 5 Jun 2014 11:26:03 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406051124330.11281@cobra.newdream.net>
References: <CA+4uBUZaFHhyn9Brx=dM08qFgPFQiAohufpVk+GH5zCR9Hzb0Q@mail.gmail.com> <5390B470.4010608@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36822 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbaFES0E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jun 2014 14:26:04 -0400
In-Reply-To: <5390B470.4010608@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 5 Jun 2014, Mark Nelson wrote:
> On 06/05/2014 12:42 PM, Samuel Just wrote:
> > I am starting to wonder whether using leveldb for the mon is actually
> > introducing an excessive amount unnecessary complexity and
> > non-determinism.  Given that the monitor workload is read mostly,
> > except for failure conditions when it becomes write latency sensitive,
> > might we do better with a strict b-tree style backing db such as
> > berkely db even at the cost of some performance?  It seems like
> > something like that might provide more reliable latency properties.
> 
> I'm not against trying it, but I'm not convinced it's the right solution.  If
> the 99th percentile latency is significantly better, that's obviously a win,
> but I think we are indeed going to take a big performance hit overall.  I'm
> more in favor of trying rocksdb first. I'm certainly not as well versed in the
> leveldb interface as you or Joao are, but it appears much of our code in
> LevelDBStore would be reusable.  I don't know that rocksdb won't have the same
> issues that leveldb does, but the rocksdb developers specifically mention
> leveldb's bad 99th percentile latencies as a driver for it's development:

FWIW, wip-rocksdb is just waiting on some build cleanups to merge.  It 
will be usable everywhere that leveldb currently is, with the backend 
swappable via a config option.

Adding BDB into the mix should be relatively painless...

sage
