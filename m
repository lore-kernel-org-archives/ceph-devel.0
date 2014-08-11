From: Loic Dachary <loic@dachary.org>
Subject: Re: Swift tests failing randomly
Date: Mon, 11 Aug 2014 20:47:18 +0200
Message-ID: <53E90FB6.8060808@dachary.org>
References: <53E7316D.3090808@dachary.org>	<53E8ED9C.5000601@dachary.org>	<CABBk=J8by_UDKXddSDQ5HovtCtNOvhzBsGWdAiywEN1MmSS69A@mail.gmail.com>	<alpine.DEB.2.00.1408111012100.32572@cobra.newdream.net> <CAJBxG-t8mWq4=1zjGf6d7O6_6NNqQs1NgZdpXuuifRPsh_nKtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="M0HRi5HIBGVjWo4xTgk3QWjsx2tiVxbV7"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57624 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751673AbaHKSrZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Aug 2014 14:47:25 -0400
In-Reply-To: <CAJBxG-t8mWq4=1zjGf6d7O6_6NNqQs1NgZdpXuuifRPsh_nKtw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>, Sage Weil <sweil@redhat.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M0HRi5HIBGVjWo4xTgk3QWjsx2tiVxbV7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/08/2014 19:34, Yuri Weinstein wrote:
> Here is what we have in vps.yaml now:
>=20
> overrides:
>   ceph:
>     conf:
>       global:
>         osd heartbeat grace: 40
>=20
> What do we want to add?

I think the idle_timeout values at

https://github.com/ceph/ceph-qa-suite/pull/79/files


>=20
> ~
>=20
> On Mon, Aug 11, 2014 at 10:13 AM, Sage Weil <sweil@redhat.com> wrote:
>> On Mon, 11 Aug 2014, Yehuda Sadeh wrote:
>>> Yeah, looking at these logs, it really seem that it's just that thing=
s
>>> are going slow on these machines and it's hitting timeouts. The fix i=
s
>>> ok with me, although I'd rather have it adjusted per machine type
>>> (somehow).
>>
>> There is a vps.yaml that bumps up another timeout, so we could put it
>> there.  Right now it lives on the teuthology machine
>> (~teuthworker/vps.yaml I think?), but perhaps we should stick it in
>> ceph-qa-suite.git somewhere ...
>>
>> sage
>>
>>>
>>> Yehuda
>>>
>>> On Mon, Aug 11, 2014 at 9:21 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>>>> Hi Yehuda,
>>>>
>>>> It looks like increasing the rgw idle timeout makes the problem go a=
way ( https://github.com/ceph/ceph-qa-suite/pull/79 and http://tracker.ce=
ph.com/issues/8988 ). It previously was 300 sec which looks like a large =
value already. Does this fix / workaround make sense to you ?
>>>>
>>>> Cheers
>>>>
>>>> On 10/08/2014 10:46, Loic Dachary wrote:
>>>>> Hi Yehuda,
>>>>>
>>>>> In the past few months the swift tests failed randomly and I was un=
fortunately unable to figure out why. Here are a few examples:
>>>>>
>>>>>     http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:firefl=
y-x:stress-split-wip-9025-chunk-remapping-testing-basic-vps/406944
>>>>>     http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:firefl=
y-x:stress-split-wip-9025-chunk-remapping-testing-basic-vps/406941
>>>>>     http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:firefl=
y-x:stress-split-wip-9025-chunk-remapping-testing-basic-vps/406946
>>>>>     http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:firefl=
y-x:stress-split-wip-9025-chunk-remapping-testing-basic-vps/406947
>>>>>
>>>>> and it has happened on every upgrade test run since I can remember.=
 I fail to see a pattern and cannot figure out what the real problem is. =
It would be really great if you could take a look. Even a hunch or a tip =
would be greatly appreciated :-)
>>>>>
>>>>> You can find more context in
>>>>>
>>>>> http://tracker.ceph.com/issues/8988
>>>>> http://tracker.ceph.com/issues/8016
>>>>> http://tracker.ceph.com/issues/7799
>>>>>
>>>>> and discussions at
>>>>>
>>>>> http://www.spinics.net/lists/ceph-devel/msg19933.html
>>>>>
>>>>> Cheers
>>>>>
>>>>
>>>> --
>>>> Lo?c Dachary, Artisan Logiciel Libre
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--M0HRi5HIBGVjWo4xTgk3QWjsx2tiVxbV7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPpD7YACgkQ8dLMyEl6F20M8wCaA3/aVLaj2MPPuzEZjxL9LSbM
8iIAn3Q4IZSUQqMPJuJj11p3oAPoDcYY
=E0GS
-----END PGP SIGNATURE-----

--M0HRi5HIBGVjWo4xTgk3QWjsx2tiVxbV7--
