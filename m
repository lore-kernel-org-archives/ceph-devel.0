From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: still recovery issues with cuttlefish
Date: Wed, 14 Aug 2013 09:04:16 +0200
Message-ID: <520B2BF0.2030208@profihost.ag>
References: <51FA1AC1.8040207@profihost.ag> <51FAAED3.3010509@cloudapt.com> <51FAB20F.3030707@profihost.ag> <CA+4uBUY079TZ7sm1EafO1pnXCpKSTkfc15KwqBLi8SyV=Z_29A@mail.gmail.com> <51FB636B.5050301@profihost.ag> <CA+4uBUbye9EOHxFgOYXah8Eg_6ZRtPY_MpgjbnNa=_ZrhFak_w@mail.gmail.com> <51FBF765.9030700@profihost.ag> <CA+4uBUZY-_jsnG+wfE4LXL-Dw2CtRkNuANwPMMJ4JyUU=4tdRQ@mail.gmail.com> <51FBFE85.5040700@profihost.ag> <5203A597.4060701@cloudapt.com> <5203DFAE.9070100@profihost.ag> <CA+4uBUYgLmP0EMv1+Gzd9ndR42o9ahTL6bnoAAD8QS+Cax7Yzg@mail.gmail.com> <52068FB6.1080209@profihost.ag> <CA+4uBUY9JiRG28MB_JqXSUe7OaK01uSOTOVCe+baFK2YuNLiaw@mail.gmail.com> <673B805F-B036-4066-B8AD-770E6464B64C@profihost.ag> <CA+4uBUYBGnCj5Mbj+v8=cFNLYqPrBiR5VqNUJD6m+dXgeHSHzQ@mail.gmail.com> <CA+4uBUaM2X4aR1vNqjHTdoBgbU0jRv9a
 KeZnbAuraWYWcFxEhQ@mail.gmail.com> <A2DD558D-3934-4E85-8B03-C8FC1EF9B8B3@profihost.ag> <CA+4uBUacvJhS1j_zE7QvidgWCYQcVwLqrz2D=OHdtE-Z05rt4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:42105 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942Ab3HNHEX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Aug 2013 03:04:23 -0400
In-Reply-To: <CA+4uBUacvJhS1j_zE7QvidgWCYQcVwLqrz2D=OHdtE-Z05rt4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Mike Dawson <mike.dawson@cloudapt.com>, "josh.durgin@inktank.com" <josh.durgin@inktank.com>, Oliver Francke <Oliver.Francke@filoo.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>

the same problem still occours. Will need to check when i've time to
gather logs again.

Am 14.08.2013 01:11, schrieb Samuel Just:
> I'm not sure, but your logs did show that you had >16 recovery ops in
> flight, so it's worth a try.  If it doesn't help, you should collect
> the same set of logs I'll look again.  Also, there are a few other
> patches between 61.7 and current cuttlefish which may help.
> -Sam
> 
> On Tue, Aug 13, 2013 at 2:03 PM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>>
>> Am 13.08.2013 um 22:43 schrieb Samuel Just <sam.just@inktank.com>:
>>
>>> I just backported a couple of patches from next to fix a bug where we
>>> weren't respecting the osd_recovery_max_active config in some cases
>>> (1ea6b56170fc9e223e7c30635db02fa2ad8f4b4e).  You can either try the
>>> current cuttlefish branch or wait for a 61.8 release.
>>
>> Thanks! Are you sure that this is the issue? I don't believe that but i'll give it a try. I already tested a branch from sage where he fixed a race regarding max active some weeks ago. So active recovering was max 1 but the issue didn't went away.
>>
>> Stefan
>>
>>> -Sam
>>>
>>> On Mon, Aug 12, 2013 at 10:34 PM, Samuel Just <sam.just@inktank.com> wrote:
>>>> I got swamped today.  I should be able to look tomorrow.  Sorry!
>>>> -Sam
>>>>
>>>> On Mon, Aug 12, 2013 at 9:39 PM, Stefan Priebe - Profihost AG
>>>> <s.priebe@profihost.ag> wrote:
>>>>> Did you take a look?
>>>>>
>>>>> Stefan
>>>>>
>>>>> Am 11.08.2013 um 05:50 schrieb Samuel Just <sam.just@inktank.com>:
>>>>>
>>>>>> Great!  I'll take a look on Monday.
>>>>>> -Sam
>>>>>>
>>>>>> On Sat, Aug 10, 2013 at 12:08 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>>>>>>> Hi Samual,
>>>>>>>
>>>>>>> Am 09.08.2013 23:44, schrieb Samuel Just:
>>>>>>>
>>>>>>>> I think Stefan's problem is probably distinct from Mike's.
>>>>>>>>
>>>>>>>> Stefan: Can you reproduce the problem with
>>>>>>>>
>>>>>>>> debug osd = 20
>>>>>>>> debug filestore = 20
>>>>>>>> debug ms = 1
>>>>>>>> debug optracker = 20
>>>>>>>>
>>>>>>>> on a few osds (including the restarted osd), and upload those osd logs
>>>>>>>> along with the ceph.log from before killing the osd until after the
>>>>>>>> cluster becomes clean again?
>>>>>>>
>>>>>>>
>>>>>>> done - you'll find the logs at cephdrop folder:
>>>>>>> slow_requests_recovering_cuttlefish
>>>>>>>
>>>>>>> osd.52 was the one recovering
>>>>>>>
>>>>>>> Thanks!
>>>>>>>
>>>>>>> Greets,
>>>>>>> Stefan
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
