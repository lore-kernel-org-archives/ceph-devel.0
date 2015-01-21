From: Cheng Cheng <ccheng.leo@gmail.com>
Subject: Re: Enable Data Compression when Requesting Data from OSD over WAN
Date: Wed, 21 Jan 2015 11:27:51 -0500
Message-ID: <79F29B04-1793-4BE9-AEE3-8F5877BA48F8@gmail.com>
References: <83069610-11CB-4E06-8B56-7583E4FC4A37@gmail.com> <CACJqLybJf+y2T-sF2gA1tesy544wgCEVHXSUS7D7ZdvsSS259A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:65224 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbbAUQ1z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Jan 2015 11:27:55 -0500
Received: by mail-ig0-f171.google.com with SMTP id h15so15143637igd.4
        for <ceph-devel@vger.kernel.org>; Wed, 21 Jan 2015 08:27:54 -0800 (PST)
In-Reply-To: <CACJqLybJf+y2T-sF2gA1tesy544wgCEVHXSUS7D7ZdvsSS259A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Haomai,

Thanks for the valuable information! I will take a look and think about=
 how to make a genetic approach for data compression.

Cheng

> On Jan 20, 2015, at 9:12 PM, Haomai Wang <haomaiwang@gmail.com> wrote=
:
>=20
> Yeah, we just have a alike PR(https://github.com/ceph/ceph/pull/3303)
> a few days ago. Short discuss is presented there.
>=20
> On Wed, Jan 21, 2015 at 1:43 AM, Cheng Cheng <ccheng.leo@gmail.com> w=
rote:
>> Hi Ceph,
>>=20
>> I am thinking of passing an extra =E2=80=9Ccompression=E2=80=9D flag=
 to OSD when client requesting data. When seeing such flag, OSD send co=
mpressed  data to client and client decompress it transparently. It wou=
ld be beneficial it OSD and client are connected over WAN.
>>=20
>> Can anyone share some hints on how should start to plan/implement th=
is feature?
>>=20
>> Thanks in advance!
>> Cheng--
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
> --=20
> Best Regards,
>=20
> Wheat

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
