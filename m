From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-disk improvements
Date: Thu, 7 Apr 2016 13:45:30 +0200
Message-ID: <5706485A.80607@dachary.org>
References: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com>
 <2041558235.2113.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
 <20160407092627.GE26235@suse.de>
 <CA+HUO7+7v5NjiP-3+h-OMkez3L8MSRoo27+=HCdEc20ntW9=gw@mail.gmail.com>
 <20160407105129.GG26235@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:37431 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424AbcDGLpe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2016 07:45:34 -0400
In-Reply-To: <20160407105129.GG26235@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>, ceph-devel@vger.kernel.org

Hi Lars,

There is some preliminary thoughts at http://tracker.ceph.com/issues/74=
75.

Cheers

On 07/04/2016 12:51, Lars Marowsky-Bree wrote:
> On 2016-04-07T12:31:21, Sebastien Han <shan@redhat.com> wrote:
>=20
>> One thing I'd like to see and I know we discussed that with Lo=EFc a
>> while ago is ceph-disk being idempotent when it comes to the device
>> preparation.
>> Running "ceph-disk prepare" against a device should result in an exi=
t
>> 0 if the disk already has an OSD prepared on it (unless we do
>> something like --force, which will then zap the disk).
>> I had to implement this logic in ceph-ansible (and the guys from
>> chef/puppet probably did the same), so now it's done but i'll be hap=
py
>> to leave ceph-disk doing it :).
>>
>> Thoughts?
>=20
> Basically, +1.
>=20
> Owen (who works on salt-ceph) has a love/love relationship with the w=
ord
> "idempotent" as well.
>=20
> Note that it should probably only exit=3D0 if the OSD matches the cur=
rent
> fsid?
>=20
>=20
> Regards,
>     Lars
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
