From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph backports
Date: Mon, 05 Jan 2015 13:16:45 +0100
Message-ID: <54AA80AD.2010901@dachary.org>
References: <54AA7B46.6090706@dachary.org> <CAGd4Wr2aw1ODd=06dQa7HQzbFu6sYZeQGTOV5Vn6VW+j6dK63g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="eoGdIGLDPTXKGa1Ij155aHXxOwpqcAP2B"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33624 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753324AbbAEMQr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 07:16:47 -0500
In-Reply-To: <CAGd4Wr2aw1ODd=06dQa7HQzbFu6sYZeQGTOV5Vn6VW+j6dK63g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eoGdIGLDPTXKGa1Ij155aHXxOwpqcAP2B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 05/01/2015 13:03, John Spray wrote:
> Sounds sane -- is the new plan to always do backports via this
> process?  i.e. if I see a backport PR which has not been through
> integration testing, should I refrain from merging it?

I think that's the idea, indeed. QE does the merge, when and if tests are=
 green.

>=20
> John
>=20
> On Mon, Jan 5, 2015 at 11:53 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Ceph,
>>
>> I'm going to spend time to care for the Ceph backports (i.e. help redu=
ce the time they stay in pull requests or redmine tickets). It should rou=
ghly go as follows:
>>
>> 0. Developer follows normal process to land PR to master. Once complet=
e and ticket is marked Pending Backport this process initiates.
>> 1. I periodically polls Redmine to look for tickets in Pending Backpor=
t state
>> 2. I find commit associated with Redmine ticket and Cherry Picks it to=
 backport integration branch off of desired maintenance branch (Dumping, =
Firefly, etc). (Note - patch may require backport to multiple branches)
>> 3. I resolve any merge conflicts with the cherry-picked commit
>> 4. Once satisfied with group of backported commits to integration bran=
ch, I notifies QE.
>> 5. QE tests backport integration branch against appropriate suites
>> 6a. If QE is satisfied with test results, they merge backport integrat=
ion branch.
>> 6b. If QE is NOT satisfied with the test results, they indicate backpo=
rt integration branch is NOT ready to merge and return to me to work with=
 original Developer to resolve issue and return to steps 2/3
>> 7. Ticket is moved to Resolved once backport integration branch contai=
ning cherry-picked backport is merged to the desired mainteance branch(es=
)
>>
>> I'll first try to implement this semi manually and document / script w=
hen convenient. If anyone has ideas to improve this tentative process, no=
w is the time :-)
>>
>> Cheers
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--eoGdIGLDPTXKGa1Ij155aHXxOwpqcAP2B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSqgK0ACgkQ8dLMyEl6F212iACgiY/eh8WkRniThJTWfgRWzHwK
CT0An2r0P6BKo3pw44BvaVZdzqp7p8bS
=UgNl
-----END PGP SIGNATURE-----

--eoGdIGLDPTXKGa1Ij155aHXxOwpqcAP2B--
