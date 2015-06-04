From: Gregory Farnum <greg@gregs42.com>
Subject: Re: RBD journal draft design
Date: Thu, 4 Jun 2015 13:25:32 -0700
Message-ID: <CAC6JEv8v9Wzx094E5pReJE47=d2wbP8rR=FJcU+BNJcT7H488w@mail.gmail.com>
References: <1574383603.9391063.1433257824183.JavaMail.zimbra@redhat.com>
	<1346174854.9391994.1433257911870.JavaMail.zimbra@redhat.com>
	<CAC6JEv98=49tW0S4g=QiT28Pffdji=6S95J4aNLUXUDB2BEs+A@mail.gmail.com>
	<1679134333.10270211.1433348013379.JavaMail.zimbra@redhat.com>
	<CAC6JEv_M5jKk+FSDZja15Rmyf3W2x5-yeg9LRukKCHLnYq-j+w@mail.gmail.com>
	<1628237419.11058538.1433430488520.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35330 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085AbbFDUZe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Jun 2015 16:25:34 -0400
Received: by qgh73 with SMTP id 73so7628184qgh.2
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jun 2015 13:25:34 -0700 (PDT)
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com. [209.85.216.178])
        by mx.google.com with ESMTPSA id 139sm2932141qhx.22.2015.06.04.13.25.33
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jun 2015 13:25:33 -0700 (PDT)
Received: by qcxw10 with SMTP id w10so22529418qcx.3
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jun 2015 13:25:32 -0700 (PDT)
In-Reply-To: <1628237419.11058538.1433430488520.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jun 4, 2015 at 8:08 AM, Jason Dillaman <dillaman@redhat.com> wrote:
>> >> >A successful append will indicate whether or not the journal is now full
>> >> >(larger than the max object size), indicating to the client that a new
>> >> >journal object should be used.  If the journal is too large, an error
>> >> >code
>> >> >responce would alert the client that it needs to write to the current
>> >> >active journal object.  In practice, the only time the journaler should
>> >> >expect to see such a response would be in the case where multiple clients
>> >> >are using the same journal and the active object update notification has
>> >> >yet to be received.
>> >>
>> >> I'm confused. How does this work with the splay count thing you
>> >> mentioned above? Can you define <splay count>?
>> >
>> > Similar to the stripe width.
>>
>> Okay, that sort of makes sense but I don't see how you could legally
>> be writing to different "sets" so why not just make it an explicit
>> striping thing and move all journal entries for that "set" at once?
>>
>> ...Actually, doesn't *not* forcing a coordinated move from one object
>> set to another mean that you don't actually have an ordering guarantee
>> across tags if you replay the journal objects in order?
>
> The ordering between tags was meant to be a soft ordering guarantee (since any number of delays could throw off the actual order as delivered from the OS).  In the case of a VM using multiple RBD images sharing the same journal, this provides an ordering guarantee per device but not between devices.
>
> This is no worse than the case of each RBD image using its own journal instead of sharing a journal and the behavior doesn't seem too different from a non-RBD case when submitting requests to two different physical devices (e.g. a SSD device and a NAS device will commit data at different latencies).

Yes, it's exactly the same. But I thought the point was that if you
commingle the journals then you actually have the appropriate ordering
across clients/disks (if there's enough ordering and synchronization)
that you can stream the journal off-site and know that if there's any
kind of disaster you are always at least crash-consistent. If there's
arbitrary re-ordering of different volume writes at object boundaries
then I don't see what benefit there is to having a commingled journal
at all.

I think there's a thing called a "consistency group" in various
storage platforms that is sort of similar to this, where you can take
a snapshot of a related group of volumes at once. I presume the
commingled journal is an attempt at basically having an ongoing
snapshot of the whole consistency group.
-Greg
