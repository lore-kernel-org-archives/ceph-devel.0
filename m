From: Dan Carpenter <error27@gmail.com>
Subject: bug report: potential null deref send_mds_reconnect()
Date: Fri, 14 May 2010 01:36:16 +0200
Message-ID: <20100513233615.GD5695@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48390 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab0EMXgj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 May 2010 19:36:39 -0400
Received: by wyb32 with SMTP id 32so1335594wyb.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 May 2010 16:36:38 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

This is a Smatch thing.

fs/ceph/mds_client.c +2217 send_mds_reconnect(82) error: we previously assumed 'session' could be null.
  2176          down_read(&mdsc->snap_rwsem);
  2177
  2178          if (!session)
  2179                  goto send;

	If we hit this goto then we will dereference session and oops.

  2180          dout("session %p state %s\n", session,
  2181               session_state_name(session->s_state));
 
regards,
dan carpenter
