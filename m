From: Loic Dachary <loic@dachary.org>
Subject: Re: v0.80.11 QE validation status
Date: Mon, 16 Nov 2015 23:17:19 +0100
Message-ID: <564A55EF.8030706@dachary.org>
References: <CAMMFjmFP88goDtrMCmrwpkNOR6R45aOaJaa2t0cCKR+Lb_jTBw@mail.gmail.com>
 <CAMMFjmFsBQihi_YNmRQtfAAMzZeTgidH18Z5rKO0kU18oyFoWw@mail.gmail.com>
 <564A44D3.9020908@redhat.com>
 <CAMMFjmGtECP2wDP6R9GOHA2DoYuJWSgWJh7h+m5QQd_puiOATg@mail.gmail.com>
 <1460602234.13742303.1447711539365.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lgwFHFQgmoWhxaArjS9JMAilnHt31LVdt"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33817 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751432AbbKPWRW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Nov 2015 17:17:22 -0500
In-Reply-To: <1460602234.13742303.1447711539365.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tamil Muthamizhan <tmuthami@redhat.com>, Yuri Weinstein <yweinste@redhat.com>, Loic Dachary <ldachary@redhat.com>
Cc: ceph-qa <ceph-qa@ceph.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Alfredo Deza <adeza@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lgwFHFQgmoWhxaArjS9JMAilnHt31LVdt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the update Tamil, that makes sense now :-)

On 16/11/2015 23:05, Tamil Muthamizhan wrote:
> Hi Loic and Yuri,
>=20
> issue 11104 can be resolved only after the stable epel[with Boris Fix] =
is out and tested in teuthology.
>=20
> what Warren has currently done is to tweak the install task to work aro=
und this issue inorder to clear the test blocker for v0.80.11. It doesnt =
count as a "real" fix.
>=20
> Regards,
> Tamil
>=20
> ----- Original Message -----
> From: "Yuri Weinstein" <yweinste@redhat.com>
> To: "Loic Dachary" <ldachary@redhat.com>
> Cc: "ceph-qa" <ceph-qa@ceph.com>, "Ceph Development" <ceph-devel@vger.k=
ernel.org>, "Sage Weil" <sage@redhat.com>, "Alfredo Deza" <adeza@redhat.c=
om>
> Sent: Monday, November 16, 2015 2:01:42 PM
> Subject: Re: v0.80.11 QE validation status
>=20
> Loic,
>=20
> I am not actually sure about resolving #11104.
>=20
> Warren?
>=20
> Thx
> YuriW
>=20
>=20
> On Mon, Nov 16, 2015 at 1:04 PM, Loic Dachary <ldachary@redhat.com> wro=
te:
>> Hi Yuri,
>>
>> Thanks for the update :-) Should we mark #11104 as resolved ?
>>
>> Cheers
>>
>> On 16/11/2015 19:45, Yuri Weinstein wrote:
>>> This release QE validation took longer time due to the #11104
>>> additional fixing/testing and discovered related to it issues ##13794=
,
>>> 13622
>>>
>>> We agreed to release v0.80.11 based on tests results.
>>>
>>> Thx
>>> YuriW
>>>
>>> On Wed, Oct 28, 2015 at 9:04 AM, Yuri Weinstein <yweinste@redhat.com>=
 wrote:
>>>> Summary of suites executed for this release can be found in
>>>> http://tracker.ceph.com/issues/11644
>>>>
>>>> rados - 1/7th passed
>>>>
>>>> rbd - http://tracker.ceph.com/issues/11104
>>>>
>>>> rgw - http://tracker.ceph.com/issues/11104
>>>>
>>>> fs - http://tracker.ceph.com/issues/11104, http://tracker.ceph.com/i=
ssues/13630
>>>>
>>>> krbd - http://tracker.ceph.com/issues/13631
>>>>
>>>> kcephfs - http://tracker.ceph.com/issues/13631,
>>>> http://tracker.ceph.com/issues/13630
>>>>
>>>> samba - http://tracker.ceph.com/issues/6613 sama as in v0.80.10 was
>>>> aprroved for release
>>>>
>>>> ceph-deploy(ubuntu_) - almost passed, 1 job is still running
>>>>
>>>> ceph-deploy(distros) - http://tracker.ceph.com/issues/13367
>>>>
>>>> upgrade/dumpling-x (to firefly)(distros) - passed
>>>>
>>>> upgrade/firefly(distros) - passed
>>>>
>>>> upgrades to giant - deprecated
>>>>
>>>> upgrade/firefly-x (to hammer)(distros) -
>>>> http://tracker.ceph.com/issues/11104,
>>>> http://tracker.ceph.com/issues/13632
>>>>
>>>> powercycle - http://tracker.ceph.com/issues/11104,
>>>> http://tracker.ceph.com/issues/13631
>>>>
>>>> All found problems seem unrelated to the product, however they
>>>> prevented some tests from running.  In particular #11104 is widespre=
ad
>>>> and has to be fixed (see also http://tracker.ceph.com/issues/13622 a=
s
>>>> proposed workaround)
>>>>
>>>> I suggest we rerunning failed tests after addressing the issues abov=
e.
>>>>
>>>> Thx
>>>> YuriW
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--lgwFHFQgmoWhxaArjS9JMAilnHt31LVdt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZKVe8ACgkQ8dLMyEl6F22pXwCfc/AgudlEj8U36gTtMSQPkDeW
RKsAn0r9VZXDwf7P81dzZ4aQ/DjPqqHu
=xIJP
-----END PGP SIGNATURE-----

--lgwFHFQgmoWhxaArjS9JMAilnHt31LVdt--
