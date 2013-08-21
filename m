From: Samuel Just <sam.just@inktank.com>
Subject: Re: still recovery issues with cuttlefish
Date: Wed, 21 Aug 2013 08:32:30 -0700
Message-ID: <CA+4uBUY+XJzdW6SueB9iPLx4X=WUTgvpgrXM35ODV5cSkamE1Q@mail.gmail.com>
References: <51FA1AC1.8040207@profihost.ag>
	<51FAAED3.3010509@cloudapt.com>
	<51FAB20F.3030707@profihost.ag>
	<CA+4uBUY079TZ7sm1EafO1pnXCpKSTkfc15KwqBLi8SyV=Z_29A@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f54.google.com ([209.85.212.54]:49413 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080Ab3HUPcb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Aug 2013 11:32:31 -0400
Received: by mail-vb0-f54.google.com with SMTP id q14so409656vbe.41
        for <ceph-devel@vger.kernel.org>; Wed, 21 Aug 2013 08:32:30 -0700 (PDT)
In-Reply-To: <5214DCA1.3040003@cloudapt.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mike.dawson@cloudapt.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "josh.durgin@inktank.com" <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Have you tried setting osd_recovery_clone_overlap to false?  That
seemed to help with Stefan's issue.
-Sam

On Wed, Aug 21, 2013 at 8:28 AM, Mike Dawson <mike.dawson@cloudapt.com> wrote:
> Sam/Josh,
>
> We upgraded from 0.61.7 to 0.67.1 during a maintenance window this morning,
> hoping it would improve this situation, but there was no appreciable change.
>
> One node in our cluster fsck'ed after a reboot and got a bit behind. Our
> instances backed by RBD volumes were OK at that point, but once the node
> booted fully and the OSDs started, all Windows instances with rbd volumes
> experienced very choppy performance and were unable to ingest video
> surveillance traffic and commit it to disk. Once the cluster got back to
> HEALTH_OK, they resumed normal operation.
>
> I tried for a time with conservative recovery settings (osd max backfills =
> 1, osd recovery op priority = 1, and osd recovery max active = 1). No
> improvement for the guests. So I went to more aggressive settings to get
> things moving faster. That decreased the duration of the outage.
>
> During the entire period of recovery/backfill, the network looked fine...no
> where close to saturation. iowait on all drives look fine as well.
>
> Any ideas?
>
> Thanks,
> Mike Dawson
>
>
>
> On 8/14/2013 3:04 AM, Stefan Priebe - Profihost AG wrote:
>>
>> the same problem still occours. Will need to check when i've time to
>> gather logs again.
>>
>> Am 14.08.2013 01:11, schrieb Samuel Just:
>>>
>>> I'm not sure, but your logs did show that you had >16 recovery ops in
>>> flight, so it's worth a try.  If it doesn't help, you should collect
>>> the same set of logs I'll look again.  Also, there are a few other
>>> patches between 61.7 and current cuttlefish which may help.
>>> -Sam
>>>
>>> On Tue, Aug 13, 2013 at 2:03 PM, Stefan Priebe - Profihost AG
>>> <s.priebe@profihost.ag> wrote:
>>>>
>>>>
>>>> Am 13.08.2013 um 22:43 schrieb Samuel Just <sam.just@inktank.com>:
>>>>
>>>>> I just backported a couple of patches from next to fix a bug where we
>>>>> weren't respecting the osd_recovery_max_active config in some cases
>>>>> (1ea6b56170fc9e223e7c30635db02fa2ad8f4b4e).  You can either try the
>>>>> current cuttlefish branch or wait for a 61.8 release.
>>>>
>>>>
>>>> Thanks! Are you sure that this is the issue? I don't believe that but
>>>> i'll give it a try. I already tested a branch from sage where he fixed a
>>>> race regarding max active some weeks ago. So active recovering was max 1 but
>>>> the issue didn't went away.
>>>>
>>>> Stefan
>>>>
>>>>> -Sam
>>>>>
>>>>> On Mon, Aug 12, 2013 at 10:34 PM, Samuel Just <sam.just@inktank.com>
>>>>> wrote:
>>>>>>
>>>>>> I got swamped today.  I should be able to look tomorrow.  Sorry!
>>>>>> -Sam
>>>>>>
>>>>>> On Mon, Aug 12, 2013 at 9:39 PM, Stefan Priebe - Profihost AG
>>>>>> <s.priebe@profihost.ag> wrote:
>>>>>>>
>>>>>>> Did you take a look?
>>>>>>>
>>>>>>> Stefan
>>>>>>>
>>>>>>> Am 11.08.2013 um 05:50 schrieb Samuel Just <sam.just@inktank.com>:
>>>>>>>
>>>>>>>> Great!  I'll take a look on Monday.
>>>>>>>> -Sam
>>>>>>>>
>>>>>>>> On Sat, Aug 10, 2013 at 12:08 PM, Stefan Priebe
>>>>>>>> <s.priebe@profihost.ag> wrote:
>>>>>>>>>
>>>>>>>>> Hi Samual,
>>>>>>>>>
>>>>>>>>> Am 09.08.2013 23:44, schrieb Samuel Just:
>>>>>>>>>
>>>>>>>>>> I think Stefan's problem is probably distinct from Mike's.
>>>>>>>>>>
>>>>>>>>>> Stefan: Can you reproduce the problem with
>>>>>>>>>>
>>>>>>>>>> debug osd = 20
>>>>>>>>>> debug filestore = 20
>>>>>>>>>> debug ms = 1
>>>>>>>>>> debug optracker = 20
>>>>>>>>>>
>>>>>>>>>> on a few osds (including the restarted osd), and upload those osd
>>>>>>>>>> logs
>>>>>>>>>> along with the ceph.log from before killing the osd until after
>>>>>>>>>> the
>>>>>>>>>> cluster becomes clean again?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> done - you'll find the logs at cephdrop folder:
>>>>>>>>> slow_requests_recovering_cuttlefish
>>>>>>>>>
>>>>>>>>> osd.52 was the one recovering
>>>>>>>>>
>>>>>>>>> Thanks!
>>>>>>>>>
>>>>>>>>> Greets,
>>>>>>>>> Stefan
>>>>>>>>
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>> ceph-devel" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>> in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>
