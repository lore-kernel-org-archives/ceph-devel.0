From: Sage Weil <sage@newdream.net>
Subject: Re: problem about pgmeta object?
Date: Wed, 9 Dec 2015 05:54:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512090552130.12816@cobra.newdream.net>
References: <CALZt5jx2bQKK6yE=bTu96CD=OE7uVGTagfqirHsXh5bNbS2t=w@mail.gmail.com> <alpine.DEB.2.00.1511180511420.7964@cobra.newdream.net> <CALZt5jzpGn1koOwK2PZ2w6xj-UPibc2B60HU-f1ZayFNDSy3EQ@mail.gmail.com> <alpine.DEB.2.00.1512080536300.19170@cobra.newdream.net>
 <CALZt5jy47HwGR7kGzmUC_cGRp-6Q0xe=aA+v+9viJW3vMYYRrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-238805754-1449669260=:12816"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38722 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbbLINyV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Dec 2015 08:54:21 -0500
In-Reply-To: <CALZt5jy47HwGR7kGzmUC_cGRp-6Q0xe=aA+v+9viJW3vMYYRrA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-238805754-1449669260=:12816
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Dec 2015, Ning Yao wrote:
> The function and transactions corresponding with pgmeta object is liste=
d
> below:
> touch() =C2=A0 and =C2=A0 remove() =C2=A0for =C2=A0pgmeta object creati=
on and deletion
> _omap_setkeys() =C2=A0and =C2=A0_omap_rmkeys() =C2=A0to =C2=A0update k/=
v data in omap for
> pgmeta(pg_info, epoch, rollback_info, pg_log and so on)
> omap_get_values() to retrieve data from omap, always call it during osd
> daemon start proccess

Note that we should make sure collection_list continues to show it, so we=
=20
can't skip creating the file...
=20
> So I think the performance will be hurt in writeOp routine as heavily c=
all
> _omap_setkeys() =C2=A0and =C2=A0_omap_rmkeys(). The ideal way to deal w=
ith it, =C2=A0of
> course, is to eventually treat pgmeta as a logical object(not real obje=
ct
> existed). But it needs alter much in FileStore, since we cannot directl=
y
> remove the t.touch() =C2=A0and =C2=A0t.remove() transaction and upgrade=
 store to
> remove the pgmeta_object based on info_struct_v. But as we discussed be=
fore,
> it is FileStore issue and need keep compatibility for other backends.=C2=
=A0
> Therefore, in order to not to alter FileStore too much and keep all its
> compatibility, my strategy is just to skip the meta object existence
> checking on the main routine of writeOps like this:
> https://github.com/ceph/ceph/pull/6870

Yep, this sounds like the right hack to me.
=20
> This brings a benefit to reduce _omap_setkeys() =C2=A0execution time
> =C2=A0from=C2=A0123.784us to=C2=A0108.444us averagely (about 15% improv=
ement), and reduce
> the whole cpu time 0.5% ~ 1% globally.=C2=A0

That seems worthwhile!

sage
--557981400-238805754-1449669260=:12816--
