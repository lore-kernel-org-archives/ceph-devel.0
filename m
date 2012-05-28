From: Tomoki BENIYA <beniya@bit-isle.co.jp>
Subject: Appearing messages per 10 sec
Date: Mon, 28 May 2012 19:35:57 +0900
Message-ID: <20120528185235.CBC5.33BC0F0F@bit-isle.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:39013 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753209Ab2E1Kf7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 May 2012 06:35:59 -0400
Received: by pbbrp8 with SMTP id rp8so5121572pbb.33
        for <ceph-devel@vger.kernel.org>; Mon, 28 May 2012 03:35:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, all.

I'm using ceph0.47.2 on Debian7(64bit).
And, I have 2 MDSes.

Following messages are appearing per 10 sec on terminal of mds.1.
But, not appearing on mds.0.

What does these mean? And, how to stop these?
============================================================
Message from syslogd@mds1 at May 28 19:26:03 ...
 ceph-mds: 2012-05-28 19:26:03.497958 7fede74e5700  0 mds.0.bal   mds.0 mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0.05> = 0 ~ 0

Message from syslogd@mds1 at May 28 19:26:03 ...
 ceph-mds: 2012-05-28 19:26:03.497977 7fede74e5700  0 mds.0.bal   mds.1 mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0> = 0 ~ 0

Message from syslogd@mds1 at May 28 19:26:13 ...
 ceph-mds: 2012-05-28 19:26:13.498058 7fede74e5700  0 mds.0.bal   mds.0 mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0.05> = 0 ~ 0

Message from syslogd@mds1 at May 28 19:26:13 ...
 ceph-mds: 2012-05-28 19:26:13.498080 7fede74e5700  0 mds.0.bal   mds.1 mdsload<[0,0 0]/[0,0 0], req 0, hr 0, qlen 0, cpu 0> = 0 ~ 0
============================================================

Thanks.

-- 
Tomoki BENIYA <beniya@bit-isle.co.jp>

