From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: ./os/ObjectStore.h: 598: FAILED assert(op->oid < om.size())
Date: Tue, 20 Jan 2015 08:53:11 +0800
Message-ID: <CAMm-wcKcnHyGQoocC8mLXPU0+CzBZEZfEBRoqXK5+M7vR_G66g@mail.gmail.com>
References: <alpine.DEB.2.00.1501190739500.26676@cobra.newdream.net>
	<CAMm-wcLbqVoFZD81R=Sn7b0Q65U56bt1nxeot3VVr1QTV66uPw@mail.gmail.com>
	<CA+4uBUbLkOSZHL_QUVNTxenkQ_Xrn_es87JRdcr_ZXY-oC8i+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:39327 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbbATAxM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jan 2015 19:53:12 -0500
Received: by mail-vc0-f181.google.com with SMTP id kv19so3294128vcb.12
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jan 2015 16:53:11 -0800 (PST)
In-Reply-To: <CA+4uBUbLkOSZHL_QUVNTxenkQ_Xrn_es87JRdcr_ZXY-oC8i+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

If we must keep the order of local_t and op_t, I think the current
impl of append is not appropriate.

Maybe I must provide something like clone_append to avoid the modify
of existing data in the op_buffer, so the msg should be happy with the
new transaction format.

I will try this solution and give a patch as soon as possible.

On 20 January 2015 at 02:44, Samuel Just <sam.just@inktank.com> wrote:
> We actually found another problem with this series as well.
>
> http://tracker.ceph.com/issues/10534
>
> Looks like d427ca35404a30e1f428859c3274e030f2f83ef6 reversed the order
> of localt (which contains the create_collection) and op_t (which
> contains all of the operations on the object in the temp collection).
> We need the operations in localt to precede the operations in op_t.
> How do we do this?
> -Sam
>
> On Mon, Jan 19, 2015 at 8:07 AM, Dong Yuan <yuandong1222@gmail.com> wrote:
>> Yes, I am working on it since last week.
>>
>> This seems the same problem which I fix in the ReplicatedPG. So I try
>> to fix it following the same way which I did in the ReplicatedPG, but
>> it break the make_check test_erasure_code.sh.
>>
>> Now I am working on the test case, but unfortunately I am not familiar
>> with the impl of EC, so it will take me more time.
>>
>> On 19 January 2015 at 23:41, Sage Weil <sweil@redhat.com> wrote:
>>> Hi,
>>>
>>> This has come up a couple times in QA since we merged the fast transaction
>>> code.  Can you take a look?
>>>
>>>         http://tracker.ceph.com/issues/10517
>>>
>>> Ping me if it will help to get access to the test cluster.  Haomai has
>>> access, and you can get the logs via http (linked from pulpito.ceph.com),
>>> but it is less convenient.
>>>
>>> Thanks!
>>> sage
>>
>>
>>
>> --
>> Dong Yuan
>> Email:yuandong1222@gmail.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Dong Yuan
Email:yuandong1222@gmail.com
