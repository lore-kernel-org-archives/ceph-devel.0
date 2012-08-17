From: Travis Rhoden <trhoden@gmail.com>
Subject: [PATCH] Use SSH in "service ceph status -a" to get version
Date: Thu, 16 Aug 2012 22:39:11 -0400
Message-ID: <CACkq2movUWvo1cfdXKSKRyb41rg+OW0N1rpzpRn5_-YSd=oZUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64658 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab2HQCjc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Aug 2012 22:39:32 -0400
Received: by qcro28 with SMTP id o28so2731878qcr.19
        for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 19:39:31 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When running "service ceph status -a", a version number was never
returned for remote hosts, only for the local.  This was because
the command to query the version number didn't use the do_cmd
function, which is responsible for running the command over SSH
when needed.

Modify the ceph init.d script to use do_cmd for querying the
Ceph version.

Signed-off-by: Travis Rhoden <trhoden@gmail.com>
---
 src/init-ceph.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/init-ceph.in b/src/init-ceph.in
index a8c5a29..31aeb28 100644
--- a/src/init-ceph.in
+++ b/src/init-ceph.in
@@ -298,7 +298,7 @@ for name in $what; do
        status)
            if daemon_is_running $name ceph-$type $id $pid_file; then
                get_conf asok "/var/run/ceph/ceph-$type.$id.asok" "admin socket"
-               version=`$BINDIR/ceph --admin-daemon $asok version
2>/dev/null || echo unknown`
+               version=`do_cmd "$BINDIR/ceph --admin-daemon $asok
version 2>/dev/null" || echo unknown`
                 echo "$name: running $version"
             elif [ -e "$pid_file" ]; then
                 # daemon is dead, but pid file still exists
--
1.7.4.4
