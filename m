From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ceph-mon blocked error
Date: Mon, 7 Nov 2011 15:43:06 -0800
Message-ID: <CAF3hT9DxEyKHDxOE+Ky1A5Oa4xHDE0=VqQAYEb161i7-mFT7Jg@mail.gmail.com>
References: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
	<CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com>
	<CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
	<orwrbfu4js.fsf@livre.localdomain>
	<CA+jddaMPvTae_W_zKyjTewiKEzpJ_FB_zQoS=4J5pjEcOj90sQ@mail.gmail.com>
	<orobwqt186.fsf@livre.localdomain>
	<CA+jddaMvo2XWAv2BvfEqBwMXYv8JV4MmFGXYF-0F2hQx92FGfw@mail.gmail.com>
	<CAF3hT9DPq_X5F2ZK0JU5jh+ugMX_DzfB2hYTLRJ5G3aELRKKag@mail.gmail.com>
	<CAORUGqD0EL4yb-RbrixJPkwjSubPpJD5NKX-2OwK6656bkgjHA@mail.gmail.com>
	<CA+jddaO4H7owZ_byUprBCfvgCUTUC8ceePyPh_7G_SE8c_kKZA@mail.gmail.com>
	<Pine.LNX.4.64.1111071508450.32056@cobra.newdream.net>
	<CAORUGqDygO3LWTY2quuq_MPRFKi3RU+wwuGnEk-veBnf29tk0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62710 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212Ab1KGXnH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 18:43:07 -0500
Received: by iage36 with SMTP id e36so6389559iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 07 Nov 2011 15:43:07 -0800 (PST)
In-Reply-To: <CAORUGqDygO3LWTY2quuq_MPRFKi3RU+wwuGnEk-veBnf29tk0g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, Mandell Degerness <mandell@pistoncloud.com>, Alexandre Oliva <oliva@lsd.ic.unicamp.br>, ceph-devel@vger.kernel.org

On Mon, Nov 7, 2011 at 3:34 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Mon, Nov 7, 2011 at 15:10, Sage Weil <sage@newdream.net> wrote:
>> It applies to RBD too... _if_ the ceph-osd process is calling sync(2=
).
>> On btrfs it doesn't, and on XFS/extN/etc., it only does on older ker=
nels
>> with older glibc. =A0New kernels (.39+) and new glibc have syncfs(2)=
, which
>> syncs only the fs the ceph-osd is serving up.
>>
>> http://linux.die.net/man/2/syncfs
>
> I'm willing to believe syncfs(2) makes the deadlock more rare, but
> isn't it still possible?
>
> e.g. see slide 23 of www.scs.stanford.edu/nyu/02fa/notes/l3.pdf for a
> description of this in context of loopback NFS. If rbd.ko does write
> caching, and uses buffer cache for it:

There are two different deadlock problems in this thread: sync
deadlock (due to syncs triggering a recursive sync call) versus memory
pressure writeout deadlock.

The first is dealt with by using syncfs; the second is usually dealt
with by using a userspace client (because then the OS can swap the
userspace client memory to disk if necessary).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
