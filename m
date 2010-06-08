From: ales-76@seznam.cz
Subject: =?us-ascii?Q?Re=3A=20ceph=2C=20slow=20=28cheap=29=20and=20fast=20=28expensive=29=20storage=3F?=
Date: Tue, 08 Jun 2010 15:13:17 +0200 (CEST)
Message-ID: <6410.1165.492-24748-1755564191-1276002797@seznam.cz>
References: <4C0E31B7.4010606@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxh.seznam.cz ([77.75.72.26]:36619 "EHLO mxh.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755031Ab0FHNNi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jun 2010 09:13:38 -0400
In-Reply-To: <4C0E31B7.4010606@wpkg.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?us-ascii?Q?Tomasz=20Chmielewski?= <mangoo@wpkg.org>
Cc: wido@pcextreme.nl, ceph-devel@vger.kernel.org

Hello,

During the last year Ottawa Linux Symposium there was a presentation of=
 open-souce implementation of Hierarchical Storage Management framework=
 for Linux. See: http://www.kernel.org/doc/ols/2009/ols2009-pages-263-2=
74.pdf AFAK it is only a prototype, works only with ext2/ext3 and no ot=
her open-source storage system offers anything like this just yet. So I=
 guess you have to wait a little. But it sounds like useful feature and=
 it would be nice if Ceph can do something like that. Would it be possi=
ble for Ceph to change data placement depending on by example file popu=
larity?

Ales Blaha

> ------------ P=F9vodn=ED zpr=E1va ------------
> Od: Tomasz Chmielewski <mangoo@wpkg.org>
> P=F8edm=ECt: Re: ceph, slow (cheap) and fast (expensive) storage?
> Datum: 08.6.2010 14:04:17
> ----------------------------------------
> Am 08.06.2010 12:53, Wido den Hollander wrote:
> > Hi,
> >
> > I'm not aware of any of those features in Ceph and i don't think th=
at it
> > will be possible in the near future.
> >
> > But while thinking about it, is ZFS an option for you? You could th=
en
> > use a lot of SATA disks and add some SAS disks for your caching. ZF=
S
> > will then place the most used blocks on the SAS disks.
>=20
> Not sure, perhaps not.
>=20
> I was thinking of something in the line of:
>=20
> http://en.wikipedia.org/wiki/Hierarchical_storage_management
>=20
>=20
> --=20
> Tomasz Chmielewski
> http://wpkg.org
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
