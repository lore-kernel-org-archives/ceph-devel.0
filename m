From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: Best practice with 0.48.2 to take a node into maintenance
Date: Mon, 3 Dec 2012 21:13:09 +0100
Message-ID: <7B185153-8ABF-4FB4-890A-4D5E8C789C55@filoo.de>
References: <0F892E7E-CF04-49A2-9ABA-5EAF25E6D645@filoo.de> <50BCFA2F.9070603@inktank.com> <EB4A37AF-6A19-4F66-B5E3-AED15BECED06@filoo.de> <50BD014E.90304@smart-weblications.de>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:40461 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab2LCUNM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 15:13:12 -0500
In-Reply-To: <50BD014E.90304@smart-weblications.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: f.wiessner@smart-weblications.de
Cc: ceph-devel <ceph-devel@vger.kernel.org>, josh.durgin@inktank.com

Hi Florian,

Am 03.12.2012 um 20:45 schrieb Smart Weblications GmbH - Florian Wiessn=
er  <f.wiessner@smart-weblications.de>:

> Am 03.12.2012 20:21, schrieb Oliver Francke:
>> Hi Josh,
>>=20
>> Am 03.12.2012 um 20:14 schrieb Josh Durgin <josh.durgin@inktank.com>=
:
>>=20
>>> On 12/03/2012 11:05 AM, Oliver Francke wrote:
>>>> Hi *,
>>>>=20
>>>> well, even if 0.48.2 is really stable and reliable, it is not ever=
ytime the case with linux kernel. We have a couple of nodes, where an u=
pdate would make life better.
>>>> So, as our OSD-nodes have to care for VM's too, it's not the probl=
em to let them drain so migrate all of them to other nodes.
>>>> Just reboot? Perhaps not, cause all OSD's will begin to remap/back=
fill, they are instructed to do so. Well, declare them as "osd lost"?
>>>> Dangerous. Is there another way I miss in doing node-maintenance? =
Will we have to wait for bobtail for far less hassle with all remapping=
 and resources?
>>>=20
>>> By default the monitors won't mark an OSD out in the time it takes =
to
>>> reboot, but if maintenance takes longer, you can drain data from th=
e
>>> node.
>>>=20
>>> A simple way to rate limit it yourself is by slowly lowering the
>>> weights of the OSDs on the host you want to update, e.g. by 0.1 at =
a
>>> time and waiting for recovery to complete before lowering again. On=
ce
>>> they're at 0 and the cluster is healthy, they're not responsible fo=
r
>>> any data anymore, and the node can be rebooted.
>>>=20
>>=20
>> true. Should have mentioned knowing smooth way. But for a planned re=
boot this take way too much time ;)
>> But if it's recommended, it's recommended ;)
>>=20
>=20
>=20
> I did rolling reboots of our whole cluster a few days ago (3.4.20). W=
hen the
> system reboots and no fsck is done, ceph won't start to backfill in m=
y setup.
>=20
> I had some nodes do fsck after upgrade so ceph marked the osd as down=
 and
> started to backfill, but once the missing osd was back up running aga=
in, the
> backfill stopped and ceph did just a little bit of peering and was he=
althy in a
> few minutes again (2-5 minutes)=85
>=20

if you encounter all BIOS-, POST-, RAID-controller-checks, linux-boot, =
openvswitch-STP setup and so on, one can imagine, that a reboot takes a=
 "couple-of-minutes", normally with our setup after 30 seconds the clus=
ter shall detect some outage and start to do it's work.
Everytings fine, but perhaps we could avoid big load in the cluster to =
remap and re-remap ( "Theme: slow requests") I have to ask in means of =
QoS for a "better way" ;)
All that stuff had a big customer impact in the past=85 Time to ask.

Kind reg's

Oliver.

=20

>=20
>=20
>=20
> --=20
>=20
> Mit freundlichen Gr=FC=DFen,
>=20
> Florian Wiessner
>=20
> Smart Weblications GmbH
> Martinsberger Str. 1
> D-95119 Naila
>=20
> fon.: +49 9282 9638 200
> fax.: +49 9282 9638 205
> 24/7: +49 900 144 000 00 - 0,99 EUR/Min*
> http://www.smart-weblications.de
>=20
> --
> Sitz der Gesellschaft: Naila
> Gesch=E4ftsf=FChrer: Florian Wiessner
> HRB-Nr.: HRB 3840 Amtsgericht Hof
> *aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
