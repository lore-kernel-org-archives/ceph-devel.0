From: Sage Weil <sage@newdream.net>
Subject: Re: mds getattr locked again
Date: Fri, 29 Oct 2010 09:26:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010290920220.13796@cobra.newdream.net>
References: <AANLkTi=R=bnsjZeq5DibVzVK__evwajLefSHuA6iJKTW@mail.gmail.com>
 <Pine.LNX.4.64.1010282151220.27485@cobra.newdream.net>
 <AANLkTinOOi4XjfnfxP8qL81sxzOTLaS4zPJYwY979J0L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1950223456-1288369565=:13796"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56279 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757613Ab0J2QXS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Oct 2010 12:23:18 -0400
In-Reply-To: <AANLkTinOOi4XjfnfxP8qL81sxzOTLaS4zPJYwY979J0L@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1010290926160.13796@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leander Yu <leander.yu@gmail.com>
Cc: Henry C Chang <henry_c_chang@tcloudcomputing.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1950223456-1288369565=:13796
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1010290926161.13796@cobra.newdream.net>

On Fri, 29 Oct 2010, Leander Yu wrote:
> Hi Sage,
>=20
> On Fri, Oct 29, 2010 at 1:08 PM, Sage Weil <sage@newdream.net> wrote:
> > On Fri, 29 Oct 2010, Henry C Chang wrote:
> >> Hi,
> >>
> >> getattr on mds hanged again.
> >>
> >> I have already reverted d91f2438d881514e4a923fd786dbd94b764a9440.
> >> Although the probability is significant lowered down, it still has the
> >> chance to hang on getattr.
> >>
> >> Attached are the logs of mds and the hanging client. :(
> >>
> >> I'm using ceph-client-standalone master-backport branch on 2.6.32 kern=
el.
> >
> > It looks like ceph_check_caps is hung somehow:
> >
> > ceph:ceph: =A0handle_caps from mds0
> > ceph:ceph: =A0 mds0 seq 99 cap seq 28
> > ceph:ceph: =A0 op revoke ino 10000000bd1.fffffffffffffffe inode
> > ffff8800a6251d88
> > ceph:ceph: =A0handle_cap_grant inode ffff8800a6251d88 cap ffff8800a635b=
780
> > mds0 seq 28 pAsLsXsFr
> > ceph:ceph: =A0 size 4294967296 max_size 8594128896, i_size 4294967296
> > ceph:ceph: =A0try_nonblocking_invalidate ffff8800a6251d88 success
> > ceph:ceph: =A0__ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b780
> > issued pAsLsXsFscr
> > ceph:ceph: =A0__ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b780
> > issued pAsLsXsFscr
> > ceph:ceph: =A0ffff8800a6251d88 mode 0100644 uid.gid 0.0
> > ceph:ceph: =A0 my wanted =3D pAsxXsxFsxcrwb, used =3D pFcr, dirty -
> > ceph:ceph: =A0revocation: pAsLsXsFscr -> pAsLsXsFr (revoking Fsc)
> > ceph:ceph: =A0__ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b780
> > issued pAsLsXsFr
> > ceph:ceph: =A0check_caps ffff8800a6251d88 file_want pAsxXsxFsxcrwb used=
 pFcr
> > dirty - flushing - issued pAsLsXsFr revoking Fsc retain pAsxLsxXsxFsxcr=
wbl
> > AUTHONLY NODELAY
> > ceph:ceph: =A0 mds0 revoking Fsc
> > ceph:ceph: =A0mdsc put_session ffff8800b41c6000 3 -> 2
> > ceph:ceph: =A0mdsc con_put ffff8800b41c6000 (2)
> > ceph:ceph: =A0aio_read ffff8800a6251d88 10000000bd1.fffffffffffffffe
> > dropping cap refs on Fcr =3D 512
> > ceph:ceph: =A0put_cap_refs ffff8800a6251d88 had Fcr last
> > ceph:ceph: =A0__ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b780
> > issued pAsLsXsFr
> > ceph:ceph: =A0check_caps ffff8800a6251d88 file_want pAsxXsxFsxcrwb used=
 pFc
> > dirty - flushing - issued pAsLsXsFr revoking Fsc retain pAsxLsxXsxFsxcr=
wbl
> > ceph:ceph: =A0check_caps trying to invalidate on ffff8800a6251d88
> > ceph:ceph: =A0try_nonblocking_invalidate ffff8800a6251d88 failed
> > ceph:ceph: =A0check_caps queuing invalidate
> >
> > --> this means queue_invalidate =3D 1, and check_caps will call
> > ceph_queue_invalidate on exit, which will always print something...
> >
> > ceph:ceph: =A0__ceph_caps_issued ffff8800a6251d88 cap ffff8800a635b780 =
issued pAsLsXsFr
> > ceph:ceph: =A0check_caps ffff8800a6251d88 file_want pAsxXsxFsxcrwb used=
 pFc
> > dirty - flushing - issued pAsLsXsFr revoking Fsc retain pAsxLsxXsxFsxcr=
wbl
> > ceph:ceph: =A0 mds0 revoking Fsc
> > ceph:ceph: =A0__cap_delay_cancel ffff8800a6251d88
> >
> > ...but that never happens. =A0Probably the CPU got blocked somewhere? =
=A0Can
> > you see what the system is doing at this point? =A0sysrq-t, or check th=
e
> > process list for ceph-msgr and cat it's stack (/proc/$pid/stack)? =A0Th=
e
> > task should be blocked in ceph_check_caps() somewhere...
>=20
> it didn't go to ceph_queue_invalidate because delayed and is_delayed =3D =
0.
>
>          if (delayed && is_delayed)
>                  force_requeue =3D 1;   /* __send_cap delayed release; re=
queue */
>          if (!delayed && !is_delayed)
>                  __cap_delay_cancel(mdsc, ci);
>          else if (!is_delayed || force_requeue)
>                  __cap_delay_requeue(mdsc, ci);
>=20
>          spin_unlock(&inode->i_lock);
>=20
>          if (queue_invalidate)
>                  ceph_queue_invalidate(inode);
>=20
> so it goes to __cap_delay_cancel().
>=20
> Should I said, the correct behavior is to go to ceph_queue_invalidate(ino=
de)?

I don't think delayed && is_delayed are related.  (Those deal with whether=
=20
we come back and re-check caps a little latter.)  The invalidate should be=
=20
queued immediately: at this point queue_invalidate =3D=3D 1, and the functi=
on=20
only has one exit point, so one way or another ceph_queue_invalidate()=20
should get called.  Since it's not, we must be getting stuck somewhere...

Some combination of sysrq and strategic printk's should narrow down where=
=20
things go wrong.

Thanks!
sage=20

>=20
>=20
> >
> > (BTW, if you're building your own kernel, one thing that I've found
> > helpful is enabling the CONFIG_PRINTK_TIME option in .config, and updat=
ing
> > kernel/printk.c to also include current->pid in the line prefix. =A0Tha=
t
> > helps sort out what tasks are doing what when. =A0But if you're stuck o=
n
> > 2.6.32 for some reason that probably not the case!)
> >
> > Thanks!
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1950223456-1288369565=:13796--
