From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: seastar starting points
Date: Fri, 15 Dec 2017 16:01:07 +0000
Message-ID: <CAJ4mKGYCJuxhKrdZT8L4o3Ya8yCdyCfqWyU3wMdwV5wWgdA8Pw@mail.gmail.com>
References: <alpine.DEB.2.11.1712131629430.2838@piezo.novalocal>
 <0ebd9a80-e838-7a4f-81ee-f206f9c575ef@suse.com> <fc7d157d-6117-ab89-606c-656a9fa1585e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:46892 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932247AbdLOQBJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Dec 2017 11:01:09 -0500
Received: by mail-it0-f65.google.com with SMTP id t1so20526539ite.5
        for <ceph-devel@vger.kernel.org>; Fri, 15 Dec 2017 08:01:09 -0800 (PST)
In-Reply-To: <fc7d157d-6117-ab89-606c-656a9fa1585e@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Ricardo Dias <rdias@suse.com>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Dec 13, 2017 at 5:31 PM, Casey Bodley <cbodley@redhat.com> wrote:
>
> On 12/13/2017 11:42 AM, Ricardo Dias wrote:
>>
>>
>>
>> On 13-12-2017 16:34, Sage Weil wrote:
>>>
>>> We had a great chat yesterday with Avi Kivity @ Scylla about seastar in
>>> ceph, and were talking about where to start...  One candidate was to
>>> carve
>>> off the entire messenger and reimplement using seastar futures/promises.
>>
>>
>> I don't think it's a good idea to start with the messenger since we are
>> currently making a lot of changes to implement the new V2 protocol.
>
>
> This seastar messenger would only be used by the seastar-osd. The existing
> messengers will still be used by everything else, so your work there is
> valuable and shouldn't be impacted by the seastar project. Whether a new
> messenger would want to target this v2 protocol from the start (and ignore
> backward compatibility with v1 messengers) is an open question.

I haven't dived into the code with an eye towards doing this (although
I think Josh is about to), but the existing AsyncMessenger is already
integrated with DPDK and relies on a state machine with thread pools
dispatching messages independently. I'm pretty sure we'll be adapting
that rather than writing another messenger from scratch. ;)

By the same token, I wouldn't worry much about work there conflicting
with protocol v2 unless we actually see it causing issues, since
seastar will be about adapting the state interfaces, and msgr2 will be
adding new ones.
-Greg
