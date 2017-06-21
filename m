From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: How best to integrate dmClock QoS library into ceph codebase
Date: Wed, 21 Jun 2017 10:38:32 -0700
Message-ID: <CAB7xdikG-Pc8DfX7VJv905ZdM8E8wXtfgw_4q693SeNnzDZ63g@mail.gmail.com>
References: <6D8EA95A-572E-4C71-A6AF-6BB8A6E8B26C@redhat.com>
 <CAF1ivSaa=06CGGJRNQ_9QO_wy6Wc5yK4zbNFiHJLnoJJiqrCSg@mail.gmail.com> <f08daf3b-751a-6887-fce0-f5ab38097af4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:34727 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdFURie (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Jun 2017 13:38:34 -0400
Received: by mail-ua0-f173.google.com with SMTP id z22so25377235uah.1
        for <ceph-devel@vger.kernel.org>; Wed, 21 Jun 2017 10:38:34 -0700 (PDT)
In-Reply-To: <f08daf3b-751a-6887-fce0-f5ab38097af4@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "J. Eric Ivancich" <ivancich@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

hi Eric,

we are pretty interested in your dmclock integration work with CEPH.
After reading your pull request, i am a little confusing.
May i ask if the setting in config such as
osd_op_queue_mclock_client_op_res functioning in your added dmclock's
queues and their enqueue and dequeue methods?
the below enqueue function insert request into a map<priority,
subqueue>, i guess for mclock_opclass queue, you set high priority for
client op and lower for scrub, recovery, etc.
Within each subqueue of same priority, did you do FIFO?

void enqueue_strict(K cl, unsigned priority, T item) override final {
    high_queue[priority].enqueue(cl, 0, item);
}

I am appreciated if you can provide some comments, especially if i
didn't understand correctly.

Thanks,
Sheng


On Tue, May 16, 2017 at 5:29 AM, J. Eric Ivancich <ivancich@redhat.com> wrote:
> On 05/15/2017 10:46 PM, Ming Lin wrote:
>> Hi Eric,
>>
>> Do you have any integration patches I can have a try?
> Hi Ming,
>
> The dmClock library became part of the master branch in early May.
>
> Also, two implementations of the dmClock QoS are in a pull request
> currently being reviewed:
>
>     https://github.com/ceph/ceph/pull/14997
>
> Eric
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
