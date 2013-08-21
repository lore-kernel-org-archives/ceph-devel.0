From: Samuel Just <sam.just@inktank.com>
Subject: Re: still recovery issues with cuttlefish
Date: Wed, 21 Aug 2013 12:13:43 -0700
Message-ID: <CA+4uBUbRiFdr5-SicQ5YJ3BvrwPyNt155XPCPFThfe6znMPnrw@mail.gmail.com>
References: <51FA1AC1.8040207@profihost.ag>
	<51FB636B.5050301@profihost.ag>
	<CA+4uBUbye9EOHxFgOYXah8Eg_6ZRtPY_MpgjbnNa=_ZrhFak_w@mail.gmail.com>
	<51FBF765.9030700@profihost.ag>
	<CA+4uBUZY-_jsnG+wfE4LXL-Dw2CtRkNuANwPMMJ4JyUU=4tdRQ@mail.gmail.com>
	<51FBFE85.5040700@profihost.ag>
	<5203A597.4060701@cloudapt.com>
	<5203DFAE.9070100@profihost.ag>
	<CA+4uBUYgLmP0EMv1+Gzd9ndR42o9ahTL6bnoAAD8QS+Cax7Yzg@mail.gmail.com>
	<52068FB6.1080209@profihost.ag>
	<CA+4uBUY9JiRG28MB_JqXSUe7OaK01uSOTOVCe+baFK2YuNLiaw@mail.gmail.com>
	<673B805F-B036-4066-B8AD-770E6464B64C@profihost.ag>
	<CA+4uBUYBGnCj5Mbj+v8=cFNLYqPrBiR5VqNUJD6m+dXgeHSHzQ@mail.gmail.com>
	<CA+4uBUaM2X4aR1vNqjHTdoBgbU0jRv9aKeZnbAuraWYWcFxEhQ@mail.gmail.com>
	<A2DD558D-3934-4E85-8B03-C8FC1EF9B8B3@profihost.ag>
	<CA+4uBUacvJhS1j_zE7QvidgWCYQcVwLqrz2D=OHdtE-Z05rt4A@mail.gmail.com>
	<520B2BF0.2030208@profihost.ag>
	<5214DCA1.3040003@cloudapt.com>
	<CA+4uBUY+XJzdW6SueB9iPLx4X=WUTgvpgrXM35ODV5cSkamE1Q@mail.gmail.com>
	<52150513.8040908@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:56044 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab3HUTNo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Aug 2013 15:13:44 -0400
Received: by mail-ve0-f177.google.com with SMTP id cz11so722284veb.22
        for <ceph-devel@vger.kernel.org>; Wed, 21 Aug 2013 12:13:43 -0700 (PDT)
In-Reply-To: <52150513.8040908@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Mike Dawson <mike.dawson@cloudapt.com>, "josh.durgin@inktank.com" <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

As long as the request is for an object which is up to date on the
primary, the request will be served without waiting for recovery.  A
request only waits on recovery if the particular object being read or
written must be recovered.  Your issue was that recovering the
particular object being requested was unreasonably slow due to
silliness in the recovery code which you disabled by disabling
osd_recover_clone_overlap.

In cases where the primary osd is significantly behind, we do make one
of the other osds primary during recovery in order to expedite
requests (pgs in this state are shown as remapped).
-Sam

