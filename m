From: Sage Weil <sage@newdream.net>
Subject: Re: Questions about a possible Ceph setup
Date: Thu, 20 May 2010 11:24:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005201102570.4397@cobra.newdream.net>
References: <909721.18944.qm@web114302.mail.gq1.yahoo.com>
 <Pine.LNX.4.64.1005201004040.4397@cobra.newdream.net>
 <1274378233.5412.63.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1756736938-1274378725=:4397"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40266 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab0ETSV0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 May 2010 14:21:26 -0400
In-Reply-To: <1274378233.5412.63.camel@wido-laptop.pcextreme.nl>
Content-ID: <Pine.LNX.4.64.1005201105280.4397@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@pcextreme.nl>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1756736938-1274378725=:4397
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1005201105281.4397@cobra.newdream.net>

On Thu, 20 May 2010, Wido den Hollander wrote:

> Hi,
>=20
> On Thu, 2010-05-20 at 17:09 +0000, Sage Weil wrote:
> > > > I'd prefer the situation where i'd stripe over all 4 disks, giving =
me=20
> > > > and extra pro. In this situation i could configure my node to panic=
=20
> > > > whenever a disk is starting to give errors, so my cluster can take=
=20
> > > > over immediately.
> > > >=20
> > > > Am i right? Is this "the way to go"?
> > >=20
> > > I don't know the way to go. But I think that in the 1st case (1 OSD p=
er=20
> > > hard disk) when a hard disk fails, it gets replicated elsewhere. Duri=
ng=20
> > > that time the other 3 OSDs on the same machine are still working fine=
=20
> > > and serving requests. And then some time later, you've got a brand ne=
w=20
> > > disk, you shutdown the machnie, that's 3 more OSDs down. In the 2nd=
=20
> > > case, as soon as 1 disk starts failing, your OSD (which is 4 disks) g=
ets=20
> > > taken down, that's approximately equivalent to 4 OSDs going down at t=
he=20
> > > same time if we compare to your 1st case.
> >=20
> > The other 3 osds don't have to rereplicate if you swap the failed disk=
=20
> > quickly, or otherwise inform the system that the failure is temporary. =
 By=20
> > default there is a 5 minute timeout.  That can be adjusted, or we can a=
dd=20
> > other administrative hooks to 'suspend' any declarations of permanent=
=20
> > failure for this sort of case.
>=20
> Ok, so upping this timeout to something like 10 minutes would be
> sufficient for swapping and OSD.
>=20
> This is done via the mon_osd_down_out_interval paramater i assume (found
> in config.cc)

Yes.  And you can modify this value on a running system (without modifying=
=20
the .conf and restarting the monitor) with

$ ceph mon injectargs \* '--mon_osd_down_out_interval 600'

on the latest unstable.

> About more then one OSD on one machine, is there a way how you can bind
> an OSD to a specific IP? Can't seem to find any configuration for this.
>=20
> I assume you will need one IP per OSD on that machine?

Not currently via the .conf, only via the --bind 1.2.3.4:123 command line=
=20
argument.  Adding a bug for this.

> And my journaling question, any views on that topic?

I don't thank that turning the write cache off will affect btrfs too much,=
=20
but I haven't tested it.  It does need to be off if you use a separate=20
partition.  The other alternative is to put the journal file in btrfs, but=
=20
that is slower.

sage




>=20
> Thanks!
>=20
> >=20
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
> --=20
> Met vriendelijke groet,
>=20
> Wido den Hollander
> Hoofd Systeembeheer / CSO
> Telefoon Support Nederland: 0900 9633 (45 cpm)
> Telefoon Support Belgi=EB: 0900 70312 (45 cpm)
> Telefoon Direct: (+31) (0)20 50 60 104
> Fax: +31 (0)20 50 60 111
> E-mail: support@pcextreme.nl
> Website: http://www.pcextreme.nl
> Kennisbank: http://support.pcextreme.nl/
> Netwerkstatus: http://nmc.pcextreme.nl
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1756736938-1274378725=:4397--
