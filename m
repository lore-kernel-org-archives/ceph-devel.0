From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: release notes script dependencies
Date: Wed, 06 May 2015 22:11:55 +0530
Message-ID: <878ud1r73g.fsf@gmail.com>
References: <55491259.4010003@dachary.org> <CAEw75dOCcdafHQhdc6uv+HsQVnOVE+rD8VdAAYFALFfFSEq2cg@mail.gmail.com> <554A2B55.8050203@dachary.org> <alpine.DEB.2.00.1505060918340.28239@cobra.newdream.net> <554A42CB.8050201@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34060 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbbEFQoO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 May 2015 12:44:14 -0400
Received: by pdbqa5 with SMTP id qa5so14728712pdb.1
        for <ceph-devel@vger.kernel.org>; Wed, 06 May 2015 09:44:12 -0700 (PDT)
In-reply-to: <554A42CB.8050201@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Loic Dachary writes:

> On 06/05/2015 18:19, Sage Weil wrote:
>> On Wed, 6 May 2015, Loic Dachary wrote:
>>>
>>> Hi Abhishek,
>>>
>>> On 06/05/2015 06:27, Abhishek L wrote:
>>>> On Wed, May 6, 2015 at 12:26 AM, Loic Dachary <loic@dachary.org> wrote:
>>>>> Hi Abhishek,
>>>>>
>>>>> It would be useful to add instructions on what dependencies to pull t=
o run http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_write_the_r=
elease_notes. Something like
>>>>>
>>>>> virtualenv /tmp/foo
>>>>> . /tmp/foo/bin/activate
>>>>> pip install GitPython # I recognized the library from the import ;-)
>>>>> pip install ?? # I tried half a dozen but could not find one that mat=
ches the import github semantic
>>>>
>>>> The module was githubpy (I agree there are too many of github python
>>>> modules around :-)) I added a basic argparser for the script; I've put
>>>> it up as a github repo at
>>>> https://github.com/theanalyst/ceph-release-helper
>>>>
>>>> Let me know if you're facing any problems using it
>>>
>>> It works :-) http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_=
write_the_release_notes amended accordingly.
>>=20
>> Could we put the script in ceph.git/src/scripts or similar instead of a=
=20
>> separate repo?  One less thing to clone...
>
> +1

Sure, I'll send in a patch=20

>
>>=20
>> sage
>>=20

=2D-=20
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJVSkReAAoJEPnwZB8bZe1fCNwH/Ruw+mcFDS1BZXyNuGJB+wOd
5Cgsrtdiqo7W6hX9itM9SA0PcrIX0FYFcuZdUCqMI3MU2I7g7sdEACyduMHCkE4+
a2B+1rBiaSu/m3//01dXXVY0zHW4sjt4eWIe25iFVlX0iF/nC403NGGgrJcxxkGZ
J1H5cHYp+Tw9/whEo3dHi8zghcsmOIxBs1lRHPoxbcPV0v2wzDnV+I7DK4DIgiZ3
w6SbQq4hosG5t/oAwCaLRTiuoRSRnBQ4v0hBlj9Dgddn1HRWtpv5+CiOneJqxjid
fsq7Hfa9LQ4HD4i/Pb3KrsA2KDp5uH6UYNZQDM9OqKnoAG+Kj831RZh5rbdCmAw=
=2cdZ
-----END PGP SIGNATURE-----
--=-=-=--
