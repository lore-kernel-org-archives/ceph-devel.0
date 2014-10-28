From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology
Date: Tue, 28 Oct 2014 16:01:45 +0100
Message-ID: <544FAFD9.1070804@dachary.org>
References: <20141024230302.GI6445@thinkpad.thebehrens.net>	 <1414397595.8790.11.camel@linux-cb82>	 <20141027104707.GU6445@thinkpad.thebehrens.net>	 <544E6A2E.5090809@dachary.org> <1414429260.8790.41.camel@linux-cb82>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qHMvRLMMXTj77sFhus6wMMvxLKMsODfQO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54792 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754672AbaJ1PB4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Oct 2014 11:01:56 -0400
In-Reply-To: <1414429260.8790.41.camel@linux-cb82>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kapil Sharma <ksharma@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qHMvRLMMXTj77sFhus6wMMvxLKMsODfQO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kapil,

On 27/10/2014 18:01, Kapil Sharma wrote:
> Hi Loic,=20
>=20
> Zack from Inktank helped me a lot in setting up teuthology.
>=20
> I think following areas could be worked upon to make teuthology
> easier to install and run -=20
>=20
>=20
> 1. Currently we can by-pass the Lock server when running individual
> tests from a yaml config file. However, if we have to run
> teuthology-suite, it seems using Lock server is mandatory.I think lock
> server should be optional. A user should have an option to by-pass the
> lock server as he may not need it when running the tests outside the
> Inktank lab.

I also started to not use the lock server, a year ago. I recently experim=
ented with paddles + teuthology-worker and it's fairly easy to get it to =
work. The advantage is that you can schedule jobs that will wait for othe=
rs to complete. My work in progress is at

https://github.com/dachary/teuthology/compare/wip-container
https://github.com/dachary/paddles/compare/wip-container

(note that it is mixed with my attempt to make it work with docker instea=
d of virtual machines or bare metal)
=20
> 2. The word "ubuntu" is hard coded in some places in the code :-)
>=20
> 3. The bootstrap script is for ubuntu machines only. Anyway, it's
> not a big task to run those commands manually or create a script of
> your own.=20

Is your script available somewhere ? I plan to set it up on fedora20 and =
it would be most useful.

> 4. Teuthology picks up several test cases from the qa/workunits dir -
> https://github.com/ceph/ceph/tree/master/qa/workunits
> Unfortunately these tests are not documented anywhere. If one has to
> check the test coverage or document the exact test steps, it's going
> to be a humungous effort.

Yes. I'm often happy to read tests as if they were the documention of the=
 code. But it would be useful to have documentation for the test themselv=
es in additon ;-)

> 5. The tests executed in qa/workunits are not listed as separate test
> cases in Pulpito results. E.g qa/workunits/rbd/test_librbd_python.sh
> contains 57 tests. However, in Pupito this is listed as one job. Though=

> not sure if it is possible to implement this as most of the qa/workunit=
s
> tests are shell scripts.

Are you running pulpito ? I create a split of workunit that may be of int=
erest to you. My motivation was not to have them show separately in pulpi=
to. Rather to run them in //=20

I first modified the script so that it could be called to group tests:

https://github.com/dachary/ceph/commit/ec0ba1a9994e4eb24955442895c6b8dd25=
61ba20

and then created scripts to run each group independantly

https://github.com/dachary/ceph/commit/bafd35478e310e887a808784f02c7f0041=
548d1e

which could also be an "exec" teuthology tasks.


> 6. I have not tried this of-late but I think teuthology can not run it'=
s
> tests against an already deployed ceph-cluster. I need to check it agai=
n
> though.

It may be possible to convince it to do that since the install task is no=
t mandatory.

> 7. Would be great if teuthology can cover Calamari testing too :-)

If I'm not mistaken Waren is working on making this happen. But I've not =
looked at it closely.

Cheers

>=20
>=20
> Best Regards,
> Kapil.
>=20
>=20
>=20
>=20
>=20
>=20
> On Mon, 2014-10-27 at 16:52 +0100, Loic Dachary wrote:
>> It was great meeting your and your family :-) Back in Paris and massiv=
ely jetlagged.
>>
>> Nice to meet you Kapil ! Are there any pain points you'd like to addre=
ss regarding the teuthology installation ?
>>
>> Cheers
>>
>> On 27/10/2014 11:47, Thorsten Behrens wrote:
>>> Hi Loic,
>>>
>>> was great to meet you and Patrick at the google summit!
>>>
>>> Loic, meet Kapil, who's doing lots of great stuff with QA automation
>>> and deployment on our side. And I think he and Zack were already in
>>> close contact. ;)
>>>
>>> As promised the update on what we run from teuthology:
>>>
>>> Kapil Sharma wrote:
>>>> As of now I have cnfigured, rbd, krbd and rados test suites which
>>>> are located here
>>>> [snip]
>>>>
>>>
>>> All the very best, and a safe trip home,
>>>
>>
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--qHMvRLMMXTj77sFhus6wMMvxLKMsODfQO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRPr9kACgkQ8dLMyEl6F20UzgCdEyaayhosN0ZzHqPhtabWRXUN
VNkAoL9AoHmOjlGjsY2G6i0iiRLXVM+Z
=gcEx
-----END PGP SIGNATURE-----

--qHMvRLMMXTj77sFhus6wMMvxLKMsODfQO--
