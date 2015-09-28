From: Mark Nelson <mark.a.nelson@gmail.com>
Subject: Follow-Up on Alexandre's Transparent Huge Pages Testing
Date: Mon, 28 Sep 2015 18:33:32 -0500
Message-ID: <5609CE4C.5060403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34564 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbbI1Xdf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 19:33:35 -0400
Received: by igcpb10 with SMTP id pb10so67902845igc.1
        for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 16:33:34 -0700 (PDT)
Received: from ?IPv6:2601:444:c001:7300::579b? ([2601:444:c001:7300::579b])
        by smtp.googlemail.com with ESMTPSA id hh9sm9176284igb.18.2015.09.28.16.33.33
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2015 16:33:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Everyone,

A while back Alexandre Derumier posted some test results looking at how 
transparent huge pages can reduce memory usage with jemalloc.  I went 
back and ran a number of new tests on the community performance cluster 
to verify his findings and also look at how performance and cpu usage 
were affected, both during various fio benchmark tests and also during a 
4k random write recovery scenario.  I tested tcmalloc 2.4 with 32MB 
thread cache, 128MB thread cache, and jemalloc 4.0.

The gist of it is that I also see a reduction in memory usage, most 
pronounced with jemalloc.  Unfortuantely the best reduction in memory 
usage is when memory usage is already fairly low.  The most important 
case is the memory spike when OSDs are marked back up/in during a 
recovery test.  In this case there is still a benefit, though memory 
usage is still a little higher than TCMalloc with 128MB thread cache. 
There's a little bit of a concerning trend where memory usage appears to 
increase fairly quickly after the recovery test is complete and the 
post-recovery phase of the benchmark is running.  That will likely need 
to be investigate in more depth.

I have been doing some other tests with the async messenger and 
newstore, but those will have to wait for another paper.

Here's are the results:

https://drive.google.com/file/d/0B2gTBZrkrnpZY3U3TUU3RkJVeVk/view

Mark
