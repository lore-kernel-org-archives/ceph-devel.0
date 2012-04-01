From: zhurongze <zrz4ceph@gmail.com>
Subject: Re: Question about the implementation of bucket_straw_choose in src/crush/mapper.c
Date: Sun, 01 Apr 2012 10:33:19 +0800
Message-ID: <4F77BE6F.9090401@gmail.com>
References: <CALwGbP+0xWC=-zZYdx_D6ikgEq6NRYYfweEDn7z5WceCypPRNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54220 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056Ab2DACd0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 31 Mar 2012 22:33:26 -0400
Received: by pbcun15 with SMTP id un15so3246800pbc.19
        for <ceph-devel@vger.kernel.org>; Sat, 31 Mar 2012 19:33:26 -0700 (PDT)
In-Reply-To: <CALwGbP+0xWC=-zZYdx_D6ikgEq6NRYYfweEDn7z5WceCypPRNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Cc: ceph-devel@vger.kernel.org

=E4=BA=8E 2012=E5=B9=B403=E6=9C=8829=E6=97=A5 17:16, =E8=83=A1=E7=80=9A=
=E6=A3=AE =E5=86=99=E9=81=93:
> Hi everyone, i'm proceeding reading source code of crush
>
> i'm reading src/crush/mapper.c which is describing the core
> implementation of crush alg.
> in reading function bucket_straw_choose, i compare the implementation
> with the idea written in the thesis and have some problem
> understanding it.
>
> in the thesis, it said that the length of straw should multiply the
> weight of bucket item so that heavier items are more likely to be
> selected.
> in bucket_straw_choose, i see bucket->straws multiplying the hash val=
ue only.
>
> next, i referred to crush.h to take a look at the data structure of
> crush_bucket_straw, and found two members named 'straws' and
> 'item_weights'.
>
> i just don't know whether 'weight' and 'straw' in the implementation
> mean the same thing as in thesis. if so, why item_weights is not used
> in bucket_straw_choose.
>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Are you chinese?  I wrote 2 articles about  CRUSH design and source cod=
e=20
analysis in Chinese, I think this is useful for you.
The Link is http://toplab.sinaapp.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
