From: Tommi Virtanen <tv@inktank.com>
Subject: Re: RadosGW on ubuntu is OK but CentOS fails
Date: Mon, 30 Jul 2012 09:59:25 -0700
Message-ID: <CADvuQRE8Xb+P=3Jo2vOmn7Z93nguugLUvDys0rVc2euc6muPDg@mail.gmail.com>
References: <CAMm-wcJ7aFjgW_ROb-=+Mk9RdRB_NCoFCChA+8U_s8jd5cgFOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52486 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754291Ab2G3Q7t convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 12:59:49 -0400
Received: by vcbfk26 with SMTP id fk26so4872687vcb.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 09:59:45 -0700 (PDT)
In-Reply-To: <CAMm-wcJ7aFjgW_ROb-=+Mk9RdRB_NCoFCChA+8U_s8jd5cgFOw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jul 30, 2012 at 12:58 AM, =E8=A2=81=E5=86=AC <yuandong1222@gmai=
l.com> wrote:
> I deploy an instance including 1 mon, 1 osd and 1 radosgw on one
> machine which based on CentOS 6.2. I can access the system from
> browser(Chrome) which tells me that: no bucket for anonymous user.
>
> I think I get everything fine, but when I use S3-tests to test this
> instance, the test script is very very slow and got lots of errors.
>
> I deploy another instance which is all the same with the first
> excepted it is based on Ubuntu 12.04 Sever. Browser access is still O=
K
> and S3-tests completed fast with 209 OK, 8 Fall and 38 Error, I think
> this is the correct result.

So radosgw on CentOS is slow, Ubuntu 12.04 is fast? Check and compare

- networking: what if you have packet loss or DNS failures to your
CentOS server, but not to your Ubuntu one
- filesystem used for OSDs
- kernel version
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
