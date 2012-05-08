From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Ceph kernel client - kernel craches
Date: Tue, 8 May 2012 12:18:11 -0700
Message-ID: <CADvuQRG2EJSC90GR+qkJN-tzi1d3VxxnZV_gMt_JdAcL2fEx4g@mail.gmail.com>
References: <CAHcbcZe2NSJhveSKq7tSazKcfB4b8ZUX89RtknXc==cQ59vDjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39344 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867Ab2EHTSc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 May 2012 15:18:32 -0400
Received: by pbbrp8 with SMTP id rp8so8412471pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 08 May 2012 12:18:32 -0700 (PDT)
In-Reply-To: <CAHcbcZe2NSJhveSKq7tSazKcfB4b8ZUX89RtknXc==cQ59vDjQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Giorgos Kappes <geokapp@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, May 8, 2012 at 8:43 AM, Giorgos Kappes <geokapp@gmail.com> wrot=
e:
> When I am running deboostrap to install a base Debian Squeeze system
> on a Ceph directory the client's kernel crashes with the following
> message:
>
> I: Extracting zlib1g...
> W: Failure trying to run: chroot /mnt/debian mount -t proc proc /proc
> [ =C2=A0759.776151] kernel tried to execute NX-protected page - explo=
it
> attempt? (uid: 0)
> [ =C2=A0759.776169] BUG: unable to handle kernel paging request at ff=
ffe8fffffe4ab0
=2E..
> [ =C2=A0759.776438] =C2=A0[<ffffffff81099405>] ? __rcu_process_callba=
cks+0x1c7/0x2f8
> [ =C2=A0759.776447] =C2=A0[<ffffffff81099898>] ? rcu_process_callback=
s+0x2c/0x56
> [ =C2=A0759.776457] =C2=A0[<ffffffff8104cb72>] ? __do_softirq+0xc4/0x=
1a0
> [ =C2=A0759.776465] =C2=A0[<ffffffff81096875>] ? handle_percpu_irq+0x=
3d/0x54
> [ =C2=A0759.776475] =C2=A0[<ffffffff8150efb6>] ? __xen_evtchn_do_upca=
ll+0x1c7/0x205
> [ =C2=A0759.776484] =C2=A0[<ffffffff8176e52c>] ? call_softirq+0x1c/0x=
30
> [ =C2=A0759.776493] =C2=A0[<ffffffff8100fa47>] ? do_softirq+0x3f/0x79
> [ =C2=A0759.776501] =C2=A0[<ffffffff8104c942>] ? irq_exit+0x44/0xb5
> [ =C2=A0759.776508] =C2=A0[<ffffffff8150ffc6>] ? xen_evtchn_do_upcall=
+0x27/0x32
> [ =C2=A0759.776516] =C2=A0[<ffffffff8176e57e>] ? xen_do_hypervisor_ca=
llback+0x1e/0x30
=2E..
> My simple cluster consists of 3 nodes in total. Each node is a Xen
> domU guest running the Linux kernel 3.2.6 and ceph 0.43. For
> reference, here is my configuration:
=2E..
> My Ceph kernel client is another Xen domU node running the Linux
> kernel 3.2.11. I have also tried a native client with the same result=
=2E
> Please note that this bug happens only in the client side.
> Your help would be greatly appreciated.

Your backtrace includes Xen code in it -- can you reproduce this bug
with a mainline kernel, without Xen at all?

Also, the error encountered is from the NX security subsystem. It
would be nice to know what would happen without NX.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
