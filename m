From: Maged Mokhtar <mmokhtar@petasan.org>
Subject: Re: wip-fancy-striping in ceph/ceph-client
Date: Fri, 16 Feb 2018 18:30:11 +0200
Message-ID: <acdbe5717d29dccdb7dae03696204886@petasan.org>
References: <CAOi1vP-4_gmH2DqL2EN2_MkLju3frqBkbun7P=U=HrMUMLnOgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:59604 "EHLO
        outbound-ss-1812.hostmonster.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755551AbeBPQvE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:51:04 -0500
Received: from cmgw3 (cmgw4 [10.0.90.84])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id 63588175B74
        for <ceph-devel@vger.kernel.org>; Fri, 16 Feb 2018 09:30:15 -0700 (MST)
In-Reply-To: <CAOi1vP-4_gmH2DqL2EN2_MkLju3frqBkbun7P=U=HrMUMLnOgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@linaro.org>, David Disseldorp <ddiss@suse.de>

On 2018-02-13 11:58, Ilya Dryomov wrote:

> Hello,
> 
> I've pushed wip-fancy-striping with my striping v2 patches.  I didn't
> want to patch bomb the list and opened a dummy PR for feedback:
> 
> https://github.com/ceph/ceph-client/pull/19
> 
> As this is a full striping v2 implementation with adjacent extent
> merging and no limitations on parent layouts, the patch set is very
> invasive -- it's basically a rewrite of the entire I/O path.  Any
> review comments and testing cycles would be greatly appreciated!
> 
> Thanks,
> 
> Ilya

Hi Ilya,

I looked at the patches, it is not a small change but is very nicely 
done. i was surprised since even though you added complex feature 
support, the new code is less (in rbd.c) and is clearer. The different 
fill from functions and different osd request creation functions is a 
very clean design.

If i may say any minor/cosmetic comments:

Out of all the old code i was happy to see removed, the only thing i 
would "miss" is the obj_requests list in the rbd_img_request struct. It 
is not needed now, but i tend to think it is logical to have a place to 
find all osd requests for a particular top block layer request. it maybe 
just a warm a and fuzzy feeling to have this control, but it could be 
useful for debugging or if in the future we think of implementing a task 
abort operation and need to find the osd inflight ops in a quick way.

Another cosmetic thing, i tend to think the new object <-> file extent 
conversion be placed in a separate new file rather than osdmap.c

I would not be able to do full test any time soon, but i do intend to do 
some manual testing of basic functionality next week. i have in mind 
writing data pattern with each value repeating the size of stripe unit 
and doing a mix of read/write interchangeably between rbd and librbd, i 
would also test copyup functionality in clones. I will let you know if i 
do find any issues.

Cheers
Maged
