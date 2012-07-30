From: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>
Subject: Re: RadosGW on ubuntu is OK but CentOS fails
Date: Tue, 31 Jul 2012 07:24:34 +0800
Message-ID: <CAMm-wcKeLa_pBASEBxDY=MDdiaMFFnS03N4YO3OG2=NCqswYUw@mail.gmail.com>
References: <CAMm-wcJ7aFjgW_ROb-=+Mk9RdRB_NCoFCChA+8U_s8jd5cgFOw@mail.gmail.com>
	<CADvuQRE8Xb+P=3Jo2vOmn7Z93nguugLUvDys0rVc2euc6muPDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:46498 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875Ab2G3XYf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 19:24:35 -0400
Received: by qadb17 with SMTP id b17so1323966qad.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 16:24:35 -0700 (PDT)
In-Reply-To: <CADvuQRE8Xb+P=3Jo2vOmn7Z93nguugLUvDys0rVc2euc6muPDg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks for your replay.

> - networking: what if you have packet loss or DNS failures to your Ce=
ntOS server, but not to your Ubuntu one
I have both s3-tests client on the two servers and I used IP address
as the hostname, so I don't think DNS is the reason.
I run S3-tests client on CentOS against CentOS server: Fail.
I run S3-tests client on Ubuntu against CentOS server: Fail.
I run S3-tests client on CentOS against Ubuntu server: OK.
I run S3-tests client on Ubuntu against Ubuntu server: OK.

So I think there is something wrong with the CentOS server.

> - filesystem used for OSDs
Both instance use btrfs file system. Is there some difference of btrfs
between CentOS and Ubuntu?

> - kernel version
CentOS Kernel Version: 3.4.0
Ubuntu Kernel Version: 3.2.0

BTW: the two servers are both virtual machines with the same hardware.

Any idea?

Thanks again.


On 31 July 2012 00:59, Tommi Virtanen <tv@inktank.com> wrote:
> On Mon, Jul 30, 2012 at 12:58 AM, =D4=AC=B6=AC <yuandong1222@gmail.co=
m> wrote:
>> I deploy an instance including 1 mon, 1 osd and 1 radosgw on one
>> machine which based on CentOS 6.2. I can access the system from
>> browser(Chrome) which tells me that: no bucket for anonymous user.
>>
>> I think I get everything fine, but when I use S3-tests to test this
>> instance, the test script is very very slow and got lots of errors.
>>
>> I deploy another instance which is all the same with the first
>> excepted it is based on Ubuntu 12.04 Sever. Browser access is still =
OK
>> and S3-tests completed fast with 209 OK, 8 Fall and 38 Error, I thin=
k
>> this is the correct result.
>
> So radosgw on CentOS is slow, Ubuntu 12.04 is fast? Check and compare
>
> - networking: what if you have packet loss or DNS failures to your
> CentOS server, but not to your Ubuntu one
> - filesystem used for OSDs
> - kernel version



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
