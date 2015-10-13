From: Sage Weil <sweil@redhat.com>
Subject: Re: chooseleaf may cause some unnecessary pg migrations
Date: Tue, 13 Oct 2015 09:44:45 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510130940400.6589@cobra.newdream.net>
References: <FF8D83DAE5DF57468726B79904321E06046B73@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46129 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118AbbJMQos (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 13 Oct 2015 12:44:48 -0400
In-Reply-To: <FF8D83DAE5DF57468726B79904321E06046B73@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xusangdi <xu.sangdi@h3c.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sangdi,

On Tue, 13 Oct 2015, Xusangdi wrote:
> Hi Sage,
> 
> Recently when I was learning about the crush rules I noticed that the step chooseleaf may cause some unnecessary pg migrations when OSDs are outed.
> For example, for a cluster of 4 hosts with 2 OSDs each, after host1(osd.2, osd.3) is down, the mapping differences would be like this:
> pgid    before <-> after        diff    diff_num
> 0.1e    [5, 1, 2] <-> [5, 1, 7]         [2]     1
> 0.1f    [0, 7, 3] <-> [0, 7, 4]         [3]     1
> 0.1a    [0, 4, 3] <-> [0, 4, 6]         [3]     1
> 0.5     [6, 3, 1] <-> [6, 0, 5]         [1, 3]  2
> 0.4     [5, 6, 2] <-> [5, 6, 0]         [2]     1
> 0.7     [3, 7, 0] <-> [7, 0, 4]         [3]     1
> 0.6     [2, 1, 7] <-> [0, 7, 4]         [1, 2]  2
> 0.9     [3, 4, 0] <-> [5, 0, 7]         [3, 4]  2
> 0.15    [2, 6, 1] <-> [6, 0, 5]         [1, 2]  2
> 0.14    [3, 6, 5] <-> [7, 4, 1]         [3, 5, 6]       3
> 0.17    [0, 5, 2] <-> [0, 5, 6]         [2]     1
> 0.16    [0, 4, 2] <-> [0, 4, 7]         [2]     1
> 0.11    [4, 7, 2] <-> [4, 7, 1]         [2]     1
> 0.10    [0, 3, 6] <-> [0, 7, 4]         [3, 6]  2
> 0.13    [1, 7, 3] <-> [1, 7, 4]         [3]     1
> 0.a     [0, 2, 7] <-> [0, 7, 4]         [2]     1
> 0.c     [5, 0, 3] <-> [5, 0, 6]         [3]     1
> 0.b     [2, 5, 7] <-> [4, 7, 0]         [2, 5]  2
> 0.18    [7, 2, 4] <-> [7, 4, 0]         [2]     1
> 0.f     [2, 7, 5] <-> [6, 4, 0]         [2, 5, 7]       3
> Changed pg ratio: 30 / 32
> 
> I tried to change the code (please see https://github.com/ceph/ceph/pull/6242) and after the modification the result would be like this:

Can you describe the reasoning behind the change?  I can't make sense 
of it.  The recursive call is still picking just 1 item, but it looks 
like it is always choosing a device in for slot 0 and not the current 
slot in the caller.  I'm not sure how that could generate a correct 
result.

Perhaps you can share the osd tree output so we can see how your map it 
structured?

It is normal for some mappings to have multiple items change, as I've 
described previously on this list.  It's a result of the fact that we're 
considering totally independent series of items, but whether we accept a 
choice also depends on the previous choices (we do not allow dups).. which 
means that you get echo effects in later slots when we make a different 
choice in earlier slots.

Thanks!
sage


> pgid    before <-> after        diff    diff_num
> 0.1e    [5, 0, 3] <-> [5, 0, 7]         [3]     1
> 0.1f    [0, 6, 3] <-> [0, 6, 4]         [3]     1
> 0.1a    [0, 5, 2] <-> [0, 5, 6]         [2]     1
> 0.5     [6, 3, 0] <-> [6, 0, 5]         [3]     1
> 0.4     [5, 7, 2] <-> [5, 7, 0]         [2]     1
> 0.7     [3, 7, 1] <-> [7, 1, 5]         [3]     1
> 0.6     [2, 0, 7] <-> [0, 7, 4]         [2]     1
> 0.9     [3, 5, 1] <-> [5, 1, 7]         [3]     1
> 0.15    [2, 6, 1] <-> [6, 1, 4]         [2]     1
> 0.14    [3, 7, 5] <-> [7, 5, 1]         [3]     1
> 0.17    [0, 4, 3] <-> [0, 4, 6]         [3]     1
> 0.16    [0, 4, 3] <-> [0, 4, 6]         [3]     1
> 0.11    [4, 6, 3] <-> [4, 6, 0]         [3]     1
> 0.10    [0, 3, 6] <-> [0, 6, 5]         [3]     1
> 0.13    [1, 7, 3] <-> [1, 7, 5]         [3]     1
> 0.a     [0, 3, 6] <-> [0, 6, 5]         [3]     1
> 0.c     [5, 0, 3] <-> [5, 0, 6]         [3]     1
> 0.b     [2, 4, 6] <-> [4, 6, 1]         [2]     1
> 0.18    [7, 3, 5] <-> [7, 5, 1]         [3]     1
> 0.f     [2, 6, 5] <-> [6, 5, 1]         [2]     1
> Changed pg ratio: 20 / 32
> 
> Currently the only defect I can see from the change is that the chance for a given pg to successfully choose required available OSDs might be a bit lower compared with before. However, I believe it will cause problems only when the cluster is pretty small and degraded. And in that case, we can still make it workable by tuning some of the crushmap parameters such as chooseleaf_tries.
> 
> Anyway I'm not sure if it would raise any other issues, could you please review it and maybe give me some suggestions? Thank you!
> 
> ----------
> Best regards,
> Sangdi
> 
> -------------------------------------------------------------------------------------------------------------------------------------
> ????????????????????????????????????????
> ????????????????????????????????????????
> ????????????????????????????????????????
> ???
> This e-mail and its attachments contain confidential information from H3C, which is
> intended only for the person or entity whose address is listed above. Any use of the
> information contained herein in any way (including, but not limited to, total or partial
> disclosure, reproduction, or dissemination) by persons other than the intended
> recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
> by phone or email immediately and delete it!
> N?????r??y??????X???v???)?{.n?????z?]z????ay?????j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
