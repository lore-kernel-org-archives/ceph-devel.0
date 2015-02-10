From: Loic Dachary <loic@dachary.org>
Subject: Re: dumpling integration branch for v0.67.12 ready for QE
Date: Tue, 10 Feb 2015 19:04:51 +0100
Message-ID: <54DA4843.10901@dachary.org>
References: <54DA3A5B.5050509@dachary.org> <54483038.14900677.1423588756901.JavaMail.zimbra@redhat.com> <54DA3E72.9010600@dachary.org> <867276671.14905190.1423589356764.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Tlji9tu2JqWP0HccNg4gm5x3gGwFalujO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41912 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753193AbbBJSEy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 13:04:54 -0500
In-Reply-To: <867276671.14905190.1423589356764.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tlji9tu2JqWP0HccNg4gm5x3gGwFalujO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/02/2015 18:29, Yuri Weinstein wrote:>=20
> On 10/02/2015 18:19, Yuri Weinstein wrote:>=20
>> Loic,
>>
>> The only difference between options if we run suits on merged dumpling=
 vs dumpling-backports first - is time.
>> We will have to run suites on the final branch after the merge anyway.=

>=20
> Could you explain why ? After merging dumpling and dumpling-backports w=
ill be exactly the same.
>=20
> Loic - I feel that finial QE validation should be done on the code that=
 gets actually released to customers, e.g. dumpling branch after the merg=
e.  I do see your point about branches being identical and ready to chang=
e my mind if you insist.  Does my reasoning make sense?  Please advice, h=
ow we should proceed.

The dumpling-backports branch currently is at=20

https://github.com/ceph/ceph/commit/3944c77c404c4a05886fe8276d5d0dd7e4f20=
410

after a successful test run from QE and a merge into dumpling, the dumpli=
ng branch will be at

https://github.com/ceph/ceph/commit/3944c77c404c4a05886fe8276d5d0dd7e4f20=
410

as well. In other words they are identical and there is no point in runni=
ng a test again. The only reason why they could be different is if a comm=
it is inadvertently added to the dumpling branch while testing happens on=
 the dumpling-backport branc. In this case the presence of this new commi=
t would be reason enough to run another round of test indeed. So the proc=
ess could be:

If tests are ok and merge can fast forward, then release.
If tests are ok and merge cannot fast forward, send back to loic because =
a commit was added by accident and needs to be approved by the leads.=20

If testing happens on the dumpling branch, adding a commit to the dumplin=
g branch would have side effects that could taint the results of the test=
s or, even worse, go unnoticed. There is zero chance that someone adds a =
commit to the dumpling-backports branch and that gives us something stabl=
e. On the contrary, the odds that someone adds a commit to the dumpling b=
ranch are high, specially if the tests take a few weeks to complete.=20

As Greg mentioned, merging in dumpling does not matter much for this roun=
d because it is what has been done in the past. And to be honest, I would=
 not mind if an additional commit taints the process by accident. However=
, unless there is a reason not to, it would be good to establish a proces=
s that is solid if we can.=20

I've witnessed Alfredo's pain on each release and an additional benefit o=
f having a dumpling-backports branch that nobody tampers with just occure=
d to me. When and if QE finds that dumpling-backports is fit for release,=
 instead of merging it into dumpling it could be handed over to Alfredo f=
or release. And he would be able to proceed knowing it is stable and won'=
t be moving forward. Once the release is done and the tag set to the prop=
er commit, the dumpling branch can be reset to dumpling-backports. If com=
mits were added during the process, their authors could be notified that =
they were discarded and need to be merge again. That would not work for t=
he master branch but it would definitely be possible for the stable branc=
hes because such "out of process" commits are rarely added.

I've not thought this through, but the more I think about it the more I l=
ike the idea of using dumpling-backports as a staging area until the rele=
ase is final.

What do you think ?=20

>=20
>>
>> Unless I hear otherwise, I will schedule suites to run on dumpling-bac=
kports first (as you are suggesting, with higher priority) and then assum=
ing that we resolved all issues, we will run on the dumpling merged.=20
>>
>> Sage, pls correct if this is not what has to be done.
>>
>>
>> Thx
>> YuriW
>>
>> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Yuri Weinstein" <yweinste@redhat.com>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Tuesday, February 10, 2015 9:05:31 AM
>> Subject: dumpling integration branch for v0.67.12 ready for QE
>>
>> Hi Yuri,
>>
>> The dumpling integration branch for v0.67.12 as found at https://githu=
b.com/ceph/ceph/commits/dumpling-backports has been approved by Yehuda, J=
osh and Sam and is ready for QE.=20
>>
>> For the record, the head is https://github.com/ceph/ceph/commit/3944c7=
7c404c4a05886fe8276d5d0dd7e4f20410
>>
>> I think it would be best for the QE tests to use the dumpling-backport=
s. The alternative would be to merge dumpling-backports into dumpling. Ho=
wever, since testing may take a long time and require more patches, it pr=
obably is better to not do that iterative process on the dumpling branch =
itself. As it is now, there already are a number of commits in the dumpli=
ng branch that should really be in the dumpling-backports: they do not be=
long to v0.67.11 and are going to be released in v0.67.12. In the future =
though, the dumpling branch will only receive commits that have been care=
fully tested and all the integration work will be on the dumpling-backpor=
ts branch exclusively. So that third parties do not have to worry that th=
e dumpling branch contains commits that have not been tested yet.
>>
>> Cheers
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Tlji9tu2JqWP0HccNg4gm5x3gGwFalujO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTaSEMACgkQ8dLMyEl6F20gJQCgtnECjWYztJfpbDxU8UMtCvCt
peMAn1OpKQwokYijmid1Ll88hAAiw+NP
=iD6e
-----END PGP SIGNATURE-----

--Tlji9tu2JqWP0HccNg4gm5x3gGwFalujO--
