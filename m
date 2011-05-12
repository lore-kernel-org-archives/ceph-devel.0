From: Brian Chrisman <brchrisman@gmail.com>
Subject: [PATCH 0/2] Update Client to handle self directories
Date: Wed, 11 May 2011 22:26:45 -0700
Message-ID: <1305178007-2927-1-git-send-email-brchrisman@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33941 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab1ELF2r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2011 01:28:47 -0400
Received: by pvg12 with SMTP id 12so561637pvg.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2011 22:28:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Brian Chrisman <brchrisman@gmail.com>

libceph lookup of the self-referencing '.' directory fails.
Patch makes Client class handle '.' specially like it does '..'.
testceph updated to check the special cases of lstat(.) and lstat(/.).

Brian Chrisman (2):
  Add analogous special case for "." directory alongside ".." in
    _lookup
  updated test to cover "." directory stat

 src/client/Client.cc   |    5 +++++
 src/client/testceph.cc |   17 +++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

