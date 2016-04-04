From: Wido den Hollander <wido@42on.com>
Subject: Re: ceph-disk improvements
Date: Mon, 4 Apr 2016 14:58:14 +0200 (CEST)
Message-ID: <1167010421.2186.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
References: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com>
 <2041558235.2113.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
 <56FF886A.3080406@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:52066 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbcDDM6T convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Apr 2016 08:58:19 -0400
In-Reply-To: <56FF886A.3080406@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org


> Op 2 april 2016 om 10:52 schreef Loic Dachary <loic@dachary.org>:
>=20
>=20
> Hi Wido,
>=20
> On 02/04/2016 07:54, Wido den Hollander wrote:
> >=20
> >> Op 1 april 2016 om 17:36 schreef Sage Weil <sweil@redhat.com>:
> >>
> >>
> >> Hi all,
> >>
> >> There are a couple of looming features for ceph-disk:
> >>
> >> 1- Support for additional devices when using BlueStore.  There can=
 be up=20
> >> to three: the main device, a WAL/journal device (small, ~128MB, id=
eally=20
> >> NVRAM), and a fast metadata device (as big as you have available; =
will be=20
> >> used for internal metadata).
> >>
> >> 2- Support for setting up dm-cache, bcache, and/or FlashCache unde=
rneath=20
> >> filestore or bluestore.
> >>
> >=20
> > Keep in mind that you can't create a partition on a bcache device. =
So when
> > using
> > bcache, the journal has to be filebased and not a partition.
>=20
> Is this true of all bcache versions ( https://bcache.evilpiepirate.or=
g/ ) ? Or
> is it a planned feature ? Or is it never going to happen ?

I am not sure. But from my experience with bcache it is not supported o=
n any
kernel. Tried up to version 4.2

>=20
> Cheers
>=20
> >=20
> > If we add the flag --file-based-journal or --no-partitions we can c=
reate
> > OSDs on
> > both bcache and dm-cache.
> >=20
> > With BlueStore this becomes a problem since it requires the small (=
XFS)
> > filesystem for it's metadata.
> >=20
> > Wido
> >=20
> >> The current syntax of
> >>
> >>  ceph-disk prepare [--dmcrypt] [--bluestore] DATADEV [JOURNALDEV]
> >>
> >> isn't terribly expressive.  For example, the journal device size i=
s set=20
> >> via a config option, not on the command line.  For bluestore, the =
metadata=20
> >> device will probably want/need explicit user input so they can ens=
ure it's=20
> >> 1/Nth of their SSD (if they have N HDDs to each SSD).
> >>
> >> And if we put dmcache in there, that partition will need to be siz=
ed too.
> >>
> >> Another consideration is that right now we don't play nice with LV=
M at=20
> >> all.  Should we?  dm-cache is usually used in conjunction with LVM=
=20
> >> (although it doesn't have to be).  Does LVM provide value?  Like, =
the=20
> >> ability for users to add a second SSD to a box and migrate cache, =
wal, or=20
> >> journal partitions around?
> >>
> >> I'm interested in hearing feedback on requirements, approaches, an=
d=20
> >> interfaces before we go too far down the road...
> >>
> >> Thanks!
> >> sage
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
>=20
> --=20
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
