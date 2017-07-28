From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: BUG: A force promote image remain locked after primary down.
Date: Fri, 28 Jul 2017 07:35:19 -0400
Message-ID: <CA+aFP1Cm+h0vz4MVn5shki_9YRuEhjzJgVkz7rE8CotuMjTd+A@mail.gmail.com>
References: <78608BF7-FC3F-441F-9A0C-E16F439CDB8C@99cloud.net>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35721 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbdG1LfU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Jul 2017 07:35:20 -0400
Received: by mail-yw0-f181.google.com with SMTP id l82so63829262ywc.2
        for <ceph-devel@vger.kernel.org>; Fri, 28 Jul 2017 04:35:20 -0700 (PDT)
In-Reply-To: <78608BF7-FC3F-441F-9A0C-E16F439CDB8C@99cloud.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: YuShengzuo <yu.shengzuo@99cloud.net>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

You are most likely seeing this issue [1] where hung threads
associated with the unreachable remote cluster are preventing the
rbd-mirror daemon from releasing the image's lock on the local
cluster. It has hopefully been resolved as part of Luminous but it
isn't a good candidate for backport given all the associated changes
it depends upon.


[1] http://tracker.ceph.com/issues/18963

On Fri, Jul 28, 2017 at 3:36 AM, YuShengzuo <yu.shengzuo@99cloud.net> wrote:
> HI all,
>
>
>
> env: CentOS 7.2
> ceph: jewel-10.2.9
>
>
>
> A image created in primary cluster, and replicated in secondary cluster by
> rbd-mirror
>
> When the primary cluster crash or shutdown, I do promote image in secondary
> with '--force'
> the image still can't read or write.
>
>
>
> So I have to restart rbd-mirror daemon in secondary, it can work.
>
>
>
> Does anyone have any better method to solved it ?
>
>
>
> Yu Shengzuo
>
>



-- 
Jason
