From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: Bucket name restrictions in RGW
Date: Sun, 14 Jun 2015 11:00:23 +0530
Message-ID: <87lhfmx3f4.fsf@gmail.com>
References: <CAPRac-aj5YrKXrxxd_YTM-VJcNmS8j1zw_BToSwSdmd5nhv9cQ@mail.gmail.com> <557B2875.1090505@42on.com> <robbat2-20150612T220814-235406925Z@orbis-terrarum.net> <1505040171.13879951.1434150828495.JavaMail.zimbra@redhat.com> <robbat2-20150612T232131-467242919Z@orbis-terrarum.net> <557C9185.1050305@42on.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33120 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbbFNFdZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Jun 2015 01:33:25 -0400
Received: by pdjn11 with SMTP id n11so49799335pdj.0
        for <ceph-devel@vger.kernel.org>; Sat, 13 Jun 2015 22:33:24 -0700 (PDT)
In-reply-to: <557C9185.1050305@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Wido den Hollander writes:

> On 06/13/2015 01:29 AM, Robin H. Johnson wrote:
>> On Fri, Jun 12, 2015 at 07:13:48PM -0400,  Yehuda Sadeh-Weinraub wrote:
>>> Whatever we end up doing, we need to make it configurable, and also
>>> keep backward compatibility, so that buckets that were created prior
>>> to such a change will still remain accessible. Some setups would not
>>> need this limitation and will find it too restricting so I'm not sure
>>> that it's really that needed. In short, make it configurable.
>> Configurable:
>> - Can we obsolete 'rgw relaxed s3 bucket names', and convert it to a new
>>   option: 'rgw s3 bucket name create strictness'
>>   Value '0' =3D> existing 'rgw relaxed s3 bucket names =3D true' logic
>>   Value '1' =3D> existing 'rgw relaxed s3 bucket names =3D false' logic
>>   Value '2' =3D> compliance with AmazonS3 DNS rules

Alternatively we could just add an opt `rgw s3 bucket name create
strictness` (maybe `rgw s3 bucket dns comply` instead) as a bool which
would set your value '2' logic when both `relaxed s3 bucket names` and
this value are set, so that we dont break backwards compatibility?
>>=20
>> Backwards-Compatibility:
>> - Make a new option 'rgw s3 bucket name access strictness'
>>   Same values as above, but used to access buckets, not create new ones.
>> - Proposed default values:
>>   rgw s3 bucket name create strictness =3D 2
>>   rgw s3 bucket name access strictness =3D 1
>>=20
>> So you can only create DNS-compliant buckets, but still access your
>> existing non-compliant buckets. Maybe also have keywords of major
>> releases and 'relaxed' supported in addition to the integer values.
>>=20
>> I don't like the names of the config keys, but I'm coming up blank on
>> something that is shorter while still being immediately clear.
>>=20
>
> Seems like a good plan to me. I would like to restrict them as much as
> possible, but we shouldn't break anything which is online now.
>
> --=20
> Wido den Hollander
> 42on B.V.
> Ceph trainer and consultant
>
> Phone: +31 (0)20 700 9902
> Skype: contact42on

=2D-=20
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJVfRF5AAoJEPnwZB8bZe1fJfYH/iLxeUcMD6IMQwJsT2R4uBbH
rKWgJC1KRuHasFrjmnF+SemBFVVWV5gwlCCF23Vi37+cvUWhvxXsKkhCXJN1tOfJ
uVU17VGu3EdGUbwcZfT7IL7lC3NQhbGOIfwk7AFAn2UsTYwbHXXAa9odlJimZ3Hp
6rf8rqR6CpRns1v/N81ol3YYAYcTEYOnWC5ilXev1qohHh34IkigvVQ5k8qciTMc
h3LdHpe4fEWPTKsql6J5DUjox5EBwh4s794nxIZFZZ9xaRoOZxB8dc9t0Y+VSPkb
gntoTeIW8HyM17CZj82iDLfO09rvAkQYB1bSeofuUhZDtVwvEApvquQWB4f8xwk=
=omSD
-----END PGP SIGNATURE-----
--=-=-=--
