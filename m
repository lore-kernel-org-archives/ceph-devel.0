From: Samuel Just <sam.just@inktank.com>
Subject: Re: ./os/ObjectStore.h: 598: FAILED assert(op->oid < om.size())
Date: Mon, 19 Jan 2015 10:44:26 -0800
Message-ID: <CA+4uBUbLkOSZHL_QUVNTxenkQ_Xrn_es87JRdcr_ZXY-oC8i+w@mail.gmail.com>
References: <alpine.DEB.2.00.1501190739500.26676@cobra.newdream.net>
	<CAMm-wcLbqVoFZD81R=Sn7b0Q65U56bt1nxeot3VVr1QTV66uPw@mail.gmail.com>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:44966 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbbASSo2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jan 2015 13:44:28 -0500
Received: by mail-lb0-f170.google.com with SMTP id 10so29532597lbg.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jan 2015 10:44:26 -0800 (PST)
In-Reply-To: <CAMm-wcLbqVoFZD81R=Sn7b0Q65U56bt1nxeot3VVr1QTV66uPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dong Yuan <yuandong1222@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

We actually found another problem with this series as well.

http://tracker.ceph.com/issues/10534

Looks like d427ca35404a30e1f428859c3274e030f2f83ef6 reversed the order
of localt (which contains the create_collection) and op_t (which
contains all of the operations on the object in the temp collection).
We need the operations in localt to precede the operations in op_t.
How do we do this?
-Sam

On Mon, Jan 19, 2015 at 8:07 AM, Dong Yuan <yuandong1222@gmail.com> wrote:
> Yes, I am working on it since last week.
>
> This seems the same problem which I fix in the ReplicatedPG. So I try
> to fix it following the same way which I did in the ReplicatedPG, but
> it break the make_check test_erasure_code.sh.
>
> Now I am working on the test case, but unfortunately I am not familiar
> with the impl of EC, so it will take me more time.
>
> On 19 January 2015 at 23:41, Sage Weil <sweil@redhat.com> wrote:
>> Hi,
>>
>> This has come up a couple times in QA since we merged the fast transaction
>> code.  Can you take a look?
>>
>>         http://tracker.ceph.com/issues/10517
>>
>> Ping me if it will help to get access to the test cluster.  Haomai has
>> access, and you can get the logs via http (linked from pulpito.ceph.com),
>> but it is less convenient.
>>
>> Thanks!
>> sage
>
>
>
> --
> Dong Yuan
> Email:yuandong1222@gmail.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
