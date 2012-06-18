From: Gregory Farnum <greg@inktank.com>
Subject: Re: RBD layering design draft
Date: Mon, 18 Jun 2012 11:04:58 -0700
Message-ID: <CAPYLRzgAoKwHB8dg4kd5QB_Ueu1ZyULZFP3tq9kRbYXfcipk+A@mail.gmail.com>
References: <4FDB9FBB.9000807@inktank.com>
	<Pine.LNX.4.64.1206151742380.28086@cobra.newdream.net>
	<CAC-hyiEGzAF=hAae6mZLjOd+5jckVZD6+WfvJHpCYuueDCCX7g@mail.gmail.com>
	<Pine.LNX.4.64.1206160808050.1862@cobra.newdream.net>
	<4FDDDEE3.8020405@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56710 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab2FRSFA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 14:05:00 -0400
Received: by lbbgm6 with SMTP id gm6so4618255lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 11:04:59 -0700 (PDT)
In-Reply-To: <4FDDDEE3.8020405@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: Sage Weil <sage@inktank.com>, Yehuda Sadeh <yehuda@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Locking is a separate mechanism we're already working on, which will
"lock" images so that they can't accidentally be mounted at more than
one location. :)
-Greg

On Sun, Jun 17, 2012 at 6:42 AM, Martin Mailand <martin@tuxadero.com> w=
rote:
> Hi,
> what's up locked, unlocked, unlocking?
>
> -martin
>
> Am 16.06.2012 17:11, schrieb Sage Weil:
>
>> On Fri, 15 Jun 2012, Yehuda Sadeh wrote:
>>>
>>> On Fri, Jun 15, 2012 at 5:46 PM, Sage Weil<sage@inktank.com> =A0wro=
te:
>>>>
>>>> Looks good! =A0Couple small things:
>>>>
>>>>> =A0 =A0 $ rbd unpreserve pool/image@snap
>>>>
>>>>
>>>> Is 'preserve' and 'unpreserve' the verbiage we want to use here? =A0=
Not
>>>> sure
>>>> I have a better suggestion, but preserve is unusual.
>>>>
>>>
>>> freeze, thaw/unfreeze?
>>
>>
>> Freeze/thaw usually mean something like quiesce I/O or read-only, us=
ually
>> temporarily. =A0What we actaully mean is "you can't delete this". =A0=
Maybe
>> pin/unpin? =A0preserve/unpreserve may be fine, too!
>>
>> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
