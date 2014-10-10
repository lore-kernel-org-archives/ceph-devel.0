From: Loic Dachary <loic@dachary.org>
Subject: Re: arm7 gitbuilder ?
Date: Fri, 10 Oct 2014 21:16:12 +0200
Message-ID: <5438307C.4060701@dachary.org>
References: <5437A6C0.3000005@dachary.org>	<alpine.DEB.2.00.1410100809370.28531@cobra.newdream.net>	<5438134E.7050009@dachary.org>	<alpine.DEB.2.00.1410101014200.28531@cobra.newdream.net> <CA+Hcz5_gwQdZ15EyJBfzxU05bDp0Pbdcgfqtv_=N5Q9Zm62FdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QBpJBKVNwp7pD9e2DrpLllV055OO48gLQ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42191 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751993AbaJJTQT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 15:16:19 -0400
In-Reply-To: <CA+Hcz5_gwQdZ15EyJBfzxU05bDp0Pbdcgfqtv_=N5Q9Zm62FdQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QBpJBKVNwp7pD9e2DrpLllV055OO48gLQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Noah,

My focus is to create centos7 and ubuntu-14.04 packages at this point. An=
d somehow find a way to convince teuthology to use them instead of what h=
ttp://ceph.com/gitbuilder.cgi creates, but that's a separate issue.

What kind of output would you like to get from these arm7 machines ?

Cheers

On 10/10/2014 19:55, Noah Watkins wrote:
> On Fri, Oct 10, 2014 at 10:14 AM, Sage Weil <sweil@redhat.com> wrote:
>> On Fri, 10 Oct 2014, Loic Dachary wrote:
>>> On 10/10/2014 17:11, Sage Weil wrote:
>>>> On Fri, 10 Oct 2014, Loic Dachary wrote:
>>>>> Hi Sandon,
>>>>>
>>>>> Would it be possible to resurect / create an arm7 gitbuilder for
>>>>> whatever distribution is more convenient ? Janne made a great
>>>>> contribution to erasure code optimization on NEON (
>>>>> https://bitbucket.org/jannau/gf-complete/branch/neon ) and it would=
 make
>>>>> it easier to have a gitbuilder to run it throught teuthology and to=
rture
>>>>> it ;-) If that's complicated or there is another way to run teuthol=
ogy
>>>>> jobs for this purpose, I'm open to suggestions.
>>>>
>>>> We have a bunch of armv7l nodes that used to run distcc and a gitbui=
lder.
>>>> It's a bit of a time suck to maintain, though.  Is there an interest=
ed
>>>> party we can set up with lab access that can help administer these o=
n an
>>>> ongoing basis?  Sandon is a highly contended resource.  :)
>>>
>>> Long term I'm not sure. I'll try to setup something temporary and see=

>>> where it goes. Is there a risk that these machines go away in the nex=
t 6
>>> months ? 3 months ?
>=20
> I am an interested party, and at least in the short term would
> dedicate some time to getting arm7 builds working too.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--QBpJBKVNwp7pD9e2DrpLllV055OO48gLQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQ4MHwACgkQ8dLMyEl6F20Y4gCfX9C/ZMIyhsrfasmbwmKZ5rpc
ErMAnRyCjRQFMoaHLUr4cfyHfZqw22+g
=nOov
-----END PGP SIGNATURE-----

--QBpJBKVNwp7pD9e2DrpLllV055OO48gLQ--
