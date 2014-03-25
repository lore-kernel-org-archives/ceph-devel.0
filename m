From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 06:48:40 -0500
Message-ID: <53316D18.7040103@ieee.org>
References: <1395736765.2823.29.camel@localhost> <CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:38387 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbaCYLsV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 07:48:21 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so391683oah.10
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 04:48:21 -0700 (PDT)
In-Reply-To: <CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, Olivier Bonvalet <ceph.list@daevel.fr>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 03/25/2014 04:04 AM, Ilya Dryomov wrote:
> On Tue, Mar 25, 2014 at 10:39 AM, Olivier Bonvalet <ceph.list@daevel.fr> wrote:
>> Hi,
>>
>> what can/should I do to help fix that problem ?
>>
>> for now, RBD kernel client hang on :
>>         Assertion failure in rbd_img_obj_callback() at line 2131:
>>            rbd_assert(which >= img_request->next_completion);

If you can build your own kernel as Ilya says I'd like to
see the values of which and img_request->next_completion
here.

If you can't, is there anything interesting about your
workload that might help reproduce the problem?

Thanks.

					-Alex

>>
>> or on :
>>         Assertion failure in rbd_img_obj_callback() at line 2127:
>>             rbd_assert(img_request != NULL);
>>
>>
>> I have both case at least once per week, on latest 3.13.5 kernels.
>>
>> It seems that the problem occurs only on more loaded servers (I have 4
>> near same servers, and crash occurs on two of them. If I move the VM,
>> crash follows...).
> 
> Hi,
> 
> I'm looking into this, but it doesn't reproduce on my boxes.  This must
> be some sort of race and the fact that there is nothing else in the
> dmesg right before the splats doesn't help.
> 
> Can you send me your 3.13.5 rbd.ko and libceph.ko?  Also, just so
> I know, can you build your own kernel?
> 
> Thanks,
> 
>                 Ilya
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

