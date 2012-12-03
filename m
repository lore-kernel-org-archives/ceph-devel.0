From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: Best practice with 0.48.2 to take a node into maintenance
Date: Mon, 03 Dec 2012 20:45:18 +0100
Message-ID: <50BD014E.90304@smart-weblications.de>
References: <0F892E7E-CF04-49A2-9ABA-5EAF25E6D645@filoo.de> <50BCFA2F.9070603@inktank.com> <EB4A37AF-6A19-4F66-B5E3-AED15BECED06@filoo.de>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.smart-weblications.de ([188.65.144.36]:56379 "EHLO
	mx01.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752306Ab2LCTvy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Dec 2012 14:51:54 -0500
In-Reply-To: <EB4A37AF-6A19-4F66-B5E3-AED15BECED06@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Oliver Francke <Oliver.Francke@filoo.de>, josh.durgin@inktank.com

Am 03.12.2012 20:21, schrieb Oliver Francke:
> Hi Josh,
>=20
> Am 03.12.2012 um 20:14 schrieb Josh Durgin <josh.durgin@inktank.com>:
>=20
>> On 12/03/2012 11:05 AM, Oliver Francke wrote:
>>> Hi *,
>>>
>>> well, even if 0.48.2 is really stable and reliable, it is not every=
time the case with linux kernel. We have a couple of nodes, where an up=
date would make life better.
>>> So, as our OSD-nodes have to care for VM's too, it's not the proble=
m to let them drain so migrate all of them to other nodes.
>>> Just reboot? Perhaps not, cause all OSD's will begin to remap/backf=
ill, they are instructed to do so. Well, declare them as "osd lost"?
>>> Dangerous. Is there another way I miss in doing node-maintenance? W=
ill we have to wait for bobtail for far less hassle with all remapping =
and resources?
>>
>> By default the monitors won't mark an OSD out in the time it takes t=
o
>> reboot, but if maintenance takes longer, you can drain data from the
>> node.
>>
>> A simple way to rate limit it yourself is by slowly lowering the
>> weights of the OSDs on the host you want to update, e.g. by 0.1 at a
>> time and waiting for recovery to complete before lowering again. Onc=
e
>> they're at 0 and the cluster is healthy, they're not responsible for
>> any data anymore, and the node can be rebooted.
>>
>=20
> true. Should have mentioned knowing smooth way. But for a planned reb=
oot this take way too much time ;)
> But if it's recommended, it's recommended ;)
>=20


I did rolling reboots of our whole cluster a few days ago (3.4.20). Whe=
n the
system reboots and no fsck is done, ceph won't start to backfill in my =
setup.

I had some nodes do fsck after upgrade so ceph marked the osd as down a=
nd
started to backfill, but once the missing osd was back up running again=
, the
backfill stopped and ceph did just a little bit of peering and was heal=
thy in a
few minutes again (2-5 minutes)...




--=20

Mit freundlichen Gr=FC=DFen,

=46lorian Wiessner

Smart Weblications GmbH
Martinsberger Str. 1
D-95119 Naila

fon.: +49 9282 9638 200
fax.: +49 9282 9638 205
24/7: +49 900 144 000 00 - 0,99 EUR/Min*
http://www.smart-weblications.de

--
Sitz der Gesellschaft: Naila
Gesch=E4ftsf=FChrer: Florian Wiessner
HRB-Nr.: HRB 3840 Amtsgericht Hof
*aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
