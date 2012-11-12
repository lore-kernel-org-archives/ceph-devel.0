From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [BUG] ceph-mon crashes
Date: Mon, 12 Nov 2012 22:20:55 +0100
Message-ID: <50A16837.9090801@profihost.ag>
References: <50A01DCB.9010001@profihost.ag> <50A024B2.3080502@inktank.com> <50A02542.1000602@profihost.ag> <50A03412.1030206@inktank.com> <21B8A3CE-BC02-44AF-ABB5-45C9C74F9380@profihost.ag> <50A10EB1.4040802@inktank.com> <50A1114A.5070200@profihost.ag> <50A12C67.50702@inktank.com> <50A14058.4070905@profihost.ag> <50A15ED9.6090207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:34121 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234Ab2KLVUx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Nov 2012 16:20:53 -0500
In-Reply-To: <50A15ED9.6090207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks i'm subscribed to the tracker now.

Stefan

Am 12.11.2012 21:40, schrieb Joao Eduardo Luis:
> On 11/12/2012 06:30 PM, Stefan Priebe wrote:
>> Hi Joao,
>>
>> Am 12.11.2012 18:05, schrieb Joao Eduardo Luis:
>>> Can you please confirm me that sometime between you issuing the out
>>> command and mon.b failing, you had yet another monitor (maybe mon.a)
>>> that was the leader but for some reason it was down by the time that
>>> mon.b failed?
>>>
>>> If so, could you provide the log for that monitor as well, given this
>>> log doesn't have some infos I'm looking for?
>> Not sure but here are the logs of the other two mons:
>> https://www.dropbox.com/s/jztsedvj1b2kjje/ceph-mon.a.log.1.gz
>>
>> https://www.dropbox.com/s/62jkfbbbgvs5o25/ceph-mon.c.log.1.gz
>>
>> Thanks,
>> Stefan
>
> Thanks Stefan,
>
> I'll be looking into this.
>
> For future reference, I created issue #3477 on the tracker:
> http://tracker.newdream.net/issues/3477
>
>    -Joao
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
