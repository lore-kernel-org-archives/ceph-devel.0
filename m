From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: stable 10GBE under 3.4.2 or 3.5.0-rc2
Date: Mon, 18 Jun 2012 16:03:36 +0200
Message-ID: <4FDF3538.3030704@profihost.ag>
References: <4FDEDB7F.4070600@profihost.ag> <4FDF3394.3000107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:47294 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab2FRODi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 10:03:38 -0400
In-Reply-To: <4FDF3394.3000107@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 18.06.2012 15:56, schrieb Mark Nelson:
> On 6/18/12 2:40 AM, Stefan Priebe - Profihost AG wrote:
>> Hi list,
>>
>> i've still problems with stable network speed under recent kernels. With
>> 3.0.32 i get stable 9.90 Gbit/s in both directions. With 3.4.2 or
>> 3.5.0-rc2 it drops sometimes down to around 1 Gbit/s. Sadly i've no idea
>> when this happen? It works sometimes for minutes at 9.9Gbit/s and then
>> suddently only with 3-4Gbit/s or even 1Gbit/s using recent kernels.
>>
>> I'm using various tunings recommanded by intel (Improving Performance)
>> => http://downloadmirror.intel.com/5874/eng/README.txt
>>
>
> Hi Stefan,
>
> Did you ever get a chance to talk to Jason Wang about the commit that
> was causing the problems? It might be a good idea to report all of this
> upstream and see what they have to say.

Hi Mark,

yes i talked to him and he told me that his change was partically 
removed in more recent kernel version.

Right now i'm in discussion with eric dumazet at the netdev kernel 
mailinglist. And he gives me some good advices which seem to work well.

I'm still testing and will share the results here.

Stefan
