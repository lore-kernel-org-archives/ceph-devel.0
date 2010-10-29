From: Leander Yu <leander.yu@gmail.com>
Subject: Re: mds getattr locked again
Date: Fri, 29 Oct 2010 14:15:36 +0800
Message-ID: <AANLkTinOOi4XjfnfxP8qL81sxzOTLaS4zPJYwY979J0L@mail.gmail.com>
References: <AANLkTi=R=bnsjZeq5DibVzVK__evwajLefSHuA6iJKTW@mail.gmail.com>
	<Pine.LNX.4.64.1010282151220.27485@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53131 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab0J2GPh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Oct 2010 02:15:37 -0400
Received: by fxm16 with SMTP id 16so2735417fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Oct 2010 23:15:36 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1010282151220.27485@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Henry C Chang <henry_c_chang@tcloudcomputing.com>, ceph-devel@vger.kernel.org

Hi Sage,

On Fri, Oct 29, 2010 at 1:08 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 29 Oct 2010, Henry C Chang wrote:
>> Hi,
>>
>> getattr on mds hanged again.
>>
>> I have already reverted d91f2438d881514e4a923fd786dbd94b764a9440.
>> Although the probability is significant lowered down, it still has t=
he
>> chance to hang on getattr.
>>
>> Attached are the logs of mds and the hanging client. :(
>>
>> I'm using ceph-client-standalone master-backport branch on 2.6.32 ke=
rnel.
>
> It looks like ceph_check_caps is hung somehow:
>
> ceph:ceph: =A0handle_caps from mds0
> ceph:ceph: =A0 mds0 seq 99 cap seq 28
> ceph:ceph: =A0 op revoke ino 10000000bd1.fffffffffffffffe inode
> ffff8800a6251d88
> ceph:ceph: =A0handle_cap_grant inode ffff8800a6251d88 cap ffff8800a63=
5b780
> mds0 seq 28 pAsLsXsFr
> ceph:ceph: =A0 size 4294967296 max_size 8594128896, i_size 4294967296
> ceph:ceph: =A0try_nonblocking_invalidate ffff8800a6251d88 success
> ceph:ceph: =A0__ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b78=
0
> issued pAsLsXsFscr
> ceph:ceph: =A0__ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b78=
0
> issued pAsLsXsFscr
> ceph:ceph: =A0ffff8800a6251d88 mode 0100644 uid.gid 0.0
> ceph:ceph: =A0 my wanted =3D pAsxXsxFsxcrwb, used =3D pFcr, dirty -
> ceph:ceph: =A0revocation: pAsLsXsFscr -> pAsLsXsFr (revoking Fsc)
> ceph:ceph: =A0__ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b78=
0
> issued pAsLsXsFr
> ceph:ceph: =A0check_caps ffff8800a6251d88 file_want pAsxXsxFsxcrwb us=
ed pFcr
> dirty - flushing - issued pAsLsXsFr revoking Fsc retain pAsxLsxXsxFsx=
crwbl
> AUTHONLY NODELAY
> ceph:ceph: =A0 mds0 revoking Fsc
> ceph:ceph: =A0mdsc put_session ffff8800b41c6000 3 -> 2
> ceph:ceph: =A0mdsc con_put ffff8800b41c6000 (2)
> ceph:ceph: =A0aio_read ffff8800a6251d88 10000000bd1.fffffffffffffffe
> dropping cap refs on Fcr =3D 512
> ceph:ceph: =A0put_cap_refs ffff8800a6251d88 had Fcr last
> ceph:ceph: =A0__ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b78=
0
> issued pAsLsXsFr
> ceph:ceph: =A0check_caps ffff8800a6251d88 file_want pAsxXsxFsxcrwb us=
ed pFc
> dirty - flushing - issued pAsLsXsFr revoking Fsc retain pAsxLsxXsxFsx=
crwbl
> ceph:ceph: =A0check_caps trying to invalidate on ffff8800a6251d88
> ceph:ceph: =A0try_nonblocking_invalidate ffff8800a6251d88 failed
> ceph:ceph: =A0check_caps queuing invalidate
>
> --> this means queue_invalidate =3D 1, and check_caps will call
> ceph_queue_invalidate on exit, which will always print something...
>
> ceph:ceph: =A0__ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b78=
0 issued pAsLsXsFr
> ceph:ceph: =A0check_caps ffff8800a6251d88 file_want pAsxXsxFsxcrwb us=
ed pFc
> dirty - flushing - issued pAsLsXsFr revoking Fsc retain pAsxLsxXsxFsx=
crwbl
> ceph:ceph: =A0 mds0 revoking Fsc
> ceph:ceph: =A0__cap_delay_cancel ffff8800a6251d88
>
> ...but that never happens. =A0Probably the CPU got blocked somewhere?=
 =A0Can
> you see what the system is doing at this point? =A0sysrq-t, or check =
the
> process list for ceph-msgr and cat it's stack (/proc/$pid/stack)? =A0=
The
> task should be blocked in ceph_check_caps() somewhere...

it didn't go to ceph_queue_invalidate because delayed and is_delayed =3D=
 0.

         if (delayed && is_delayed)
                 force_requeue =3D 1;   /* __send_cap delayed release; =
requeue */
         if (!delayed && !is_delayed)
                 __cap_delay_cancel(mdsc, ci);
         else if (!is_delayed || force_requeue)
                 __cap_delay_requeue(mdsc, ci);

         spin_unlock(&inode->i_lock);

         if (queue_invalidate)
                 ceph_queue_invalidate(inode);

so it goes to __cap_delay_cancel().

Should I said, the correct behavior is to go to ceph_queue_invalidate(i=
node)?


>
> (BTW, if you're building your own kernel, one thing that I've found
> helpful is enabling the CONFIG_PRINTK_TIME option in .config, and upd=
ating
> kernel/printk.c to also include current->pid in the line prefix. =A0T=
hat
> helps sort out what tasks are doing what when. =A0But if you're stuck=
 on
> 2.6.32 for some reason that probably not the case!)
>
> Thanks!
> sage
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
