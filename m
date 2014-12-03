From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Lock Constrains about Fast Dispatch for Messenger
Date: Wed, 3 Dec 2014 14:39:55 +0800
Message-ID: <CACJqLyaiYE_AwTfgNUY5FLM7FYYy5RP5u9JD+JVKfcNfH56ZQQ@mail.gmail.com>
References: <CACJqLyaf0QKHCxU4Pm877LLbZNwk30F7xdKdrrg1D0tOuShjGQ@mail.gmail.com>
	<CAPYLRzhrKOzAiW+vTFrL5h45uxC44Svehm_hU7+P8Y3uBAVtbA@mail.gmail.com>
	<CACJqLyafqtoerUcu8gkJSAMLPmKdG-0Yf=xTs-3paEq5sX-a=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:40550 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbaLCGj5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Dec 2014 01:39:57 -0500
Received: by mail-wi0-f179.google.com with SMTP id ex7so23327057wid.12
        for <ceph-devel@vger.kernel.org>; Tue, 02 Dec 2014 22:39:56 -0800 (PST)
In-Reply-To: <CACJqLyafqtoerUcu8gkJSAMLPmKdG-0Yf=xTs-3paEq5sX-a=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Another question:

we have "lossy", "server", "standy" and "resetcheck" as policy for
Messenger, but in practice there exists some overlap semantics among
these fields. For example, "server" and "standy" plays the same
function in Simple and Async impl. It will let connection standby if
losing connection. Maybe we can combine the two?

And "lossy" and "resetcheck" also seemed redundancy. If a connection
is lossy, we will want to reset the connection state. "resetcheck" is
mainly used when server accept  a connection and meets conflict, but
PR(https://github.com/ceph/ceph/pull/3070) remove this check, so it's
really useless in current impl.

So could we say that policy for Messenger only have two semantics
which are lossy or standy. "lossy" means connection will try to close
if aborting. and "standy" will let connection keep state in memory.


On Wed, Dec 3, 2014 at 10:21 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> Thanks!
>
> On Tue, Dec 2, 2014 at 11:03 PM, Gregory Farnum <greg@inktank.com> wrote:
>> On Tue, Dec 2, 2014 at 12:26 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
>>> Hi Gregoy and Sage,
>>>
>>> I'm just writing Messenger's unit tests to ensure that SimpleMessenger and
>>> AsyncMessenger behavior same and expected.
>>>
>>> I think the most unclear thing is the lock rule of fast dispatch. When
>>> introduced fast dispatch, there exists three methods "ms_fast_connect",
>>> "ms_fast_accept", "ms_fast_dispatch" will be called within Messenger's
>>> thread. Because without fast dispatcher all messages are delivered from
>>> queue to queue, fast path will result in potential dead lock I think.
>>>
>>> "ms_fast_accept" and "ms_fast_connect" are called with "pipe_lock"(Pipe) or
>>> "lock"(AsyncConnection). And Connection::send_message will called outsider.
>>> So it may happen:
>>>
>>> Other thread                   Messenger's thread
>>>        lock()                          connection lock()
>>>   send_message()                  connect
>>>  try connection lock()         ms_fast_connect()
>>>
>>>                           DEAD LOCK
>>
>> Sorry, which lock() is the "Other thread" calling? It's not like
>> anybody can access the Pipe's lock before it has been connect()ed.
>> Or perhaps you're referring to some kind of global lock that you're
>> worried ms_fast_connect() will try and access? In that case, yes, the
>> rules on locking within the Dispatcher *fast* functions are very
>> strict. We basically don't want any of them to take locks at all; in
>> the case of the OSD we don't quite manage that and have had to dance
>> through a number of hoops to avoid various tight races, but we're very
>> close.
>> -Greg
>
>
>
> --
> Best Regards,
>
> Wheat



-- 
Best Regards,

Wheat
