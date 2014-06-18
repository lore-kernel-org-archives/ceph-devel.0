From: Sebastien Ponce <sebastien.ponce@cern.ch>
Subject: Re: New Defects reported by Coverity Scan for ceph (fwd)
Date: Wed, 18 Jun 2014 09:37:39 +0200
Message-ID: <1403077059.4397.10.camel@sebmain.cern.ch>
References: <alpine.DEB.2.00.1406070911560.11424@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:17475 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933231AbaFRHii (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 18 Jun 2014 03:38:38 -0400
In-Reply-To: <alpine.DEB.2.00.1406070911560.11424@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

I've now looked at the defects. And according to me, there are mostly
irrelevant.
There are 2 cases :
  - the 2 "division by zero" will never happen because we will never run
the test with a zero parameter. Still, I've added an ASSERT to avoid
their report.
  - all the rest is a clash between gtest and coverity : whenever you
allocate something via the C API and you have an assert between this
allocation and the deallocation, you have a potential resource leak if
the assert fails. However, avoiding it means wrapping all the C API in a
kind of autoPtr interface. I do not believe it's worth it for test code.
By the way, the rados tests must have the same leaks a priori and I
suppose they are ignored.

So is it ok to commit the 2 new asserts and ignore the other defects ?

Cheers,

Sebastien

On Sat, 2014-06-07 at 09:12 -0700, Sage Weil wrote:
> Mostly stuff in teh new libradosstriper code, it looks like.


