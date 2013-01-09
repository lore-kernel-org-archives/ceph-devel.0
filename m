From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Are there significant performance enhancements in 0.56.x to be
 expected soon or planned in the near future?
Date: Wed, 09 Jan 2013 08:26:35 -0600
Message-ID: <50ED7E1B.403@inktank.com>
References: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D927F31C3@ABGEX70E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:55885 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757811Ab3AIO0j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 09:26:39 -0500
Received: by mail-ia0-f177.google.com with SMTP id h8so926959iaa.36
        for <ceph-devel@vger.kernel.org>; Wed, 09 Jan 2013 06:26:39 -0800 (PST)
In-Reply-To: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D927F31C3@ABGEX70E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Lachfeld, Jutta" <jutta.lachfeld@ts.fujitsu.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/09/2013 06:51 AM, Lachfeld, Jutta wrote:
> Hi all,
>
> in expectation of better performance, we are just switching from CEPH version 0.48 to 0.56.1
> for comparisons between Hadoop with HDFS and Hadoop with CEPH FS.
>
> We are now wondering whether there are currently any development activities
> concerning further significant performance enhancements,
> or whether further significant performance enhancements are already planned for the near future.
>
> I would now be loath to start benchmarking with 0.56.1 and then, a month or so later, detect that there have been significant performance enhancements in CEPH in the meantime.
>
> Regards,
> Jutta.
>
> -
> jutta.lachfeld@ts.fujitsu.com, Fujitsu Technology Solutions PBG PDG ES&S SWE SOL 4, "Infrastructure Solutions", MchD 5B, Tel. ..49-89-3222-2705, Company Details: http://de.ts.fujitsu.com/imprint
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Hi Jutta,

As Wido mentioned there have been some performance improvements, 
especially with small IO sizes.  The conclusion section of the 
performance preview may be useful for you:

http://ceph.com/uncategorized/argonaut-vs-bobtail-performance-preview/

One oddity is that there may have been some regression for 128k reads. 
Overall though I'd say that performance has improved, especially on XFS.

I don't think it's likely we will be pushing any performance patches to 
the bobtail series, but it's possible performance could change as a 
result of a bug fix.

For what it's worth, I've started performing sweeps over ceph parameter 
spaces (and looking at underlying io schedulers) to see how tuning 
affects ceph performance under different scenarios.  I'm hoping to be 
able to release the results later this month.

Mark
