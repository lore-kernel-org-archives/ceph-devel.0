From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: OSD sizes
Date: Sun, 4 Nov 2012 16:51:06 +0100
Message-ID: <CAOLwVUmMFsMQ355xpzyDsvgrLJjQRsRVabh9m85mbCgpVZC5sA@mail.gmail.com>
References: <50963862.7060800@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:56436 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755624Ab2KDPv2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 10:51:28 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so3647228lag.19
        for <ceph-devel@vger.kernel.org>; Sun, 04 Nov 2012 07:51:26 -0800 (PST)
In-Reply-To: <50963862.7060800@ledeuns.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Denis Fondras <ceph@ledeuns.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Well, there is not really an "ideal" number. For instance, at
Dreamhost they put 12 disks per machines, but they have really big and
powerful server. The  problem is: as many disks per machine you have
as data you have to migrate in case of failure. At the end, it's up to
you... It also highly depend of the size of your cluster (amount of
data).
--
Bien cordialement.
S=E9bastien HAN.


On Sun, Nov 4, 2012 at 10:41 AM, Denis Fondras <ceph@ledeuns.net> wrote=
:
> Hello,
>
>
>>
>> As far I'm concerned I think that 12 disks per servers is way too mu=
ch.
>
>
> From your experience, what is the "correct" number of OSD per server =
?
>
> Denis
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
