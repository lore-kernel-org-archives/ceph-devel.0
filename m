From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: ceph-mon blocked error
Date: Mon, 7 Nov 2011 15:34:14 -0800
Message-ID: <CAORUGqDygO3LWTY2quuq_MPRFKi3RU+wwuGnEk-veBnf29tk0g@mail.gmail.com>
References: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
 <CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com>
 <CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
 <orwrbfu4js.fsf@livre.localdomain> <CA+jddaMPvTae_W_zKyjTewiKEzpJ_FB_zQoS=4J5pjEcOj90sQ@mail.gmail.com>
 <orobwqt186.fsf@livre.localdomain> <CA+jddaMvo2XWAv2BvfEqBwMXYv8JV4MmFGXYF-0F2hQx92FGfw@mail.gmail.com>
 <CAF3hT9DPq_X5F2ZK0JU5jh+ugMX_DzfB2hYTLRJ5G3aELRKKag@mail.gmail.com>
 <CAORUGqD0EL4yb-RbrixJPkwjSubPpJD5NKX-2OwK6656bkgjHA@mail.gmail.com>
 <CA+jddaO4H7owZ_byUprBCfvgCUTUC8ceePyPh_7G_SE8c_kKZA@mail.gmail.com> <Pine.LNX.4.64.1111071508450.32056@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40306 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab1KGXeg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 18:34:36 -0500
Received: by wwi36 with SMTP id 36so7480913wwi.1
        for <ceph-devel@vger.kernel.org>; Mon, 07 Nov 2011 15:34:35 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1111071508450.32056@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Mandell Degerness <mandell@pistoncloud.com>, Gregory Farnum <gregory.farnum@dreamhost.com>, Alexandre Oliva <oliva@lsd.ic.unicamp.br>, ceph-devel@vger.kernel.org

On Mon, Nov 7, 2011 at 15:10, Sage Weil <sage@newdream.net> wrote:
> It applies to RBD too... _if_ the ceph-osd process is calling sync(2)=
=2E
> On btrfs it doesn't, and on XFS/extN/etc., it only does on older kern=
els
> with older glibc. =C2=A0New kernels (.39+) and new glibc have syncfs(=
2), which
> syncs only the fs the ceph-osd is serving up.
>
> http://linux.die.net/man/2/syncfs

I'm willing to believe syncfs(2) makes the deadlock more rare, but
isn't it still possible?

e.g. see slide 23 of www.scs.stanford.edu/nyu/02fa/notes/l3.pdf for a
description of this in context of loopback NFS. If rbd.ko does write
caching, and uses buffer cache for it:

1. ceph-osd reads a file from local disk
2. the fs needs to allocate a buffer
3. vm chooses dirty buffer in rbd cache to flush
4. rbd.ko blocks waiting for ceph-osd, which is waiting to read the
file from disk in step 1.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
