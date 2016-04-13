From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/8] cifs: Check for equality with ACL_TYPE_ACCESS and ACL_TYPE_DEFAULT
Date: Thu, 14 Apr 2016 00:30:14 +0200
Message-ID: <1460586620-5717-3-git-send-email-agruenba@redhat.com>
References: <1460586620-5717-1-git-send-email-agruenba@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46757 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119AbcDMWa1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Apr 2016 18:30:27 -0400
In-Reply-To: <1460586620-5717-1-git-send-email-agruenba@redhat.com>
In-Reply-To: <20160413182026.GR25498@ZenIV.linux.org.uk>
References: <20160413182026.GR25498@ZenIV.linux.org.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, cluster-devel@redhat.com

The two values ACL_TYPE_ACCESS and ACL_TYPE_DEFAULT are meant to be
enumerations, not bits in a bit mask.  Use '==' instead of '&' to check
for these values.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/cifs/cifssmb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 76fcb50..f24a89c 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -3366,7 +3366,7 @@ static int cifs_copy_posix_acl(char *trgt, char *src, const int buflen,
 	if (le16_to_cpu(cifs_acl->version) != CIFS_ACL_VERSION)
 		return -EOPNOTSUPP;
 
-	if (acl_type & ACL_TYPE_ACCESS) {
+	if (acl_type == ACL_TYPE_ACCESS) {
 		count = le16_to_cpu(cifs_acl->access_entry_count);
 		pACE = &cifs_acl->ace_array[0];
 		size = sizeof(struct cifs_posix_acl);
@@ -3377,7 +3377,7 @@ static int cifs_copy_posix_acl(char *trgt, char *src, const int buflen,
 				 size_of_data_area, size);
 			return -EINVAL;
 		}
-	} else if (acl_type & ACL_TYPE_DEFAULT) {
+	} else if (acl_type == ACL_TYPE_DEFAULT) {
 		count = le16_to_cpu(cifs_acl->access_entry_count);
 		size = sizeof(struct cifs_posix_acl);
 		size += sizeof(struct cifs_posix_ace) * count;
-- 
2.4.11

