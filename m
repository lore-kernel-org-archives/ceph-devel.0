From: Casey Bodley <cbodley@redhat.com>
Subject: Re: seastar starting points
Date: Wed, 13 Dec 2017 12:06:28 -0500
Message-ID: <3ecedee5-4369-5f9a-81df-bd2cc66efe9a@redhat.com>
References: <alpine.DEB.2.11.1712131629430.2838@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f172.google.com ([74.125.82.172]:35322 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753311AbdLMRGc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Dec 2017 12:06:32 -0500
Received: by mail-ot0-f172.google.com with SMTP id q3so2555000oth.2
        for <ceph-devel@vger.kernel.org>; Wed, 13 Dec 2017 09:06:32 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1712131629430.2838@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org


On 12/13/2017 11:34 AM, Sage Weil wrote:
> We had a great chat yesterday with Avi Kivity @ Scylla about seastar in
> ceph, and were talking about where to start...  One candidate was to carve
> off the entire messenger and reimplement using seastar futures/promises.

I shared a branch a while ago that started on such a messenger. I didn't 
get very far in testing interop with existing Messengers, but the shape 
is there and it includes a unit test that can echo a message between two 
endpoints. See 
https://github.com/cbodley/ceph/tree/wip-seastar-msg/src/crimson/

> Another thought that is somewhat trivial but probably necessary and
> smallish is the log/ framework.  This might be a good test case for the
> legacy <-> seastar communications infrastructure.  It's all one-way, which
> simplifies things a bit, and the implementation should be pretty
> straightforward?
>
> I know we can't rely on the current debug stuff for
> tracing/instrumentation, but I don't think teh need for a debug log is
> going to go away.
>
> Another question is how the logger/perfcounters will need to change in a
> seastar world.

Yeah, there's a lot in CephContext that will need work. Agreed that the 
logging would be a good start, but the locking in md_config_t will be 
problematic too.

Casey
