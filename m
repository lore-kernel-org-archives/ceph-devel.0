From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: ceph-disk vs keyvaluestore
Date: Thu, 2 Oct 2014 13:25:08 +0800
Message-ID: <CACJqLybowOLA9OLXRwzHvQW55UAeyd9aQ_foi1TG5GZ_k7ghKQ@mail.gmail.com>
References: <alpine.DEB.2.00.1409291645320.20141@cobra.newdream.net>
	<CACJqLyaY90afTC8UCn6jTOWNhJyvyGEaEwiou4S8_sX0hUnB6g@mail.gmail.com>
	<CACJqLyZpG7rPB1oi0jAxL2+B-xhRrWMg8oyFNqp10cm=+DmgLg@mail.gmail.com>
	<alpine.DEB.2.00.1409292103250.6593@cobra.newdream.net>
	<542C9264.9090300@catalyst.net.nz>
	<alpine.DEB.2.00.1410011650140.31126@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:46107 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbaJBFZJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Oct 2014 01:25:09 -0400
Received: by mail-wi0-f171.google.com with SMTP id em10so151069wid.10
        for <ceph-devel@vger.kernel.org>; Wed, 01 Oct 2014 22:25:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1410011650140.31126@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Oct 2, 2014 at 7:53 AM, Sage Weil <sweil@redhat.com> wrote:
> On Thu, 2 Oct 2014, Mark Kirkwood wrote:
>> On 30/09/14 17:05, Sage Weil wrote:
>> > On Tue, 30 Sep 2014, Haomai Wang wrote:
>> > > Hi sage,
>> > >
>> > > What do you think use existing ObjectStore::peek_journal_fsid
>> > > interface to detect whether journal needed.
>> > >
>> > > KeyValueStore and MemStore could set passing argument "fsid" to zero
>> > > to indicate no journal.
>> >
>> > I'm not sure it's a good fit... it's called on an existing store and tells
>> > you something about it.  I would probably expect a zeroed fsid to mean
>> > that the specified journal is empty or does not exist, not that it doesn't
>> > need to exist.
>> >
>> > What we need, on the other hand, is something that just tells us whether
>> > we should create a journal...
>> >
>> >
>>
>> And perhaps the "type" (probably not the right word) of journal:
>>
>> - filestore: device or filesystem
>> - rocksdb: filesystem (wal directory)
>> - leveldb: none (I think)
>
> Hmm, good point.  Haomai added this as yes/no, maybe 'none' and 'device'
> is a bit more flexible in case we add 'dir' in the future?

Looks good to me. Any other points?

>
>> FWIW, it looks like the log files for leveldb *could* benefit from being
>> placed somewhere else (e.g on faster storage). Is it worthwhile suggesting to
>> the leveldb devs?
>
> Worth a shot, but don't hold your breath :)
>
> sage



-- 
Best Regards,

Wheat
