From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Lock Constrains about Fast Dispatch for Messenger
Date: Thu, 4 Dec 2014 10:34:10 +0800
Message-ID: <CACJqLyaXaPFzUuCUP57TvikiVKwAVt93mrOXL9Ff+p8Y1BpfEQ@mail.gmail.com>
References: <CACJqLyaf0QKHCxU4Pm877LLbZNwk30F7xdKdrrg1D0tOuShjGQ@mail.gmail.com>
	<CAPYLRzhrKOzAiW+vTFrL5h45uxC44Svehm_hU7+P8Y3uBAVtbA@mail.gmail.com>
	<CACJqLyafqtoerUcu8gkJSAMLPmKdG-0Yf=xTs-3paEq5sX-a=A@mail.gmail.com>
	<CACJqLyaiYE_AwTfgNUY5FLM7FYYy5RP5u9JD+JVKfcNfH56ZQQ@mail.gmail.com>
	<CAPYLRzg2yfpt3ZCECY8104BNYHAA-pvfffQ73Dy_Trs1vHErmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33755 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbaLDCeL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Dec 2014 21:34:11 -0500
Received: by mail-wi0-f170.google.com with SMTP id bs8so34842996wib.3
        for <ceph-devel@vger.kernel.org>; Wed, 03 Dec 2014 18:34:10 -0800 (PST)
In-Reply-To: <CAPYLRzg2yfpt3ZCECY8104BNYHAA-pvfffQ73Dy_Trs1vHErmw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Dec 4, 2014 at 1:32 AM, Gregory Farnum <greg@inktank.com> wrote:
> On Tue, Dec 2, 2014 at 10:39 PM, Haomai Wang <haomaiwang@gmail.com> wrote:
>> Another question:
>>
>> we have "lossy", "server", "standy" and "resetcheck" as policy for
>> Messenger, but in practice there exists some overlap semantics among
>> these fields. For example, "server" and "standy" plays the same
>> function in Simple and Async impl. It will let connection standby if
>> losing connection. Maybe we can combine the two?
>
> I think you're missing some uses of these. "Servers" will never
> initiate a reconnect to the other endpoint, but they can go into
> standby and queue up new messages for if a reconnect does happen.

OK. I missed it that if a client set policy.standby, it also can make
itself standby.

>
>> And "lossy" and "resetcheck" also seemed redundancy. If a connection
>> is lossy, we will want to reset the connection state. "resetcheck" is
>> mainly used when server accept  a connection and meets conflict, but
>> PR(https://github.com/ceph/ceph/pull/3070) remove this check, so it's
>> really useless in current impl.
>
> Not quite. The PR removes one of the resetcheck gates, but there are
> two of them. :) If you look at the commit which added resetcheck
> you'll see that it's about some peer connection races, but again lossy
> is used in a lot of other places orthogonal to resetcheck.

Hmm, I got it.

> -Greg



-- 
Best Regards,

Wheat
