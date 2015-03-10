From: Loic Dachary <loic@dachary.org>
Subject: Re: giant integration branch for v0.87.1 ready for QE / fix for 10433/8011
 ? osd/ReplicatedPG.cc: 5545: FAILED assert(soid < scrubber.start || soid
 >= scrubber.end)
Date: Tue, 10 Mar 2015 08:59:13 +0100
Message-ID: <54FEA451.5090002@dachary.org>
References: <54DA3DD6.7070108@dachary.org> <54DB757E.2000009@dachary.org>	 <1387059957.19365485.1424108024488.JavaMail.zimbra@redhat.com>	 <1622340604.24695270.1424468972740.JavaMail.zimbra@redhat.com> <1425970573.3853.583.camel@pc2>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AxrSmaxiwWj1qq3sBPVsgbtwGnjextgDE"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55646 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751709AbbCJH7W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Mar 2015 03:59:22 -0400
In-Reply-To: <1425970573.3853.583.camel@pc2>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laurent GUERBY <laurent@guerby.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AxrSmaxiwWj1qq3sBPVsgbtwGnjextgDE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

http://tracker.ceph.com/issues/8011 is now marked with a higher priority =
for backporting (I'm using the "Severity" field for that purpose). Please=
 let me know if other backports need more attention.

Cheers

On 10/03/2015 07:56, Laurent GUERBY wrote:
> Hi,
>=20
> Any reason why the complete fix for 8011/10433 was
> not included in giant 0.87.1?
>=20
> Missing fix:
> http://workbench.dachary.org/ceph/ceph/commit/9b26de3f3653d38dcdfc5b978=
74089f19d2a59d7
>=20
> Issues:
> http://tracker.ceph.com/issues/8011
> http://tracker.ceph.com/issues/10433#note-7
>=20
> Thanks in advance,
>=20
> Sincerely,
>=20
> Laurent
>=20
> On Fri, 2015-02-20 at 16:49 -0500, Yuri Weinstein wrote:
>> Team leads,
>>
>> Please review QE validation results summary in http://tracker.ceph.com=
/issues/10501
>>
>> Loic - this RC looks ready for release (in my opinion) !=20
>>
>> Thx
>> YuriW
>>
>> ----- Original Message -----
>> From: "Yuri Weinstein" <yweinste@redhat.com>
>> To: "Loic Dachary" <loic@dachary.org>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Monday, February 16, 2015 9:33:44 AM
>> Subject: Re: giant integration branch for v0.87.1 ready for QE
>>
>> I have completed suites execution on giant branch (v0.87.1 RC)
>>
>> All results are summarized in http://tracker.ceph.com/issues/10501 und=
er "QE VALIDATION" section.
>> Some suites had to be run more then ones due to environment noise.
>>
>> Two suites are being re-run now - upgrade:firefly-x and powecycle.
>>
>> Next steps:
>> -  the team leads to review/confirm results
>> -  Loic - can you review and triage issues as needed.
>> -  two suites require results analysis:
>>    multimds
>>    rados (two known tickets, but need more checking) ## 10209, 9891
>>    krbd (two new tickets, but need more checking) ## 10889, 10890
>>
>>
>> Thx
>> YuriW
>>
>> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Yuri Weinstein" <yweinste@redhat.com>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Wednesday, February 11, 2015 7:30:06 AM
>> Subject: Re: giant integration branch for v0.87.1 ready for QE
>>
>> Hi Yuri,
>>
>> The giant-backports pull requests were merged into https://github.com/=
ceph/ceph/tree/giant which is not ready for testing.
>>
>> For the record, the head is https://github.com/ceph/ceph/commit/78c71b=
9200da5e7d832ec58765478404d31ae6b5
>>
>> Cheers
>>
>> On 10/02/2015 18:20, Loic Dachary wrote:
>>> Hi Yuri,
>>>
>>> The giant integration branch for v0.87.1 as found at https://github.c=
om/ceph/ceph/commits/giant-backports has been approved by Yehuda, Josh an=
d Sam and is ready for QE.=20
>>>
>>> For the record, the head is https://github.com/ceph/ceph/commit/6b08a=
729540c61f3c8b15c5a3ce9382634bf800c
>>>
>>> Cheers
>>>
>>
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--AxrSmaxiwWj1qq3sBPVsgbtwGnjextgDE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEUEARECAAYFAlT+pFEACgkQ8dLMyEl6F21Q1QCYn4grpw9neumxmIVpIVlaII6B
kACaA2WHuk+JHHluT1Ko91i14bTSAC8=
=UDO6
-----END PGP SIGNATURE-----

--AxrSmaxiwWj1qq3sBPVsgbtwGnjextgDE--
