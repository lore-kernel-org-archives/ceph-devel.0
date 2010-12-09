From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: FAILED assert(!missing.is_missing(soid))
Date: Thu, 9 Dec 2010 12:16:12 -0800
Message-ID: <AANLkTikOFkior_NR2sbC1y0Y9wWYPQRkNm=j8GNzZ-Jp@mail.gmail.com>
References: <AANLkTin3eipR98c4B+g=bsGmTn4p3ncWpQ=N8y1uEx-W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:60216 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab0LIUQN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Dec 2010 15:16:13 -0500
Received: by fxm18 with SMTP id 18so2880888fxm.2
        for <ceph-devel@vger.kernel.org>; Thu, 09 Dec 2010 12:16:12 -0800 (PST)
In-Reply-To: <AANLkTin3eipR98c4B+g=bsGmTn4p3ncWpQ=N8y1uEx-W@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

Hi Christian,

If you still have the logs for the OSD that had the problem, I'd like
to take a look.

Colin


On Thu, Dec 9, 2010 at 11:49 AM, Christian Brunner <chb@muc.de> wrote:
> Hi,
>
> while doing further stress testing one of our osds died with an asser=
t:
>
> osd/ReplicatedPG.cc: In function 'void ReplicatedPG::sub_op_modify(MO=
SDSubOp*)':
> osd/ReplicatedPG.cc:2528: FAILED assert(!missing.is_missing(soid))
> ceph version 0.24~rc (commit:)
> =A01: (ReplicatedPG::sub_op_modify(MOSDSubOp*)+0xd08) [0x488358]
> =A02: (OSD::dequeue_op(PG*)+0x374) [0x4cc284]
> =A03: (ThreadPool::worker()+0x28f) [0x5bd04f]
> =A04: (ThreadPool::WorkThread::entry()+0xd) [0x4f4a1d]
> =A05: (Thread::_entry_func(void*)+0x7) [0x4723c7]
> =A06: (()+0x77e1) [0x7fb5e37327e1]
> =A07: (clone()+0x6d) [0x7fb5e275253d]
>
> The rc-version we are using is from Dec 3rd (approximately).
>
> I'm not sure if we can reproduce this, but if you need further debug
> output we will try to.
>
> Regards,
> Christian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
