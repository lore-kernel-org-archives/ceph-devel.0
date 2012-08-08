From: Guangliang Zhao <gzhao@suse.com>
Subject: Re: [PATCH v4] rbd: fix the memory leak of bio_chain_clone
Date: Wed, 8 Aug 2012 14:09:45 +0800
Message-ID: <20120808060945.GB8588@linux-b964.site>
References: <1344015188-11289-1-git-send-email-gzhao@suse.com>
 <5021D3B1.20401@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from user.194.126.222.zhong-ren.net ([222.126.194.154]:1650 "EHLO
	linux-b964.site" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752324Ab2HHGKQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Aug 2012 02:10:16 -0400
Content-Disposition: inline
In-Reply-To: <5021D3B1.20401@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Aug 07, 2012 at 07:49:21PM -0700, Alex Elder wrote:
> On 08/03/2012 10:33 AM, Guangliang Zhao wrote:
> >The bio_pair alloced in bio_chain_clone would not be freed,
> >this will cause a memory leak. It could be freed actually only
> >after 3 times release, because the reference count of bio_pair
> >is initialized to 3 when bio_split and bio_pair_release only
> >drops the reference count.
> 
> Last Friday I added this patch to the testing branch and
> ran the xfstests-on-rbd suite on it, and it triggered some
> new errors.  I did not have time to investigate them though.
> 
> I am taking this latest version and will apply it and will
> run it through the same series of tests.
Please notify me of any issues about the tests.
> 
> I also had hoped to give your patch a careful review, but
> so far I haven't managed to do that (yet).
> 
> I just want you to know you haven't been forgotten...
Thanks for your reply :).

-- 
Best regards,
Guangliang
