From: ramu eppa <ramu.freesystems@gmail.com>
Subject: Re: RADOS gateway and the S3 compatibility.
Date: Tue, 28 Aug 2012 03:48:49 +0000 (UTC)
Message-ID: <loom.20120828T054548-835@post.gmane.org>
References: <loom.20120827T091156-421@post.gmane.org> <CAC-hyiHm+-aU9pfXE_eb2Gpji2vC3U15YfBwyLMF4XsZRMWkBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:56406 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894Ab2H1DtC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Aug 2012 23:49:02 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1T6CnU-00064R-6B
	for ceph-devel@vger.kernel.org; Tue, 28 Aug 2012 05:49:00 +0200
Received: from 81-254-187-203.static.youbroadband.in ([81-254-187-203.static.youbroadband.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 05:49:00 +0200
Received: from ramu.freesystems by 81-254-187-203.static.youbroadband.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 05:49:00 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

   I configured apache correctly and it was running correctly.
The apache2 error log is,

radosgw: must specify 'rgw socket path' to run as a daemon
[Tue Aug 28 08:59:10 2012] [warn] FastCGI: (dynamic) server "/var/www/s3gw.fcgi" 
(pid 6492) terminated by calling exit with status '1'
[Tue Aug 28 08:59:10 2012] [warn] FastCGI: (dynamic) server "/var/www/s3gw.fcgi" 
has failed to remain running for 30 seconds given 3 attempts, its restart 
interval has been backed off to 600 seconds
[Tue Aug 28 08:59:10 2012] [warn] FastCGI: server "/usr/local/bin/radosgw" has 
failed to remain running for 30 seconds given 3 attempts, its restart interval 
has been backed off to 600 seconds
[Tue Aug 28 09:04:10 2012] [warn] FastCGI: (dynamic) server "/var/www/s3gw.fcgi" 
has failed to remain running for 30 seconds given 3 attempts, its restart 
interval has been backed off to 600 seconds
[Tue Aug 28 09:04:10 2012] [warn] FastCGI: server "/usr/local/bin/radosgw" has 
failed to remain running for 30 seconds given 3 attempts, its restart interval 
has been backed off to 600 seconds
[Tue Aug 28 09:09:02 2012] [warn] FastCGI: (dynamic) server "/var/www/s3gw.fcgi" 
has failed to remain running for 30 seconds given 3 attempts, its restart 
interval has been backed off to 600 seconds
[Tue Aug 28 09:09:02 2012] [warn] FastCGI: server "/usr/local/bin/radosgw" has 
failed to remain running for 30 seconds given 3 attempts, its restart interval 
has been backed off to 600 seconds
[Tue Aug 28 09:09:02 2012] [warn] FastCGI: server "/usr/local/bin/radosgw" (uid 
33, gid 33) restarted (pid 6504)
radosgw: must specify 'rgw socket path' to run as a daemon
[Tue Aug 28 09:09:02 2012] [warn] FastCGI: server "/usr/local/bin/radosgw" (pid 
6504) terminated by calling exit with status '1'
[Tue Aug 28 09:09:02 2012] [warn] FastCGI: (dynamic) server "/var/www/s3gw.fcgi" 
has failed to remain running for 30 seconds given 3 attempts, its restart 
interval has been backed off to 600 seconds
[Tue Aug 28 09:09:02 2012] [warn] FastCGI: server "/usr/local/bin/radosgw" has 
failed to remain running for 30 seconds given 3 attempts, its restart interval 
has been backed off to 600 seconds
[Tue Aug 28 09:09:10 2012] [warn] FastCGI: (dynamic) server "/var/www/s3gw.fcgi" 
has failed to remain running for 30 seconds given 3 attempts, its restart 
interval has been backed off to 600 seconds
[Tue Aug 28 09:09:10 2012] [warn] FastCGI: (dynamic) server "/var/www/s3gw.fcgi" 
(uid 0, gid 0) restarted (pid 6510)
[Tue Aug 28 09:09:10 2012] [warn] FastCGI: server "/usr/local/bin/radosgw" has 
failed to remain running for 30 seconds given 3 attempts, its restart interval 
has been backed off to 600 seconds
radosgw: must specify 'rgw socket path' to run as a daemon
[Tue Aug 28 09:09:11 2012] [warn] FastCGI: (dynamic) server "/var/www/s3gw.fcgi" 
(pid 6510) terminated by calling exit with status '1'
[Tue Aug 28 09:09:11 2012] [warn] FastCGI: (dynamic) server "/var/www/s3gw.fcgi" 
has failed to remain running for 30 seconds given 3 attempts, its restart 
interval has been backed off to 600 seconds
[Tue Aug 28 09:09:11 2012] [warn] FastCGI: server "/usr/local/bin/radosgw" has 
failed to remain running for 30 seconds given 3 attempts, its restart interval 
has been backed off to 600 seconds
[Tue Aug 28 09:14:11 2012] [warn] FastCGI: (dynamic) server "/var/www/s3gw.fcgi" 
has failed to remain running for 30 seconds given 3 attempts, its restart 
interval has been backed off to 600 seconds
[Tue Aug 28 09:14:11 2012] [warn] FastCGI: server "/usr/local/bin/radosgw" has 
failed to remain running for 30 seconds given 3 attempts, its restart interval 
has been backed off to 600 seconds

Thanks,
Ramu.


