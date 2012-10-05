From: Smart Weblications GmbH - Florian Wiessner
	<f.wiessner@smart-weblications.de>
Subject: Re: ceph-mon not starting - AdminSocketConfigObs::init: error: AdminSocket::create_shutdown_pipe
 error: (38) Function not implemented
Date: Fri, 05 Oct 2012 17:56:15 +0200
Message-ID: <506F031F.9050405@smart-weblications.de>
References: <506D9148.9040106@smart-weblications.de> <506ED188.5020905@smart-weblications.de> <506ED404.1000306@inktank.com> <alpine.DEB.2.00.1210050819320.6121@cobra.newdream.net>
Reply-To: f.wiessner@smart-weblications.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.smart-weblications.de ([188.65.144.36]:45961 "EHLO
	mx01.smart-weblications.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751225Ab2JEPzr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Oct 2012 11:55:47 -0400
In-Reply-To: <alpine.DEB.2.00.1210050819320.6121@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 05.10.2012 17:24, schrieb Sage Weil:
> On Fri, 5 Oct 2012, Joao Eduardo Luis wrote:
>> On 10/05/2012 01:24 PM, Smart Weblications GmbH - Florian Wiessner w=
rote:
>>> Am 04.10.2012 15:38, schrieb Smart Weblications GmbH - Florian Wies=
sner:
>>>> Hi,
>>>>
>>>>
>>>> i have a ceph cluster with 2 osds, 3 mons.. one of the monitors do=
es not start
>>>> anymore:
>>>>
>>>> 2012-10-04 13:36:29.501178 7f7e123f9780 -1 asok(0x14ac000)
>>>> AdminSocketConfigObs::init: error: AdminSocket::create_shutdown_pi=
pe error: (38)
>>>> Function not implemented
>>>> 2012-10-04 13:36:29.535018 7f7e123f9780  1 mon.2@-1(probing) e1 in=
it fsid
>>>> 5b59811a-d235-488f-9b9b-953db7e5028b
>>>> 2012-10-04 13:36:29.541171 7f7e123f9780 -1 mon/Paxos.cc: In functi=
on 'bool
>>>> Paxos::is_consistent()' thread 7f7e123f9780 time 2012-10-04 13:36:=
29.536744
>>>> mon/Paxos.cc: 1031: FAILED assert(consistent || (slurping =3D=3D 1=
))
>>
>> This assertion means the monitor was killed or failed either during
>> slurping (while catching up with the other monitors) or while perfor=
ming
>> some kind of update. So it ended up in an inconsistent state.
>=20
> The monitor is supposed to take note of when it is slurping and may b=
e=20
> temporarily inconsistent by writing a 'slurping' file with '1' in it =
in=20
> the paxos subdirectory(ies), so some bug triggered this.  A simple=20
> workaround is to do
>=20
>   echo 1 > $mondata/osdmap/slurping
>   echo 1 > $mondata/pgmap/slurping
>   echo 1 > $mondata/monmap/slurping
>   echo 1 > $mondata/logm/slurping
>   echo 1 > $mondata/auth/slurping
>=20
> and it will go through the recovery steps.  It would be helpful if yo=
u=20
> could tar up a copy of the mon directory first, though, along with an=
y=20
> log files on that host, so we can try to figure out what went wrong.
>=20

unfortunatelly, i deleted the logs for the monitor, as i did not see an=
ything
special except this assertion...


i'll send mon-directory directly to Sage with a seperate mail.


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
