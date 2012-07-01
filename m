From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Sun, 01 Jul 2012 16:13:40 -0500
Message-ID: <4FF0BD84.1050607@inktank.com>
References: <4FED8792.1090905@profihost.ag> <4FED964D.3080201@inktank.com> <4FEDA777.1060309@profihost.ag> <Pine.LNX.4.64.1206290819170.30691@cobra.newdream.net> <4FEE1B91.8080404@profihost.ag> <4FF0BAB8.3070503@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f42.google.com ([209.85.213.42]:54145 "EHLO
	mail-yw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab2GAVNn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Jul 2012 17:13:43 -0400
Received: by yhfq11 with SMTP id q11so5345463yhf.1
        for <ceph-devel@vger.kernel.org>; Sun, 01 Jul 2012 14:13:43 -0700 (PDT)
In-Reply-To: <4FF0BAB8.3070503@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 7/1/12 4:01 PM, Stefan Priebe wrote:
> Hello list,
> Hello sage,
>
> i've made some further tests.
>
> Sequential 4k writes over 200GB: 300% CPU usage of kvm process 34712 iops
>
> Random 4k writes over 200GB: 170% CPU usage of kvm process 5500 iops
>
> When i make random 4k writes over 100MB: 450% CPU usage of kvm process
> and !! 25059 iops !!
>

When you say 100MB vs 200GB, do you mean the total amount of data that 
is written for the test?  Also, are these starting out on a fresh 
filesystem?  Recently I've been working on tracking down an issue where 
small write performance is degrading as data is written.  The tests I've 
done have been for sequential writes, but I wonder if the problem may be 
significantly worse with random writes.

> Random 4k writes over 1GB: 380% CPU usage of kvm process 14387 iops
>
> So the range where the random I/O happen seem to be important and the
> cpu usage just seem to reflect the iops.
>
> So i'm not sure if the problem is really the client rbd driver. Mark i
> hope you can make some tests next week.

I need to get perf setup on our test boxes, but once I do that I'm 
hoping to follow up on this.

>
> Greets
> Stefan
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

Mark
