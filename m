From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] mark rbd requiring stable pages
Date: Thu, 22 Oct 2015 20:07:22 +0200
Message-ID: <CAOi1vP-aJRk-LFXiWatFNfp_j23iExLvXxe4q34mcjQmfbyNCg@mail.gmail.com>
References: <201510151850.48348.ronny.hegewald@online.de>
	<CAOi1vP_ZDHBfCDeH6gxCKRsqoGteWv+nn7EFTexf+qsUBMHvjA@mail.gmail.com>
	<CAOi1vP8nAfr1_dNmvhNspz6ANZo2onGExU7=-agKLNr5KPxrzw@mail.gmail.com>
	<CAOi1vP_0GoqXuHm5SjZHpS8g_mK_wFRs9t9_VE1N9JUMFvL3Gw@mail.gmail.com>
	<562860F2.8070208@cs.wisc.edu>
	<CAOi1vP_e1aY4zMyYgRLy=D+jBs44g9++0VKutRm7D6q0OALJ3Q@mail.gmail.com>
	<562902D3.7040501@cs.wisc.edu>
	<CAOi1vP_zx+Cz+tM07pZa_ciFhnJ8ddHX+dy35cqhOJ3BT4a8jw@mail.gmail.com>
	<56291B60.1040106@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33264 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965425AbbJVSHY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Oct 2015 14:07:24 -0400
Received: by wijp11 with SMTP id p11so44349051wij.0
        for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2015 11:07:23 -0700 (PDT)
In-Reply-To: <56291B60.1040106@cs.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: Ronny Hegewald <ronny.hegewald@online.de>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>

On Thu, Oct 22, 2015 at 7:22 PM, Mike Christie <michaelc@cs.wisc.edu> wrote:
> On 10/22/15, 11:52 AM, Ilya Dryomov wrote:
>>
>> On Thu, Oct 22, 2015 at 5:37 PM, Mike Christie <michaelc@cs.wisc.edu>
>> wrote:
>>>
>>> On 10/22/2015 06:20 AM, Ilya Dryomov wrote:
>>>>
>>>>
>>>>>>
>>>>>> If we are just talking about if stable pages are not used, and someone
>>>>>> is re-writing data to a page after the page has already been submitted
>>>>>> to the block layer (I mean the page is on some bio which is on a
>>>>>> request
>>>>>> which is on some request_queue scheduler list or basically anywhere in
>>>>>> the block layer), then I was saying this can occur with any block
>>>>>> driver. There is nothing that is preventing this from happening with a
>>>>>> FC driver or nvme or cciss or in dm or whatever. The app/user can
>>>>>> rewrite as late as when we are in the make_request_fn/request_fn.
>>>>>>
>>>>>> I think I am misunderstanding your question because I thought this is
>>>>>> expected behavior, and there is nothing drivers can do if the app is
>>>>>> not
>>>>>> doing a flush/sync between these types of write sequences.
>>>>
>>>> I don't see a problem with rewriting as late as when we are in
>>>> request_fn() (or in a wq after being put there by request_fn()).  Where
>>>> I thought there *might* be an issue is rewriting after sendpage(), if
>>>> sendpage() is used - perhaps some sneaky sequence similar to that
>>>> retransmit bug that would cause us to *transmit* incorrect bytes (as
>>>> opposed to *re*transmit) or something of that nature?
>>>
>>>
>>>
>>> Just to make sure we are on the same page.
>>>
>>> Are you concerned about the tcp/net layer retransmitting due to it
>>> detecting a issue as part of the tcp protocol, or are you concerned
>>> about rbd/libceph initiating a retry like with the nfs issue?
>>
>>
>> The former, tcp/net layer.  I'm just conjecturing though.
>>
>
> For iscsi, we normally use the sendpage path. Data digests are off by
> default and some distros do not even allow you to turn them on, so our
> sendpage path has got a lot of testing and we have not seen any corruptions.
> Not saying it is not possible, but just saying we have not seen any.

Great, that's reassuring.

>
> It could be due to a recent change. Ronny, tell us about the workload and I
> will check iscsi.
>
> Oh yeah, for the tcp/net retransmission case, I had said offlist, I thought
> there might be a issue with iscsi but I guess I was wrong, so I have not
> seen any issues with that either.

I'll drop my concerns then.  Those corruptions could be a bug in ceph
reconnect code or something else - regardless, that's separate from the
issue at hand.

Thanks,

                Ilya
