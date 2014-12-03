From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Lock Constrains about Fast Dispatch for Messenger
Date: Wed, 3 Dec 2014 10:21:02 +0800
Message-ID: <CACJqLyafqtoerUcu8gkJSAMLPmKdG-0Yf=xTs-3paEq5sX-a=A@mail.gmail.com>
References: <CACJqLyaf0QKHCxU4Pm877LLbZNwk30F7xdKdrrg1D0tOuShjGQ@mail.gmail.com>
	<CAPYLRzhrKOzAiW+vTFrL5h45uxC44Svehm_hU7+P8Y3uBAVtbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:40653 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaLCCVD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Dec 2014 21:21:03 -0500
Received: by mail-wi0-f170.google.com with SMTP id bs8so31828789wib.5
        for <ceph-devel@vger.kernel.org>; Tue, 02 Dec 2014 18:21:02 -0800 (PST)
In-Reply-To: <CAPYLRzhrKOzAiW+vTFrL5h45uxC44Svehm_hU7+P8Y3uBAVtbA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks!

On Tue, Dec 2, 2014 at 11:03 PM, Gregory Farnum <greg@inktank.com> wrote:
> On Tue, Dec 2, 2014 at 12:26 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
>> Hi Gregoy and Sage,
>>
>> I'm just writing Messenger's unit tests to ensure that SimpleMessenger and
>> AsyncMessenger behavior same and expected.
>>
>> I think the most unclear thing is the lock rule of fast dispatch. When
>> introduced fast dispatch, there exists three methods "ms_fast_connect",
>> "ms_fast_accept", "ms_fast_dispatch" will be called within Messenger's
>> thread. Because without fast dispatcher all messages are delivered from
>> queue to queue, fast path will result in potential dead lock I think.
>>
>> "ms_fast_accept" and "ms_fast_connect" are called with "pipe_lock"(Pipe) or
>> "lock"(AsyncConnection). And Connection::send_message will called outsider.
>> So it may happen:
>>
>> Other thread                   Messenger's thread
>>        lock()                          connection lock()
>>   send_message()                  connect
>>  try connection lock()         ms_fast_connect()
>>
>>                           DEAD LOCK
>
> Sorry, which lock() is the "Other thread" calling? It's not like
> anybody can access the Pipe's lock before it has been connect()ed.
> Or perhaps you're referring to some kind of global lock that you're
> worried ms_fast_connect() will try and access? In that case, yes, the
> rules on locking within the Dispatcher *fast* functions are very
> strict. We basically don't want any of them to take locks at all; in
> the case of the OSD we don't quite manage that and have had to dance
> through a number of hoops to avoid various tight races, but we're very
> close.
> -Greg



-- 
Best Regards,

Wheat
