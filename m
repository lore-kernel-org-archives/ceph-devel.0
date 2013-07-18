From: Ta Ba Tuan <tuantb@vccloud.vn>
Subject: Re: [ceph-users] ceph -w warning "I don't have pgid 0.2c8"?
Date: Fri, 19 Jul 2013 01:24:46 +0700
Message-ID: <51E832EE.6070905@vccloud.vn>
References: <51E64EE7.3090902@vccloud.vn> <CA+4uBUbASJWUME+zOZRh=NrZLEGdJcmwXMoMWvvmgGRzG04C0w@mail.gmail.com> <51E75166.9000308@vccloud.vn> <51E75958.10806@vccloud.vn> <CA+4uBUZgjxObUp9a9=+meY=td4DY7x=KfUzCP81sFxS3fv4cwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from vccloud.vn ([222.255.27.61]:50840 "EHLO mail.vccloud.vn"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758266Ab3GRSY7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 18 Jul 2013 14:24:59 -0400
Received: from localhost (mail.vccloud.vn [127.0.0.1])
	by mail.vccloud.vn (Postfix) with ESMTP id 7D0F83A0086
	for <ceph-devel@vger.kernel.org>; Fri, 19 Jul 2013 01:24:57 +0700 (ICT)
Received: from mail.vccloud.vn ([127.0.0.1])
	by localhost (mail.vccloud.vn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aYhX2U8mKg9e for <ceph-devel@vger.kernel.org>;
	Fri, 19 Jul 2013 01:24:53 +0700 (ICT)
In-Reply-To: <CA+4uBUZgjxObUp9a9=+meY=td4DY7x=KfUzCP81sFxS3fv4cwg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

Hi Samuel,

Output logs from : ceph pg dump | grep 'stale\|creating'

0.f4f 0 0 0 0 0 0 0 stale+creating 2013-07-17 16:35:06.882419 0'0 0'0 [=
]=20
[68,12] 0=E2=94=82'0 0.000000 0'0 0.000000 =E2=94=82
2.f4d 0 0 0 0 0 0 0 stale+creating 2013-07-17 16:35:22.826552 0'0 0'0 [=
]=20
[68,12] 0=E2=94=82
'0 0.000000 0'0 0.000000 =E2=94=82
0.2c8 0 0 0 0 0 0 0 stale+creating 2013-07-17 14:30:54.280454 0'0 0'0 [=
]=20
[68,5] 0=E2=94=82
'0 0.000000 0'0 0.000000 =E2=94=82
2.2c6 0 0 0 0 0 0 0 stale+creating 2013-07-17 16:35:28.445878 0'0 0'0 [=
]=20
[68,5] 0=E2=94=82
'0 0.000000 0'0 0.000000

Thanks!

On 07/19/2013 01:16 AM, Samuel Just wrote:
> ceph pg dump | grep 'stale\|creating'

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
