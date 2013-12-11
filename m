From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: question for the new ceph-osd key/value backend
Date: Wed, 11 Dec 2013 20:12:47 +1300
Message-ID: <52A8106F.30407@catalyst.net.nz>
References: <A9F57F2ABA6BB2469F01E127557C6C9B10E7BEDD@SHSMSX104.ccr.corp.intel.com> <alpine.DEB.2.00.1312102155520.19333@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:57939 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab3LKHMs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 02:12:48 -0500
In-Reply-To: <alpine.DEB.2.00.1312102155520.19333@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, "Duan, Jiangang" <jiangang.duan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/12/13 19:09, Sage Weil wrote:

> That is one part.  The current strategy of layering on top of a file
> system and using a write-ahead journal makes sense given the existing
> linux fs building blocks, but is far from an optimal solution for many
> workloads.  A k/v interface based on something leveldb probably performs
> much better for many small-object use-cases.  Also, a k/v backend can take
> advatange of emerging non-block storage interfaces like NVMKV, Kinetic,
> new libraries like rocksdb, etc.
>

Yeah, the pluggable backend approach seems like a really good plan.

Regards

Mark

