From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH 4/4] radosgw_admin: Update manpage to new syntax
Date: Sun, 17 Apr 2011 11:32:04 +0200
Message-ID: <1303032724-13456-4-git-send-email-wido@widodh.nl>
References: <1303032724-13456-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:56622 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab1DQJcY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Apr 2011 05:32:24 -0400
In-Reply-To: <1303032724-13456-1-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 man/radosgw_admin.8 |   70 ++++++++++++++++++++++++++++++++++----------------
 1 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/man/radosgw_admin.8 b/man/radosgw_admin.8
index f85685a..702474a 100644
--- a/man/radosgw_admin.8
+++ b/man/radosgw_admin.8
@@ -2,14 +2,23 @@
 .SH NAME
 radosgw_admin \- rados REST gateway user administration utility
 .SH SYNOPSIS
-.B radosgw_admin
-[ \fB\-\-user\-gen\fR ]
-[ \fB\-\-user\-modify\fR ]
-[ \fB\-\-read\-policy\fR ]
-[ \fB\-\-list\-buckets\fR ] [ options ... ]
+.B radosgw_admin <cmd> [options..]
 .SH DESCRIPTION
 .B radosgw_admin
 is a RADOS gateway user administration utility. It allows creating and modifying users.
+.SH COMMANDS
+.TP
+\fBcmd\fR can be one of the following options:
+.IP
+ user create    Create a new user
+ user modify    Modify a user
+ user info      Display information of a user
+ user rm        Remove a user
+ bucket list    List all buckets
+ bucket unlink  Remove a bucket
+ policy         Display bucket/object policy
+ log show       Show the log of a bucket (with a specified date)
+.PP
 .SH OPTIONS
 .TP
 \fB\-c\fI ceph.conf\fR, \fB\-\-conf=\fIceph.conf\fR
@@ -19,40 +28,55 @@ to determine monitor addresses during startup.
 \fB\-m\fI monaddress[:port]\fR
 Connect to specified monitor (instead of looking through \fIceph.conf\fR).
 .TP
-\fB\-\-user\-gen\fR
-Generate a new user.
-.TP
-\fB\-\-user\-modify\fR
-Modify an existing user.
+\fB\-\-uid=\fIuid\fR
+The S3 user/access key.
 .TP
-\fB\-\-read\-policy\fR
-Show the ACL policy of an bucket or object.
-.TP
-\fB\-\-list\-buckets\fR
-Dump the list of buckets that belong to a specific user.
-.TP
-\fB\-\-uid=\fIid\fR
-Specify the user id for this operation.
-.TP
-\fB\-\-secret=\fIkey\fR
-Configure the secret key for this user.
+\fB\-\-secret=\fIsecret\fR
+The S3 secret.
 .TP
 \fB\-\-display\-name=\fIname\fR
 Configure the display name of the user.
 .TP
+\fB\-\-email=\fIemail\fR
+The e-mail address of the user
+.TP
 \fB\-\-bucket=\fIbucket\fR
 Specify the bucket name.
 .TP
 \fB\-\-object=\fIobject\fR
 Specify the object name.
+.TP
+\fB\-\-date=\fIyyyy-mm-dd\fR
+The date need for some commands
+.TP
+\fB\-\-os\-user=\fIgroup:name\fR
+The OpenStack user (only needed for use with OpenStack)
+.TP
+\fB\-\-os\-secret=\fIkey\fR
+The OpenStack key
+.TP
+\fB\-\-auth\-uid=\fIauid\fR
+The librados auid
 .SH EXAMPLES
-To generate a new user:
+Generate a new user
 .IP
- $ ./radosgw_admin --user-gen --display-name="johnny rotten" --email=johnny@rotten.com
+ $ radosgw_admin user gen --display-name="johnny rotten" --email=johnny@rotten.com
  User ID: CHBQFRTG26I8DGJDGQLW
  Secret Key: QR6cI/31N+J0VKVgHSpEGVSfEEsmf6PyXG040KCB
  Display Name: johnny rotten
 .PP
+Remove a user
+.IP
+ $ radosgw_admin user rm --uid=CHBQFRTG26I8DGJDGQLW
+.PP
+Remove a bucket
+.IP
+ $ radosgw_admin bucket unlink --bucket=foo
+.PP
+Thow the logs of a bucket from April 1st 2011
+.IP
+ $ radosgw_admin log show --bucket=foo --date=2011=04-01
+.PP
 .SH AVAILABILITY
 .B radosgw_admin
 is part of the Ceph distributed file system.  Please refer to the Ceph wiki at
-- 
1.7.0.4

