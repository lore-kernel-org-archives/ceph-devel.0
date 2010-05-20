From: Wido den Hollander <wido@pcextreme.nl>
Subject: Re: Questions about a possible Ceph setup
Date: Thu, 20 May 2010 19:57:13 +0200
Message-ID: <1274378233.5412.63.camel@wido-laptop.pcextreme.nl>
References: <909721.18944.qm@web114302.mail.gq1.yahoo.com>
	 <Pine.LNX.4.64.1005201004040.4397@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:40805 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab0ETR5Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 May 2010 13:57:16 -0400
In-Reply-To: <Pine.LNX.4.64.1005201004040.4397@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi,

On Thu, 2010-05-20 at 17:09 +0000, Sage Weil wrote:
> > > I'd prefer the situation where i'd stripe over all 4 disks, givin=
g me=20
> > > and extra pro. In this situation i could configure my node to pan=
ic=20
> > > whenever a disk is starting to give errors, so my cluster can tak=
e=20
> > > over immediately.
> > >=20
> > > Am i right? Is this "the way to go"?
> >=20
> > I don't know the way to go. But I think that in the 1st case (1 OSD=
 per=20
> > hard disk) when a hard disk fails, it gets replicated elsewhere. Du=
ring=20
> > that time the other 3 OSDs on the same machine are still working fi=
ne=20
> > and serving requests. And then some time later, you've got a brand =
new=20
> > disk, you shutdown the machnie, that's 3 more OSDs down. In the 2nd=
=20
> > case, as soon as 1 disk starts failing, your OSD (which is 4 disks)=
 gets=20
> > taken down, that's approximately equivalent to 4 OSDs going down at=
 the=20
> > same time if we compare to your 1st case.
>=20
> The other 3 osds don't have to rereplicate if you swap the failed dis=
k=20
> quickly, or otherwise inform the system that the failure is temporary=
=2E  By=20
> default there is a 5 minute timeout.  That can be adjusted, or we can=
 add=20
> other administrative hooks to 'suspend' any declarations of permanent=
=20
> failure for this sort of case.

Ok, so upping this timeout to something like 10 minutes would be
sufficient for swapping and OSD.

This is done via the mon_osd_down_out_interval paramater i assume (foun=
d
in config.cc)

>=20
> > About your 2nd case: as cheap as the hardware may be, having 3 perf=
ectly=20
> > operational disks not working has a cost...
> >=20
> > What I don't know, in both cases, is: when the machines gets back=20
> > online, will it hold the same data as before being shutdown, or wil=
l=20
> > they get entirely new data? I can remember that crush was quite sta=
ble=20
> > and designed to avoid that kind of full cluster rebalance on failin=
g/new=20
> > OSD...
>=20
> For independent disks, the the old data will still be there on the 3 =
that=20
> weren't replaced.  If the 4 are striped without redundancy, all will =
be=20
> lost due to the singel failure.  If they are striped with redudancy (=
btrfs=20
> mirroring, DM/MD or hardware raid, etc.), all 4 disks' data will be t=
here=20
> (tho there will be some internal rebuild load in the raid).
>=20
> > I don't understand how - in the 2nd case - the btrfs pool of 4 disk=
s=20
> > would "repair" its missing data, so that the data on the 3 good dis=
ks=20
> > does not need to get replicated over the network.
>=20
> Currently it won't, unless you enable data mirroring (off by default)=
=2E =20
> The problem is that costs you 2x the storage space, which combined wi=
th=20
> ceph mirroring means you're buying 4x the disk.

My intentions where never to use replication in btrfs, i meant using
"RAID-0". So when one disk fails, you loose all your data in that
particular node.

>=20
> I lean toward a cosd per disk in this situation.  The downside is the=
re is=20
> a bit more work in setting up the CRUSH hierarchy and rules properly.=
 =20
> User friendly tools to do this would certainly be nice.

Yes, the CRUSH map is somewhat more work and also the Ceph config needs
some work.

About more then one OSD on one machine, is there a way how you can bind
an OSD to a specific IP? Can't seem to find any configuration for this.

I assume you will need one IP per OSD on that machine?

And my journaling question, any views on that topic?

Thanks!

>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Met vriendelijke groet,

Wido den Hollander
Hoofd Systeembeheer / CSO
Telefoon Support Nederland: 0900 9633 (45 cpm)
Telefoon Support Belgi=C3=AB: 0900 70312 (45 cpm)
Telefoon Direct: (+31) (0)20 50 60 104
=46ax: +31 (0)20 50 60 111
E-mail: support@pcextreme.nl
Website: http://www.pcextreme.nl
Kennisbank: http://support.pcextreme.nl/
Netwerkstatus: http://nmc.pcextreme.nl

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
