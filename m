From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Slow request in XFS
Date: Thu, 31 Jan 2013 08:15:44 -0700
Message-ID: <510A8AA0.6000508@sandia.gov>
References: <6F3FA899187F0043BA1827A69DA2F7CC5EA81F@SHSMSX102.ccr.corp.intel.com>
 <alpine.DEB.2.00.1301310441590.11107@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [132.175.109.14] ([132.175.109.14]:60425 "EHLO
	sentry-two.sandia.gov" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab3AaPQ1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 10:16:27 -0500
In-Reply-To: <alpine.DEB.2.00.1301310441590.11107@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/31/2013 05:43 AM, Sage Weil wrote:
> Hi-
> 
> Can you reproduce this with logs?  It looks like there are a few ops that 
> are hanging for a very long time, but there isn't enough information here 
> except to point to osds 610, 612, 615, and 68...

FWIW, I have a small pile of disks with bad sections in
them - these sections aren't bad enough that writes fail,
but they are bad enough that throughput drops by a factor
of ~20.

Do OSDs already collect statistics on, say, op commit
elapsed time (assuming that's the statistic most directly
related to slow writes on only some sections of a disk),
in a way that could be used to diagnose such disks?

If not, is there enough structure already in place that
it would be easy to add?

-- Jim

> 
> thanks!
> s


