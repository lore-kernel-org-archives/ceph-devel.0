From: Li Wang <liwang@ubuntukylin.com>
Subject: Performance results on inline data support
Date: Mon, 30 Sep 2013 16:34:04 +0800
Message-ID: <5249377C.8030003@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:55325 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab3I3Inj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Sep 2013 04:43:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>

Hi,
   We did a performance test on inline data support, the Ceph cluster is 
composed of 1 MDS, 1 MON, 6 OSD on a HPC cluster. The program is simple,
there are 1000 - 3000 files with each being 1KB. The program repeated 
the following processes on each file: open(), read(), close(). The total 
time is measured with/without inline data support. The results are as 
follows (seconds),

#files  without    with
1000    17.3674	  8.7186
2000    35.4848	  17.7646
3000    53.2164	  26.4374

Cheers,
Li Wang
