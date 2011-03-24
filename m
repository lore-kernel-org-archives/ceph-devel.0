From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: a question about laggy mds
Date: Thu, 24 Mar 2011 09:24:12 -0700
Message-ID: <AANLkTim_N8=9zCCeacWydyjGBibrmQF2a=TqBjQ+KbSB@mail.gmail.com>
References: <AANLkTikFcmEcyEjoVcT_s-3dTvqLsiy8MhmXW-ZSD6to@mail.gmail.com>
	<AANLkTimecWXyouv-0R8RuZampTyf=zQq3-UBBvJZ=axE@mail.gmail.com>
	<1F34D01083244531A8A36BF3DEA8B419@PC201010310710>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39945 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933023Ab1CXQYQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2011 12:24:16 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 4249DC064
	for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2011 09:24:14 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id E64B5C062
	for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2011 09:24:13 -0700 (PDT)
Received: by ewy4 with SMTP id 4so108235ewy.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2011 09:24:12 -0700 (PDT)
In-Reply-To: <1F34D01083244531A8A36BF3DEA8B419@PC201010310710>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuki <chengmao2010@gmail.com>, ceph-devel@vger.kernel.org

2011/3/23 Yuki <chengmao2010@gmail.com>:
> hi
> if there is only one mds in the ceph cluster , after it was marked la=
ggy, it can clear the laggy flag itself sometime. But if there are two =
mdses , the laggy one would be taken over by the standby soon. Under wh=
at circumstance the laggy mds can clear the laggy flag=A3=BF
An mds is marked laggy *by the monitor* if it goes too long without
delivering the monitor a beacon message. At that point, if there is an
available mds in standby or standby-replay the laggy mds will get
blacklisted and the standby will take over. If there are no available
standbys, the mds stays laggy, and can clear itself by sending the
monitor a couple messages.

> Why does the mds send  "beacon" to the monitors? Does it just report =
mon its state ? The mds is marked laggy by itself not the mon, is that =
right ?
The beacon message contains a very minimal amount of state, and is
mostly just a heartbeat to let the monitor know that the MDS is still
alive.
As I said above, an mds is marked laggy by the monitors. :)
-Greg
PS: Please send questions like these to the list, not to individuals.
You will get better answers more quickly, and the contents of the
emails are archived and indexed by search engines so other people can
get their answer by google instead of email! :)

> Thanks .
>
> ----- Original Message -----
> From: "Gregory Farnum" <gregory.farnum@dreamhost.com>
> To: "huang jun" <hjwsm1989@gmail.com>
> Cc: <ceph-devel@vger.kernel.org>
> Sent: Thursday, March 24, 2011 10:27 AM
> Subject: Re: a question about laggy mds
>
>
>> 2011/3/23 huang jun <hjwsm1989@gmail.com>:
>>> Hi all=A3=AC
>>> There are two mds in the ceph cluster=A3=ACone is active and the ot=
her is
>>> standby.  In my test,  I found the mds0 was marked as laggy, and it
>>> was taken over by the standby soon. And it will take a long time fo=
r
>>> the standby to become active if there are a great many of requests
>>> from the client. I want to know under what circumstances mds would =
be
>>> marked as laggy.
>>
>> The MDS gets marked laggy if it goes too long without sending a
>> "beacon" to the monitors. This generally happens if the MDS gets
>> overloaded by client requests for some reason -- or if it simply
>> crashes. Your config looks okay so either your MDS doesn't have the
>> resources it needs for the workload you're using, or the workload
>> breaks our default config/algorithms.
>>
>> The amount of time it takes for a standby to take over is generally
>> determined by 3 things:
>> 1) Time to declare an mds down (this is when it's marked laggy)
>> 2) Time to replay the MDS journal
>> 3) Time to handle client replay requests
>>
>> Usually (2) and (3) are dominated by (1), and I'm surprised this isn=
't
>> the case for you... What's your workload look like?
>> -Greg
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
