From: Sage Weil <sweil@redhat.com>
Subject: Re: zero length write fro store_test to bluestore
Date: Mon, 20 Jun 2016 13:55:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606201354350.21827@piezo.us.to>
References: <e175ac33-0398-2154-6edd-6ee932509c8c@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49472 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927AbcFTODU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 20 Jun 2016 10:03:20 -0400
In-Reply-To: <e175ac33-0398-2154-6edd-6ee932509c8c@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 20 Jun 2016, Igor Fedotov wrote:
> Hi All,
> 
> I'm hitting the following issue while running Synthetic test case (from
> store_test.cc) against bluestore:
> 
> store_test asserts on read data mismatch when read happens after the
> zero-length write above object boundary.
> 
> Test case assumes all the data between the old and new object boundaries are
> filled with zeros. But current bluestore write path implementation simply
> discards zero-length writes and hence doesn't raise object size. As a result
> subsequent read doesn't return anything above the old boundary.
> 
> The question is what's the proper fix for that:
> 
> 1) Ignore zero-length writes in the test case and do not increase object
> size/fill content on them.
> 
> or
> 
> 2) Increase object content size on such writes in the bluestore.

Heh, I just hit this too.  I think it makes more sense for 0 
length writes to not affect object size.  I added a test for it 
and fixed Memstore.  store_test.cc needs to be adjusted still though...

Pushed patches to top of wip-bluestore-2q, do you mind pulling those 2 out 
and fixing store_test in another PR?

Thanks!
sage

