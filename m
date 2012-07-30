From: Tommi Virtanen <tv@inktank.com>
Subject: Re: RadosGW on ubuntu is OK but CentOS fails
Date: Mon, 30 Jul 2012 16:41:20 -0700
Message-ID: <CADvuQRH7y+yM=6Muva_FQ3ku-Wd3ZJwkrV_w0NXzncJuMMKFxg@mail.gmail.com>
References: <CAMm-wcJ7aFjgW_ROb-=+Mk9RdRB_NCoFCChA+8U_s8jd5cgFOw@mail.gmail.com>
 <CADvuQRE8Xb+P=3Jo2vOmn7Z93nguugLUvDys0rVc2euc6muPDg@mail.gmail.com> <CAMm-wcKeLa_pBASEBxDY=MDdiaMFFnS03N4YO3OG2=NCqswYUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:58795 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2G3Xll convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 19:41:41 -0400
Received: by vbbff1 with SMTP id ff1so5203091vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 16:41:40 -0700 (PDT)
In-Reply-To: <CAMm-wcKeLa_pBASEBxDY=MDdiaMFFnS03N4YO3OG2=NCqswYUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jul 30, 2012 at 4:24 PM, =E8=A2=81=E5=86=AC <yuandong1222@gmail=
=2Ecom> wrote:
>> - filesystem used for OSDs
> Both instance use btrfs file system. Is there some difference of btrf=
s
> between CentOS and Ubuntu?
>
>> - kernel version
> CentOS Kernel Version: 3.4.0
> Ubuntu Kernel Version: 3.2.0

There's five months of active development between those two kernels,
including plenty of btrfs work:
http://kernelnewbies.org/Linux_3.4#head-8ad9e3d4ad73e1da565f52c2abbe9ac=
f7efdc614

I'd recommend building the latest & greatest kernel, same version, on
both your ubuntu and centos servers. That'll make the comparison more
even.

Additionally, you might want to try xfs.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
