From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: payload of MPing
Date: Thu, 7 Sep 2017 09:53:10 +0100
Message-ID: <413e410d-5fee-7703-e788-a132b26f64c4@suse.de>
References: <CAJE9aONuZZeDut2boHFU-nWXstCqXEaSEHT+KfGE0xJqJm=SaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39410 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754068AbdIGIxM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 7 Sep 2017 04:53:12 -0400
In-Reply-To: <CAJE9aONuZZeDut2boHFU-nWXstCqXEaSEHT+KfGE0xJqJm=SaA@mail.gmail.com>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 09/07/2017 05:00 AM, kefu chai wrote:
> hey Joao,
> 
> while reviewing https://github.com/ceph/ceph/pull/17269, i found that
> there is no consumers of the payload of MPing replies. but apparently,
> we stuff it with the health status on purpose. do you happen to
> remember why we are doing so? if the feature/functionality depending
> on it is deprecated or removed or not implemented, probably we can
> just drop the logic to stuff the payload of MPing?

The only consumer, to date, and possibly ever until we (maybe) 
piggy-back on it for heartbeats, is the ceph tool.

We do consume that reply when we run `ceph ping mon.foo`. The interface 
is through RadosClient, all the way up to the Objecter, and eventually 
up the chain to the ceph tool.

Unless I'm misunderstanding what you're talking about?

   -Joao
