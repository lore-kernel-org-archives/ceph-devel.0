From: Andrew Thompson <andrewkt@aktzero.com>
Subject: Re: Very unbalanced storage
Date: Fri, 31 Aug 2012 12:24:18 -0400
Message-ID: <5040E532.6040306@aktzero.com>
References: <50409BDC.5010006@gmail.com> <5040D179.5000008@aktzero.com> <alpine.DEB.2.00.1208310908520.1531@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1a.cologlobal.com ([96.125.182.177]:57505 "EHLO
	mx1.cologlobal.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753666Ab2HaQZn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 12:25:43 -0400
Received: from mail3.hspheredns.com ([208.77.157.24])
	by mx1.cologlobal.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80)
	(envelope-from <andrewkt@aktzero.com>)
	id 1T7U2N-0007mj-KT
	for ceph-devel@vger.kernel.org; Fri, 31 Aug 2012 12:25:42 -0400
In-Reply-To: <alpine.DEB.2.00.1208310908520.1531@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 8/31/2012 12:10 PM, Sage Weil wrote:
> On Fri, 31 Aug 2012, Andrew Thompson wrote:
>> Have you been reweight-ing osds? I went round and round with my 
>> cluster a few days ago reloading different crush maps only to find 
>> that it re-injecting a crush map didn't seem to overwrite reweights. 
>> Take a look at `ceph osd tree` to see if the reweight column matches 
>> the weight column. 
> Note that the ideal situation is for reweight to be 1, regardless of what
> the crush weight is.  If you find the utilizations are skewed, I would
> look for other causes before resorting to reweight-by-utilization; it is
> meant to adjust the normal statistical variation you expect from a
> (pseudo)random placement, but if the variance is high there is likely
> another cause.

So if someone(me, guilty) had been messing with reweight, will setting 
them all to 1 return it to a normal un-reweight-ed state?

-- 
Andrew Thompson
http://aktzero.com/

