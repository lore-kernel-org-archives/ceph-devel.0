From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph versions
Date: Sat, 28 Feb 2015 00:50:45 +0100
Message-ID: <54F102D5.5060604@dachary.org>
References: <alpine.DEB.2.00.1502261451220.1619@cobra.newdream.net> <54EFAE77.3020101@dachary.org> <567942662.11970131.1424995195896.JavaMail.zimbra@redhat.com> <54EFC131.8080402@dachary.org> <CAOi1vP_wsKVOECxvZG6AGKQHts9t1LQSetppGFjH9nmxK2FF0Q@mail.gmail.com> <54F07108.8040500@dachary.org> <mcqs5s$6sr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qrpQdh3TBNK7qBxqpGg1OAeIPrjCAlp71"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50336 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755393AbbB0Xut (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Feb 2015 18:50:49 -0500
In-Reply-To: <mcqs5s$6sr$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qrpQdh3TBNK7qBxqpGg1OAeIPrjCAlp71
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 27/02/2015 23:47, Alex Elsayed wrote:
> Loic Dachary wrote:
>=20
>>
>>
>> On 27/02/2015 13:59, Ilya Dryomov wrote:
>>> On Fri, Feb 27, 2015 at 3:58 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>>>>
>>>>
>>>> On 27/02/2015 00:59, Yehuda Sadeh-Weinraub wrote:
>>>>>
>>>>>
>>>>> ----- Original Message -----
>>>>>> From: "Loic Dachary" <loic@dachary.org>
>>>>>> To: "Sage Weil" <sweil@redhat.com>, ceph-devel@vger.kernel.org
>>>>>> Sent: Thursday, February 26, 2015 3:38:31 PM
>>>>>> Subject: Re: ceph versions
>>>>>>
>>>>>> Hi Sage,
>>>>>>
>>>>>> I prefer Option D because it's self explanatory. We could also dro=
p
>>>>>> the names. I became attached to them but they are confusing to the=
 new
>>>>>> users who is required to remember that firefly is 0.80, giant is 0=
=2E87
>>>>>> etc.
>>>>>>
>>>>>> Cheers
>>>>>>
>>>>>> On 27/02/2015 00:12, Sage Weil wrote:
>>>>>>> -- Option D -- "labeled"
>>>>>>>
>>>>>>> X.Y-{dev,rc,release}Z
>>>>>>>
>>>>>>>  - Increment Y on each major named release
>>>>>>>  - Increment X if it's a major major named release (bigger change=

>>>>>>> than usual)
>>>>>>>  - Use dev, rc, or release prefix to clearly label what type of
>>>>>>>  release
>>>>>>> this is
>>>>>>>  - Increment Z for stable updates
>>>>>>>
>>>>>>>  1.0-dev1 first infernalis dev release
>>>>>>>  1.0-dev2 another dev release
>>>>>>>  ...
>>>>>>>  1.0-rc1 first rc
>>>>>>>  1.0-rc2 next rc
>>>>>>>  1.0-release1 final release
>>>>>>>  1.0-release2 stable update
>>>>>>>  1.0-release3 stable update
>>>>>>>  1.1-dev1 first cut for j-release
>>>>>>>  1.1-dev2 ...
>>>>>>>  ...
>>>>>>>  1.1-rc1
>>>>>>>  1.1-release1 stable
>>>>>>>  1.1-release2 stable
>>>>>>>  1.1-release3 stable
>>>>>>>
>>>>>>> Q: How do I tell what kind of release this is?
>>>>>>> A: Look at the string embedded in the version
>>>>>>>
>>>>>>> Q: Will these funny strings confuse things that sort by version?
>>>>>>> A: I don't think so.
>>>>>>
>>>>>> dev < rc < release : good pick ;-)
>>>>>>
>>>>>
>>>>> This is the one I lean towards, with one slight variation. I'd drop=
 the
>>>>> 'release' tag and have X.Y[.Z] format for the formal releases, e.g.=
,
>>>>> 2.0-dev1 first infernalis dev release 2.0-dev2
>>>>> ..
>>>>> 2.0-rc1
>>>>> 2.0-rc2
>>>>> ...
>>>>> 2.0 # infarnalis
>>>>> 2.0.1 # first dot release
>>>>> ...
>>>>> 2.1-dev1 # first j dev release
>>>>> ...
>>>>> 2.1 # j release
>>>>>
>>>>> Then after a few release move to 3.0 to avoid the dreadful big numb=
ers.
>>>>>
>>>>> Sage did mention that this might have some issues in certain
>>>>> environments to sort correctly. Possibly replacing the dash with a
>>>>> tilde solves this?
>>>>>
>>>>
>>>> The lexicographic order of ~ is modified in debian and that may crea=
te
>>>> confusion:
>>>>
>>>> http://man.he.net/man5/deb-version
>>>>
>>>>        lexical comparison is a comparison of ASCII values modified s=
o
>>>>        that all
>>>>        the letters sort earlier than all the non-letters and so that=
  a=20
>>>>        tilde
>>>>        sorts  before  anything, even the end of a part.  For example=
,
>>>>        the fol-
>>>>        lowing parts are in sorted order: '~~', '~~a',  '~',  the  em=
pty=20
>>>>        part, 'a'.
>>>>
>>>> The - is lower than the . so it should be good provided the major
>>>> releases are X.Y.0 instead of X.Y, i.e.:
>>>>
>>>> 2.0-rc3
>>>> 2.0.0 # infarnalis
>>>> 2.0.1 # first dot release
>>>>
>>>> etc.
>>>>
>>>> Dropping the "release" word for stable releases is a good idea.
>>>
>>> FWIW I'd lean towards "labeled" scheme without the "release" label as=

>>> well.  I don't have a strong opinion on X.Y vs X.Y.0 for formal
>>> releases, but I would have probably gone with X.Y - just my 2c.
>>
>> The problem with X.Y is that it sorts before X.Y-rc3 instead of after.=

>=20
> Stringwise, yes - though in Exherbo and Gentoo, X.Y-rc3 sorts before X.=
Y=20
> because not all distros treat versions as strings.

Interesting :-) Using X.Y.0 for the first stable release sorts the same, =
numerically or lexicographically, right ?
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--qrpQdh3TBNK7qBxqpGg1OAeIPrjCAlp71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTxAtUACgkQ8dLMyEl6F20tqACfUc6WSrXCO4jHedXXihb0SoJN
AvcAoJuKsnZNlKMvgq3+WehAG+63N+xH
=7iPu
-----END PGP SIGNATURE-----

--qrpQdh3TBNK7qBxqpGg1OAeIPrjCAlp71--
