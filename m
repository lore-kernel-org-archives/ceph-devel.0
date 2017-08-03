From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Re: About RADOS level replication
Date: Thu, 3 Aug 2017 09:04:34 +0800
Message-ID: <CAJACTudB8QV1NGbTWJvwPR=WBe_6KSKAad8K=z90XhR7s88GHA@mail.gmail.com>
References: <CAJACTueZvpoPB96zcz5mRVSNUYtVLEHxfBERV1J+zPx6WTkAqQ@mail.gmail.com>
 <CAJACTufvJSxmUM84FmseBA=5VB8ZhjSkgY3ACJo7=oZ2Zy59sw@mail.gmail.com> <CAJACTudewhYi7MQN=aaGNYKy_MEXd9nwQQ1zkGueAZU_n4T2Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36470 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbdHCBEf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Aug 2017 21:04:35 -0400
Received: by mail-oi0-f42.google.com with SMTP id g131so60155553oic.3
        for <ceph-devel@vger.kernel.org>; Wed, 02 Aug 2017 18:04:34 -0700 (PDT)
In-Reply-To: <CAJACTudewhYi7MQN=aaGNYKy_MEXd9nwQQ1zkGueAZU_n4T2Eg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Joao Eduardo Luis <joao@suse.de>, ceph-devel <ceph-devel@vger.kernel.org>

By the way, the advice that you give during the CDM was very
important, we'll adjust our plan based on those advice.

Thanks:-)
And apologize again.

On 3 August 2017 at 08:57, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
> We didn't consider condition 2 so detailed before the CDM.
>
> I think I was just mistakenly confused about the things we considered
> before the CDM and that we discussed during the CDM, and mistakenly
> thought we considered some details, which we didn't actually, before
> the CDM.
>
> I'm really sorry about this.
>
> Please forgive me. I'm really sorry
>
> On 3 August 2017 at 08:34, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>> Um.... Sorry, I just read my algorithm 17 again, it seems that it
>> doesn't have condition 2......
>>
>> I think I just got things confused, it was 04:00 AM and I was really
>> sleepy then. Please forgive me.
>>
>> I'll add this into that algorithm. Really sorry.
>>
>> On 3 August 2017 at 04:05, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>>> Hi, Sage and Joao
>>>
>>> I think there were something I didn't make clear just now, sorry.
>>>
>>> About the second issue, by "insuring consistency of cross-object
>>> operations", I mean:
>>>
>>>      Say, a rbd write X involves two rados object A and B, and turn
>>> them into A1 and B1 respectively, and a following rbd write Y turn
>>> them in to A2 and B2, when these two operations are replicated, the
>>> result on the backup cluster can't be A1, B2 or A2, B1.
>>>
>>> So, just like Joao said, this is all about ORDERING.
>>>
>>> My approach is like this: since RADOS can guarantee the order of OPs
>>> coming from the same client and targeting the same object, we make
>>> "repop"s within the same rbd operation forwarded to the same
>>> intermediate node, and intermediate node forward these "repop"s to the
>>> backup cluster on two conditions: 1) all "repop"s within the same rbd
>>> operation arrived at the intermediate node; 2) all rbd operations, the
>>> id of which are less than that of the current rbd operation(the id is
>>> a monotonously increasing integer that uniquely identifies a rbd
>>> operation, the order of the id indicates the order they are created by
>>> the librbd client), are sent to the backup cluster(not replicated, or
>>> "ondisk" on the backup cluster).
>>>
>>> With these two constrains, I think we can insure the order of rbd
>>> operations. The first condition makes sure that all "repop"s are all
>>> sent to the backup cluster, or none of them are sent, which can insure
>>> the consistency of the resulting rbd image if the master cluster
>>> crashes when only part of a rbd operation are forwarded to the
>>> intermediate node. The second condition can make sure that rbd
>>> operations are replicated to the backup cluster in the order that they
>>> are created by librbd clients. And since RADOS can guarantee the order
>>> of OPs coming from the same client and targeting the same object, we
>>> don't have to replicate a rbd operation after its ancestor is
>>> replicated, only after it's issued to the backup cluster is enough. I
>>> think this should be able to preserve the throughput of the
>>> inter-cluster replication procedure.
>>>
>>> The detail of this approach is shown in Algorithm 17.
>>>
>>> And since we are implementing this at the RADOS level, we shouldn't
>>> directly process "rbd" operations here. So, I think we should involve
>>> the concept "object set" to adapt to the concepts of the upper level
>>> system like "rbd image".
>>>
>>> I don't know if I'm considering this in the right way, and I'm looking
>>> forward to your opinion. Thanks very much:-)
