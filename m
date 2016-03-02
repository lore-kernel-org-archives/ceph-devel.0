From: Willem Jan Withagen <wjw@digiware.nl>
Subject: OSD not coming up after being set down
Date: Wed, 2 Mar 2016 17:03:33 +0100
Message-ID: <56D70ED5.7080203@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:10424 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016AbcCBQfk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 2 Mar 2016 11:35:40 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id A0BE11534ED
	for <ceph-devel@vger.kernel.org>; Wed,  2 Mar 2016 17:35:35 +0100 (CET)
Received: from [192.168.10.10] (asus [192.168.10.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 7F8CC153401
	for <ceph-devel@vger.kernel.org>; Wed,  2 Mar 2016 17:03:33 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Any handholding is welcomed!!

In test/cephtool-mon-test.sh part of the excuted code is:
 ceph osd down 0
  ceph osd dump | grep 'osd.0 down'
  ceph osd unset noup
  for ((i=0; i < 120; i++)); do
    if ! ceph osd dump | grep 'osd.0 up'; then
      echo "waiting for osd.0 to come back up"
      sleep 1
    else
      break
    fi
  done
  ceph osd dump | grep 'osd.0 up'

But the OSD refused to come back up.
Below the output of the dump.

How would I start analyzing this issue?
What kind of things would I expect to see in the logfile?
  What if the OSD does come up
  What if the OSD stays down

Thanx,
--WjW


*** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
epoch 170
fsid 8b5c0b4b-e08c-11e5-8cd4-1c6f6582ec12
created 2016-03-02 16:36:35.001700
modified 2016-03-02 16:45:17.802073
flags sortbitwise
pool 0 'rbd' replicated size 3 min_size 1 crush_ruleset 0 object_hash
rjenkins pg_num 8 pgp_num 8 last_change 1 flags hashpspool stripe_width 0
max_osd 3
osd.0 down out weight 0 up_from 4 up_thru 163 down_at 166
last_clean_interval [0,0) 127.0.0.1:6804/2455 127.0.0.1:6805/2455
127.0.0.1:6806/2455 127.0.0.1:6807/2455 autoout,exists
8bc29c74-e08c-11e5-8cd4-1c6f6582ec12
osd.1 up   in  weight 1 up_from 8 up_thru 166 down_at 0
last_clean_interval [0,0) 127.0.0.1:6808/2475 127.0.0.1:6811/2475
127.0.0.1:6813/2475 127.0.0.1:6816/2475 exists,up
8d7a2cb5-e08c-11e5-8cd4-1c6f6582ec12
osd.2 up   in  weight 1 up_from 13 up_thru 166 down_at 0
last_clean_interval [0,0) 127.0.0.1:6817/2495 127.0.0.1:6818/2495
127.0.0.1:6819/2495 127.0.0.1:6820/2495 exists,up
8f46df05-e08c-11e5-8cd4-1c6f6582ec12
pg_temp 0.0 [0,2,1]
pg_temp 0.1 [2,0,1]
pg_temp 0.2 [0,1,2]
pg_temp 0.3 [2,0,1]
pg_temp 0.4 [0,2,1]
pg_temp 0.5 [0,2,1]
pg_temp 0.6 [0,1,2]
pg_temp 0.7 [1,0,2]
2016-03-02 16:56:11.027977 8021d7800  0 lockdep stop
