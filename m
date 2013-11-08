From: Sage Weil <sage@inktank.com>
Subject: Signed-off-by: and jenkins
Date: Thu, 7 Nov 2013 20:16:15 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311072013280.15297@cobra.newdream.net>
References: <ceph/ceph/pull/794@github.com> <CABBk=J-ih=nPn7nJsgjM1EA4kwvZoBXxyFvHXB6Ax0SG02FB2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48523 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab3KHEQP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 23:16:15 -0500
In-Reply-To: <CABBk=J-ih=nPn7nJsgjM1EA4kwvZoBXxyFvHXB6Ax0SG02FB2A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Tangential thought: we've set up Jenkins on other repos to do some basic 
tests.  The plan is to do the same for the ceph.git, but the test of tests 
is much more extensive (build tests, possibly teuthology tests).

I wonder if an easy first step would be a trivial test that just verifies 
that everything has a Signed-off-by.  That would get jenkins into the 
pipeline and we can build from there...

[Background: every commit to ceph needs a 

 Signed-off-by: Name <email>

line to acknowledge/consent to the open source software license; see
https://github.com/ceph/ceph/blob/master/SubmittingPatches
]

sage


On Thu, 7 Nov 2013, Yehuda Sadeh wrote:

> Hey,
> 
>   I wanted to backport that fix to dumpling, but just noticed that the
> commits were missing a signed-off-by line. Can I add it?
> 
> Thanks,
> Yehuda
> 
> 
> ---------- Forwarded message ----------
> From: Xiangyu (Ray) Lv <notifications@github.com>
> Date: Wed, Oct 30, 2013 at 7:24 PM
> Subject: [ceph] Put obj sometimes got 405 (#794)
> To: ceph/ceph <ceph@noreply.github.com>
> Cc: Yehuda Sadeh <yehuda@inktank.com>
> 
> 
> Fixes:
> 
> Bug #6672 (http://tracker.ceph.com/issues/6672)
> 
> Original discussion at #783
> Branch reviewed by @yehudasa.
> 
> ________________________________
> 
> You can merge this Pull Request by running
> 
>   git pull https://github.com/xylv/ceph put-obj-sometimes-got-405
> 
> Or view, comment on, or merge it at:
> 
>   https://github.com/ceph/ceph/pull/794
> 
> Commit Summary
> 
> [rgw] Set initialized to true after populating table in hex_to_num()
> Wrap hex_to_num table into class HexTable
> 
> File Changes
> 
> M src/rgw/rgw_common.cc (20)
> 
> Patch Links:
> 
> https://github.com/ceph/ceph/pull/794.patch
> https://github.com/ceph/ceph/pull/794.diff
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
