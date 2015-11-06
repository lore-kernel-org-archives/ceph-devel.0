From: Loic Dachary <loic@dachary.org>
Subject: Re: a home for backport snippets
Date: Fri, 6 Nov 2015 08:53:12 +0100
Message-ID: <563C5C68.1010606@dachary.org>
References: <563B5789.7050006@dachary.org>
 <CAP3mxSzcET62u7zJCUtMv56Xjkr_29HN4qhj_H4b-XsxRNf2SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="0srnXq33PWJnV2VUEIiRdCRskktkI7EWV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55805 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1032480AbbKFHxX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Nov 2015 02:53:23 -0500
In-Reply-To: <CAP3mxSzcET62u7zJCUtMv56Xjkr_29HN4qhj_H4b-XsxRNf2SA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Abhishek L <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0srnXq33PWJnV2VUEIiRdCRskktkI7EWV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

On 06/11/2015 07:11, Abhishek Varshney wrote:
> Hi Loic,
>=20
> It is definitely a great idea to have all the backport snippets under
> a roof. However, these snippets, which are mostly a set of commands,
> provide great flexibility in terms of configuration and the ability to
> partly execute them. For instance, if I see conflicts while preparing
> an integration branch, I comment out the git fetch, checkout and reset
> steps from [1] after resolving the conflicts and re-run the snippet.
> It would be nice if we can incorporate all the snippets and take
> ceph-workbench to that level of flexibility :)

This is a good point: I'm doing the same kind of copy / paste. We'll have=
 to adjust the granularity.

   http://ceph-workbench.dachary.org/users/auth/github

was setup and is dedicated to the tool. Please let me know when you first=
 login so that I can make you an admin.

Cheers

>=20
> [1] http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_populate_=
the_integration_branch
>=20
> Thanks
> Abhishek
>=20
> On Thu, Nov 5, 2015 at 6:50 PM, Loic Dachary <loic@dachary.org> wrote:
>> Hi,
>>
>> Today, Nathan and I briefly discussed the idea of collecting the backp=
ort snippets that are archived in the wiki at http://tracker.ceph.com/pro=
jects/ceph-releases/wiki/HOWTO. We all have copies on our local disks and=
 although they don't diverge much, this is not very sustainable. It was r=
eally good as we established the backport workflows. And it would have be=
en immensely painful to maintain a proper software while we were changing=
 the workflow on a regular basis. But it looks like we now have something=
 stable.
>>
>> Early this year ceph-workbench[1] was started with the idea of helping=
 with backports. It is a mostly empty shell we can now use to collect all=
 the snippets we have. Instead of adding set-release[2] to the script dir=
ectory of Ceph, it would be a subcommand of ceph-workbench, like so:
>>
>>   ceph-workbench set-release --token $github_token --key $redmine_key
>>
>> What do you think ?
>>
>> Cheers
>>
>> [1] https://pypi.python.org/pypi/ceph-workbench
>> [2] https://github.com/ceph/ceph/pull/6466
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--0srnXq33PWJnV2VUEIiRdCRskktkI7EWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlY8XGkACgkQ8dLMyEl6F20SJACfUbmE6mUTBHEPPVYARziQwDVM
63UAn2FPMulsc1Fx1YLE1OV+5iLoaw6N
=fr/4
-----END PGP SIGNATURE-----

--0srnXq33PWJnV2VUEIiRdCRskktkI7EWV--
