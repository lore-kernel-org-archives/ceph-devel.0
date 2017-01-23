From: Ming Lin <minggr@gmail.com>
Subject: Re: monitor port closed
Date: Mon, 23 Jan 2017 13:01:03 -0800
Message-ID: <CAF1ivSZjJZ7uThOYAkgVHW-AJni4GGbgOkaHJiaPy2A+wbS8Gw@mail.gmail.com>
References: <CAF1ivSbn_bzic_JjOEEUKnp936XOy43s2r=0V0ujzVSpv2okBw@mail.gmail.com>
 <CAJE9aON2E8zAnBxqHhmY9cT3RVr3jGaVtkYcsk-9zfxoqk2+HQ@mail.gmail.com>
 <226f223c-88d6-1d94-410a-482479c54691@digiware.nl> <CAF1ivSYsX2pOabSg3bfXQsL-VpstXxYTRsK1x2Pijhai1YOYXA@mail.gmail.com>
 <e2c33bd7-d582-9233-6648-0c2593a32233@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:36218 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbdAWVBK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 16:01:10 -0500
Received: by mail-it0-f51.google.com with SMTP id c7so72495065itd.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2017 13:01:10 -0800 (PST)
In-Reply-To: <e2c33bd7-d582-9233-6648-0c2593a32233@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jan 23, 2017 at 12:38 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 23-1-2017 20:08, Ming Lin wrote:
>> On Mon, Jan 23, 2017 at 6:28 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>
>>>
>>> Other nice tools to help you here to see where the socket has gone:
>>>         sockstat
>>>         lsof
>>>
>>> They can tell you if the socket is somewhere else opened.
>>> And what the state is.
>>>
>>> Or they can tell you what other port(s) the monitor has opened.
>>
>> # netstat -putnl |grep 7000
>> <no output>
>
>> # netstat -putna |grep 7000
>> tcp        0      0 192.168.0.1:7000        192.168.122.131:53240
>> ESTABLISHED 21980/ceph-mon
>
> Is process 21980 listening on any other ports? the normal range would be
> 6800-7300 (as defined in config_opts.h)

No, that's the only one with ESTABLISHED state.

# netstat -putna |grep 21980
tcp        0      0 192.168.0.1:7000        192.168.122.131:53240
ESTABLISHED 21980/ceph-mon

> And it would start on 6789, so quite a few rebinds have occurred.
> unless have configured it differently.

I configured with 7000 for test purpose.

[mon]
mon initial members = a

[mon.a]
mon addr = 192.168.0.1:7000
