From: Willem Jan Withagen <wjw@digiware.nl>
Subject: AttributeError: 'Rados' object has no attribute 'monitor_log'
Date: Wed, 6 Jul 2016 19:22:15 +0200
Message-ID: <30f6bbac-0b8b-b241-b58d-e3960051ad7c@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:47162 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754168AbcGFRW7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Jul 2016 13:22:59 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id BD0E31534C7
	for <ceph-devel@vger.kernel.org>; Wed,  6 Jul 2016 19:22:24 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I'm trying to run cephtool-test-mon.sh, and it gets there quite far
but somewhere down the test I have this error:
Now python is not my strong point.

Where should I start looking?

--WjW

/home/wjw/Ceph/work.cmake/ceph/qa/workunits/cephtool/test.sh:159:
ceph_watch_start:  sleep 1
5: Traceback (most recent call last):
5:   File "/home/wjw/Ceph/work.cmake/ceph/build/bin/ceph", line 948, in
<module>
5:     retval = main()
5:   File "/home/wjw/Ceph/work.cmake/ceph/build/bin/ceph", line 775, in main
5:     run_in_thread(cluster_handle.monitor_log, level, watch_cb, 0)
5: AttributeError: 'Rados' object has no attribute 'monitor_log'

