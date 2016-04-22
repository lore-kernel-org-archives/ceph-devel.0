From: Jan Schermer <jan@schermer.cz>
Subject: Re: [ceph-users] On-going Bluestore Performance Testing Results
Date: Fri, 22 Apr 2016 17:54:32 +0200
Message-ID: <4EF91BD6-72DF-49FE-AD0B-B29C677C31A8@schermer.cz>
References: <571A44D0.80704@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33420 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604AbcDVPyf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Apr 2016 11:54:35 -0400
Received: by mail-wm0-f46.google.com with SMTP id 127so10673284wmz.0
        for <ceph-devel@vger.kernel.org>; Fri, 22 Apr 2016 08:54:35 -0700 (PDT)
In-Reply-To: <571A44D0.80704@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: "cbt@lists.ceph.com" <cbt@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Having correlated graphs of CPU and block device usage would be helpful.

To my cynical eye this looks like a clear regression in CPU usage, which was always bottlenecking pure-SSD OSDs, and now got worse.
The gains are from doing less IO on IO-saturated HDDs.

Regression of 70% in 16-32K random writes is the most troubling, that's coincidentaly the average IO size for a DB2, and the biggest bottleneck to its performance I've seen (other databases will be similiar).
It's great 

Btw readahead is not dependant on filesystem (it's a mechanism in the IO scheduler), so it should be present even on a block device, I think? 

Jan
 
 
> On 22 Apr 2016, at 17:35, Mark Nelson <mnelson@redhat.com> wrote:
> 
> Hi Guys,
> 
> Now that folks are starting to dig into bluestore with the Jewel release, I wanted to share some of our on-going performance test data. These are from 10.1.0, so almost, but not quite, Jewel.  Generally bluestore is looking very good on HDDs, but there are a couple of strange things to watch out for, especially with NVMe devices.  Mainly:
> 
> 1) in HDD+NVMe configurations performance increases dramatically when replacing the stock CentOS7 kernel with Kernel 4.5.1.
> 
> 2) In NVMe only configurations performance is often lower at middle-sized IOs.  Kernel 4.5.1 doesn't really help here.  In fact it seems to amplify both the cases where bluestore is faster and where it is slower.
> 
> 3) Medium sized sequential reads are where bluestore consistently tends to be slower than filestore.  It's not clear yet if this is simply due to Bluestore not doing read ahead at the OSD (ie being entirely dependent on client read ahead) or something else as well.
> 
> I wanted to post this so other folks have some ideas of what to look for as they do their own bluestore testing.  This data is shown as percentage differences vs filestore, but I can also release the raw throughput values if people are interested in those as well.
> 
> https://drive.google.com/file/d/0B2gTBZrkrnpZOTVQNkV0M2tIWkk/view?usp=sharing
> 
> Thanks!
> Mark
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

