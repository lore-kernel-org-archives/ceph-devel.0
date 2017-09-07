From: kefu chai <tchaikov@gmail.com>
Subject: Re: payload of MPing
Date: Fri, 8 Sep 2017 00:20:57 +0800
Message-ID: <CAJE9aOO2-SmRZokvwm7T0=5CkYr0=kn0Yy49GOcbcAmyP=Fn6A@mail.gmail.com>
References: <CAJE9aONuZZeDut2boHFU-nWXstCqXEaSEHT+KfGE0xJqJm=SaA@mail.gmail.com>
 <413e410d-5fee-7703-e788-a132b26f64c4@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36230 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932083AbdIGQU6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Sep 2017 12:20:58 -0400
Received: by mail-oi0-f43.google.com with SMTP id x190so1041856oix.3
        for <ceph-devel@vger.kernel.org>; Thu, 07 Sep 2017 09:20:58 -0700 (PDT)
In-Reply-To: <413e410d-5fee-7703-e788-a132b26f64c4@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Sep 7, 2017 at 4:53 PM, Joao Eduardo Luis <joao@suse.de> wrote:
> On 09/07/2017 05:00 AM, kefu chai wrote:
>>
>> hey Joao,
>>
>> while reviewing https://github.com/ceph/ceph/pull/17269, i found that
>> there is no consumers of the payload of MPing replies. but apparently,
>> we stuff it with the health status on purpose. do you happen to
>> remember why we are doing so? if the feature/functionality depending
>> on it is deprecated or removed or not implemented, probably we can
>> just drop the logic to stuff the payload of MPing?
>
>
> The only consumer, to date, and possibly ever until we (maybe) piggy-back on
> it for heartbeats, is the ceph tool.
>
> We do consume that reply when we run `ceph ping mon.foo`. The interface is
> through RadosClient, all the way up to the Objecter, and eventually up the
> chain to the ceph tool.


ahh, right! i missed MonClientPinger when grep'ing MPing in the source tree.

thank you, Joao!


-- 
Regards
Kefu Chai
