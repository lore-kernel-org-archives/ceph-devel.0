From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Newstore Update Part 2
Date: Mon, 11 May 2015 11:21:31 -0400
Message-ID: <CANP1eJEYWgp=BHh314uGqH9MAm2aW3hXgPFmVk+X4s+gQzn+HQ@mail.gmail.com>
References: <554D44E3.7080600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:35751 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbbEKPVd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 11:21:33 -0400
Received: by labbd9 with SMTP id bd9so95802460lab.2
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 08:21:31 -0700 (PDT)
In-Reply-To: <554D44E3.7080600@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, May 8, 2015 at 7:21 PM, Mark Nelson <mnelson@redhat.com> wrote:
>
> Hi Guys,
>
> At the performance meeting this week we discussed the possibility of changing how newstore handles large partial overwrites.  To determine if this is useful, we look at rados bench and rbd performance of newstore at various IO sizes.  I've also included some rados bench read results as folks were interested in those.  On the graphs I've tried to mark interesting improvements/regressions and also some questions/comments. These tests were run without overlay which may help small IO performance in some cases.
>
> Graphs are here:
>
> http://nhm.ceph.com/newstore/8c8c5903_rbd_rados_tests.pdf
>
> Thanks,
> Mark


May I suggest that we try to test new store aging (no pun intended).
I'm worried that inevitably we'll have cases crop up where newstore
degrades after prolonged usage (real-world). Case like:

1) Behavior after a few TB has been written
2) Behavior of OSDs with newstore after it's 50% full.
3) Behavior after many write/del operations.

I'm sure I'm missing many scenarios. We're dealing with quintessential
filesystem design problem, how do deliver predictable performance
after it's been used for a long time. Design maturing pains.

-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
