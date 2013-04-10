From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: MDS crash on 0.60 after upgrade from 0.58
Date: Wed, 10 Apr 2013 02:06:04 +0100
Message-ID: <5164BAFC.6090108@inktank.com>
References: <dcbb6527421f9a4537782e43dcaf4e47@omrb.pnpi.spb.ru> <515D419B.3000002@inktank.com> <e424a8f1c14106827dc9c72eb812670e@omrb.pnpi.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:47537 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756358Ab3DJBGQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Apr 2013 21:06:16 -0400
Received: by mail-wi0-f173.google.com with SMTP id ez12so4300573wid.12
        for <ceph-devel@vger.kernel.org>; Tue, 09 Apr 2013 18:06:15 -0700 (PDT)
In-Reply-To: <e424a8f1c14106827dc9c72eb812670e@omrb.pnpi.spb.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexey Shvetsov <alexxy@gentoo.org>
Cc: ceph-devel@vger.kernel.org, Ross Turk <ross@inktank.com>

On 04/09/2013 01:02 PM, Alexey Shvetsov wrote:
> Hello!
>
> There issue on bugtracker that describes this problems
> http://tracker.ceph.com/issues/4644
>
> Unfortunately i cannot login to it since i dont get registration mail=
=2E

Alexey,

After speaking with Ross about the registration issue, he mentioned tha=
t=20
sometimes the registration email is flagged as spam.  So I guess you=20
should check your spam folder.

Let us know how that goes.

   -Joao

>
> Also patches listed on this issue doesnt work for me. MDS still keeps
> crashing
>
>
> Joao Eduardo Luis =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 04-04-2013 13:02:
>> On 04/04/2013 09:27 AM, Alexey Shvetsov wrote:
>>> Hi all!
>>>
>>> I'm getting mds crash on 0.60 after i upgraded to it from 0.58 rele=
ase.
>>> MDS log looks like http://bpaste.net/show/88863/
>>> MON log looks like http://bpaste.net/show/88864/
>>>
>>> Interesting that if we didnt started osd then mds will not crash
>>>
>>> PS configuration consist of 18 osd + 1 mon + 1 mds
>>>
>>
>> Hello Alexey,
>>
>> First of all, it appears that your monitors have not been upgraded.
>> Their crash dumps state their version to be 0.59 still.
>>
>> Furthermore, the issue you're suffering from is the one described in
>> ticket #4519 at the tracker [1], and the fix [2] is already present =
on
>> v0.60, just not 0.59.
>>
>>   -Joao
>>
>> [1] - http://tracker.ceph.com/issues/4519
>> [2] - 71ec9c6bd54d560cc2bca4b6d0dbb3e6961df135
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
