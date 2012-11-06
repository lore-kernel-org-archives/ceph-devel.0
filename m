From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: chaning pg_num / pgp_num after adding more osds
Date: Tue, 06 Nov 2012 08:32:15 +0100
Message-ID: <5098BCFF.6050004@profihost.ag>
References: <5097C9DD.3030600@profihost.ag> <50984F82.3010706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:39274 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab2KFHcT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 02:32:19 -0500
In-Reply-To: <50984F82.3010706@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 06.11.2012 00:45, schrieb Josh Durgin:
> On 11/05/2012 06:14 AM, Stefan Priebe - Profihost AG wrote:
>> Hello list,
>>
>> Is there a way to change the number of pg_num / pgp_num after adding
>> more osds?
>
> The pg_num/pgp_num settings are only used by mkcephfs at install time.
>
>> I mean i would like to start with 16 OSDs but i think i'll expand over
>> time to up to 100 OSDs. So i think i need to tune pg_num / pgp_num.
>
> You can specify pg_num when creating a pool:
>
> ceph osd pool create <name> <pgnum>
>
> But you don't want to have too many (thousands per osd). Being able
> to change the number of pgs in a pool (pg splitting/merging) is in
> the works, but in the mean time you can create more pools after you add
> a bunch of osds to keep your pg/osd ratio around 100.

Thanks Josh for your explanation. I'm not sure if i already understood 
what pg is at all.

First i see that ceph is creating 832 pgs for 12 osds in my case per 
default. This is 69,3333333 per OSD. You're talking about 100 - is the 
default calculation broken or hardcoded?

When i have one pool with 800 pgs and i add 20 new OSDs how does a new 
pool help? I mean the old pools will stay with 800 pgs.

Thanks again!

Greets,
Stefan
