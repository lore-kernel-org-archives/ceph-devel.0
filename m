From: Casey Bodley <cbodley@redhat.com>
Subject: Re: seastar starting points
Date: Fri, 15 Dec 2017 12:07:37 -0500
Message-ID: <b9159d8a-d810-b2c2-f6a6-f9d2554ea7af@redhat.com>
References: <alpine.DEB.2.11.1712131629430.2838@piezo.novalocal>
 <0ebd9a80-e838-7a4f-81ee-f206f9c575ef@suse.com>
 <fc7d157d-6117-ab89-606c-656a9fa1585e@redhat.com>
 <CAJ4mKGYCJuxhKrdZT8L4o3Ya8yCdyCfqWyU3wMdwV5wWgdA8Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34165 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756067AbdLORHk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Dec 2017 12:07:40 -0500
Received: by mail-qk0-f174.google.com with SMTP id d66so11176778qkg.1
        for <ceph-devel@vger.kernel.org>; Fri, 15 Dec 2017 09:07:40 -0800 (PST)
In-Reply-To: <CAJ4mKGYCJuxhKrdZT8L4o3Ya8yCdyCfqWyU3wMdwV5wWgdA8Pw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Haomai Wang <haomai@xsky.com>



On 12/15/2017 11:01 AM, Gregory Farnum wrote:
> On Wed, Dec 13, 2017 at 5:31 PM, Casey Bodley <cbodley@redhat.com> wrote:
>> On 12/13/2017 11:42 AM, Ricardo Dias wrote:
>>>
>>>
>>> On 13-12-2017 16:34, Sage Weil wrote:
>>>> We had a great chat yesterday with Avi Kivity @ Scylla about seastar in
>>>> ceph, and were talking about where to start...  One candidate was to
>>>> carve
>>>> off the entire messenger and reimplement using seastar futures/promises.
>>>
>>> I don't think it's a good idea to start with the messenger since we are
>>> currently making a lot of changes to implement the new V2 protocol.
>>
>> This seastar messenger would only be used by the seastar-osd. The existing
>> messengers will still be used by everything else, so your work there is
>> valuable and shouldn't be impacted by the seastar project. Whether a new
>> messenger would want to target this v2 protocol from the start (and ignore
>> backward compatibility with v1 messengers) is an open question.
> I haven't dived into the code with an eye towards doing this (although
> I think Josh is about to), but the existing AsyncMessenger is already
> integrated with DPDK and relies on a state machine with thread pools
> dispatching messages independently. I'm pretty sure we'll be adapting
> that rather than writing another messenger from scratch. ;)

Cool. I haven't read through AsyncMessenger in-depth, so I wasn't sure 
how much of it we could reuse. I think it's important to have separate 
Messenger/Connection interfaces that expose futures to the application 
though. And ideally we'd be able to call into dpdk from seastar threads 
without requiring a separate thread pool.

Haomai, have you put any thought into how this could work?
