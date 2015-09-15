From: Tianshan Qu <qutianshan@gmail.com>
Subject: Fwd: A new rados api set_client_priority
Date: Tue, 15 Sep 2015 21:13:10 +0800
Message-ID: <CAEv+sP5bqy2y_8CO4x1xsGAf4wYU1UbW68b0dJwRT5HRbhx1gg@mail.gmail.com>
References: <CAEv+sP6jsqAitvGnWxbtZdcFtof2V7NB_C583w2JZnOjf7T4EQ@mail.gmail.com>
	<CAJ4mKGbPCt4HnOJaB16AsZs8g-5gYpQgqDh+nsaDSq_YgZhrcw@mail.gmail.com>
	<CAEv+sP7aQ-xWH8hrrm=T2VBGQ2vRMd6jMEa4OR-w7L4Eog662g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34530 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbbIONNL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Sep 2015 09:13:11 -0400
Received: by ykdg206 with SMTP id g206so184235562ykd.1
        for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2015 06:13:11 -0700 (PDT)
In-Reply-To: <CAEv+sP7aQ-xWH8hrrm=T2VBGQ2vRMd6jMEa4OR-w7L4Eog662g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel@vger.kernel.org

sorry for forgot the ceph-devel, resend this.


2015-09-15 7:06 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
> On Thu, Sep 10, 2015 at 2:43 AM, =E7=9E=BF=E5=A4=A9=E5=96=84 <qutians=
han@gmail.com> wrote:
>> Hi,
>>   I'm working on the topic
>> <http://tracker.ceph.com/projects/ceph/wiki/Messenger_-_priorities_f=
or_Client>
>> , first step I add a new rados api set_client_priority, then I will =
do
>> more test to get the idea of how to balance the performance.
>>    code is in the pr <https://github.com/ceph/ceph/pull/5602>,
>> originally client read the config to get priority.
>>    Is the api ok?
>
> The API looks fine at first glance, but I continue to be concerned
> about exposing priorities like this. Right now they behave fairly
> oddly. For instance:
> 1) If you have multiple message priorities on the same client, the
> higher-priority ones always get sent out if there are any.
> 2) When receiving messages, the higher-priority ones in the queue are
> always delivered ahead of lower-priority ones
> 2b) ...unless the ms_fast_dispatch interface is involved (as with
> client<->OSD communication), in which case priority is ignored by the
> receiving messenger and it's just dispatched instantly.

we have consider these situations, so in future work we want to
redesign the queue,
to satisfy priority and fairness

> 3) The priority is used internally by the OSD for a proper tokenized
> delivery scheme.

in this situation, the high priority can not be processed first

>
> I think for QOS like this you're most interested in the third option,
> but simply setting message priority like this will also apply to the
> monitors and MDSes (and do potentially strange things!), and without
> guards on the results users could do stuff like set their priority to
> the max value and basically crowd out everybody else in the cluster.
> ...come to think of it, that's probably an attack they could do
> currently if they've got a RADOS key they control. But it's at least
> *difficult* to do accidentally since the interfaces generally aren't
> exposed. ;)
>
> So before merging something like this I'd like to see us have a more
> complete solution carved out:
> 0) Identify if we even want message priority and in-daemon processing
> priority to be conflated.

now the message and processing are using the same priority, is that
what you mean?

> 1) What does the messenger do? Make it as consistent as possible,
> probably with tokenization like the OSD has. (This won't be difficult
> code-wise as we're already using PrioritizedQueue, but we use the
> "strict" portion of it for all messages right now.) Make sure stuff
> doesn't break.

yes, messenger with tokenization queue may solve low priority's starvat=
ion,
I will test it with PrioritizedQueue.

> 2) Establish a way to specify different priorities for different
> daemons. Just because somebody gets faster data IO doesn't mean they
> get faster MDS access. Everybody should probably be equal to the
> monitors. ...and this is one of the things that the proposed API woul=
d
> need to be changed to support.

this is a good point, but I think we may first focus on the object &
block scene,
after fix those, we can think about the cephfs

> 3) Add capabilities support for specifying priority limits, along wit=
h
> a reasonable default. Check these on message receipt. (...and reject
> messages outside the bounds? Move them in-bounds?)
> -Greg

yes, we can specify some limits to satisfy different situation, after
test some workloads,
I will propose some.


In general, the api is convenient for future works' tests, we can mark
it experiment now, all consideration above will be my future work.
on the other hand, in the previous impl, client priority read from
ceph.conf, these problems will also take place. so I think it's a good
chance to fix these problems.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
