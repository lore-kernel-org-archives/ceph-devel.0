From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: leveldb compaction overhead
Date: Wed, 5 Jun 2013 13:16:10 -0600
Message-ID: <51AF8E7A.9050606@sandia.gov>
References: <alpine.DEB.2.00.1305291406080.16097@cobra.newdream.net>
 <51A916AE.9010700@sandia.gov>
 <alpine.DEB.2.00.1305311659200.16097@cobra.newdream.net>
 <51AF8AC8.6030301@sandia.gov> <51AF8BF2.5090304@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:40550 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354Ab3FETQ3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Jun 2013 15:16:29 -0400
In-Reply-To: <51AF8BF2.5090304@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On 06/05/2013 01:05 PM, Mark Nelson wrote:
> 
> FWIW, I've been fighting with some mon/leveldb issues on 24-node test
> cluster causing high CPU utilization, constant reads, laggy osdmap
> updates, and mons dropping out of quorum.  Work is going on in
> wip-mon.  Should have some more testing done later today.  Other than
> some crashing it appears to be behaving much better. ;)

Cool!

I've seen that branch, but haven't had a chance to take it for
a spin yet....

Thanks -- Jim

> 
> Mark


