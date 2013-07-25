From: peter@2force.nl
Subject: Re: Upgrading from 0.61.5 to 0.61.6 ended in disaster
Date: Thu, 25 Jul 2013 13:19:35 +0200
Message-ID: <fac262a41d5df6360f3106a38b9a6a79@2force.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [217.78.241.10] ([217.78.241.10]:40651 "EHLO
	cpanel01.schosting.nl" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755193Ab3GYMDC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jul 2013 08:03:02 -0400
Received: from localhost ([127.0.0.1]:48530 helo=cpanel01.schosting.nl)
	by cpanel01.schosting.nl with esmtpa (Exim 4.80.1)
	(envelope-from <peter@2force.nl>)
	id 1V2Ja3-0002ZS-FL
	for ceph-devel@vger.kernel.org; Thu, 25 Jul 2013 13:19:35 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We did not upgrade from bobtail to cuttlefish and are still seeing this 
issue. I posted this on the ceph-users mailinglist and I missed this 
thread (sorry!) so I didn't know.

Either way, I also have an osd crashing after upgrading to 0.61.6. As 
said on the other list, I'm more than happy to share log files etc with 
you guys.

Thanks,

Peter

> This is fixed in the cuttlefish branch as of earlier this afternoon.  
> I've
> spent most of the day expanding the automated test suite to include
> upgrade combinations to trigger this and *finally* figured out that 
> this
> particular problem seems to surface on clusters that upgraded from 
> bobtail
> -> cuttlefish but not clusters created on cuttlefish.

> If you've run into this issue, please use the cuttlefish branch build 
> for
> now.  We will have a release out in the next day or so that includes 
> this
> and a few other pending fixes.

> I'm sorry we missed this one!  The upgrade test matrix I've been 
> working
> on today should catch this type of issue in the future.

> Thanks!
> sage
