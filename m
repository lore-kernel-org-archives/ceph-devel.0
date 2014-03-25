From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 11:52:53 +0200
Message-ID: <CALFYKtCfRjJDj5zS1ooct4nO6BHL-eRQ-U47ee5mRHmevqzdkg@mail.gmail.com>
References: <1395736765.2823.29.camel@localhost>
	<CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>
	<1395739214.2823.34.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:36319 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbaCYJwy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 05:52:54 -0400
Received: by mail-qa0-f45.google.com with SMTP id hw13so184639qab.18
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 02:52:53 -0700 (PDT)
In-Reply-To: <1395739214.2823.34.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Mar 25, 2014 at 11:20 AM, Olivier Bonvalet <ceph.list@daevel.fr=
> wrote:
>
> Le mardi 25 mars 2014 =E0 11:04 +0200, Ilya Dryomov a =E9crit :
>> On Tue, Mar 25, 2014 at 10:39 AM, Olivier Bonvalet <ceph.list@daevel=
=2Efr> wrote:
>> > Hi,
>> >
>> > what can/should I do to help fix that problem ?
>> >
>> > for now, RBD kernel client hang on :
>> >         Assertion failure in rbd_img_obj_callback() at line 2131:
>> >            rbd_assert(which >=3D img_request->next_completion);
>> >
>> > or on :
>> >         Assertion failure in rbd_img_obj_callback() at line 2127:
>> >             rbd_assert(img_request !=3D NULL);
>> >
>> >
>> > I have both case at least once per week, on latest 3.13.5 kernels.
>> >
>> > It seems that the problem occurs only on more loaded servers (I ha=
ve 4
>> > near same servers, and crash occurs on two of them. If I move the =
VM,
>> > crash follows...).
>>
>> Hi,
>>
>> I'm looking into this, but it doesn't reproduce on my boxes.  This m=
ust
>> be some sort of race and the fact that there is nothing else in the
>> dmesg right before the splats doesn't help.
>>
>> Can you send me your 3.13.5 rbd.ko and libceph.ko?  Also, just so
>> I know, can you build your own kernel?
>>
>> Thanks,
>>
>>                 Ilya
>>
>
> Thanks for your help. Yes, logs are not very usefull here :( Maybe ca=
n I
> enable some debugging informations ?
>
> I add libceph.ko and rbd.ko in attachment. And yes, I can patch and
> build my own kernel. I also add the config file used to compile my
> current kernel, if it can help.

That's great, I'll keep that in mind.  Our debug mode is probably waay
too verbose for running it under load on the order of days so for now
I'll try to make as much sense as I can from the .ko and dumps and keep
digging.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
