From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: still recovery issues with cuttlefish
Date: Tue, 13 Aug 2013 23:03:58 +0200
Message-ID: <A2DD558D-3934-4E85-8B03-C8FC1EF9B8B3@profihost.ag>
References: <51FA1AC1.8040207@profihost.ag> <CA+4uBUYPDyQrP=Hg9kCVNvnh4mNi9URbbrGg39AJOmBWjEbCAg@mail.gmail.com> <51FAAED3.3010509@cloudapt.com> <51FAB20F.3030707@profihost.ag> <CA+4uBUY079TZ7sm1EafO1pnXCpKSTkfc15KwqBLi8SyV=Z_29A@mail.gmail.com> <51FB636B.5050301@profihost.ag> <CA+4uBUbye9EOHxFgOYXah8Eg_6ZRtPY_MpgjbnNa=_ZrhFak_w@mail.gmail.com> <51FBF765.9030700@profihost.ag> <CA+4uBUZY-_jsnG+wfE4LXL-Dw2CtRkNuANwPMMJ4JyUU=4tdRQ@mail.gmail.com> <51FBFE85.5040700@profihost.ag> <5203A597.4060701@cloudapt.com> <5203DFAE.9070100@profihost.ag> <CA+4uBUYgLmP0EMv1+Gzd9ndR42o9ahTL6bnoAAD8QS+Cax7Yzg@mail.gmail.com> <52068FB6.1080209@profihost.ag> <CA+4uBUY9JiRG28MB_JqXSUe7OaK01uSOTOVCe+baFK2YuNLiaw@mail.gmail.com> <673B805F-B036-4066-B8AD-770E6464B64C@profihost.ag> <CA+4uBUYBGnCj5Mbj+v8=cFNLYqPrBiR5
 VqNUJD6m+dXgeHSHzQ@mail.gmail.com> <CA+4uBUaM2X4aR1vNqjHTdoBgbU0jRv9aKeZnbAuraWYWcFxEhQ@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:37627 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab3HMVEA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Aug 2013 17:04:00 -0400
In-Reply-To: <CA+4uBUaM2X4aR1vNqjHTdoBgbU0jRv9aKeZnbAuraWYWcFxEhQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Mike Dawson <mike.dawson@cloudapt.com>, "josh.durgin@inktank.com" <josh.durgin@inktank.com>, Oliver Francke <Oliver.Francke@filoo.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>


Am 13.08.2013 um 22:43 schrieb Samuel Just <sam.just@inktank.com>:

> I just backported a couple of patches from next to fix a bug where we
> weren't respecting the osd_recovery_max_active config in some cases
> (1ea6b56170fc9e223e7c30635db02fa2ad8f4b4e).  You can either try the
> current cuttlefish branch or wait for a 61.8 release.

Thanks! Are you sure that this is the issue? I don't believe that but i'll give it a try. I already tested a branch from sage where he fixed a race regarding max active some weeks ago. So active recovering was max 1 but the issue didn't went away.

Stefan

> -Sam
> 
> On Mon, Aug 12, 2013 at 10:34 PM, Samuel Just <sam.just@inktank.com> wrote:
>> I got swamped today.  I should be able to look tomorrow.  Sorry!
>> -Sam
>> 
>> On Mon, Aug 12, 2013 at 9:39 PM, Stefan Priebe - Profihost AG
>> <s.priebe@profihost.ag> wrote:
>>> Did you take a look?
>>> 
>>> Stefan
>>> 
>>> Am 11.08.2013 um 05:50 schrieb Samuel Just <sam.just@inktank.com>:
>>> 
>>>> Great!  I'll take a look on Monday.
>>>> -Sam
>>>> 
>>>> On Sat, Aug 10, 2013 at 12:08 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
>>>>> Hi Samual,
>>>>> 
>>>>> Am 09.08.2013 23:44, schrieb Samuel Just:
>>>>> 
>>>>>> I think Stefan's problem is probably distinct from Mike's.
>>>>>> 
>>>>>> Stefan: Can you reproduce the problem with
>>>>>> 
>>>>>> debug osd = 20
>>>>>> debug filestore = 20
>>>>>> debug ms = 1
>>>>>> debug optracker = 20
>>>>>> 
>>>>>> on a few osds (including the restarted osd), and upload those osd logs
>>>>>> along with the ceph.log from before killing the osd until after the
>>>>>> cluster becomes clean again?
>>>>> 
>>>>> 
>>>>> done - you'll find the logs at cephdrop folder:
>>>>> slow_requests_recovering_cuttlefish
>>>>> 
>>>>> osd.52 was the one recovering
>>>>> 
>>>>> Thanks!
>>>>> 
>>>>> Greets,
>>>>> Stefan
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
