From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: radosgw:s3 create doesn't work
Date: Thu, 25 Aug 2011 08:12:09 -0700
Message-ID: <CAC-hyiHS4EiR+XYZcm==dYgo0U4MYM0kfj6+KWhNSt2Dk67tMA@mail.gmail.com>
References: <CABAwU-ZxPeQu1b=EbBjxWeNSn7X7+jOwiywO5hPOnsAxUe0Pvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48369 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab1HYPML convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2011 11:12:11 -0400
Received: by bke11 with SMTP id 11so1807278bke.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2011 08:12:10 -0700 (PDT)
In-Reply-To: <CABAwU-ZxPeQu1b=EbBjxWeNSn7X7+jOwiywO5hPOnsAxUe0Pvw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 25, 2011 at 6:51 AM, huang jun <hjwsm1989@gmail.com> wrote:
> hi,all
> i try to use radosgw in ceph 0.30.
> but i always got error in "s3 -u create alpha"
> steps below:
> bsd02:/data#ceph -s
> 2011-08-25 21:47:33.256884 =A0 =A0pg v149: 230 pgs: 230
> active+clean+degraded; 29 KB data, 7868 MB used, 6481 MB / 15118 MB
> avail; 29/58 degraded (50.000%)
> 2011-08-25 21:47:33.257330 =A0 mds e4: 1/1/1 up {0=3D0=3Dup:active}
> 2011-08-25 21:47:33.257355 =A0 osd e6: 1 osds: 1 up, 1 in
> 2011-08-25 21:47:33.257399 =A0 log 2011-08-25 21:32:26.114013 osd0
> 192.168.1.102:6801/5163 230 : [INF] 6.7 scrub ok
> 2011-08-25 21:47:33.257454 =A0 mon e1: 1 mons at {0=3D192.168.1.102:6=
789/0}
>
> bsd02:/data# =A0radosgw_admin -m 192.168.1.102:6789 -c
> /etc/ceph/ceph.conf user create --display-name=3D"chuyunhanzhi"
> --email=3Dservice_wh@chinfotech.com.cn -i 0
> User ID: 0
> RADOS UID: 0
> Keys:
> =A0User: 0
> =A0Access Key: 669L0E71AIIGD5GZL4EJ
> =A0Secret Key: IwRFVHrPwT115hCry2hXRiRqWVLCgLIk1SbALViG
> Users:
> Display Name: chuyunhanzhi
> Email: service_wh@chinfotech.com.cn
> OpenStack User: <undefined>
> OpenStack Key: <undefined>
>
> bsd02:/data# export S3_ACCESS_KEY_ID=3D669L0E71AIIGD5GZL4EJ
> bsd02:/data# export
> S3_SECRET_ACCESS_KEY=3DIwRFVHrPwT115hCry2hXRiRqWVLCgLIk1SbALViG
> bsd02:/data# export S3_HOSTNAME=3D192.168.1.102
>
> bsd02:/data# s3 create alpha
>
> ERROR: ErrorInvalidAccessKeyId
> =A0Message: The AWS Access Key Id you provided does not exist in our =
records.
> =A0Extra Details:
> =A0 =A0RequestId: 006D8781356B1B00
> =A0 =A0HostId: d6lXuxT+ospDfgMYayaz7YjTzB5If4Q9s9mkoZno9fgyGe0shHrhfG=
Gv3y3WGCAb
> =A0 =A0AWSAccessKeyId: 669L0E71AIIGD5GZL4EJ
>
> and i tried another two times,but the error always occur.
> so what should i do to avoid this problem?

You're going to Amazon here and get that response from there. Are you
using the correct s3 utility?

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
