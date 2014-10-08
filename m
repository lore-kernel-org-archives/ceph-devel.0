From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: 10/7/2014 Weekly Ceph Performance Meeting: kernel boot params
Date: Wed, 08 Oct 2014 20:07:45 +0200 (CEST)
Message-ID: <d7a70129-13c4-421d-b7fe-35990c384c4f@mailpro>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2785D4C1@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:50848 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbaJHSHz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Oct 2014 14:07:55 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2785D4C1@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Andreas Bluemle <andreas.bluemle@itxperts.de>, ceph-devel@vger.kernel.org

hi,

>>BTW, I am using Ubuntu 14.04 LTS and couldn't find any sysfs entry li=
ke 'cpufreq'..=20

check this arch wiki about kernel modules needed
https://wiki.archlinux.org/index.php/CPU_frequency_scaling



Also note that all theses tuning can normaly be done at bios level.
(on last dell servers bios, setting power profile to max performance, i=
s setting the governor to max and disable all cstate)

I'm always doing it on my kvm hypervisors hosts.


They are also the C1E option to disable on AMD processor.


----- Mail original -----=20

De: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
=C3=80: "Andreas Bluemle" <andreas.bluemle@itxperts.de>, ceph-devel@vge=
r.kernel.org=20
Envoy=C3=A9: Mercredi 8 Octobre 2014 19:38:26=20
Objet: RE: 10/7/2014 Weekly Ceph Performance Meeting: kernel boot param=
s=20

Thanks Andres for sharing this. I will try those out.=20
BTW, I am using Ubuntu 14.04 LTS and couldn't find any sysfs entry like=
 'cpufreq'..=20

root@stormeap-4:~# ll /sys/devices/system/cpu/cpu10/=20
cache/ crash_notes driver/ microcode/ online subsystem/ topology/=20
cpuidle/ crash_notes_size firmware_node/ node0/ power/ thermal_throttle=
/ uevent=20

I am using Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz.=20

Regards=20
Somnath=20

-----Original Message-----=20
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Andreas Bluemle=20
Sent: Wednesday, October 08, 2014 9:33 AM=20
To: ceph-devel@vger.kernel.org=20
Subject: Re: 10/7/2014 Weekly Ceph Performance Meeting: kernel boot par=
ams=20

Hi,=20

as mentioned during today's meeting, here are the kernel boot parameter=
s which I found to provide the basis for good performance results:=20

processor.max_cstate=3D0=20
intel_idle.max_cstate=3D0=20

I understand these to basically turn off any power saving modes of the =
CPU; the CPU's we are using are like=20
Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz=20
Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz=20

At the BIOS level, we=20
- turn off Hyperthraeding=20
- turn off Turbo mode (in order ot not leave the specifications)=20
- turn on frequency floor override=20

We also assert that=20
/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor=20
is set to "performance"=20

Using above we see a constant frequency at the maximum level allowed by=
 the CPU (except Turbo mode).=20


Best Regards=20

Andreas Bluemle=20






On Wed, 8 Oct 2014 02:51:21 +0200=20
Mark Nelson <mark.nelson@inktank.com> wrote:=20

> Hi All,=20
>=20
> Just a remind that the weekly performance meeting is on Wednesdays at=
=20
> 8AM PST. Same bat time, same bat channel!=20
>=20
> Etherpad URL:=20
> http://pad.ceph.com/p/performance_weekly=20
>=20
> To join the Meeting:=20
> https://bluejeans.com/268261044=20
>=20
> To join via Browser:=20
> https://bluejeans.com/268261044/browser=20
>=20
> To join with Lync:=20
> https://bluejeans.com/268261044/lync=20
>=20
>=20
> To join via Room System:=20
> Video Conferencing System: bjn.vc -or- 199.48.152.152 Meeting ID:=20
> 268261044=20
>=20
> To join via Phone:=20
> 1) Dial:=20
> +1 408 740 7256=20
> +1 888 240 2560(US Toll Free)=20
> +1 408 317 9253(Alternate Number)=20
> (see all numbers - http://bluejeans.com/numbers)=20
> 2) Enter Conference ID: 268261044=20
>=20
> Mark=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at http://vger.kernel.org/majordomo-info.html=20
>=20
>=20



--=20
Andreas Bluemle mailto:Andreas.Bluemle@itxperts.de=20
ITXperts GmbH http://www.itxperts.de=20
Balanstrasse 73, Geb. 08 Phone: (+49) 89 89044917=20
D-81541 Muenchen (Germany) Fax: (+49) 89 89044910=20

Company details: http://www.itxperts.de/imprint.htm=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at http://vger.kernel.org/majordomo-info.html=20

________________________________=20

PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above=
=2E If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
