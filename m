From: Ming Lin <minggr@gmail.com>
Subject: Re: Fwd: question about snapset
Date: Sun, 5 Feb 2017 15:28:41 -0800
Message-ID: <CAF1ivSZ4Bke6zHZGZs9BSpcZAGzpSHAwnFpXQoHSrJSEBzNkjg@mail.gmail.com>
References: <CAB7xdi=b=HxAepvKna-Rfi9z9Wd+SAxADsbZUkYk-TuEkYJnjA@mail.gmail.com>
 <alpine.DEB.2.11.1702031359260.3660@piezo.novalocal> <CAB7xdi=NFjC4W3XYSLPYFrs_vN18+TY-5F_UGzCe_TCweYHxdg@mail.gmail.com>
 <CAB7xdikDAtXL6UGzRjKVa6Vzv9QE6if3ixteYu-UApRfMYVOXw@mail.gmail.com> <alpine.DEB.2.11.1702031803520.3654@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36173 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751931AbdBEX2n (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Feb 2017 18:28:43 -0500
Received: by mail-it0-f68.google.com with SMTP id f200so7001487itf.3
        for <ceph-devel@vger.kernel.org>; Sun, 05 Feb 2017 15:28:43 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1702031803520.3654@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: sheng qiu <herbert1984106@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Feb 3, 2017 at 10:07 AM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 3 Feb 2017, sheng qiu wrote:
>> ---------- Forwarded message ----------
>> From: sheng qiu <herbert1984106@gmail.com>
>> Date: Fri, Feb 3, 2017 at 7:45 AM
>> Subject: Re: question about snapset
>> To: Sage Weil <sage@newdream.net>
>> Cc: ceph-devel <ceph-devel@vger.kernel.org>
>>
>>
>> Hi Sage,
>>
>> Thanks a lot for your reply. It's very helpful.
>> We are trying to avoid the query for snapset object for new object
>> write, we think it may save some latency. Currently when we measure
>> the op prepare latency, it's around 300 us, which is quite high. Is
>> this normal? In our test, we configure 64 pgs per osd and use five
>> shards with two workers per shard. The test machine is a four socket
>> with 40 cores and plenty of memory.
>> We are thinking how to reduce this latency, do you have any suggestions?
>
> There are several sources, and this is an active area of
> investigation and optimization.  I'm not sure that the snapset
> specifically is probably a big part of the problem.. it's like the overall
> work involved with get_object_context(), which will fetch the
> attributes from the object.  The snapset will be a small part of this.
>
> I suggest joining the weekly performance call if you can.  Or we can
> discuss some of the specific efforts on the list.  The main efforts here
> are
>
> - simplifying ms_fast_dispatch so that incoming messages get queued more
> quickly

Look at below call stack.
Could you share more detail which parts to simplify?

(gdb) bt
#0  PG::queue_op ()
#1  OSD::enqueue_op ()
#2  OSD::handle_op ()
#3  OSD::dispatch_op_fast ()
#4  OSD::dispatch_session_waiting ()
#5  OSD::ms_fast_dispatch ()
#6  Messenger::ms_fast_dispatch ()
#7  DispatchQueue::fast_dispatch ()
#8  AsyncConnection::process ()
#9  EventCenter::process_events ()
#10 NetworkStack::<lambda()>::operator()
#12 start_thread ()
#13 clone ()
