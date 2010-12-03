From: Sage Weil <sage@newdream.net>
Subject: Re: questions about pg membership
Date: Fri, 3 Dec 2010 09:27:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012030922220.1982@cobra.newdream.net>
References: <AANLkTin8d5xMoqvjt8YcS6NrCTEB=-L2Tyx4_96TckZd@mail.gmail.com>
 <Pine.LNX.4.64.1012021130260.1982@cobra.newdream.net>
 <AANLkTinY7ZAox9ZK3Ueo1TbPyMgRBw7YBTDCnxw4ucrr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-507384139-1291397276=:1982"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59313 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab0LCRXN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Dec 2010 12:23:13 -0500
In-Reply-To: <AANLkTinY7ZAox9ZK3Ueo1TbPyMgRBw7YBTDCnxw4ucrr@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-507384139-1291397276=:1982
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 3 Dec 2010, Henry C Chang wrote:
> > The primary changing nodes is more of a concern, though; the rest is sm=
all
> > optimizations. =A0Let's figure out why the mapping is changing like tha=
t!
>=20
> Hi Sage,
>=20
> Thanks for you explanation.
>=20
> I use 'ceph pg dump -o -' to dump the pg stats before and after osd2
> got down and out.
> As shown in the attached files, pg 3.1p2 changed from [2,0] to [1.0].

Oh, that explains it: the 'p' placement groups are ones in which the=20
primary is 'forcefed' into the crush algorithm.  The way things behave if=
=20
that choice isn't usable doesn't behave as well as the unconstrianed=20
placement.

Those PGs are not used unless you call the setlayout ioctl on a file and=20
set the preferred osd.  For normal users these pgs should all be empty.

> What I meant to say (sorry for my bad English and bad example) is:
> Since osd0 is the replica before change, it should be able to shorten
> the client's waiting time (at least for read) if we can choose osd0 as
> the primary.

Right.  If you see this one non-'p' placement groups, definitely let us
know!

sage
--557981400-507384139-1291397276=:1982--
