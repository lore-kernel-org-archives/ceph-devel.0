From: Loic Dachary <loic@dachary.org>
Subject: Re: Proposal for a Backport tracker
Date: Fri, 22 May 2015 12:50:51 +0200
Message-ID: <555F0A0B.2040006@dachary.org>
References: <555DC080.8050508@dachary.org> <555ED569.2090604@suse.cz> <555ED98F.8020402@dachary.org> <555EE989.5070009@suse.cz> <555F0694.1060209@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="u9Gh5K75lnuuldKDNsFDpcqggnLOb5TIV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49112 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756570AbbEVKuz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 May 2015 06:50:55 -0400
In-Reply-To: <555F0694.1060209@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u9Gh5K75lnuuldKDNsFDpcqggnLOb5TIV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 22/05/2015 12:36, Joao Eduardo Luis wrote:
> On 05/22/2015 09:32 AM, Nathan Cutler wrote:
>>> We can probably keep the original ticket in the "Pending Backport"
>>> status until all backports are resolved, as we currently do.
>>>
>>>> So the question is, what will the original ticket's status be change=
d
>>>> to? Resolved?
>>>
>>> When all backports are resolved, then we can also resolve the origina=
l
>>> ticket. Do you forsee a problem with that ?
>>>
>>
>> Yes and no. It's a scripting problem, not a workflow problem. I'll try=

>> to describe the scenario I'm envisioning:
>>
>> We have a simple script that loops over all tickets with status "Pendi=
ng
>> Backport". We run it once per week. The first week we run it, the scri=
pt
>> finds 3 such tickets. For each one it creates a ticket in the Backport=

>> tracker.
>>
>> A week goes by, during which developers marked 4 more tickets "Pending=

>> Backport". It's time to run the script again. Since it is looping over=

>> all tickets marked "Pending Backport", it now finds 7 such tickets: 3
>> from last week and the 4 new ones. For each one it dutifully creates a=

>> new ticket in the Backport tracker. Now we have duplicate Backport
>> tickets for 3 bugfixes.
>>
>> But I guess it will be trivial to make the script check if a Backport
>> ticket is already open and refrain from opening a new one in this case=
=2E
>=20
> Alternatively, adding a new state to the tracker that distinguishes
> between tickets that are pending being picked up on by the stable
> releases team vs those that are just pending the backport.  Say, "Mark
> for Backport" vs "Pending Backport".
>=20

I liked the idea, wrote a reply and then realized: that won't save the sc=
ript from checking if the reality matches the status. Sometimes the "back=
ports" field is updated to remove or add a new backport target. It may me=
an closing or creating the corresponding issue and for that the script wi=
ll have to query the backport tracker.

>   -Joao
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--u9Gh5K75lnuuldKDNsFDpcqggnLOb5TIV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVfCgsACgkQ8dLMyEl6F215pACfQFLt4y7t+PYvB3WPbB9If4Gv
KHkAn1qjqyLLdgmMY61M8xzEeFY4CR0e
=h1kh
-----END PGP SIGNATURE-----

--u9Gh5K75lnuuldKDNsFDpcqggnLOb5TIV--
