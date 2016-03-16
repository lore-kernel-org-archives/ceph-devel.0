From: Loic Dachary <loic@dachary.org>
Subject: Re: GPG signing RPM packages : must not have subkeys
Date: Wed, 16 Mar 2016 08:55:53 +0100
Message-ID: <56E91189.7070306@dachary.org>
References: <56E84635.8080109@dachary.org>
 <CANMxC7BPoRnHRGYXNNu2QmtcbrVP9HTiu3gtim5=aWW42HoAgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:43960 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933203AbcCPHz5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 03:55:57 -0400
In-Reply-To: <CANMxC7BPoRnHRGYXNNu2QmtcbrVP9HTiu3gtim5=aWW42HoAgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Palma <martin@palma.bz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Martin,

It works indeed ! Thanks :-)

Cheers

On 15/03/2016 20:25, Martin Palma wrote:
> If I remember it right I read somewhere that verification with
> sub-keys is not implemented in rpm.
>=20
> To create a passwordless key with no subkey you can simple leave out
> the Subkey-Type and Subkey-Length I think:
>=20
>=20
> KEY=3D"$HOME/.ceph-workbench/release-team-key.asc"
> if ! test -f $KEY ; then
>   printf "Key-Type: 1\nKey-Length: 2048\nName-Real: Release
> Team\nName-Email: contact@ceph.com\nExpire-Date: 0" |
> GNUPGHOME=3D~/.ceph-workbench gpg --batch --gen-key
>   GNUPGHOME=3D~/.ceph-workbench gpg --export --armor > $KEY
> fi
>=20
> Can you verify that?
>=20
> Best,
> Martin
>=20
> On Tue, Mar 15, 2016 at 6:28 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>> Hi Martin,
>>
>> It turns out that the key created by
>>
>> KEY=3D"$HOME/.ceph-workbench/release-team-key.asc"
>> if ! test -f $KEY ; then
>>   printf "Key-Type: 1\nKey-Length: 2048\nSubkey-Type: 1\nSubkey-Leng=
th: 2048\nName-Real: Release Team\nName-Email: contact@ceph.com\nExpire=
-Date: 0" | GNUPGHOME=3D~/.ceph-workbench gpg --batch --gen-key
>>   GNUPGHOME=3D~/.ceph-workbench gpg --export --armor > $KEY
>> fi
>>
>> cannot be used to verify RPM packages: rpm -K on the signed package =
claims the 69C8876E key is missing. It turns out to be related to the s=
ubkey.
>>
>> --------------------------------------------
>> pub   2048R/B8F1ACED 2016-03-11
>>       Key fingerprint =3D 7FEB E845 6F19 153B AAFC  2810 4597 2ACD B=
8F1 ACED
>> uid                  A Contributor <generous@ceph.com>
>> sub   2048R/69C8876E 2016-03-11
>>
>> rpm -K complains that the 69C8876E key is not available. After remov=
ing the subkey 69C8876E with gpg --edit-key and signing the RPM again, =
rpm -K is happy. This does not make any sense to me and I suspect there=
 is an expert explanation that justify this behavior. The sensible way =
out seems to create a passwordless key with no subkey to avoid that pro=
blem. Do you happen to know how that can be done ?
>>
>> Cheers
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
