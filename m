From: Loic Dachary <loic@dachary.org>
Subject: Re: Infernalis RGW failure investigation
Date: Tue, 9 Feb 2016 12:34:04 +0700
Message-ID: <56B97A4C.2020303@dachary.org>
References: <56B8110D.8040401@dachary.org> <20160208210218.GC14128@oak.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:46889 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbcBIFeM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Feb 2016 00:34:12 -0500
Received: from mfilter22-d.gandi.net (mfilter22-d.gandi.net [217.70.178.150])
	by relay2-d.mail.gandi.net (Postfix) with ESMTP id BE288C5A54
	for <ceph-devel@vger.kernel.org>; Tue,  9 Feb 2016 06:34:10 +0100 (CET)
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
	by mfilter22-d.gandi.net (mfilter22-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id r4Ckwy8ac6yJ for <ceph-devel@vger.kernel.org>;
	Tue,  9 Feb 2016 06:34:09 +0100 (CET)
Received: from [10.7.10.93] (node-ar0.pool-118-172.dynamic.totbb.net [118.172.54.108])
	(Authenticated sender: loic@dachary.org)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8EA25C5A4E
	for <ceph-devel@vger.kernel.org>; Tue,  9 Feb 2016 06:34:08 +0100 (CET)
In-Reply-To: <20160208210218.GC14128@oak.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

On 09/02/2016 04:02, Karol Mroz wrote:
> On Mon, Feb 08, 2016 at 10:52:45AM +0700, Loic Dachary wrote:
>> Dear RGW developers,
>>
>> We ran into http://tracker.ceph.com/issues/14665 on the infernalis b=
ranch. It would be great if someone could shed some light on why it hap=
pens.
>>
>=20
> Hi Loic,
>=20
> If this has already been discussed elsewhere, or I'm simply stating t=
he obvious,
> my apologies in advance. However, it looks like the rgw socket file _=
may_ be created
> with some odd permissions/ownership, relative to the user under which=
 the test is being
> run.
>=20
> With a recent ceph/master build on my end (I don't have immediate acc=
ess to an infernalis
> system), the rgw admin socket is created as ceph:ceph. Running `rados=
gw-admin` as root
> then binds fine.
>=20
>=20
> I've added http://tracker.ceph.com/issues/14665#note-3

Thanks ! let's continue this discussion in the tracker :-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
