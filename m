From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: ceph-resource-agents
Date: Thu, 16 Feb 2012 15:13:46 -0800
Message-ID: <A0A6E7A3-540F-42E7-A160-C29C1F47201A@cs.ucsc.edu>
References: <989BA3D6-5844-4566-AA9B-69A0472C0228@cs.ucsc.edu> <Pine.LNX.4.64.1202161506340.20265@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:39163 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab2BPXNs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2012 18:13:48 -0500
In-Reply-To: <Pine.LNX.4.64.1202161506340.20265@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


On Feb 16, 2012, at 3:09 PM, Sage Weil wrote:

> On Thu, 16 Feb 2012, Noah Watkins wrote:
> 
> That package is a recommends, right?  This doesn't break the ceph package 
> itself?

I think so, but it does show up in the 10.04 repositories without its dependency being available via aptitude. I wan't sure if that is the expected behavior, or if it should only show up in 11.10 and later.

Thanks,
-Noah