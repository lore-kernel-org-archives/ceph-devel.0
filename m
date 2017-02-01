From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: how to disable all complier optimizations
Date: Thu, 2 Feb 2017 01:02:34 +0800
Message-ID: <CACKY0b95F8GJRqG=ZOgvY2Exh6jzJ4YENOO40wfWBBF=LC+VRA@mail.gmail.com>
References: <914C48E9796C6046B6424CA69C30AB3B03BBBA@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:34477 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752974AbdBARCg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2017 12:02:36 -0500
Received: by mail-yw0-f169.google.com with SMTP id w75so68440082ywg.1
        for <ceph-devel@vger.kernel.org>; Wed, 01 Feb 2017 09:02:35 -0800 (PST)
In-Reply-To: <914C48E9796C6046B6424CA69C30AB3B03BBBA@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ramesh Chander <Ramesh.Chander@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

hi, try this

cmake -DCMAKE_BUILD_TYPE=3DDebug ..

2017-02-01 19:48 GMT+08:00 Ramesh Chander <Ramesh.Chander@sandisk.com>:
> I am trying to compile ceph-osd and debug it but keep getting "optimized =
out " message for local variables.
>
> How to I disable compiler optimization for ceph-osd ?
>
> Thanks in advance.
>
> -Ramesh
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is=
 intended only for the use of the designated recipient(s) named above. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that you have received this message in error and that any review, dis=
semination, distribution, or copying of this message is strictly prohibited=
. If you have received this communication in error, please notify the sende=
r by telephone or e-mail (as shown above) immediately and destroy any and a=
ll copies of this message in your possession (whether hard copies or electr=
onically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
