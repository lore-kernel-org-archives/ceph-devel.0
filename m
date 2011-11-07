From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Re: ceph-mon blocked error
Date: Mon, 7 Nov 2011 11:07:57 -0800
Message-ID: <CA+jddaMvo2XWAv2BvfEqBwMXYv8JV4MmFGXYF-0F2hQx92FGfw@mail.gmail.com>
References: <CA+jddaNKeneAL7350tv039H21Kr1kk1xSD4Eux_v7Of7vxpa5w@mail.gmail.com>
	<CAF3hT9BuCqV5Z3GS4VVsQptT=d_uii20Q4hMP=qbHwD+f0-HTA@mail.gmail.com>
	<CA+jddaNFKhu_KOa+VXhqGMw_pjM+uP9VFEcpeV+zY+E5KWO-Cw@mail.gmail.com>
	<orwrbfu4js.fsf@livre.localdomain>
	<CA+jddaMPvTae_W_zKyjTewiKEzpJ_FB_zQoS=4J5pjEcOj90sQ@mail.gmail.com>
	<orobwqt186.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40259 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab1KGTH6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 14:07:58 -0500
Received: by vcbf1 with SMTP id f1so2395916vcb.19
        for <ceph-devel@vger.kernel.org>; Mon, 07 Nov 2011 11:07:57 -0800 (PST)
In-Reply-To: <orobwqt186.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>, ceph-devel@vger.kernel.org

Can someone give me the bug number for this?

On Sat, Nov 5, 2011 at 7:48 PM, Alexandre Oliva <oliva@lsd.ic.unicamp.b=
r> wrote:
> On Nov =A05, 2011, Mandell Degerness <mandell@pistoncloud.com> wrote:
>
>> Yes, we are using kernel module for ceph and there was a posix file
>> system and an RBD mounted on the node at the time. =A0The monitor is=
 not
>> using either for it's data though.
>
> It doesn't matter. =A0The monitor calls sync() quite often, and that =
waits
> for *all* filesystems to flush, including the ceph.ko mount, thus the
> potential deadlock. =A0It can use syncfs() if that's available in ker=
nel
> and glibc, but I'm not sure that's enough to work around this particu=
lar
> deadlock scenario. =A0As I found out the hard way, there are others i=
n the
> osd as well, so if you want to mount -o rw on a mon or osd, use the f=
use
> client, or virtualize the mount (never tested this to make sure it
> actually addresses the problem).
>
> --
> Alexandre Oliva, freedom fighter =A0 =A0http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/ =A0 FSF Latin America board member
> Free Software Evangelist =A0 =A0 =A0Red Hat Brazil Compiler Engineer
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
