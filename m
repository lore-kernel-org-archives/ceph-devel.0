From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2 2/6] libceph: introduce reference counted string
Date: Tue, 29 Mar 2016 13:18:26 +0200
Message-ID: <CAOi1vP9riYTwxCt-2TNxFw9+Hj_A4rNaxVM1w-pQMufZ7bHb9g@mail.gmail.com>
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
	<CAOi1vP-vh5T4Z7eM__wc2a+sOJKy4UhQgtkfZw3aZkxFFSRdHQ@mail.gmail.com>
	<EFA5261C-F2CD-4D70-8F6F-40D7D48082D6@redhat.com>
	<CAOi1vP96C_GheGTR248g2FnT+fgSVYAO95WtiaJOLzhCLH2aHQ@mail.gmail.com>
	<B4ADDB5D-8516-40D9-8485-BC9DC1C9B6C8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33078 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbcC2LS2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2016 07:18:28 -0400
Received: by mail-lf0-f68.google.com with SMTP id v198so1035866lfd.0
        for <ceph-devel@vger.kernel.org>; Tue, 29 Mar 2016 04:18:27 -0700 (PDT)
In-Reply-To: <B4ADDB5D-8516-40D9-8485-BC9DC1C9B6C8@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Tue, Mar 29, 2016 at 11:56 AM, Yan, Zheng <zyan@redhat.com> wrote:
> Here is code that share i_layout and embed namespace in osd_request. =
 But the code is more complex and less less efficient. I strongly doubt=
 it=E2=80=99s good design.
>
> https://github.com/ceph/ceph-client/commits/wip-file-layout2 <https:/=
/github.com/ceph/ceph-client/commits/wip-file-layout2>

When I suggested it, I assumed namespace updates were more synchronous
than they actually are.  I said in one of my previous emails a few days
ago that it seemed less attractive, at least compared to the posted
patches, so I agree.

The string-sharing approach reaches deeply into osd_client though.
I have a *big* set of changes in the works for it - let me try to finis=
h
it, prepare the ground for reference-counting for object locators and
ping you in couple of weeks?  Discussing particulars like locking and
RCU usage should be easier then.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
