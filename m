From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: monitor port closed
Date: Mon, 23 Jan 2017 21:38:05 +0100
Message-ID: <e2c33bd7-d582-9233-6648-0c2593a32233@digiware.nl>
References: <CAF1ivSbn_bzic_JjOEEUKnp936XOy43s2r=0V0ujzVSpv2okBw@mail.gmail.com>
 <CAJE9aON2E8zAnBxqHhmY9cT3RVr3jGaVtkYcsk-9zfxoqk2+HQ@mail.gmail.com>
 <226f223c-88d6-1d94-410a-482479c54691@digiware.nl>
 <CAF1ivSYsX2pOabSg3bfXQsL-VpstXxYTRsK1x2Pijhai1YOYXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:17409 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750979AbdAWUiP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 23 Jan 2017 15:38:15 -0500
In-Reply-To: <CAF1ivSYsX2pOabSg3bfXQsL-VpstXxYTRsK1x2Pijhai1YOYXA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ming Lin <minggr@gmail.com>
Cc: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 23-1-2017 20:08, Ming Lin wrote:
> On Mon, Jan 23, 2017 at 6:28 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> 
>>
>> Other nice tools to help you here to see where the socket has gone:
>>         sockstat
>>         lsof
>>
>> They can tell you if the socket is somewhere else opened.
>> And what the state is.
>>
>> Or they can tell you what other port(s) the monitor has opened.
> 
> # netstat -putnl |grep 7000
> <no output>

> # netstat -putna |grep 7000
> tcp        0      0 192.168.0.1:7000        192.168.122.131:53240
> ESTABLISHED 21980/ceph-mon

Is process 21980 listening on any other ports? the normal range would be
6800-7300 (as defined in config_opts.h)
And it would start on 6789, so quite a few rebinds have occurred.
unless have configured it differently.

> 
> Seems port 7000 is not listening, but still established with rbd client.
> 
> root@rbd-client:~# netstat -putna |grep 53240
> tcp        0      0 192.168.122.131:53240   192.168.0.1:7000
> ESTABLISHED -

Seems the OS thinks there is still a fully open connection, since both
ends are in ESTABLISHED.

--WjW