On Wed, Aug 21, 2013 at 11:21 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Am 21.08.2013 17:32, schrieb Samuel Just:
>
>> Have you tried setting osd_recovery_clone_overlap to false?  That
>> seemed to help with Stefan's issue.
>
>
> This might sound a bug harsh but maybe due to my limited english skills ;-)
>
> I still think that Cephs recovery system is broken by design. If an OSD
> comes back (was offline) all write requests regarding PGs where this one is
> primary are targeted immediatly to this OSD. If this one is not up2date for
> an PG it tries to recover that one immediatly which costs 4MB / block. If
> you have a lot of small write all over your OSDs and PGs you're sucked as
> your OSD has to recover ALL it's PGs immediatly or at least lots of them
> WHICH can't work. This is totally crazy.
>
> I think the right way would be:
> 1.) if an OSD goes down the replicas got primaries
>
> or
>
> 2.) an OSD which does not have an up2date PG should redirect to the OSD
> holding the secondary or third replica.
>
> Both results in being able to have a really smooth and slow recovery without
> any stress even under heavy 4K workloads like rbd backed VMs.
>
> Thanks for reading!
>
> Greets Stefan
>
>
>
>> -Sam
>>
>> On Wed, Aug 21, 2013 at 8:28 AM, Mike Dawson <mike.dawson@cloudapt.com>
>> wrote:
>>>
>>> Sam/Josh,
>>>
>>> We upgraded from 0.61.7 to 0.67.1 during a maintenance window this
>>> morning,
>>> hoping it would improve this situation, but there was no appreciable
>>> change.
>>>
>>> One node in our cluster fsck'ed after a reboot and got a bit behind. Our
>>> instances backed by RBD volumes were OK at that point, but once the node
>>> booted fully and the OSDs started, all Windows instances with rbd volumes
>>> experienced very choppy performance and were unable to ingest video
>>> surveillance traffic and commit it to disk. Once the cluster got back to
>>> HEALTH_OK, they resumed normal operation.
>>>
>>> I tried for a time with conservative recovery settings (osd max backfills
>>> =
>>> 1, osd recovery op priority = 1, and osd recovery max active = 1). No
>>> improvement for the guests. So I went to more aggressive settings to get
>>> things moving faster. That decreased the duration of the outage.
>>>
>>> During the entire period of recovery/backfill, the network looked
>>> fine...no
>>> where close to saturation. iowait on all drives look fine as well.
>>>
>>> Any ideas?
>>>
>>> Thanks,
>>> Mike Dawson
>>>
>>>
>>>
>>> On 8/14/2013 3:04 AM, Stefan Priebe - Profihost AG wrote:
>>>>
>>>>
>>>> the same problem still occours. Will need to check when i've time to
>>>> gather logs again.
>>>>
>>>> Am 14.08.2013 01:11, schrieb Samuel Just:
>>>>>
>>>>>
>>>>> I'm not sure, but your logs did show that you had >16 recovery ops in
>>>>> flight, so it's worth a try.  If it doesn't help, you should collect
>>>>> the same set of logs I'll look again.  Also, there are a few other
>>>>> patches between 61.7 and current cuttlefish which may help.
>>>>> -Sam
>>>>>
>>>>> On Tue, Aug 13, 2013 at 2:03 PM, Stefan Priebe - Profihost AG
>>>>> <s.priebe@profihost.ag> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> Am 13.08.2013 um 22:43 schrieb Samuel Just <sam.just@inktank.com>:
>>>>>>
>>>>>>> I just backported a couple of patches from next to fix a bug where we
>>>>>>> weren't respecting the osd_recovery_max_active config in some cases
>>>>>>> (1ea6b56170fc9e223e7c30635db02fa2ad8f4b4e).  You can either try the
>>>>>>> current cuttlefish branch or wait for a 61.8 release.
>>>>>>
>>>>>>
>>>>>>
>>>>>> Thanks! Are you sure that this is the issue? I don't believe that but
>>>>>> i'll give it a try. I already tested a branch from sage where he fixed
>>>>>> a
>>>>>> race regarding max active some weeks ago. So active recovering was max
>>>>>> 1 but
>>>>>> the issue didn't went away.
>>>>>>
>>>>>> Stefan
>>>>>>
>>>>>>> -Sam
>>>>>>>
>>>>>>> On Mon, Aug 12, 2013 at 10:34 PM, Samuel Just <sam.just@inktank.com>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> I got swamped today.  I should be able to look tomorrow.  Sorry!
>>>>>>>> -Sam
>>>>>>>>
>>>>>>>> On Mon, Aug 12, 2013 at 9:39 PM, Stefan Priebe - Profihost AG
>>>>>>>> <s.priebe@profihost.ag> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Did you take a look?
>>>>>>>>>
>>>>>>>>> Stefan
>>>>>>>>>
>>>>>>>>> Am 11.08.2013 um 05:50 schrieb Samuel Just <sam.just@inktank.com>:
>>>>>>>>>
>>>>>>>>>> Great!  I'll take a look on Monday.
>>>>>>>>>> -Sam
>>>>>>>>>>
>>>>>>>>>> On Sat, Aug 10, 2013 at 12:08 PM, Stefan Priebe
>>>>>>>>>> <s.priebe@profihost.ag> wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Hi Samual,
>>>>>>>>>>>
>>>>>>>>>>> Am 09.08.2013 23:44, schrieb Samuel Just:
>>>>>>>>>>>
>>>>>>>>>>>> I think Stefan's problem is probably distinct from Mike's.
>>>>>>>>>>>>
>>>>>>>>>>>> Stefan: Can you reproduce the problem with
>>>>>>>>>>>>
>>>>>>>>>>>> debug osd = 20
>>>>>>>>>>>> debug filestore = 20
>>>>>>>>>>>> debug ms = 1
>>>>>>>>>>>> debug optracker = 20
>>>>>>>>>>>>
>>>>>>>>>>>> on a few osds (including the restarted osd), and upload those
>>>>>>>>>>>> osd
>>>>>>>>>>>> logs
>>>>>>>>>>>> along with the ceph.log from before killing the osd until after
>>>>>>>>>>>> the
>>>>>>>>>>>> cluster becomes clean again?
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> done - you'll find the logs at cephdrop folder:
>>>>>>>>>>> slow_requests_recovering_cuttlefish
>>>>>>>>>>>
>>>>>>>>>>> osd.52 was the one recovering
>>>>>>>>>>>
>>>>>>>>>>> Thanks!
>>>>>>>>>>>
>>>>>>>>>>> Greets,
>>>>>>>>>>> Stefan
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>>>> ceph-devel" in
>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>>>> in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>> in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
