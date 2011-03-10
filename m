From: Henry Chang <henry.cy.chang@gmail.com>
Subject: PG::Missing::rm
Date: Thu, 10 Mar 2011 18:03:32 +0800
Message-ID: <AANLkTin79SwBJhVyGutV0PXRba7hMR7AF4+UQEWtiUFd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51450 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab1CJKDd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2011 05:03:33 -0500
Received: by gwaa18 with SMTP id a18so349372gwa.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2011 02:03:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I have another question about the function PG::Missing::rm.
I wonder if it should be fixed as follows.

diff --git a/src/osd/PG.cc b/src/osd/PG.cc
index 4ce3336..29062c8 100644
--- a/src/osd/PG.cc
+++ b/src/osd/PG.cc
@@ -3600,7 +3600,7 @@ void PG::Missing::add(const sobject_t& oid,
eversion_t need, eversion_t have)

 void PG::Missing::rm(const sobject_t& oid, eversion_t when)
 {
-  if (missing.count(oid) && missing[oid].need < when) {
+  if (missing.count(oid) && missing[oid].need <= when) {
     rmissing.erase(missing[oid].need);
     missing.erase(oid);
   }

I am not quite sure what the argument "when" means. However, in
PG::merge_old_entry, it seems that the object will be removed from
filestore but left in the missing list due to the if condition in
missing.rm. As in the following code, although missing.rm is called,
but it does not "really" remove the obj from the missing list since
oe.version is equal to missing[oid].need.

    if (oe.is_delete()) {
      dout(20) << "merge_old_entry  had " << oe << " new dne : ok" <<
dendl;
    } else {
      dout(20) << "merge_old_entry  had " << oe << " new dne :
deleting" << dendl;
      t.remove(coll, oe.soid);
      missing.rm(oe.soid, oe.version);
    }

-- 
Henry Chang
