From: Brian Chrisman <brchrisman@gmail.com>
Subject: [PATCH 0/2] fix null deref in readdir_r callback and test
Date: Thu, 12 May 2011 23:39:36 -0700
Message-ID: <1305268778-18691-1-git-send-email-brchrisman@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46751 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581Ab1EMGjs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2011 02:39:48 -0400
Received: by pvg12 with SMTP id 12so1030673pvg.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 May 2011 23:39:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Brian Chrisman <brchrisman@gmail.com>

_readdir_single_dirent_cb is invoked with zeroed pointers when called beneath readdir_r rather than directly readdirplus_r.
Those pointers are then dereferenced in assignment.
There is still a problem in readdir_r, so I extended the basic scenario in testceph.cc.
Methods readdir_r and readdirplus_r are bypassed in cfuse.

Brian Chrisman (2):
  fix null deref when callback invoked en route from readdir_r rather
    than readdirplus_r
  add basic test case for readdir_r

 src/client/Client.cc   |    8 ++++++--
 src/client/testceph.cc |   36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 3 deletions(-)

