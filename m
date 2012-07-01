From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Sun, 01 Jul 2012 23:27:30 +0200
Message-ID: <4FF0C0C2.2010407@profihost.ag>
References: <4FED8792.1090905@profihost.ag> <4FED964D.3080201@inktank.com> <4FEDA777.1060309@profihost.ag> <Pine.LNX.4.64.1206290819170.30691@cobra.newdream.net> <4FEE1B91.8080404@profihost.ag> <4FF0BAB8.3070503@profihost.ag> <4FF0BD84.1050607@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:53899 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab2GAV12 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Jul 2012 17:27:28 -0400
In-Reply-To: <4FF0BD84.1050607@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 01.07.2012 23:13, schrieb Mark Nelson:
> On 7/1/12 4:01 PM, Stefan Priebe wrote:
>> Hello list,
>> Hello sage,
>>
>> i've made some further tests.
>>
>> Sequential 4k writes over 200GB: 300% CPU usage of kvm process 34712 iops
>>
>> Random 4k writes over 200GB: 170% CPU usage of kvm process 5500 iops
>>
>> When i make random 4k writes over 100MB: 450% CPU usage of kvm process
>> and !! 25059 iops !!
>>
> When you say 100MB vs 200GB, do you mean the total amount of data that
> is written for the test?

Yes/No, it is the max amount of data written but for random I/O it is 
also the range like random block device position between 0 and X where 
to write the 4K block.

 > Also, are these starting out on a fresh
> filesystem?
Yes, 5 Min old in this case ;-)

Stefan
