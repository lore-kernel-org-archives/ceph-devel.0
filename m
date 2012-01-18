From: =?ISO-8859-15?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Subject: another Problem / question
Date: Wed, 18 Jan 2012 14:13:38 +0100
Message-ID: <4F16C582.7010403@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-5.de-punkt.de ([93.190.64.35]:33253 "EHLO
	mail-5.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704Ab2ARNNn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2012 08:13:43 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

todo i've done few performance tests with my two clusters.

I've used : rados -p data load-gen --run-length 10 --target-throughput 50

to generate some load. Now i have a question regarding "ceph -w" output.

The output before the test was:

2012-01-18 11:55:28.621107    pg v113011: 594 pgs: 594 peering; 61022 MB
data, 120 GB used, 244 GB / 372 GB avail

here is the output after the test:

2012-01-18 13:53:30.190602    pg v113119: 594 pgs: 594 active+clean;
1058 GB data, 120 GB used, 244 GB / 372 GB avail

How can i have more Data then the available discspace ? Is there any
possiblity to identify the rados objects of this test and delete them
manualy ?

The "xxxx GB Data" value fills up in a few seconds. So i think this
might be a display problem.

This happens on my 0.39 Cluster and also on my 0.40 cluster.

Thanks a lot

Jens
