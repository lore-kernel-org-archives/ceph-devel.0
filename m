From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/5] libceph: use void pointers in page vector functions
Date: Fri, 08 Feb 2013 10:32:35 -0600
Message-ID: <511528A3.9090406@inktank.com>
References: <51152847.2030305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:53995 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759956Ab3BHQcj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 11:32:39 -0500
Received: by mail-ia0-f176.google.com with SMTP id i18so4369907iac.21
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 08:32:38 -0800 (PST)
In-Reply-To: <51152847.2030305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The functions used for working with ceph page vectors are defined
with char pointers, but they're really intended to operate on
untyped data.  Change the types of these function parameters
to (void *) to reflect this.

(Note that the functions now assume void pointer arithmetic works
like arithmetic on char pointers.)

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/libceph.h |   10 +++++-----
 net/ceph/pagevec.c           |   10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index c44275a..2250f8b 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -222,7 +222,7 @@ extern int ceph_open_session(struct ceph_client
*client);
 /* pagevec.c */
 extern void ceph_release_page_vector(struct page **pages, int num_pages);

-extern struct page **ceph_get_direct_page_vector(const char __user *data,
+extern struct page **ceph_get_direct_page_vector(const void __user *data,
 						 int num_pages,
 						 bool write_page);
 extern void ceph_put_page_vector(struct page **pages, int num_pages,
@@ -230,15 +230,15 @@ extern void ceph_put_page_vector(struct page
**pages, int num_pages,
 extern void ceph_release_page_vector(struct page **pages, int num_pages);
 extern struct page **ceph_alloc_page_vector(int num_pages, gfp_t flags);
 extern int ceph_copy_user_to_page_vector(struct page **pages,
-					 const char __user *data,
+					 const void __user *data,
 					 loff_t off, size_t len);
 extern int ceph_copy_to_page_vector(struct page **pages,
-				    const char *data,
+				    const void *data,
 				    loff_t off, size_t len);
 extern int ceph_copy_from_page_vector(struct page **pages,
-				    char *data,
+				    void *data,
 				    loff_t off, size_t len);
-extern int ceph_copy_page_vector_to_user(struct page **pages, char
__user *data,
+extern int ceph_copy_page_vector_to_user(struct page **pages, void
__user *data,
 				    loff_t off, size_t len);
 extern void ceph_zero_page_vector_range(int off, int len, struct page
**pages);

diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
index cd9c21d..5b20be9 100644
--- a/net/ceph/pagevec.c
+++ b/net/ceph/pagevec.c
@@ -12,7 +12,7 @@
 /*
  * build a vector of user pages
  */
-struct page **ceph_get_direct_page_vector(const char __user *data,
+struct page **ceph_get_direct_page_vector(const void __user *data,
 					  int num_pages, bool write_page)
 {
 	struct page **pages;
@@ -93,7 +93,7 @@ EXPORT_SYMBOL(ceph_alloc_page_vector);
  * copy user data into a page vector
  */
 int ceph_copy_user_to_page_vector(struct page **pages,
-					 const char __user *data,
+					 const void __user *data,
 					 loff_t off, size_t len)
 {
 	int i = 0;
@@ -119,7 +119,7 @@ int ceph_copy_user_to_page_vector(struct page **pages,
 EXPORT_SYMBOL(ceph_copy_user_to_page_vector);

 int ceph_copy_to_page_vector(struct page **pages,
-				    const char *data,
+				    const void *data,
 				    loff_t off, size_t len)
 {
 	int i = 0;
@@ -143,7 +143,7 @@ int ceph_copy_to_page_vector(struct page **pages,
 EXPORT_SYMBOL(ceph_copy_to_page_vector);

 int ceph_copy_from_page_vector(struct page **pages,
-				    char *data,
+				    void *data,
 				    loff_t off, size_t len)
 {
 	int i = 0;
@@ -170,7 +170,7 @@ EXPORT_SYMBOL(ceph_copy_from_page_vector);
  * copy user data from a page vector into a user pointer
  */
 int ceph_copy_page_vector_to_user(struct page **pages,
-					 char __user *data,
+					 void __user *data,
 					 loff_t off, size_t len)
 {
 	int i = 0;
-- 
1.7.9.5

