From: YuShengzuo <yu.shengzuo@99cloud.net>
Subject: Re: A force promote image remain locked after primary down.
Date: Sat, 29 Jul 2017 15:25:39 +0800
Message-ID: <597F2775-F370-41DC-9442-7EC67A21444E@99cloud.net>
References: <78608BF7-FC3F-441F-9A0C-E16F439CDB8C@99cloud.net>
 <CA+aFP1Cm+h0vz4MVn5shki_9YRuEhjzJgVkz7rE8CotuMjTd+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr21361.mail.yeah.net ([223.252.213.61]:54012 "EHLO
        mr21361.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbdG2HXk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 29 Jul 2017 03:23:40 -0400
In-Reply-To: <CA+aFP1Cm+h0vz4MVn5shki_9YRuEhjzJgVkz7rE8CotuMjTd+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Thanks , I will try new release.

On 28/07/2017, 7:35 PM, "Jason Dillaman" <ceph-devel-owner@vger.kernel.org on behalf of jdillama@redhat.com> wrote:

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
    --
    To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
    the body of a message to majordomo@vger.kernel.org
    More majordomo info at  http://vger.kernel.org/majordomo-info.html
    



