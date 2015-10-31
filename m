From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: Re: why we use two ObjectStore::Transaction in ReplicatedBackend::submit_transaction?
Date: Sat, 31 Oct 2015 21:30:50 +0800
Message-ID: <CANE=7sX3THWWN=i5EjUy0x9vJhdEL3Dj6vPQp1fV=U_ESdJgBw@mail.gmail.com>
References: <CANE=7sWNry9QYHkV=DK8NOudeU7UNNoRya8-be1BFiG=9YGn3g@mail.gmail.com>
	<alpine.DEB.2.00.1510310617240.19081@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:36474 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbbJaNav (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 31 Oct 2015 09:30:51 -0400
Received: by obdgf3 with SMTP id gf3so785574obd.3
        for <ceph-devel@vger.kernel.org>; Sat, 31 Oct 2015 06:30:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1510310617240.19081@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

the op_t items are encoded in issue_op, so after issue_op, we could
use it directly instead of local_t items?

2015-10-31 21:18 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Sat, 31 Oct 2015, ??? wrote:
>> hi, all:
>>
>>     There are two ObjectStore::Transaction in
>> ReplicatedBackend::submit_transaction, one is op_t and the other one
>> is local_t. Is that something
>>     critilal logic we should consider?
>>
>>     If we could reuse variable op_t it would be great. Because it is
>> expensive to calling local_t.append(*op_t).
>>
>>     There are similar logic in ReplicatedBackend::sub_op_modify_impl.
>
> The local_t items are only applied locally; the op_t items are encoded and
> sent over the wire to the replicas.
>
> If append() is expensive we should just refactor to avoid that.  IIRC I
> got partway down this path but apparently didn't finish.  The ObjectStore
> interface takes a list of transactions to apply, so I think it's just a
> matter of refactoring the interfaces a bit...?
>
> sage
>



-- 
Regards,
xinze
