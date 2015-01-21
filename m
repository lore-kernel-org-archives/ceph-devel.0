From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Enable Data Compression when Requesting Data from OSD over WAN
Date: Wed, 21 Jan 2015 10:12:29 +0800
Message-ID: <CACJqLybJf+y2T-sF2gA1tesy544wgCEVHXSUS7D7ZdvsSS259A@mail.gmail.com>
References: <83069610-11CB-4E06-8B56-7583E4FC4A37@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:63750 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbbAUCMb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jan 2015 21:12:31 -0500
Received: by mail-wi0-f170.google.com with SMTP id em10so10280503wid.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jan 2015 18:12:29 -0800 (PST)
In-Reply-To: <83069610-11CB-4E06-8B56-7583E4FC4A37@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Cheng Cheng <ccheng.leo@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yeah, we just have a alike PR(https://github.com/ceph/ceph/pull/3303)
a few days ago. Short discuss is presented there.

On Wed, Jan 21, 2015 at 1:43 AM, Cheng Cheng <ccheng.leo@gmail.com> wro=
te:
> Hi Ceph,
>
> I am thinking of passing an extra =E2=80=9Ccompression=E2=80=9D flag =
to OSD when client requesting data. When seeing such flag, OSD send com=
pressed  data to client and client decompress it transparently. It woul=
d be beneficial it OSD and client are connected over WAN.
>
> Can anyone share some hints on how should start to plan/implement thi=
s feature?
>
> Thanks in advance!
> Cheng--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
