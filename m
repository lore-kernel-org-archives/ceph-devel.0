From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: read and write speed.
Date: Tue, 31 May 2011 10:48:24 +0800
Message-ID: <BANLkTikOLuHmw-3ijpamDgMdPeU4wqhXRw@mail.gmail.com>
References: <4DE41F34.8020504@ufm.su>
	<BANLkTi=Pew-stDVCxUQoa5t2s5P8pWRomA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57907 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab1EaCsZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 May 2011 22:48:25 -0400
Received: by fxm17 with SMTP id 17so2750808fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 May 2011 19:48:24 -0700 (PDT)
In-Reply-To: <BANLkTi=Pew-stDVCxUQoa5t2s5P8pWRomA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: djlee064 <djlee064@gmail.com>
Cc: Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

2011/5/31 djlee064 <djlee064@gmail.com>:
> A bit off, but can you Fyodor, and all of devs run
>
> dd if=3D/dev/null of=3D/cephmount/file bs=3D1M count=3D10000 =C2=A0 (=
10gb)
> dd if=3D/dev/null of=3D/cephmount/file bs=3D1M count=3D50000 =C2=A0 (=
50gb)
> dd if=3D/dev/null of=3D/cephmount/file bs=3D1M count=3D100000 (100gb)
>
> and continue to 200gb,... 500gb
>
> see the MB/s difference, =C2=A0expecting an enormous difference, e.g.=
,
> starts ~200MB/s and drops down to well less than 50MB/s or even less
> (Depending on the #disk, but about 12MB/s per-disk is what I have
> analyzed)
> I feel that Fyodor's and the rest of you are testing only a very smal=
l
> part, the high rate at the start is likely to be due to the journal
> size.

It's client-side caching effect. Without adding the option
conv=3Dfdatasync (or fsync), dd returns the throughput without flushing
the data.

--Henry
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
