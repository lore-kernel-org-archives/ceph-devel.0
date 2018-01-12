From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: Re: [ceph-users] data cleaup/disposal process
Date: Fri, 12 Jan 2018 12:42:46 +0530
Message-ID: <CANA9Uk6+1FPnwz4TFCDRwaGPpsTCf9Mg7NNkoEjsPCe35JhoSg@mail.gmail.com>
References: <CANA9Uk5w5j4ax7aPZF-ybA55zVcELn00zExMEbwS1jUtA_CA-w@mail.gmail.com>
 <DB6P190MB0327E4A22662575074B54549FF1F0@DB6P190MB0327.EURP190.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:39107 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeALHMr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jan 2018 02:12:47 -0500
Received: by mail-qt0-f169.google.com with SMTP id k19so4960743qtj.6
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jan 2018 23:12:47 -0800 (PST)
In-Reply-To: <DB6P190MB0327E4A22662575074B54549FF1F0@DB6P190MB0327.EURP190.PROD.OUTLOOK.COM>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sergey Malinin <hell@newmail.com>
Cc: ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi - The "rbd rm" or "rados rm -p <pool>" will not clean the data in
side the OSDs. for ex: I wrote 1 MB data on my image/volume, then
removed that image using "rbd rm" command, is this "rbd rm" will
remove the data in side the OSD's object or just mark it as removed.

Thanks
Swami

On Thu, Jan 4, 2018 at 6:49 PM, Sergey Malinin <hell@newmail.com> wrote:
> http://cephnotes.ksperis.com/blog/2014/07/04/remove-big-rbd-image
>
> ________________________________
> From: ceph-users <ceph-users-bounces@lists.ceph.com> on behalf of M Ranga
> Swami Reddy <swamireddy@gmail.com>
> Sent: Thursday, January 4, 2018 3:55:27 PM
> To: ceph-users; ceph-devel
> Subject: [ceph-users] data cleaup/disposal process
>
> Hello,
> In Ceph, is the way to cleanup data before deleting an image?
>
> Means wipe the data with '0' before deleting an image.
>
> Please let me know if you have any suggestions here.
>
> Thanks
> Swami
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
