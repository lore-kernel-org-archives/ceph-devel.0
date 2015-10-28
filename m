From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: Re: pg scrub check problem
Date: Wed, 28 Oct 2015 18:34:46 +0800
Message-ID: <CANE=7sXqUs=9TgZsO0A8n0aQKHex4OnCW9uikP=TkNdsj+bDrQ@mail.gmail.com>
References: <000001d11164$7fa470a0$7eed51e0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:32909 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbbJ1Ker convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Oct 2015 06:34:47 -0400
Received: by obbwb3 with SMTP id wb3so2370120obb.0
        for <ceph-devel@vger.kernel.org>; Wed, 28 Oct 2015 03:34:46 -0700 (PDT)
In-Reply-To: <000001d11164$7fa470a0$7eed51e0$@com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: changtao381 <changtao381@163.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Are you sure the osd begin to scrub? maybe you could check it from osd
log, or using 'ceph pg dump' to
check whether the scrub stamp changes or not.
Because there is some strategy which would reject the scrub command
Such as the system load , osd_scrub_min_interval,
osd_deep_scrub_interval and so on

2015-10-28 17:39 GMT+08:00 changtao381 <changtao381@163.com>:
> Hi,
>
> I=E2=80=99m testing the deep-scrub function of ceph.  And the test st=
eps are below :
>
> 1)  I put an object on ceph using command :
>  rados put test.txt test.txt =E2=80=93p testpool
>
> The size of testpool is 3, so there three replicates on three osds:
>
> osd.0:   /data1/ceph_data/osd.0/current/1.0_head/test.txt__head_8B0B6=
108__1
> osd.1:   /data2/ceph_data/osd.1/current/1.0_head/test.txt__head_8B0B6=
108__1
> osd.2    /data3/ceph_data/osd.2/current/1.0_head/test.txt__head_8B0B6=
108__1
>
> 2) I modified the content of one replica on osd.0 using vim editor di=
rectly on disk
>
> 3) I run the command
> =E3=80=80ceph pg deep-scrub 1.0
>
> and expect it can check the inconsistent error out, but it fails. It =
doesn=E2=80=99t find the error
> why?
>
> Any suggestions will be appreciated! Thanks
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Regards,
xinze
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
