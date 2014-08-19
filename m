From: Dhiraj Kamble <Dhiraj.Kamble@sandisk.com>
Subject: Swift Upload/Post failing - 403 Forbidden
Date: Tue, 19 Aug 2014 05:34:05 +0000
Message-ID: <AE39FC098EAC574B88212DCCB67F06AF05DA4CF9@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1blp0189.outbound.protection.outlook.com ([207.46.163.189]:41851
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752586AbaHSFeV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Aug 2014 01:34:21 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Recent changes to rgw(post ceph 0.78), caused an issue while creating a key for SWIFT subuser. An empty string is entered into the .users.swift pool instead of the expected id(user:subuser). Although "radosgw-admin user info" shows the required information; when doing a swift put; rgw errors out with 403; as the required user does not match with the users in .users.swift pool.

Doing a "rados ls -p .users.swift" will show nothing -  it's  an empty string and goes unnoticed.
Infact, one can do Swift Uploads/Puts using an empty string as the swift user; but will give an 403 if you specify the "user:subuser" instead.

Several users on the ceph-users mailing list have also reported similar issues.

Opened a tracker: http://tracker.ceph.com/issues/9155
Here's the pull request:  https://github.com/ceph/ceph/pull/2281

Please find below the diff.
The fix also takes care of an user specifying an access key as an input while creating a SWIFT key - which should not be allowed(we could do some checking & clean up there). The user specifying "--gen-access-key" option is just fine; cause it just sets the "gen_access" variable to true - which is used to create the id during SWIFT key creation. An access key is required only for S3; providing one while creating a SWIFT key will cause the swift id to be set as the "access key"  instead of the expected "user:subuser" id.
This will cause the access key to be entered into the .users.swift pool instead of the subuser "user:subuser". So we again hit 403 error when we try using expected "user:subuser" as the swift user.

No doing a "rados ls -p .users.swift" will show the expected users and not an empty string or the access key(if specified).


diff --git a/src/rgw/rgw_user.cc b/src/rgw/rgw_user.cc
index f21670a..a8d06b1 100644
--- a/src/rgw/rgw_user.cc
+++ b/src/rgw/rgw_user.cc
@@ -1040,6 +1040,15 @@ int RGWAccessKeyPool::add(RGWUserAdminOpState& op_state, std::string *err_msg, b
   int ret;
   std::string subprocess_msg;

+  if (op_state.get_key_type() == KEY_TYPE_SWIFT && !op_state.will_gen_access()) {
+    if (op_state.get_access_key().empty()) {
+      op_state.set_gen_access();
+    } else {
+      set_err_msg(err_msg, "access key was specified during SWIFT key creation");
+      return -EINVAL;
+    }
+  }
+
   ret = check_op(op_state, &subprocess_msg);
   if (ret < 0) {
     set_err_msg(err_msg, "unable to parse request, " + subprocess_msg);


Regards,
Dhiraj


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

