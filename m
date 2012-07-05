From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Slow request warnings on 0.48
Date: Thu, 05 Jul 2012 14:49:17 -0500
Message-ID: <4FF5EFBD.1060603@inktank.com>
References: <44469a6e-79a3-4eaa-be25-c47192c8fc80@mailpro> <4FF5D5C3.80207@inktank.com> <45F11B42CB5830479EF0E56A27F4E68D7F4E54@exchange1.ad.100it.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41519 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004Ab2GETtW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 15:49:22 -0400
Received: by gglu4 with SMTP id u4so7825367ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jul 2012 12:49:21 -0700 (PDT)
In-Reply-To: <45F11B42CB5830479EF0E56A27F4E68D7F4E54@exchange1.ad.100it.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Blundell <David.Blundell@100percentit.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/05/2012 01:43 PM, David Blundell wrote:
>> Hi David and Alexandre,
>>
>> Does this only happen with random writes or also sequential writes?  If it
>> happens with sequential writes as well, does it happen with rados bench?
>>
>> --
>> Mark Nelson
>> Performance Engineer
>> Inktank
>
> Hi Mark,
>
> I just ran "rados -p data bench 60 write -t 16" and a few dd tests with no problems at all so at the moment it looks like only random IO triggers the slow writes.
>
> Please do let me know if there are any other tests that I can do to help track down the cause.
>
> David

Thanks David!  We've got some people internally taking a look at this. 
I'll let you guys know if there is anything else we need!

Thanks,
Mark

-- 
Mark Nelson
Performance Engineer
Inktank
