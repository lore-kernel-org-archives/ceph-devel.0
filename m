From: Sage Weil <sage@inktank.com>
Subject: Re: Lots of misdirected client requests with 73984 PGs/pool
Date: Fri, 14 Sep 2012 12:04:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209141203170.16552@cobra.newdream.net>
References: <503D3FA7.2050603@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37265 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759860Ab2INTEg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Sep 2012 15:04:36 -0400
In-Reply-To: <503D3FA7.2050603@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Jim,

On Tue, 28 Aug 2012, Jim Schutt wrote:
> Hi,
> 
> I was testing on 288 OSDs with pg_bits=8, for 73984 PGs/pool,
> 221952 total PGs.
> 
> Writing from CephFS clients generates lots of messages like this:
> 
> 2012-08-28 14:53:33.772344 osd.235 [WRN] client.4533
> 172.17.135.45:0/1432642641 misdirected client.4533.1:124 pg 0.8b9d12d4 to
> osd.235 in e7, client e7 pg 0.112d4 features 262282
> 
> There's no trouble with 288 OSDs and pg_bits=7 (36992 PGs/pool).
> 
> This is all with current Linus master branch + ceph-client testing
> branch, and master branch on the server side.
> 
> Does this have anything to do with old_pg_t AKA struct ceph_pg
> only using 16 bits for the placement seed?

I think so.  We just need to update the kernel to understand the new 
structures.. unfortunately that inlcudes a bunch of message types (MOSDOp 
and MOSDMap for starters, I think), but it'll be nice to move things 
forward.

sage

> 
> I'd about to start testing on 576 OSDs, and was hoping to use
> pg_bits=7 to get more uniform data placement across OSDs.
> My first step on that path was 288 OSDs with pg_bits=8.
> 
> Maybe I can't, or I have to just ignore the warnings, until
> the kernel's libceph learns about 32-bit placement seeds?
> 
> Or maybe this 16-bit seed theory is all wrong, and something
> else is going on?  If so, what more information is needed
> to help sort this out?
> 
> Thanks -- Jim
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
