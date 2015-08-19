From: Mark Nelson <mnelson@redhat.com>
Subject: Ceph Community Lab: Understanding where the QA suites spend time
Date: Wed, 19 Aug 2015 14:46:44 -0500
Message-ID: <55D4DD24.9010100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46446 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651AbbHSTqr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 Aug 2015 15:46:47 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, cbt@lists.ceph.com

Hi Guys,

About a month ago we were going through the process of trying to figure 
out how to replace some of the hardware in the community laboratory that 
runs all of the nightly Teuthology tests.  Given a limited budget to 
replace the existing nodes, we wanted to understand how the current QA 
suites actually spend time on the hardware.  To do this, we investigated 
the composition of suites, the amount of time that is spent in each 
suite, and then a deeper dive into how the most resource intensive jobs 
spend their time.  We then wrote a new benchmark for CBT to run 
ceph-test-rados in a rather naive reproduction of what the ceph task in 
teuthology does and tested it against several different storage device 
configurations to see how much benefit SSDs in the nodes may provide.

A couple of folks at the Hackathon were interested in the paper we 
wrote.  I thought I would share it with the community as well in case 
any folks ever wondered what Teuthology actually spends it's time doing.

http://nhm.ceph.com/community/Ceph_Community_Lab_Performance_Investigation.pdf

Thanks,
Mark
