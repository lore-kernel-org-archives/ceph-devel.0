From: Ming Lin <minggr@gmail.com>
Subject: Re: monitor port closed
Date: Mon, 23 Jan 2017 11:08:06 -0800
Message-ID: <CAF1ivSYsX2pOabSg3bfXQsL-VpstXxYTRsK1x2Pijhai1YOYXA@mail.gmail.com>
References: <CAF1ivSbn_bzic_JjOEEUKnp936XOy43s2r=0V0ujzVSpv2okBw@mail.gmail.com>
 <CAJE9aON2E8zAnBxqHhmY9cT3RVr3jGaVtkYcsk-9zfxoqk2+HQ@mail.gmail.com> <226f223c-88d6-1d94-410a-482479c54691@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:34859 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbdAWTII (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 14:08:08 -0500
Received: by mail-it0-f46.google.com with SMTP id 203so70759124ith.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2017 11:08:08 -0800 (PST)
In-Reply-To: <226f223c-88d6-1d94-410a-482479c54691@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jan 23, 2017 at 6:28 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:

>
> Other nice tools to help you here to see where the socket has gone:
>         sockstat
>         lsof
>
> They can tell you if the socket is somewhere else opened.
> And what the state is.
>
> Or they can tell you what other port(s) the monitor has opened.

# netstat -putnl |grep 7000
<no output>

# netstat -putna |grep 7000
tcp        0      0 192.168.0.1:7000        192.168.122.131:53240
ESTABLISHED 21980/ceph-mon

Seems port 7000 is not listening, but still established with rbd client.

root@rbd-client:~# netstat -putna |grep 53240
tcp        0      0 192.168.122.131:53240   192.168.0.1:7000
ESTABLISHED -
