From: Ning Yao <zay11022@gmail.com>
Subject: Re: why we use two ObjectStore::Transaction in ReplicatedBackend::submit_transaction?
Date: Sat, 31 Oct 2015 23:34:55 +0800
Message-ID: <CALZt5jwEocBc2uqvec11ynWVWu=M=pG5wZSw_quFBVoaCgZcZQ@mail.gmail.com>
References: <CANE=7sWNry9QYHkV=DK8NOudeU7UNNoRya8-be1BFiG=9YGn3g@mail.gmail.com>
	<alpine.DEB.2.00.1510310617240.19081@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34904 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbbJaPe4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 31 Oct 2015 11:34:56 -0400
Received: by wmll128 with SMTP id l128so31573234wml.0
        for <ceph-devel@vger.kernel.org>; Sat, 31 Oct 2015 08:34:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1510310617240.19081@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yeah, since issue_op is called before log_operation, we may consider
to reuse op_t after sent encoded op_t to the wire. local_t.append(),
at least, does copy the op_bl in op_t transaction and we may avoid
this memory copy, and if we can avoid this append operation as well as
in sub_op_modify_impl(), it, at least, improves the performance 1%~2%
under my testing environment using ssd as Filestore backend.
The only difference we find in this path is that local_t should be
done first, but actually it seems that the order of the transaction is
not quite important. If so, we may refactor and improve this?
Regards
Ning Yao


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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
