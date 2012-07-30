From: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>
Subject: Re: RadosGW on ubuntu is OK but CentOS fails
Date: Tue, 31 Jul 2012 07:47:03 +0800
Message-ID: <CAMm-wc+UY6su9PX70XMKhL_=+22BTJUOyYt10+PMEy20UU_3JA@mail.gmail.com>
References: <CAMm-wcJ7aFjgW_ROb-=+Mk9RdRB_NCoFCChA+8U_s8jd5cgFOw@mail.gmail.com>
	<CADvuQRE8Xb+P=3Jo2vOmn7Z93nguugLUvDys0rVc2euc6muPDg@mail.gmail.com>
	<CAMm-wcKeLa_pBASEBxDY=MDdiaMFFnS03N4YO3OG2=NCqswYUw@mail.gmail.com>
	<CADvuQRH7y+yM=6Muva_FQ3ku-Wd3ZJwkrV_w0NXzncJuMMKFxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:51823 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2G3XrE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 19:47:04 -0400
Received: by qcro28 with SMTP id o28so3356090qcr.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 16:47:03 -0700 (PDT)
In-Reply-To: <CADvuQRH7y+yM=6Muva_FQ3ku-Wd3ZJwkrV_w0NXzncJuMMKFxg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I will try them and report lately.

Thanks.

On 31 July 2012 07:41, Tommi Virtanen <tv@inktank.com> wrote:
> On Mon, Jul 30, 2012 at 4:24 PM, =D4=AC=B6=AC <yuandong1222@gmail.com=
> wrote:
>>> - filesystem used for OSDs
>> Both instance use btrfs file system. Is there some difference of btr=
fs
>> between CentOS and Ubuntu?
>>
>>> - kernel version
>> CentOS Kernel Version: 3.4.0
>> Ubuntu Kernel Version: 3.2.0
>
> There's five months of active development between those two kernels,
> including plenty of btrfs work:
> http://kernelnewbies.org/Linux_3.4#head-8ad9e3d4ad73e1da565f52c2abbe9=
acf7efdc614
>
> I'd recommend building the latest & greatest kernel, same version, on
> both your ubuntu and centos servers. That'll make the comparison more
> even.
>
> Additionally, you might want to try xfs.



--=20
=D4=AC=B6=AC
Tel:13573888215
Email:yuandong1222@gmail.com
QQ:10200230
MSN:yuandong1222@hotmail.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
