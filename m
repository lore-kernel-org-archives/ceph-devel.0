From: Yuri Weinstein <yuri.weinstein@inktank.com>
Subject: Re: Swift tests failing randomly
Date: Mon, 11 Aug 2014 11:50:19 -0700
Message-ID: <CAJBxG-srn4+0MuRa9EgQ4csF=jK5+m=GBKPhKUp+nnzsP==gyA@mail.gmail.com>
References: <53E7316D.3090808@dachary.org>
	<53E8ED9C.5000601@dachary.org>
	<CABBk=J8by_UDKXddSDQ5HovtCtNOvhzBsGWdAiywEN1MmSS69A@mail.gmail.com>
	<alpine.DEB.2.00.1408111012100.32572@cobra.newdream.net>
	<CAJBxG-t8mWq4=1zjGf6d7O6_6NNqQs1NgZdpXuuifRPsh_nKtw@mail.gmail.com>
	<53E90FB6.8060808@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36314 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbaHKSuV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Aug 2014 14:50:21 -0400
Received: by mail-wi0-f170.google.com with SMTP id f8so5984854wiw.3
        for <ceph-devel@vger.kernel.org>; Mon, 11 Aug 2014 11:50:19 -0700 (PDT)
In-Reply-To: <53E90FB6.8060808@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sweil@redhat.com>, Yehuda Sadeh <yehuda@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

I thought we could do the same in run-time for vps'es only.

Sage?

On Mon, Aug 11, 2014 at 11:47 AM, Loic Dachary <loic@dachary.org> wrote=
:
>
>
> On 11/08/2014 19:34, Yuri Weinstein wrote:
>> Here is what we have in vps.yaml now:
>>
>> overrides:
>>   ceph:
>>     conf:
>>       global:
>>         osd heartbeat grace: 40
>>
>> What do we want to add?
>
> I think the idle_timeout values at
>
> https://github.com/ceph/ceph-qa-suite/pull/79/files
>
>
>>
>> ~
>>
>> On Mon, Aug 11, 2014 at 10:13 AM, Sage Weil <sweil@redhat.com> wrote=
:
>>> On Mon, 11 Aug 2014, Yehuda Sadeh wrote:
>>>> Yeah, looking at these logs, it really seem that it's just that th=
ings
>>>> are going slow on these machines and it's hitting timeouts. The fi=
x is
>>>> ok with me, although I'd rather have it adjusted per machine type
>>>> (somehow).
>>>
>>> There is a vps.yaml that bumps up another timeout, so we could put =
it
>>> there.  Right now it lives on the teuthology machine
>>> (~teuthworker/vps.yaml I think?), but perhaps we should stick it in
>>> ceph-qa-suite.git somewhere ...
>>>
>>> sage
>>>
>>>>
>>>> Yehuda
>>>>
>>>> On Mon, Aug 11, 2014 at 9:21 AM, Loic Dachary <loic@dachary.org> w=
rote:
>>>>> Hi Yehuda,
>>>>>
>>>>> It looks like increasing the rgw idle timeout makes the problem g=
o away ( https://github.com/ceph/ceph-qa-suite/pull/79 and http://track=
er.ceph.com/issues/8988 ). It previously was 300 sec which looks like a=
 large value already. Does this fix / workaround make sense to you ?
>>>>>
>>>>> Cheers
>>>>>
>>>>> On 10/08/2014 10:46, Loic Dachary wrote:
>>>>>> Hi Yehuda,
>>>>>>
>>>>>> In the past few months the swift tests failed randomly and I was=
 unfortunately unable to figure out why. Here are a few examples:
>>>>>>
>>>>>>     http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:fir=
efly-x:stress-split-wip-9025-chunk-remapping-testing-basic-vps/406944
>>>>>>     http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:fir=
efly-x:stress-split-wip-9025-chunk-remapping-testing-basic-vps/406941
>>>>>>     http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:fir=
efly-x:stress-split-wip-9025-chunk-remapping-testing-basic-vps/406946
>>>>>>     http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:fir=
efly-x:stress-split-wip-9025-chunk-remapping-testing-basic-vps/406947
>>>>>>
>>>>>> and it has happened on every upgrade test run since I can rememb=
er. I fail to see a pattern and cannot figure out what the real problem=
 is. It would be really great if you could take a look. Even a hunch or=
 a tip would be greatly appreciated :-)
>>>>>>
>>>>>> You can find more context in
>>>>>>
>>>>>> http://tracker.ceph.com/issues/8988
>>>>>> http://tracker.ceph.com/issues/8016
>>>>>> http://tracker.ceph.com/issues/7799
>>>>>>
>>>>>> and discussions at
>>>>>>
>>>>>> http://www.spinics.net/lists/ceph-devel/msg19933.html
>>>>>>
>>>>>> Cheers
>>>>>>
>>>>>
>>>>> --
>>>>> Lo?c Dachary, Artisan Logiciel Libre
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
