From: kefu chai <tchaikov@gmail.com>
Subject: Re: understand ceph packets on the wire
Date: Mon, 6 Feb 2017 19:18:53 +0800
Message-ID: <CAJE9aOO+qgU+vyusOXkwQ-3OC+9z0BYTZm_d7SmZG23PQ9nhuw@mail.gmail.com>
References: <CAF1ivSZtbb_mrSB7gdgO0sszWwZA+r95btd6_AM4VXffNyXq8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35248 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbdBFLSy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2017 06:18:54 -0500
Received: by mail-ua0-f194.google.com with SMTP id 96so6892541uaq.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Feb 2017 03:18:54 -0800 (PST)
In-Reply-To: <CAF1ivSZtbb_mrSB7gdgO0sszWwZA+r95btd6_AM4VXffNyXq8A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ming Lin <minggr@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Feb 4, 2017 at 7:18 AM, Ming Lin <minggr@gmail.com> wrote:
> Hi,
>
> With a one monitor one OSD test setup(osd pool default size = 1), I
> captured the packets with tshark.
> pcap.out file: https://ufile.io/43c78
>
> The test I did was:
> dd if=tmp.txt bs=512 count=1 of=/dev/rbd0 oflag=direct
>
> About 350 packets were captured just for above simple "dd" command.
>
> If you open the file with wireshark, you'll see packet #41 is the data packet.
> "192.168.122.1" is the OSD and "192.168.122.131" is the rbd client.
>
> What are other packets?

you can set "debug-ms=1" and probably set "log_file" to a writable
path, then check the log.

>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
