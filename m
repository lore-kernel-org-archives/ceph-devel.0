From: Willem Jan Withagen <wjw@digiware.nl>
Subject: all OSDs crash at more or less the same time
Date: Mon, 7 Mar 2016 00:37:59 +0100
Message-ID: <56DCBF57.10008@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:63438 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbcCFXiV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 6 Mar 2016 18:38:21 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 53AED153413
	for <ceph-devel@vger.kernel.org>; Mon,  7 Mar 2016 00:38:16 +0100 (CET)
Received: from [192.168.10.10] (asus [192.168.10.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 0895C153401
	for <ceph-devel@vger.kernel.org>; Mon,  7 Mar 2016 00:38:00 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

While running cephtool-test-rados.sh "all of a sudden" the OSDs
disapear, I had one of the logs open which contained at the end:

    -2> 2016-03-06 21:56:02.073226 80569ed00  1 heartbeat_map is_healthy
'OSD::osd_op_tp thread 0x806795200' had timed out after 15
    -1> 2016-03-06 21:56:02.073248 80569ed00  1 heartbeat_map is_healthy
'OSD::osd_op_tp thread 0x806795200' had suicide timed out after 150
     0> 2016-03-06 21:56:02.113948 80569ed00 -1 common/HeartbeatMap.cc:
In function 'bool ceph::HeartbeatMap::_check(const ceph::heartbeat_handle_d
*, const char *, time_t)' thread 80569ed00 time 2016-03-06 21:56:02.073269
common/HeartbeatMap.cc: 86: FAILED assert(0 == "hit suicide timeout")

the monitor is still running. It claims the heartbeat_map is valid, but
still it suicides??

And what messages would prevent this from happening?
Receiving heartbeats from other OSDs?

IF so how would a 2 OSD server even survive when its connection would be
split for longer than 2,5 minute?

--WjW
