From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2 2/6] libceph: introduce reference counted string
Date: Thu, 24 Mar 2016 14:55:27 +0100
Message-ID: <CAOi1vP-vh5T4Z7eM__wc2a+sOJKy4UhQgtkfZw3aZkxFFSRdHQ@mail.gmail.com>
References: <1454742006-85706-1-git-send-email-zyan@redhat.com>
	<1454742006-85706-3-git-send-email-zyan@redhat.com>
	<CAOi1vP8SrL71Q34W4b_ZDUkTNyi-UtDstgrTjnjq9fGE=VMa_g@mail.gmail.com>
	<4C995660-CB5D-4E26-9947-988D65BEAA3A@redhat.com>
	<CAOi1vP-g9kj6B-Fmv7cBzjfrnoSrnGuVZyB+b0K-CmpLPd6xbw@mail.gmail.com>
	<040FA762-A7C8-47FE-A72B-03419C79C782@redhat.com>
	<CAOi1vP_v=iev1vQQrxGFYU2y7uTV1_imV5MkwqMgBQUCf2GnEg@mail.gmail.com>
	<CDD7EC25-57D8-4BD5-B8D0-41AAFC09EFA7@redhat.com>
	<CAOi1vP80kT5rE=pjefY09KByAj6upeb2zOG8BwkaXpziZfQJJw@mail.gmail.com>
	<21C799EB-4B5D-4F66-923F-FF52F0323146@redhat.com>
	<CAOi1vP9L7yN_RHHbMLK7Cwr84pBYgm8GpHFsygwUxj4Tpjabfg@mail.gmail.com>
	<A3CC3516-D528-4F4A-B1A9-3421844B1484@redhat.com>
	<CAOi1vP9E4S1yrWAwQ6KSKL07-xZwt301UBBq6Z5QOoR3L+0ycQ@mail.gmail.com>
	<C4A3841F-3310-446D-9DC1-CEB2FE40CB4E@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:34650 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbcCXNz3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2016 09:55:29 -0400
Received: by mail-lb0-f196.google.com with SMTP id vk4so3290628lbb.1
        for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2016 06:55:28 -0700 (PDT)
In-Reply-To: <C4A3841F-3310-446D-9DC1-CEB2FE40CB4E@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Thu, Mar 24, 2016 at 2:18 PM, Yan, Zheng <zyan@redhat.com> wrote:
>
>> On Mar 24, 2016, at 18:26, Ilya Dryomov <idryomov@gmail.com> wrote:

[ snip ]

>> TBH I still can't wrap my head around lockless layout/namespace poin=
ter
>> updates and how that can ever work reliably=E2=80=A6
>
> see Documentation/RCU/rcuref.txt. How RCU is used in my code is simil=
ar to the second example.

It's the higher-level cephfs code and installing new namespaces in the
middle of whatever else that might be going on that I'm worried about.
See my other mail, I'd like to hear what exactly is being achieved with
this approach and have you considered reusing i_ceph_lock (or others,
of which there are plenty).

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
