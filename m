From: peter@2force.nl
Subject: Re: Upgrading from 0.61.5 to 0.61.6 ended in disaster
Date: Thu, 25 Jul 2013 18:12:47 +0200
Message-ID: <f03ce22908265e69355583a9e5415dd5@2force.nl>
References: <fac262a41d5df6360f3106a38b9a6a79@2force.nl>
 <alpine.DEB.2.00.1307250845140.29435@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cpanel01.schosting.nl ([217.78.241.10]:44374 "EHLO
	cpanel01.schosting.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755778Ab3GYQMx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jul 2013 12:12:53 -0400
Received: from localhost ([127.0.0.1]:53057 helo=cpanel01.schosting.nl)
	by cpanel01.schosting.nl with esmtpa (Exim 4.80.1)
	(envelope-from <peter@2force.nl>)
	id 1V2O9n-0001bN-IW
	for ceph-devel@vger.kernel.org; Thu, 25 Jul 2013 18:12:47 +0200
In-Reply-To: <alpine.DEB.2.00.1307250845140.29435@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2013-07-25 17:46, Sage Weil wrote:
> On Thu, 25 Jul 2013, peter@2force.nl wrote:
>> We did not upgrade from bobtail to cuttlefish and are still seeing 
>> this issue.
>> I posted this on the ceph-users mailinglist and I missed this thread 
>> (sorry!)
>> so I didn't know.
> 
> That's interesting; a bobtail upgraded cluster was the only way I was 
> able
> to reproduce it, but I'm also working with relatively short-lived 
> clusters
> in a test environment so there may very well be a possibility I 
> missed.
> Can you summarize what the lineage of your cluster is?  (What version 
> was
> it installed with, and when was it upgraded and to what versions?)
> 

Here is what I found:

2013-06-17 17:12:57
===================
0.61.3-1precise

2013-06-20 17:27:50
===================
0.61.3-1precise -> 0.61.4-1precise

2013-07-19 14:04:30
===================
0.61.4-1precise -> 0.61.5-1precise

2013-07-23 17:51:40
===================
0.61.5-1precise -> 0.61.5-2-g7ab701a-1precise

2013-07-24 09:16:52
===================
0.61.5-2-g7ab701a-1precise -> 0.61.6-1precise

2013-07-25 16:35:59
===================
0.61.6-1-g28720b0-1precise -> 0.61.6-15-g24a56a9-1precise

Hope this helps...

>> Either way, I also have an osd crashing after upgrading to 0.61.6. As 
>> said on
>> the other list, I'm more than happy to share log files etc with you 
>> guys.
> 
> Will take a look.
> 
> Thanks!
> sage

Thanks alot!

Peter

> 
> 
>> 
>> Thanks,
>> 
>> Peter
>> 
>>> This is fixed in the cuttlefish branch as of earlier this afternoon. 
>>> I've
>>> spent most of the day expanding the automated test suite to include
>>> upgrade combinations to trigger this and *finally* figured out that 
>>> this
>>> particular problem seems to surface on clusters that upgraded from 
>>> bobtail
>>> -> cuttlefish but not clusters created on cuttlefish.
>> 
>>> If you've run into this issue, please use the cuttlefish branch 
>>> build for
>>> now.  We will have a release out in the next day or so that includes 
>>> this
>>> and a few other pending fixes.
>> 
>>> I'm sorry we missed this one!  The upgrade test matrix I've been 
>>> working
>>> on today should catch this type of issue in the future.
>> 
>>> Thanks!
>>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
