From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: osd pool erasure code stripe width
Date: Sat, 20 Jun 2015 01:18:23 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91669A8FEC@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91669A8E8B@SATLEXDAG01.amd.com>
 <55849BF7.5050603@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0148.outbound.protection.outlook.com ([157.56.111.148]:60982
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753429AbbFTBSa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jun 2015 21:18:30 -0400
In-Reply-To: <55849BF7.5050603@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, ceph-devel <ceph-devel@vger.kernel.org>

So if I am looking at the performance of a system with
ceph_erasure_code_benchmark, does this mean I should concentrate
on the performance with --size 4096 (or whatever stripe width my
ec pools are going to use)?

-- Tom

> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]
> Sent: Friday, June 19, 2015 5:47 PM
> To: Deneau, Tom; ceph-devel
> Subject: Re: osd pool erasure code stripe width
>=20
> Hi Tom,
>=20
> A stripe width of 4KB (the default) means the object is encoded 4KB a=
t a
> time. It does not show in the file written to disk.
>=20
> Cheers
>=20
> On 19/06/2015 22:11, Deneau, Tom wrote:
> > I am trying to understand the use of "osd pool erasure code stripe =
width"
> > For example, I have a single-node system with a k=3D2,m=3D1 ec pool=
 and I
> > write a single 40M object to this pool using rados bench.
> > But when I look on the disk, I still see only the 3 20M pieces for =
this
> object.
> > Where does the striping get used?
> >
> > -- Tom Deneau, AMD
> >
> >
> > Description:
> > Sets the desired size, in bytes, of an object stripe on every erasu=
re coded
> pools. Every object if size S will be stored as N stripes and each st=
ripe
> will be encoded/decoded individually.
> > Type:
> > Unsigned 32-bit Integer
> > Default:
> > 4096
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
> > in
> >
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
