From: Matthew Roy <imjustmatthew@gmail.com>
Subject: mkcephfs "max osd in /etc/ceph/ceph.conf is 2, num osd is 3"
Date: Tue, 4 Jan 2011 05:04:43 -0500
Message-ID: <AANLkTike0z5eyVd-wY+hxtNv3wqEE_DmLxfA98CT5q=5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41635 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab1ADKEo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jan 2011 05:04:44 -0500
Received: by qyk12 with SMTP id 12so15979154qyk.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Jan 2011 02:04:43 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Matthew Roy <matthew@royhousehold.net>

When building a new cluster with 3 osd using mkcephfs I'm getting the
message "max osd in /etc/ceph/ceph.conf is 2, num osd is 3". The
ceph.conf initially didn't define a max osd line at all and adding
"max osd = 4" or "osd max = 4" didn't seem to have any effect on the
message, regardless of the section of the conf file. Looking in
config.cc there doesn't seem to be any option field related to max osd
at all.

After building the cluster anyway, the ceph command reports that
maxosd is now 3 - a workable value, but not what I wanted.

Looking at mkcephfs.in, line 120, where the message originates, it
looks to me like the message is referring to the maximum id listed in
the conf file without any relation to the maxosd parameter of the
cluster. mkcephfs.in seems to be looking for the highest osd id and
incrementing by one to figure out the number of configured osds.

If my understanding is correct this patch will clarify the message and
add a comment explaining what the block of script is doing - nothing
having to do with the cluster maxosd parameter.



From 4b0239b9e4d907ce0c3d1ab75b49fef8c1a708ac Mon Sep 17 00:00:00 2001
From: Matthew Roy <matthew@royhousehold.net>
Date: Fri, 31 Dec 2010 02:42:14 -0500
Subject: [PATCH] mkcephfs: Clarified numosd message

Signed-off-by: Matthew Roy <matthew@royhousehold.net>
---
 src/mkcephfs.in |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/mkcephfs.in b/src/mkcephfs.in
index cac7c39..ee9764e 100644
--- a/src/mkcephfs.in
+++ b/src/mkcephfs.in
@@ -115,9 +115,10 @@ if true; then
     # build osdmap
     osdmap="/tmp/osdmap.$$"
     if [ -z "$numosd" ]; then
+	# find highest osd id - assumes the conf file complies with osd
numbering requirements
 	maxosd=`$CCONF -c $conf -l osd | egrep -v '^osd$' | cut -c 4- | sort
-n | tail -1`
 	numosd=$(($maxosd + 1))
-	echo max osd in $conf is $maxosd, num osd is $numosd
+	echo Highest osd in $conf is osd$maxosd, number of osd is $numosd.
     fi
     $BINDIR/osdmaptool --clobber --createsimple $numosd $osdmap || exit 1

-- 
1.7.1
