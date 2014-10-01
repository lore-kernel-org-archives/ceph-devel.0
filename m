From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: ceph-disk vs keyvaluestore
Date: Thu, 02 Oct 2014 12:46:44 +1300
Message-ID: <542C9264.9090300@catalyst.net.nz>
References: <alpine.DEB.2.00.1409291645320.20141@cobra.newdream.net> <CACJqLyaY90afTC8UCn6jTOWNhJyvyGEaEwiou4S8_sX0hUnB6g@mail.gmail.com> <CACJqLyZpG7rPB1oi0jAxL2+B-xhRrWMg8oyFNqp10cm=+DmgLg@mail.gmail.com> <alpine.DEB.2.00.1409292103250.6593@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:59582 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbaJAXqt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Oct 2014 19:46:49 -0400
In-Reply-To: <alpine.DEB.2.00.1409292103250.6593@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 30/09/14 17:05, Sage Weil wrote:
> On Tue, 30 Sep 2014, Haomai Wang wrote:
>> Hi sage,
>>
>> What do you think use existing ObjectStore::peek_journal_fsid
>> interface to detect whether journal needed.
>>
>> KeyValueStore and MemStore could set passing argument "fsid" to zero
>> to indicate no journal.
>
> I'm not sure it's a good fit... it's called on an existing store and tells
> you something about it.  I would probably expect a zeroed fsid to mean
> that the specified journal is empty or does not exist, not that it doesn't
> need to exist.
>
> What we need, on the other hand, is something that just tells us whether
> we should create a journal...
>
>

And perhaps the "type" (probably not the right word) of journal:

- filestore: device or filesystem
- rocksdb: filesystem (wal directory)
- leveldb: none (I think)

FWIW, it looks like the log files for leveldb *could* benefit from being 
placed somewhere else (e.g on faster storage). Is it worthwhile 
suggesting to the leveldb devs?

Cheers

Mark

