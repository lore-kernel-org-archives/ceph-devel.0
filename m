From: Mark Nelson <mnelson@redhat.com>
Subject: On-going Bluestore Performance Testing Results
Date: Fri, 22 Apr 2016 10:35:44 -0500
Message-ID: <571A44D0.80704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41023 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753881AbcDVPfs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Apr 2016 11:35:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "cbt@lists.ceph.com" <cbt@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi Guys,

Now that folks are starting to dig into bluestore with the Jewel 
release, I wanted to share some of our on-going performance test data. 
These are from 10.1.0, so almost, but not quite, Jewel.  Generally 
bluestore is looking very good on HDDs, but there are a couple of 
strange things to watch out for, especially with NVMe devices.  Mainly:

1) in HDD+NVMe configurations performance increases dramatically when 
replacing the stock CentOS7 kernel with Kernel 4.5.1.

2) In NVMe only configurations performance is often lower at 
middle-sized IOs.  Kernel 4.5.1 doesn't really help here.  In fact it 
seems to amplify both the cases where bluestore is faster and where it 
is slower.

3) Medium sized sequential reads are where bluestore consistently tends 
to be slower than filestore.  It's not clear yet if this is simply due 
to Bluestore not doing read ahead at the OSD (ie being entirely 
dependent on client read ahead) or something else as well.

I wanted to post this so other folks have some ideas of what to look for 
as they do their own bluestore testing.  This data is shown as 
percentage differences vs filestore, but I can also release the raw 
throughput values if people are interested in those as well.

https://drive.google.com/file/d/0B2gTBZrkrnpZOTVQNkV0M2tIWkk/view?usp=sharing

Thanks!
Mark
