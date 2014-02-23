From: Sage Weil <sage@inktank.com>
Subject: Re: ceph-standalone
Date: Sun, 23 Feb 2014 14:44:29 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402231438270.17508@cobra.newdream.net>
References: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net> <AAA9F1FF-2397-422E-BA8A-A6B681AD069E@enovance.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-723641181-1393195469=:17508"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58197 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbaBWWo3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Feb 2014 17:44:29 -0500
In-Reply-To: <AAA9F1FF-2397-422E-BA8A-A6B681AD069E@enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <sebastien.han@enovance.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-723641181-1393195469=:17508
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Sun, 23 Feb 2014, Sebastien Han wrote:
> This seems quite useful and could improve the user experience.
> This looks more or less like a ceph-deploy wrapper to me and shouldn=92=
t be that difficult to make (except for the RGW part since nothing is the=
re).
> A simple bash script could be used I guess.

I think it is actually simpler than ceph-deploy.  The package postinst=20
script can just do the setup steps to create the daemons since it is all=20
on the local machine.

> I just wonder if it=92s worth investing into a RGW with ceph-deploy and=
=20
> then just write a bash script that wraps up everything on a single=20
> setup.

Independently, it would be great to add rgw support for ceph-deploy since=
=20
that is one of the more difficult pieces to set up.

But I think the ceph-standalone piece is about making a simple,=20
prescriptive version of vstart.sh that deploys 1 mon, 1 mds, and maybe 2=20
osds (or something like that; suggestions welcome!) and wrapping it in a=20
deb/rpm.

sage

>=20
> What do you think?
>=20
> Cheers.
> =96=96=96=96=20
> S=E9bastien Han=20
> Cloud Engineer=20
>=20
> "Always give 100%. Unless you're giving blood.=94=20
>=20
> Phone: +33 (0)1 49 70 99 72=20
> Mail: sebastien.han@enovance.com=20
> Address : 10, rue de la Victoire - 75009 Paris=20
> Web : www.enovance.com - Twitter : @enovance=20
>=20
> On 23 Feb 2014, at 21:30, Sage Weil <sage@inktank.com> wrote:
>=20
> > One idea kicking around is to create a simple ceph-standalone package=
 that=20
> > is meant to make it really easy to play around with Ceph.  It would:
> >=20
> > - depend on all the relevant ceph packages
> > - install a simple, generic ceph.conf for use on localhost (or perhap=
s=20
> > whatever /etc/hosts has for our hostname)
> > - mkfs and start up a mon
> > - start up an osd (or two?) in /var/lib/ceph (no dedicated disk/volum=
e)
> > - start an mds
> > - add an apache2 site in /etc/apache2/sites-available (or whatever)
> >=20
> > The idea would be to do
> >=20
> > $ sudo apt-get install ceph-standalone
> > $ ceph -s
> > [...]
> >=20
> > and have a usable mini-cluster.  That makes it really easy for users =
to=20
> > play with the basics, like:
> >=20
> > $ mkdir /mnt/ceph
> > $ sudo ceph-fuse /mnt/ceph
> >=20
> > $ rbd create ...
> > $ rbd map ...
> >=20
> > $ curl http://localhost:8000/
> > <more rgw stuff>
> >=20
> > Does this sound useful?  Any takers?
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-723641181-1393195469=:17508--
