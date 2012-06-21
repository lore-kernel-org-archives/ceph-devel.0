From: Dan Mick <dan.mick@inktank.com>
Subject: Re: ceph init script didn't stop the ceph.
Date: Thu, 21 Jun 2012 11:40:43 -0700
Message-ID: <4FE36AAB.3010709@inktank.com>
References: <loom.20120621T131015-713@post.gmane.org> <EE8917CF-85FD-4918-AB38-DAD178AE8678@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49686 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab2FUSkq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 14:40:46 -0400
Received: by pbbrp8 with SMTP id rp8so2471239pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jun 2012 11:40:46 -0700 (PDT)
In-Reply-To: <EE8917CF-85FD-4918-AB38-DAD178AE8678@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

You can also try -v to get more output.

On 06/21/2012 09:59 AM, Dan Mick wrote:
> Do you see any error messages?  Are daemons still running on all machines, or just remote ones?
>
> On Jun 21, 2012, at 4:35 AM, ramu<ramu.freesystems@gmail.com>  wrote:
>
>> Hi,
>>
>> The sudo /etc/init.d/ceph -a stop script command was didn't stop the ceph.
>> I tried with the version ceph-0.47.3 also ,but it was not stopping.
>> The sudo /etc/init.d/ceph -a start is working fine.
>> And i tried with the sudo /etc/init.d/ceph -a killall it's working fine but when
>> iam stop the single osd it is not working.please help me.
>>
>> Thanks,
>> Ramu.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
