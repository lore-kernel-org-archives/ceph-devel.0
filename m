From: Dan Mick <dan.mick@inktank.com>
Subject: Re: changed rbd cp behavior in 0.53
Date: Wed, 14 Nov 2012 16:56:00 -0800
Message-ID: <50A43DA0.6030307@inktank.com>
References: <CABYiri8Hm2EjLsffgSp3aANPwVQ2FPYWx5q01Wkq7sk1Smp41w@mail.gmail.com> <50A17C8A.9020007@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56472 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299Ab2KOA4E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 19:56:04 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so698486pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Nov 2012 16:56:03 -0800 (PST)
In-Reply-To: <50A17C8A.9020007@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Andrey Korolyov <andrey@xdel.ru>, ceph-devel <ceph-devel@vger.kernel.org>



On 11/12/2012 02:47 PM, Josh Durgin wrote:
> On 11/12/2012 08:30 AM, Andrey Korolyov wrote:
>> Hi,
>>
>> For this version, rbd cp assumes that destination pool is the same as
>> source, not 'rbd', if pool in the destination path is omitted.
>>
>> rbd cp install/img testimg
>> rbd ls install
>> img testimg
>>
>>
>> Is this change permanent?
>>
>> Thanks!
>
> This is a regression. The previous behavior will be restored for 0.54.
> I added http://tracker.newdream.net/issues/3478 to track it.

Actually, on detailed examination, it looks like this has been the 
behavior for a long time; I think the wiser course would be not to 
change this defaulting.  One could argue the value of such defaulting, 
but it's also true that you can specify the source and destination pools 
explicitly.

Andrey, any strong objection to leaving this the way it is?
