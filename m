From: Sage Weil <sage@inktank.com>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Fri, 8 Jun 2012 06:55:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206080652031.10292@cobra.newdream.net>
References: <21601270.dfB0BsVfyn@pc10> <4FD10575.7010300@inktank.com>
 <6535521.l6e0muMKBm@pc10> <4FD1FFD2.6050707@filoo.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1969212683-1339163719=:10292"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46847 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082Ab2FHNzY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 09:55:24 -0400
In-Reply-To: <4FD1FFD2.6050707@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: Guido Winkelmann <guido-ceph@thisisnotatest.de>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1969212683-1339163719=:10292
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 8 Jun 2012, Oliver Francke wrote:
> Hi Guido,
>=20
> yeah, there is something weird going on. I just started to establish some
> test-VM's. Freshly imported from running *.qcow2 images.
> Kernel panic with INIT, seg-faults and other "funny" stuff.
>=20
> Just added the rbd_cache=3Dtrue in my config, voila. All is
> fast-n-up-n-running...
> All my testing was done with cache enabled... Since our errors all came f=
rom
> rbd_writeback from former ceph-versions...

Are you guys able to reproduce the corruption with 'debug osd =3D 20' and=
=20
'debug ms =3D 1'?  Ideally we'd like to:

 - reproduce from a fresh vm, with osd logs
 - identify the bad file
 - map that file to a block offset (see=20
   http://ceph.com/qa/fiemap.[ch], linux_fiemap.h)
 - use that to identify the badness in the log

I suspect the cache is just masking the problem because it submits fewer=20
IOs...

sage


>=20
> Josh? Sage? Help?!
>=20
> Oliver.
>=20
> On 06/08/2012 02:55 PM, Guido Winkelmann wrote:
> > Am Donnerstag, 7. Juni 2012, 12:48:05 schrieben Sie:
> > > On 06/07/2012 11:04 AM, Guido Winkelmann wrote:
> > > > Hi,
> > > >=20
> > > > I'm using Ceph with RBD to provide network-transparent disk images =
for
> > > > KVM-
> > > > based virtual servers. The last two days, I've been hunting some we=
ird
> > > > elusive bug where data in the virtual machines would be corrupted i=
n
> > > > weird ways. It usually manifests in files having some random data -
> > > > usually zeroes - at the start before the actual contents that shoul=
d be
> > > > in there start.
> > > I definitely want to figure out what's going on with this.
> > > A few questions:
> > >=20
> > > Are you using rbd caching? If so, what settings?
> > >=20
> > > In either case, does the corruption still occur if you
> > > switch caching on/off? There are different I/O paths here,
> > > and this might tell us if the problem is on the client side.
> > Okay, I've tried enabling rbd caching now, and so far, the problem appe=
ars
> > to
> > be gone.
> >=20
> > I am using libvirt for starting and managing the virtual machines, and =
what
> > I
> > did was change the<source>  element for the virtual disk from
> >=20
> > <source protocol=3D'rbd' name=3D'rbd/name_of_image'>
> >=20
> > to
> >=20
> > <source protocol=3D'rbd' name=3D'rbd/name_of_image:rbd_cache=3Dtrue'>
> >=20
> > and then restart the VM.
> > (I found that in one of your mails on this list; there does not appear =
to be
> > any proper documentation on this...)
> >=20
> > The iotester does not find any corruptions with these settings.
> >=20
> > The VM ist still horribly broken, but that's probably lingering filesys=
tem
> > damage from yesterday. I'll try with a fresh image next.
> >=20
> > I did not change anything else in the setup. In particular, the OSDs st=
ill
> > use
> > btrfs. One of the OSD has been restarted, though. I will run another te=
st
> > with
> > a VM without rbd caching, to make sure it wasn't by random chance resta=
rting
> > that one osd that made the real difference.
> >=20
> > Enabling btrfs did not appear to make any difference wrt performance, b=
ut
> > that's probably because my tests mostly create sustained sequential IO,=
 for
> > which caches are generally not very helpful.
> >=20
> > Enabling rbd caching is not a solution I particularly like, for two rea=
sons:
> >=20
> > 1. In my setup, migrating VMs from one host to another is a normal part=
 of
> > operation, and I still don't know ho to prevent data corruption (in the=
 form
> > of silently lost writes) when combining rbd caching and migration.
> >=20
> > 2. I'm not really looking into speeding up single VM, I'm really more
> > interested in just how many VMs I can run before performance starts
> > degrading
> > for everyone, and I don't think rbd caching will help with that.
> >=20
> > Regards,
> > =09Guido
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
--557981400-1969212683-1339163719=:10292--
