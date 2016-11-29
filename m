From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] libceph: wake up sync waiter when unregistering request
Date: Tue, 29 Nov 2016 21:59:57 +0800
Message-ID: <B93E1ED2-557B-4414-AABC-42A47569D405@redhat.com>
References: <20161129114921.62964-1-zyan@redhat.com>
 <CAOi1vP8ieneOG-UhTysHNoOvoZ3_kcV_x7zqw9p3BSUpMLK_9Q@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756364AbcK2OAC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 29 Nov 2016 09:00:02 -0500
In-Reply-To: <CAOi1vP8ieneOG-UhTysHNoOvoZ3_kcV_x7zqw9p3BSUpMLK_9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


> On 29 Nov 2016, at 21:54, Ilya Dryomov <idryomov@gmail.com> wrote:
> 
> On Tue, Nov 29, 2016 at 12:49 PM, Yan, Zheng <zyan@redhat.com> wrote:
>> Current code does not wake up sync waiter if osd replies error
>> or the request does not want ondisk ack.
> 
> Hi Zheng,
> 
> Did you mean to write "and" instead of "or" - "if osd replies error
> *and* the request does not want ondisk ack”?

I mean ‘or’.  The code does not wake up sync waiter in either of these two cases.

> 
> Thanks,
> 
>                Ilya

