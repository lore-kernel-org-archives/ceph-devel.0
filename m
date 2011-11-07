From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: ceph-mon blocked error
Date: Mon, 7 Nov 2011 15:45:09 -0800
Message-ID: <CAORUGqBHpYOaZMKW8BoZ=zrZXuR3FLTJV__y6ZJvLv3JnDPDiA@mail.gmail.com>
References: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
 <CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com>
 <CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
 <orwrbfu4js.fsf@livre.localdomain> <CA+jddaMPvTae_W_zKyjTewiKEzpJ_FB_zQoS=4J5pjEcOj90sQ@mail.gmail.com>
 <orobwqt186.fsf@livre.localdomain> <CA+jddaMvo2XWAv2BvfEqBwMXYv8JV4MmFGXYF-0F2hQx92FGfw@mail.gmail.com>
 <CAF3hT9DPq_X5F2ZK0JU5jh+ugMX_DzfB2hYTLRJ5G3aELRKKag@mail.gmail.com>
 <CAORUGqD0EL4yb-RbrixJPkwjSubPpJD5NKX-2OwK6656bkgjHA@mail.gmail.com>
 <CA+jddaO4H7owZ_byUprBCfvgCUTUC8ceePyPh_7G_SE8c_kKZA@mail.gmail.com>
 <Pine.LNX.4.64.1111071508450.32056@cobra.newdream.net> <CAORUGqDygO3LWTY2quuq_MPRFKi3RU+wwuGnEk-veBnf29tk0g@mail.gmail.com>
 <CAF3hT9DxEyKHDxOE+Ky1A5Oa4xHDE0=VqQAYEb161i7-mFT7Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64746 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823Ab1KGXpb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 18:45:31 -0500
Received: by wwi36 with SMTP id 36so7491026wwi.1
        for <ceph-devel@vger.kernel.org>; Mon, 07 Nov 2011 15:45:30 -0800 (PST)
In-Reply-To: <CAF3hT9DxEyKHDxOE+Ky1A5Oa4xHDE0=VqQAYEb161i7-mFT7Jg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, Mandell Degerness <mandell@pistoncloud.com>, Alexandre Oliva <oliva@lsd.ic.unicamp.br>, ceph-devel@vger.kernel.org

On Mon, Nov 7, 2011 at 15:43, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> There are two different deadlock problems in this thread: sync
> deadlock (due to syncs triggering a recursive sync call) versus memory
> pressure writeout deadlock.
>
> The first is dealt with by using syncfs; the second is usually dealt
> with by using a userspace client (because then the OS can swap the
> userspace client memory to disk if necessary).

Oh yes. So for the second part, Mandell needs to make sure he's using
qemu-rbd and not rbd.ko (e.g. with Xen), and then with the right
backing filesystem choice and new enough software, he should be safe.
