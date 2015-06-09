From: Gregory Farnum <greg@gregs42.com>
Subject: Re: RBD journal draft design
Date: Tue, 9 Jun 2015 11:32:08 -0700
Message-ID: <CAC6JEv-RnsXqYZ215WZHcy8Fhyz2H7PPEJSjWVfj4P=gnTCP2A@mail.gmail.com>
References: <1574383603.9391063.1433257824183.JavaMail.zimbra@redhat.com>
	<1346174854.9391994.1433257911870.JavaMail.zimbra@redhat.com>
	<CAC6JEv98=49tW0S4g=QiT28Pffdji=6S95J4aNLUXUDB2BEs+A@mail.gmail.com>
	<1679134333.10270211.1433348013379.JavaMail.zimbra@redhat.com>
	<CAC6JEv_M5jKk+FSDZja15Rmyf3W2x5-yeg9LRukKCHLnYq-j+w@mail.gmail.com>
	<1628237419.11058538.1433430488520.JavaMail.zimbra@redhat.com>
	<CAC6JEv8v9Wzx094E5pReJE47=d2wbP8rR=FJcU+BNJcT7H488w@mail.gmail.com>
	<810657134.11416115.1433464573115.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34697 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbbFITB2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jun 2015 15:01:28 -0400
Received: by igbhj9 with SMTP id hj9so19547822igb.1
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jun 2015 12:01:27 -0700 (PDT)
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com. [209.85.213.174])
        by mx.google.com with ESMTPSA id t7sm1653975ign.8.2015.06.09.11.32.11
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 11:32:11 -0700 (PDT)
Received: by igbzc4 with SMTP id zc4so18203454igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jun 2015 11:32:11 -0700 (PDT)
In-Reply-To: <810657134.11416115.1433464573115.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jun 4, 2015 at 5:36 PM, Jason Dillaman <dillaman@redhat.com> wrote:
>> >> ...Actually, doesn't *not* forcing a coordinated move from one object
>> >> set to another mean that you don't actually have an ordering guarantee
>> >> across tags if you replay the journal objects in order?
>> >
>> > The ordering between tags was meant to be a soft ordering guarantee (since
>> > any number of delays could throw off the actual order as delivered from
>> > the OS).  In the case of a VM using multiple RBD images sharing the same
>> > journal, this provides an ordering guarantee per device but not between
>> > devices.
>> >
>> > This is no worse than the case of each RBD image using its own journal
>> > instead of sharing a journal and the behavior doesn't seem too different
>> > from a non-RBD case when submitting requests to two different physical
>> > devices (e.g. a SSD device and a NAS device will commit data at different
>> > latencies).
>>
>> Yes, it's exactly the same. But I thought the point was that if you
>> commingle the journals then you actually have the appropriate ordering
>> across clients/disks (if there's enough ordering and synchronization)
>> that you can stream the journal off-site and know that if there's any
>> kind of disaster you are always at least crash-consistent. If there's
>> arbitrary re-ordering of different volume writes at object boundaries
>> then I don't see what benefit there is to having a commingled journal
>> at all.
>>
>> I think there's a thing called a "consistency group" in various
>> storage platforms that is sort of similar to this, where you can take
>> a snapshot of a related group of volumes at once. I presume the
>> commingled journal is an attempt at basically having an ongoing
>> snapshot of the whole consistency group.
>
> Seems like even with a SAN-type consistency group, you could still have temporal ordering issues between volume writes unless it synchronized with the client OSes to flush out all volumes at a consistent place so that the snapshot could take place.
>
> I suppose you could provide much tighter QEMU inter-volume ordering guarantees if you modified the RBD block device so that each individual RBD image instance was provided a mechanism to coordinate the allocation of the sequence number between the images.  Right now, each image is opened in its own context w/ no knowledge of one another and no way to coordinate.  The current proposed tag + sequence number approach could be used to provide the soft inter-volume ordering guarantees until QEMU / librbd could be modified to support volume groupings.

I must not be being clear. Tell me if this scenario is possible:

* Client A writes to file foo many times and it is journaled to object set 1.
* Client B writes to file bar many times and it starts journaling to
object set 1, but hits the end and moves on to object set 2.
* Client A hits a synchronization point in its higher-level logic.
* Client A fsyncs file foo to object set 1 and then
* Client B hits the synchronization point, fsyncs file bar to object
set 2, and sends data back to Client A.
* Client A fsyncs the receipt of its data stream to object set 1, and
only then gets sent on to object set 2.
* The journal copier runs and migrates object set 1 to a remote data
center, then the data center explodes.
* In the remote data center they fail over and client A thinks it has
reached a synchronization point and gotten an acknowledgement that
client B has never heard of.

Does that being a problem make sense? I don't think handling it is
overly complicated and it's kind of important.
-Greg
