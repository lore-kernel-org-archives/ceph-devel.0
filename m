From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v2 2/6] libceph: introduce reference counted string
Date: Fri, 25 Mar 2016 11:05:02 +0800
Message-ID: <EFA5261C-F2CD-4D70-8F6F-40D7D48082D6@redhat.com>
References: <1454742006-85706-1-git-send-email-zyan@redhat.com> <1454742006-85706-3-git-send-email-zyan@redhat.com> <CAOi1vP8SrL71Q34W4b_ZDUkTNyi-UtDstgrTjnjq9fGE=VMa_g@mail.gmail.com> <4C995660-CB5D-4E26-9947-988D65BEAA3A@redhat.com> <CAOi1vP-g9kj6B-Fmv7cBzjfrnoSrnGuVZyB+b0K-CmpLPd6xbw@mail.gmail.com> <040FA762-A7C8-47FE-A72B-03419C79C782@redhat.com> <CAOi1vP_v=iev1vQQrxGFYU2y7uTV1_imV5MkwqMgBQUCf2GnEg@mail.gmail.com> <CDD7EC25-57D8-4BD5-B8D0-41AAFC09EFA7@redhat.com> <CAOi1vP80kT5rE=pjefY09KByAj6upeb2zOG8BwkaXpziZfQJJw@mail.gmail.com> <21C799EB-4B5D-4F66-923F-FF52F0323146@redhat.com> <CAOi1vP9L7yN_RHHbMLK7Cwr84pBYgm8GpHFsygwUxj4Tpjabfg@mail.gmail.com> <A3CC3516-D528-4F4A-B1A9-3421844B1484@redhat.com> <CAOi1vP9E4S1yrWAwQ6KSKL07-xZwt301UBBq6Z5QOoR3L+0ycQ@mail.gmail.com> <C4A3841F-3310-446D-
 9DC1-CEB2FE40CB4E@redhat.com> <CAOi1vP-vh5T4Z7eM__wc2a+sOJKy4UhQgtkfZw3aZkxFFSRdHQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40832 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452AbcCYDFI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2016 23:05:08 -0400
In-Reply-To: <CAOi1vP-vh5T4Z7eM__wc2a+sOJKy4UhQgtkfZw3aZkxFFSRdHQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>


> On Mar 24, 2016, at 21:55, Ilya Dryomov <idryomov@gmail.com> wrote:
>=20
> On Thu, Mar 24, 2016 at 2:18 PM, Yan, Zheng <zyan@redhat.com> wrote:
>>=20
>>> On Mar 24, 2016, at 18:26, Ilya Dryomov <idryomov@gmail.com> wrote:
>=20
> [ snip ]
>=20
>>> TBH I still can't wrap my head around lockless layout/namespace poi=
nter
>>> updates and how that can ever work reliably=E2=80=A6
>>=20
>> see Documentation/RCU/rcuref.txt. How RCU is used in my code is simi=
lar to the second example.
>=20
> It's the higher-level cephfs code and installing new namespaces in th=
e
> middle of whatever else that might be going on that I'm worried about=
=2E
> See my other mail, I'd like to hear what exactly is being achieved wi=
th
> this approach and have you considered reusing i_ceph_lock (or others,
> of which there are plenty).

Updating namespace pointer is protected by i_ceph_lock, For read access=
 of the namespace, using i_ceph_lock does not provide any extra guarant=
ee. This approach provides lockless access of namespace, it=E2=80=99s c=
onvenient for functions that do not know=20
i_ceph_lock.

Regards
Yan, Zheng

> Thanks,
>=20
>                Ilya

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
