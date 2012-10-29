From: Sam Lang <sam.lang@inktank.com>
Subject: Re: Ceph performance
Date: Mon, 29 Oct 2012 13:57:08 -0500
Message-ID: <508ED184.50203@inktank.com>
References: <508E8C1C.4020605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:52553 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760378Ab2J2S5L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Oct 2012 14:57:11 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so4127468iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Oct 2012 11:57:10 -0700 (PDT)
In-Reply-To: <508E8C1C.4020605@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Alekseev <rs.alekseev@gmail.com>
Cc: ceph-devel@vger.kernel.org


Hi Roman,

Is this with the ceph fuse client or the ceph kernel module?

Its not surprising that the local file system (/home) is so much faster=
=20
than a mounted ceph volume, especially the first time the directory tre=
e=20
is traversed (metadata results are cached at the client to improve=20
performance).  Try running the same find command on the ceph volume and=
=20
see if the cached results at the client improve performance at all.

In order to understand what the performance of ceph should be capable o=
f=20
doing with your deployment for this specific workload, you should run=20
iperf between two nodes to get an idea of your latency limits.

Also, I noticed that the real timings you listed for ceph and /home are=
=20
offset by exactly 17 minutes (user and sys are identical).  Was that a=20
copy/paste error, by chance?

-sam

On 10/29/2012 09:01 AM, Roman Alekseev wrote:
> Hi,
>
> Kindly guide me how to improve performance on the cluster which consi=
st
> of 5 dedicated servers:
>
> - ceph.conf: http://pastebin.com/hT3qEhUF
> - file system on all drives is ext4
> - mount options "user_xattr"
> - each server has :
> CPU:Intel=AE Xeon=AE Processor E5335(8M Cache, 2.00 GHz, 1333 MHz FSB=
) x2
> MEM: 4Gb DDR2
> - 1Gb network
>
> Simple test:
>
> mounted as ceph
> root@client1:/mnt/mycephfs# time find . | wc -l
> 83932
>
> real    17m55.399s
> user    0m0.152s
> sys    0m1.528s
>
> on 1 HDD:
>
> root@client1:/home# time find . | wc -l
> 83932
>
> real    0m55.399s
> user    0m0.152s
> sys    0m1.528s
>
> Please help me to find out the issue. Thanks.
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
