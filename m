From: Alex Elder <elder@linaro.org>
Subject: [PATCH 0/7] ceph-client: some refactoring patches
Date: Mon, 27 Apr 2015 12:13:08 -0500
Message-ID: <1430154795-17123-1-git-send-email-elder@linaro.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35935 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbbD0RNT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 13:13:19 -0400
Received: by pabsx10 with SMTP id sx10so135725971pab.3
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2015 10:13:19 -0700 (PDT)
Received: from shibby.corp.google.com ([104.135.1.105])
        by mx.google.com with ESMTPSA id ff10sm12124675pab.13.2015.04.27.10.13.18
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Apr 2015 10:13:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Most of this series is just comment changes and a few minor naming
tweaks.  The last two patches actually change code, but the
resulting behavior should be identical to before.

These have been compile tested only.  They (especially the last two)
need to run through teuthology.  The series is based on the current
testing branch:
    5eeb14f ceph: check OSD caps before read/write

					-Alex

Alex Elder (7):
  messenger: update state diagram
  messenger: add some clarifying comments
  messenger: rename "out_kvec_left" field
  osd_client: don't supply connection to handle_reply()
  osd_client: improve safety of osd_req_op_data() macro
  messenger: encapsulate grabbing incoming message
  messenger: con_work() is not really a loop

 include/linux/ceph/messenger.h |   2 +-
 net/ceph/messenger.c           | 254 +++++++++++++++++++++++------------------
 net/ceph/osd_client.c          |  16 +--
 3 files changed, 156 insertions(+), 116 deletions(-)

-- 
2.1.0

