From: Loic Dachary <loic@dachary.org>
Subject: Re: 10/7/2014 Weekly Ceph Performance Meeting: kernel boot params
Date: Wed, 08 Oct 2014 19:57:56 +0200
Message-ID: <54357B24.4040106@dachary.org>
References: <54348A89.1060906@redhat.com> <20141008183234.19a24ac1@doppio> <755F6B91B3BE364F9BCA11EA3F9E0C6F2785D4C1@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uw300Ai1d3ok7jsA3va3jdKHBPGTDjlDe"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:40462 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754557AbaJHR6F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Oct 2014 13:58:05 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2785D4C1@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Andreas Bluemle <andreas.bluemle@itxperts.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uw300Ai1d3ok7jsA3va3jdKHBPGTDjlDe
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/10/2014 19:38, Somnath Roy wrote:
> Thanks Andres for sharing this. I will try those out.
> BTW, I am using Ubuntu 14.04 LTS and couldn't find any sysfs entry like=
  'cpufreq'..
>=20
> root@stormeap-4:~# ll /sys/devices/system/cpu/cpu10/
> cache/            crash_notes       driver/           microcode/       =
 online            subsystem/        topology/
> cpuidle/          crash_notes_size  firmware_node/    node0/           =
 power/            thermal_throttle/ uevent
>=20
> I am using Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz.


-rw-r--r-- 1 root root 4096 oct.   8 17:31 /sys/devices/system/cpu/cpu0/c=
pufreq/scaling_governor
-rw-r--r-- 1 root root 4096 oct.   8 17:31 /sys/devices/system/cpu/cpu1/c=
pufreq/scaling_governor
-rw-r--r-- 1 root root 4096 oct.   8 17:31 /sys/devices/system/cpu/cpu2/c=
pufreq/scaling_governor
-rw-r--r-- 1 root root 4096 oct.   8 17:31 /sys/devices/system/cpu/cpu3/c=
pufreq/scaling_governor
-rw-r--r-- 1 root root 4096 oct.   8 17:31 /sys/devices/system/cpu/cpu4/c=
pufreq/scaling_governor
-rw-r--r-- 1 root root 4096 oct.   8 17:31 /sys/devices/system/cpu/cpu5/c=
pufreq/scaling_governor
-rw-r--r-- 1 root root 4096 oct.   8 17:31 /sys/devices/system/cpu/cpu6/c=
pufreq/scaling_governor
-rw-r--r-- 1 root root 4096 oct.   8 17:31 /sys/devices/system/cpu/cpu7/c=
pufreq/scaling_governor

model name	: Intel(R) Core(TM) i7-4900MQ CPU @ 2.80GHz

$ lsb_release -d
Description:	Ubuntu Trusty Tahr (development branch)

Cheers

>=20
> Regards
> Somnath
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.ke=
rnel.org] On Behalf Of Andreas Bluemle
> Sent: Wednesday, October 08, 2014 9:33 AM
> To: ceph-devel@vger.kernel.org
> Subject: Re: 10/7/2014 Weekly Ceph Performance Meeting: kernel boot par=
ams
>=20
> Hi,
>=20
> as mentioned during today's meeting, here are the kernel boot parameter=
s which I found to provide the basis for good performance results:
>=20
>   processor.max_cstate=3D0
>   intel_idle.max_cstate=3D0
>=20
> I understand these to basically turn off any power saving modes of the =
CPU; the CPU's we are using are like
>  Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz
>  Intel(R) Xeon(R) CPU E5-2630 0 @ 2.30GHz
>=20
> At the BIOS level, we
>  - turn off Hyperthraeding
>  - turn off Turbo mode (in order ot not leave the specifications)
>  - turn on frequency floor override
>=20
> We also assert that
>  /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
>  is set to "performance"
>=20
> Using above we see a constant frequency at the maximum level allowed by=
 the CPU (except Turbo mode).
>=20
>=20
> Best Regards
>=20
> Andreas Bluemle
>=20
>=20
>=20
>=20
>=20
>=20
> On Wed, 8 Oct 2014 02:51:21 +0200
> Mark Nelson <mark.nelson@inktank.com> wrote:
>=20
>> Hi All,
>>
>> Just a remind that the weekly performance meeting is on Wednesdays at
>> 8AM PST.  Same bat time, same bat channel!
>>
>> Etherpad URL:
>> http://pad.ceph.com/p/performance_weekly
>>
>> To join the Meeting:
>> https://bluejeans.com/268261044
>>
>> To join via Browser:
>> https://bluejeans.com/268261044/browser
>>
>> To join with Lync:
>> https://bluejeans.com/268261044/lync
>>
>>
>> To join via Room System:
>> Video Conferencing System: bjn.vc -or- 199.48.152.152 Meeting ID:
>> 268261044
>>
>> To join via Phone:
>> 1) Dial:
>>            +1 408 740 7256
>>            +1 888 240 2560(US Toll Free)
>>            +1 408 317 9253(Alternate Number)
>>            (see all numbers - http://bluejeans.com/numbers)
>> 2) Enter Conference ID: 268261044
>>
>> Mark
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>=20
>=20
>=20
> --
> Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
> ITXperts GmbH                       http://www.itxperts.de
> Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
> D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910
>=20
> Company details: http://www.itxperts.de/imprint.htm
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo info =
at  http://vger.kernel.org/majordomo-info.html
>=20
> ________________________________
>=20
> PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above. =
If the reader of this message is not the intended recipient, you are here=
by notified that you have received this message in error and that any rev=
iew, dissemination, distribution, or copying of this message is strictly =
prohibited. If you have received this communication in error, please noti=
fy the sender by telephone or e-mail (as shown above) immediately and des=
troy any and all copies of this message in your possession (whether hard =
copies or electronically stored copies).
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--uw300Ai1d3ok7jsA3va3jdKHBPGTDjlDe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQ1eyUACgkQ8dLMyEl6F21oCwCgt4LtANe8gvS2HRW8N9dTxlwI
5LgAn1zPZMBiukgMPBlw7xAIHPgfFCet
=abBY
-----END PGP SIGNATURE-----

--uw300Ai1d3ok7jsA3va3jdKHBPGTDjlDe--
