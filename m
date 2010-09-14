From: Sage Weil <sage@newdream.net>
Subject: Re: Questions about ceph
Date: Mon, 13 Sep 2010 21:41:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009132139010.31409@cobra.newdream.net>
References: <AANLkTi=3RgYs8yE6Q+yPjEEsMvX5Bt-x9qK__WzMs_JW@mail.gmail.com>
 <4C8E458D.5030908@sanger.ac.uk> <AANLkTinWjbgm7AaDBAb=kud-=iw9ws1bRn7PMbRMpQzb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1691178257-1284439279=:31409"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57362 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab0INEju (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Sep 2010 00:39:50 -0400
In-Reply-To: <AANLkTinWjbgm7AaDBAb=kud-=iw9ws1bRn7PMbRMpQzb@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mag Gam <magawake@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1691178257-1284439279=:31409
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

> On Mon, Sep 13, 2010 at 11:38 AM, Guy Coates <gmpc@sanger.ac.uk> wrote:
> > On 13/09/10 12:16, Mag Gam wrote:
> >> Hello,
> >>
> >
> > Hi Mag,
> >
> > One of the nice ceph features that only work with btrfs as the backing
> > filesystem is the sub-directory accounting;
> >
> > ls -ald on a directory will show the size of all the files contained
> > within in, and getfattr -d directory will show the number of files and
> > other accounting information. =A0Invaluable for large file-systems!

(Didn't see this one come over the list, but just to clarify:)

The recursive accounting is a function of the Ceph MDS and will work=20
regardless what what backend file system you're using on the OSDs (extN,=20
btrfs, xfs).  The main thing that currently doesn't work properly without=
=20
btrfs is recovery when snapshots are being used.  (It'll work most of the=
=20
time, but there are corner cases that aren't covered.)  This is something=
=20
we plan to fix.

sage


> >
> > Cheers,
> >
> > Guy
> >
> >
> > --
> > Dr. Guy Coates, Informatics System Group
> > The Wellcome Trust Sanger Institute, Hinxton, Cambridge, CB10 1HH, UK
> > Tel: +44 (0)1223 834244 x 6925
> > Fax: +44 (0)1223 496802
> >
> >
> > --
> > =A0The Wellcome Trust Sanger Institute is operated by Genome Research
> > =A0Limited, a charity registered in England with number 1021457 and a
> > =A0company registered in England with number 2742969, whose registered
> > =A0office is 215 Euston Road, London, NW1 2BE.
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1691178257-1284439279=:31409--
