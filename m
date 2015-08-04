From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: CephFS and the next hammer release v0.94.3
Date: Tue, 4 Aug 2015 10:01:15 +0800
Message-ID: <C7284C47-5C31-4AB5-8AFD-1DF901C7ED67@redhat.com>
References: <55BF8C21.5020204@dachary.org> <CAC6JEv91iRpTZivmaFME9iaeuJPrwaCpbriXY2kTpucPWGnXTg@mail.gmail.com> <55BF978B.9010604@dachary.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40857 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbbHDCBV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 22:01:21 -0400
In-Reply-To: <55BF978B.9010604@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Gregory Farnum <greg@gregs42.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

Hi Loic.

Yes, https://github.com/ceph/ceph/pull/5222 is problematic.  Do you mea=
n should we include these RPs in v0.94.3?  These RPs fix a bug in rare =
configure, I think it=E2=80=99s not a big deal to not include it in v0.=
94.3=20

Regards
Yan, Zheng


> On Aug 4, 2015, at 00:32, Loic Dachary <loic@dachary.org> wrote:
>=20
> Hi Greg,
>=20
> I assume the "file handle reference counting" is about http://tracker=
=2Eceph.com/issues/12088 which is backported as described at http://tra=
cker.ceph.com/issues/12319. It was indeed somewhat problematic and requ=
ired two pull requests: https://github.com/ceph/ceph/pull/5222 (authore=
d by Yan Zheng) and https://github.com/ceph/ceph/pull/5427 (merged by Y=
an Zheng).
>=20
> Cheers
>=20
> On 03/08/2015 18:01, Gregory Farnum wrote:
>> On Mon, Aug 3, 2015 at 6:43 PM Loic Dachary <loic@dachary.org> wrote=
:
>>>=20
>>> Hi Greg,
>>>=20
>>> The next hammer release as found at https://github.com/ceph/ceph/tr=
ee/hammer passed the fs suite (http://tracker.ceph.com/issues/11990#fs)=
=2E Do you think it is ready for QE to start their own round of testing=
 ?
>>=20
>> I'm on vacation right now, but the only thing I see there that might
>> be iffy is the backport of the file handle reference counting. As lo=
ng
>> as that is all good (Zheng?) things look fine to me.
>> -Greg
>>=20
>>>=20
>>> Cheers
>>>=20
>>> P.S. http://tracker.ceph.com/issues/11990#Release-information has d=
irect links to the pull requests merged into hammer since v0.94.2 in ca=
se you need more context about one of them.
>>>=20
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>=20
> --=20
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
