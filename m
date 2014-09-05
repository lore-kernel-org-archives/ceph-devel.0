From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 0/2] libceph: #8806 fix (wip-watch-tid-8806)
Date: Fri,  5 Sep 2014 12:42:44 +0400
Message-ID: <1409906566-5662-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:55721 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840AbaIEImu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Sep 2014 04:42:50 -0400
Received: by mail-wi0-f173.google.com with SMTP id cc10so405628wib.12
        for <ceph-devel@vger.kernel.org>; Fri, 05 Sep 2014 01:42:49 -0700 (PDT)
Received: from localhost ([109.110.66.113])
        by mx.google.com with ESMTPSA id u5sm1207281wia.17.2014.09.05.01.42.47
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Sep 2014 01:42:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

This is a fix for #8806 ("libceph: must use new tid when watch is
resent").  (This problem has been fixed in userspace with commit
5dd68b95b1d2ac0e4972609ca497d4cff28ef351.)

I have tested with pre-"make notify return error code on timeout
(#9193)" and current master - the current master propagates the notify
error, yay!

Thanks,

                Ilya


Ilya Dryomov (2):
  libceph: abstract out ceph_osd_request enqueue logic
  libceph: resend lingering requests with a new tid

 net/ceph/osd_client.c |   96 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 27 deletions(-)

-- 
1.7.10.4

