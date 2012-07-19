From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Poor read performance in KVM
Date: Thu, 19 Jul 2012 11:42:32 -0700
Message-ID: <50085518.80507@inktank.com>
References: <5002C215.108@bashkirtsev.com> <5003B1CC.4060909@inktank.com> <50064DCD.8040904@bashkirtsev.com> <5006D5FB.8030700@inktank.com> <50080D9D.8010306@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:62527 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab2GSSmi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 14:42:38 -0400
Received: by gglu4 with SMTP id u4so3121141ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 11:42:37 -0700 (PDT)
In-Reply-To: <50080D9D.8010306@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 07/19/2012 06:37 AM, Vladimir Bashkirtsev wrote:
>
>> Try to determine how much of the 200ms avg latency comes from osds vs
>> the qemu block driver.
> Now I see following:
>
> 2012-07-19 22:59:55.604365 osd.1 [WRN] 6 slow requests, 6 included
> below; oldest blocked for > 38.034575 secs
> 2012-07-19 22:59:55.604377 osd.1 [WRN] slow request 38.034575 seconds
> old, received at 2012-07-19 22:59:17.569653:
> osd_op(client.154924.0:5640639 rb.0.11.00000000268d [write 2912256~4096]
> 2.9e04890a) v4 currently waiting for sub ops
> 2012-07-19 22:59:55.604384 osd.1 [WRN] slow request 38.034442 seconds
> old, received at 2012-07-19 22:59:17.569786:
> osd_op(client.154924.0:5640640 rb.0.11.00000000296f [write 2269184~4096]
> 2.bc0707d9) v4 currently waiting for sub ops
> 2012-07-19 22:59:55.604389 osd.1 [WRN] slow request 37.813370 seconds
> old, received at 2012-07-19 22:59:17.790858:
> osd_op(client.152350.0:2269710 rb.0.d.000000001e9e [write
> 2097152~1048576] 2.bb4282ca) v4 currently waiting for sub ops
> 2012-07-19 22:59:55.604396 osd.1 [WRN] slow request 37.715288 seconds
> old, received at 2012-07-19 22:59:17.888940:
> osd_op(client.152365.0:1474333 rb.0.12.0000000004d7 [write 274432~4096]
> 2.d68a2203) v4 currently waiting for sub ops
> 2012-07-19 22:59:55.604402 osd.1 [WRN] slow request 32.812673 seconds
> old, received at 2012-07-19 22:59:22.791555:
> osd_op(client.158304.0:11002 rb.0.13.000000001c6d [write 1978368~12288]
> 2.dada321f) v4 currently waiting for sub ops
>
> Looks like an indication of something bigger than just latency. Similar
> problems on osd.2 too. So with two osds misbehaving not really surprised
> that KVM reads are slow. Do these slow requests hold up reads?

Yes, they can hold up reads to the same object. Depending on where 
they're stuck, they may be blocking other requests as well if they're
e.g. taking up all the filestore threads. Waiting for subops means
they're waiting for replicas to acknowledge the write and commit it to
disk. The real cause for slowness of those ops is the replicas. If you
enable 'debug osd = 25', 'filestore = 25', and 'debug journal = 20' you
can trace through the logs to see exactly what's happening with the
subops for those requests.

Josh
