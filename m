From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: ceph-disk vs keyvaluestore
Date: Tue, 30 Sep 2014 12:00:35 +0800
Message-ID: <CACJqLyZpG7rPB1oi0jAxL2+B-xhRrWMg8oyFNqp10cm=+DmgLg@mail.gmail.com>
References: <alpine.DEB.2.00.1409291645320.20141@cobra.newdream.net>
	<CACJqLyaY90afTC8UCn6jTOWNhJyvyGEaEwiou4S8_sX0hUnB6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:40023 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbaI3EAg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Sep 2014 00:00:36 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so5458566wgh.34
        for <ceph-devel@vger.kernel.org>; Mon, 29 Sep 2014 21:00:35 -0700 (PDT)
In-Reply-To: <CACJqLyaY90afTC8UCn6jTOWNhJyvyGEaEwiou4S8_sX0hUnB6g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mark Kirkwood <mark.kirkwood@catalyst.net.nz>

Hi sage,

What do you think use existing ObjectStore::peek_journal_fsid
interface to detect whether journal needed.

KeyValueStore and MemStore could set passing argument "fsid" to zero
to indicate no journal.

On Tue, Sep 30, 2014 at 10:23 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> No problem, I would like do it.
>
> On Tue, Sep 30, 2014 at 7:48 AM, Sage Weil <sweil@redhat.com> wrote:
>> Hi Haomai,
>>
>> Not sure if you saw
>>
>>         http://tracker.ceph.com/issues/9580
>>
>> which came from an issue Mark had getting ceph-disk to work with the
>> keyvaluestore backend.  I think the answer is to make a command
>> like
>>
>>         ceph-osd -i 123 --check-needs-journal
>>
>> to query whether the configured backend wants a journal backend.  That
>> would let ceph-disk skip the work.  Would need to be careful to
>> distinguish between errors and a true/false answer.
>>
>> Any interest in wiring that up?
>> sage
>>
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
