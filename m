From: "Stephen Perkins" <perkins@netmass.com>
Subject: Lazy Erasure Coding for RADOS
Date: Mon, 6 Aug 2012 09:50:29 -0500
Message-ID: <00b201cd73e2$d2cf5a60$786e0f20$@netmass.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 142.122.233.72.static.reverse.ltdomains.com ([72.233.122.142]:53918
	"EHLO stgateway01.netmass.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932074Ab2HFOuf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Aug 2012 10:50:35 -0400
Received: from stgateway01.netmass.com (localhost [127.0.0.1])
	by stgateway01.netmass.com (Postfix) with ESMTP id DAADA42202D
	for <ceph-devel@vger.kernel.org>; Mon,  6 Aug 2012 09:50:34 -0500 (CDT)
Received: from sidney (sidney.netmass.com [10.10.120.10])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by stgateway01.netmass.com (Postfix) with ESMTPS id AC18C422023
	for <ceph-devel@vger.kernel.org>; Mon,  6 Aug 2012 09:50:29 -0500 (CDT)
Content-Language: en-us
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I would like to build a fully geo-redundant and highly available storage
solution.  I read a research paper that describes the architecture of the
Microsoft Azure deployment (looking to hit several hundred petabytes soon).
This was presented at the 23rd ACM Symposium on Operating System Principles.
Information and paper here:  

http://blogs.msdn.com/b/windowsazure/archive/2011/11/21/windows-azure-storag
e-a-highly-available-cloud-storage-service-with-strong-consistency.aspx

The thing I took away from it was that Microsoft considered 3 copies locally
to be the minimum number required for protection.  However, they also
realized that you cannot afford to scale to an Exabyte with a 3x overhead
for storage.  So. they have a lazy process that goes around and behind the
scenes and converts objects stored with 3X redundancy to an object that is
erasure coded with Reed-Solomon having a 1.3 or 1.6 overhead.   At the same
time, the RS coding provides a better long term availability than the 3x
replication approach.

Specifics of the RS coding are here (best paper award at Usenix):  

https://www.usenix.org/conference/usenixfederatedconferencesweek/erasure-cod
ing-windows-azure-storage

As far as I have found, there are two implementations of R-S coded object
stores out there:
                Commercial - Cleversafe (http://www.cleversafe.com/)
                Open Source - Tahoe-LAFS (http://www.tahoe-lafs.org/)

Given a certain availability metric, stronger erasure coding can make a HUGE
difference in the cost of deployment.  See "Erasure Coding vs Replication: A
Quantitative Comparison" here:
http://oceanstore.cs.berkeley.edu/publications/papers/pdf/erasure_iptps.pdf

Has any thought been given to implementing stronger erasure coding in RADOS
(either directly or in a lazy fashion)?

Thanks in advance for any thoughts,

- Steve

---
Stephen Perkins
NetMass Incorporated
800-731-2737 x5005
+1-972-838-1520 x5005
perkins@netmass.com
 
NetMassT
The safe data company.


