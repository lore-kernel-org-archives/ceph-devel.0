From: Samuel Just <sam.just@inktank.com>
Subject: =?UTF-8?Q?Re=3A_=CE=99nstrumenting_RADOS_with_Zipkin_=2B_LTTng?=
Date: Wed, 13 Aug 2014 14:21:40 -0700
Message-ID: <CA+4uBUZhP7wNDoJn6rGSvqCZ1HVnd_6hoihcBK-+9Ui8VxoCxA@mail.gmail.com>
References: <CACDi=KpbvTNNEL-59Fej9rvShO9HOdsEPDueTD4uw9nWOYaByg@mail.gmail.com>
	<CA+4uBUYSM3n-3DcuHuHDA-CarXp5vx0s7JmyTVSGqerpLGGe1g@mail.gmail.com>
	<CA+4uBUaV_W0x5vV7SS0xBGnWfDRLa6OAd25NYWsEc0vOp3+c7A@mail.gmail.com>
	<CAFu9Dv1Aqsf69=fXGZ1QjgQuvmXyaDGX0vk91MAT=6QuWznXDw@mail.gmail.com>
	<CACDi=KosXL9L9WjHPw-f-2hZ6DpWbCbX+rSLmVyg7h1jm5cRGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:57258 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbaHMVVm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Aug 2014 17:21:42 -0400
Received: by mail-qg0-f52.google.com with SMTP id f51so316452qge.11
        for <ceph-devel@vger.kernel.org>; Wed, 13 Aug 2014 14:21:41 -0700 (PDT)
In-Reply-To: <CACDi=KosXL9L9WjHPw-f-2hZ6DpWbCbX+rSLmVyg7h1jm5cRGw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marios-Evaggelos Kogias <marioskogias@gmail.com>
Cc: Adam Crume <adamcrume@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Vangelis Koukis <vkoukis@grnet.gr>, Constantinos Venetsanopoulos <cven@grnet.gr>, Filippos Giannakos <philipgian@grnet.gr>

Would you be interested in trying to submit a cleaned up version of
the branch as a pull request?  That would make it easier to get it
into a merge-able state.
-Sam

On Tue, Aug 5, 2014 at 9:22 AM, Marios-Evaggelos Kogias
<marioskogias@gmail.com> wrote:
> 2014-08-02 0:00 GMT+03:00 Adam Crume <adamcrume@gmail.com>:
>> I've been assuming the code is at
>> https://github.com/marioskogias/ceph/tree/feature-blkin, in which case
>> the diff is attached.  I computed the diff using:
>> git diff $(git merge-base marioskogias/feature-blkin ceph/master)
>> marioskogias/feature-blkin
>>
>
> Exactly, this is the repo with the Ceph code changes.
> Indeed we updated it so as it has the latest code producing the output shown in
> the screenshot which was attached in the previous mail.
>
> Marios
>
>> On Fri, Aug 1, 2014 at 1:24 PM, Samuel Just <sam.just@inktank.com> wrote:
>>> I'm probably missing something, is there supposed to be a [6] with
>>> your ceph changes?
>>> -Sam
>>>
>>> On Fri, Aug 1, 2014 at 1:17 PM, Samuel Just <sam.just@inktank.com> wrote:
>>>> Reading!
>>>> -Sam
>>>>
>>>> On Fri, Aug 1, 2014 at 9:28 AM, Marios-Evaggelos Kogias
>>>> <marioskogias@gmail.com> wrote:
>>>>> Hello all,
>>>>>
>>>>> my name is Marios Kogias and I am a student at the National Technical
>>>>> University of Athens. As part of my diploma thesis and my participation in
>>>>> Google Summer of Code 2014 (in the LTTng organization) I am working on a
>>>>> low-overhead tracing infrastructure for distributed systems. I am also
>>>>> collaborating with the Synnefo team (https://www.synnefo.org/) and especially
>>>>> with Vangelis Koukis, Constantinos Venetsanopoulos and Filippos Giannakos (cc)
>>>>>
>>>>> Some time ago, we started experimenting with RADOS instrumentation
>>>>> using LTTng and
>>>>> we noticed that there are similar endeavours in the Ceph github repository [1].
>>>>>
>>>>> However, unlike your approach, we are following an annotation-based tracing
>>>>> schema, which enables us to track a specific request from the time it enters
>>>>> the system at higher levels till it is finally served by RADOS.
>>>>>
>>>>> In general, we try to implement the tracing semantics described in the Dapper
>>>>> paper [2] in order to trace the causal relationships between the different
>>>>> processing phases that an IO request may trigger. Our target is an end-to-end
>>>>> visualisation of the request's route in the system, accompanied by information
>>>>> concerning latencies in each processing phase. Thanks to LTTng this can happen
>>>>> with a minimal overhead and in realtime. In order to visualize the results we
>>>>> have integrated Twitter's Zipkin [3], (which is a tracing system
>>>>> entirely based on
>>>>> Dapper) with LTTng.
>>>>>
>>>>> You can find a proof of concept of what we've done so far here:
>>>>>
>>>>> http://snf-551656.vm.okeanos.grnet.gr:8080/traces/0b554b8a48cb3e84?serviceName=MOSDOp
>>>>>
>>>>> In the above link you can see the trace of a write request served by a RADOS
>>>>> pool with replication level set to 3 (two replicas).
>>>>>
>>>>> We'd love to have early feedback and comments from you guys too,
>>>>> so that we can incorporate useful recommendations. You can find all
>>>>> the relevant code
>>>>> here[5][6]. If you have any questions or you wish to experiment with the
>>>>> project please do not hesitate to contact us.
>>>>>
>>>>> Kind regards,
>>>>> Marios
>>>>>
>>>>> [1]https://github.com/ceph/ceph/tree/wip-lttng
>>>>> [2]http://static.googleusercontent.com/media/research.google.com/el//pubs/archive/36356.pdf
>>>>> [3]http://twitter.github.io/zipkin/
>>>>> [4] https://github.com/marioskogias/blkin
>>>>> [5] https://github.com/marioskogias/babeltrace-plugins
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
