From: Willem Jan Withagen <wjw@digiware.nl>
Subject: MDS connection problem
Date: Wed, 15 Nov 2017 20:06:15 +0100
Message-ID: <d635ebd2-7ad0-5313-8245-3cc26b9d02c3@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:43873 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758735AbdKOTGT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 15 Nov 2017 14:06:19 -0500
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id AEA6B2E965
        for <ceph-devel@vger.kernel.org>; Wed, 15 Nov 2017 20:06:16 +0100 (CET)
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

After a server restart my MDS does not want to start, and it looks like 
keys don't match or something?

This is de MDS log:

2017-11-15 20:03:18.180242 9e0e000 10 mds.a MDSDaemon::ms_get_authorizer 
type=mon
2017-11-15 20:03:18.181387 9e0f200 10 cephx: set_have_need_key no 
handler for service mon
2017-11-15 20:03:18.181394 9e0f200 10 cephx: set_have_need_key no 
handler for service mds
2017-11-15 20:03:18.181396 9e0f200 10 cephx: set_have_need_key no 
handler for service osd
2017-11-15 20:03:18.181399 9e0f200 10 cephx: set_have_need_key no 
handler for service mgr
2017-11-15 20:03:18.181401 9e0f200 10 cephx: set_have_need_key no 
handler for service auth
2017-11-15 20:03:18.181402 9e0f200 10 cephx: validate_tickets want 55 
have 0 need 55
2017-11-15 20:03:18.181414 9e0f200 10 cephx client: handle_response ret = 0
2017-11-15 20:03:18.181417 9e0f200 10 cephx client:  got initial server 
challenge 7d0dda00ee4847b8
2017-11-15 20:03:18.181420 9e0f200 10 cephx client: validate_tickets: 
want=55 need=55 have=0
2017-11-15 20:03:18.181424 9e0f200 10 cephx: set_have_need_key no 
handler for service mon
2017-11-15 20:03:18.181426 9e0f200 10 cephx: set_have_need_key no 
handler for service mds
2017-11-15 20:03:18.181427 9e0f200 10 cephx: set_have_need_key no 
handler for service osd
2017-11-15 20:03:18.181428 9e0f200 10 cephx: set_have_need_key no 
handler for service mgr
2017-11-15 20:03:18.181429 9e0f200 10 cephx: set_have_need_key no 
handler for service auth
2017-11-15 20:03:18.181430 9e0f200 10 cephx: validate_tickets want 55 
have 0 need 55
2017-11-15 20:03:18.181433 9e0f200 10 cephx client: want=55 need=55 have=0
2017-11-15 20:03:18.181439 9e0f200 10 cephx client: build_request
2017-11-15 20:03:18.181451 9e0f200 20 cephx client: no secret found for 
entity: mds.a
2017-11-15 20:03:18.182114 9e0f200 10 cephx client: handle_response ret 
= -22
2017-11-15 20:03:18.182214 9b54480 -1 mds.a ERROR: failed to 
authenticate: (22) Invalid argument
2017-11-15 20:03:18.182253 9b54480  1 mds.a suicide.  wanted state up:boot
2017-11-15 20:03:18.182401 9b54480 10 mds.beacon.a set_want_state: 
up:boot -> down:dne
