From: Sage Weil <sage@newdream.net>
Subject: Re: Problem after ceph-osd crash
Date: Mon, 20 Feb 2012 10:05:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202201002440.30577@cobra.newdream.net>
References: <4F427C05.1000304@filoo.de> <Pine.LNX.4.64.1202200941100.30577@cobra.newdream.net>
 <4F42879F.1040802@filoo.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1333711764-1329761114=:30577"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47677 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab2BTSFO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2012 13:05:14 -0500
In-Reply-To: <4F42879F.1040802@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1333711764-1329761114=:30577
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 20 Feb 2012, Oliver Francke wrote:
> Hi Sage,
>=20
> On 02/20/2012 06:41 PM, Sage Weil wrote:
> > On Mon, 20 Feb 2012, Oliver Francke wrote:
> > > Hi,
> > >=20
> > > we are just in trouble after some mess with trying to include a new
> > > OSD-node
> > > into our cluster.
> > >=20
> > > We get some weird "libceph: corrupt inc osdmap epoch 880 off 102
> > > (ffffc9001db8990a of ffffc9001db898a4-ffffc9001db89dae)"

I just retested the kernel client against the new server code and I don't=
=20
see this.  If you can pull the osdmap/880 file from the monitor data=20
directory (soon, please, the monitor will delete it once things fully=20
recover and move on) I can see what the data looks like.

> > >=20
> > > on the console.
> > > The whole system is in a state ala:
> > >=20
> > > 012-02-20 17:56:27.585295    pg v942504: 2046 pgs: 1348 active+clean,=
 43
> > > active+recovering+degraded+remapped+backfill, 218 active+recovering, =
437
> > > active+recovering+remapped+backfill; 1950 GB data, 3734 GB used, 2605=
9 GB
> > > /
> > > 29794 GB avail; 272914/1349073 degraded (20.230%)
> > >=20
> > > and sometimes the ceph-osd on node0 is crashing. At the moment of wri=
ting,
> > > the
> > > degrading continues to shrink down below 20%.
> > How did ceph-osd crash?  Is there a dump in the log?
>=20
> 'course I will provide all logs, uhm, a bit later, we are busy to start a=
ll
> VM's, and handle first customer-tickets right now ;-)
>
> To be most complete for the collection, would you be so kind to give a=20
> list of all necessary kern.log osdX.log etc.?

I think just the crashed osd log will be enough.  It looks like the rest=20
of the cluster is recovering ok...

Are the VMs running on top of the kernel rbd client, or KVM+librbd?

sage


>=20
> Thnx for the fast reaction,
>=20
> Oliver.
>=20
> > sage
> >=20
> > > Any clues?
> > >=20
> > > Thnx in @vance,
> > >=20
> > > Oliver.
> > >=20
> > > --=20
> > >=20
> > > Oliver Francke
> > >=20
> > > filoo GmbH
> > > Moltkestra=DFe 25a
> > > 33330 G=FCtersloh
> > > HRB4355 AG G=FCtersloh
> > >=20
> > > Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz
> > >=20
> > > Folgen Sie uns auf Twitter: http://twitter.com/filoogmbh
> > >=20
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >=20
>=20
>=20
> --=20
>=20
> Oliver Francke
>=20
> filoo GmbH
> Moltkestra=DFe 25a
> 33330 G=FCtersloh
> HRB4355 AG G=FCtersloh
>=20
> Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz
>=20
> Folgen Sie uns auf Twitter: http://twitter.com/filoogmbh
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1333711764-1329761114=:30577--
