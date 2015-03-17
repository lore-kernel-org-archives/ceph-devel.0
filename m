From: =?UTF-8?B?5b6Q5piV?= <xuxinhfut@gmail.com>
Subject: =?UTF-8?Q?Can_i_improve_the_performance_of_rbd_rollback_in_thi?=
	=?UTF-8?Q?s_way=EF=BC=9F?=
Date: Tue, 17 Mar 2015 11:24:28 +0800
Message-ID: <CAO7bE7fXz7-An2REcJKSjsb-HZFMnfi0Bo-MWtskptmLDd=8_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35508 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbbCQDY3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Mar 2015 23:24:29 -0400
Received: by oiag65 with SMTP id g65so55242719oia.2
        for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2015 20:24:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I am a newbie to ceph. Recently i need to improve the performance of
rbd rollback on xfs in my project. Through experiment i found that the
mechanism of rbd rollback is like this:

When a image is rolled back to one of its snapshot (say N), for every
object that has been allocated,
case A) if the object has no snap version since snap N, then the head
version will be copied back to the latest snap (say N+M);
case B) if the object has snap version since snap N, and it has the
latest snap version (N+M), then the oldest snap version since snap N
(say N+x, 0<=x<=M) will be copied to cover the head version;
case C) if the object has snap version since snap N, and it has no
version in the latest snap (N+M), then the head version will be copied
back to the latest snap N+M, and the oldest snap version since snap N
(say N+x, 0<=x<M) will be copied to cover the head version.

I think in case A, we need not to copied the head version back. So for
improving performance, i comment the following statement in function
ReplicatedPG::_rollback_to in osd/ReplicatedPG.cc,

......
else if (rollback_to->obs.oi.soid.snap == CEPH_NOSNAP) {
      // rolling back to the head; we just need to clone it.
      // ctx->modify = true;
}
......

Can i improve performance of rollback like this? If CAN NOT, what is the reason?

Thank you.

Xin Xu
