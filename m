From: Victor Denisov <vdenisov@mirantis.com>
Subject: Re: blueprint: consistency groups
Date: Tue, 10 May 2016 09:25:57 -0700
Message-ID: <CA+hcxJTWZWUAUGr1gAZwEqLrGY9eJpzrF3+0H3wqaSjiY6-Faw@mail.gmail.com>
References: <CA+hcxJQqbi_oCMF+0=fgQ6-=W1k-KPw6Y_3pZZnXKe01=Z-dhQ@mail.gmail.com>
	<CAJ4mKGYHno0u4z8PkUz0gL9voeBPQCPP+TSroEQRy2+26H+WHQ@mail.gmail.com>
	<20160325071933.GA14634@gmail.com>
	<CAJ4mKGZHd1Bm558woz=2Agd-x7sDkQmarwQfZUkwSWAcmOb8ew@mail.gmail.com>
	<CA+hcxJS+-HsTKpbASkWqr-gR8N6zF1k-pyWh8eQZCCC7sHCiLg@mail.gmail.com>
	<CA+aFP1CnKvVJrWDmKhpziu5otOV73HC5gnUsgZ8+oDW+708Rag@mail.gmail.com>
	<CA+hcxJSnUg1grhdBgOQPRcPK57VyW2Nyg9Rv6whZ3rj1ZoGU_Q@mail.gmail.com>
	<CA+aFP1CPc-aExqfNL671Zr6ectLH9aUEScmKveBn8rPCmJDLtA@mail.gmail.com>
	<CA+hcxJTsPnVyF5Jvic+hDGgR=9CRZNzcwA6sAZzNxnm5x1J=kg@mail.gmail.com>
	<CA+aFP1C7me+-dbXVrMgU0Qs9fX8_4ocC9v5orzy+c8tK30y08A@mail.gmail.com>
	<CA+hcxJT4DWgt8K8hc27KbkJK=DRePM18Zh=GPxtfR5afoxVP1w@mail.gmail.com>
	<CA+hcxJQGcDy96o0f9sEY8HwLXng9YzxsoKAhaaCuCDDhVbN76A@mail.gmail.com>
	<CA+aFP1AQzo7bO=e-Gd_sAtBWSYFgvji8isxuXFKDejaHAA+FuA@mail.gmail.com>
	<CA+hcxJRMcJFxYdscdwyvowjw_dNF6xoNzCHT1=oaznwGqY-4Rw@mail.gmail.com>
	<CA+aFP1Awk0YZnW16JxOgfDeJFsuKPoN4jdrpr8dCdqUjhhD_Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35728 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbcEJQZ6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2016 12:25:58 -0400
Received: by mail-yw0-f171.google.com with SMTP id g133so16903109ywb.2
        for <ceph-devel@vger.kernel.org>; Tue, 10 May 2016 09:25:58 -0700 (PDT)
In-Reply-To: <CA+aFP1Awk0YZnW16JxOgfDeJFsuKPoN4jdrpr8dCdqUjhhD_Mw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Mykola Golub <mgolub@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

I was writing unit tests for create_cg function when I realized that
it wouldn't recover if we lost connection between
cls_client::dir_add_cg and create_cg object. If create_cg doesn't
happen then we are unable to repeat dir_add_cg.
However since I implemented create_cg operation after create_image
operation. create_image operation has the same issue.

So, my question is. Should I reimplement create_cg so that it can
recover from connection loss to the cluster or should I keep it the
same way create_image is implemented?

Also, what is more preferable big pull request for all components of
the feature - CRUD for consistency groups and snapshots, or split it
into smaller pull requests - first merge CRUD operations then
implement snapshots?

Thanks,
V.

On Tue, May 3, 2016 at 5:29 PM, Jason Dillaman <jdillama@redhat.com> wrote:
> You can use the explicit constructor of librados::Rados to convert
> from a librados::IoCtx [1].  Once you have the Rados object, use
> librados::Rados::ioctx_create2 to create a new librados::IoCtx [2].
> Here is the example from the snap unprotect state machine [3].
>
> [1] https://github.com/ceph/ceph/blob/master/src/include/rados/librados.hpp#L1145
> [2] https://github.com/ceph/ceph/blob/master/src/include/rados/librados.hpp#L1187
> [3] https://github.com/ceph/ceph/blob/master/src/librbd/operation/SnapshotUnprotectRequest.cc#L73
>
> On Tue, May 3, 2016 at 5:48 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>> Jason,
>>
>> Can you point me to a specific line of code where you reuse Rados?
>> I see that IoCtx only has reference to RadosClient not to Rados itself.
>>
>> On Tue, May 3, 2016 at 5:05 AM, Jason Dillaman <jdillama@redhat.com> wrote:
>>> On Mon, May 2, 2016 at 8:26 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>>>> As such, I can't open another ioctx when I'm already inside rbd
>>>> class.
>>>
>>> You actually can open a new IoCtx against a new pool -- we do this
>>> internally for journaling handling, scanning pools for children during
>>> the snapshot unprotect operation, opening a parent image of a clone,
>>> etc.   You can extract the "librados::Rados" object from the
>>> "librados::IoCtx" and then use "librados::Rados::ioctx_create2" to
>>> create a new IoCtx by pool id.
>>>
>>> Also agree with Mykola in that the API should return resolved image names.
>>>
>>> --
>>> Jason
>
>
>
> --
> Jason
