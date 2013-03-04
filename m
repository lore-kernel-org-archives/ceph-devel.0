From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/3] ceph: simplify ceph_sync_write() page_align calculation
Date: Mon, 04 Mar 2013 12:15:36 -0600
Message-ID: <5134E4C8.4070601@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E46C.9020402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:44098 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758246Ab3CDSPg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:15:36 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so6645697ieb.29
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 10:15:35 -0800 (PST)
In-Reply-To: <5134E46C.9020402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

(This is being reposted.  The first one had a problem because it
erroneously added a similar change elsewhere; that change has been
dropped.)

The next patch in this series points out that the calculation for
the number of pages in an osd request is getting done twice.  It
is not obvious, but the result of both calculations is identical.
This patch simplifies one of them--as a separate step--to make
it clear that the transformation in the next patch is valid.


In ceph_sync_write() there is some magic that computes page_align
for an osd request.  But a little analysis shows it can be
simplified.

First, we have:
 	io_align = pos & ~PAGE_MASK;
which is used here:
	page_align = (pos - io_align + buf_align) & ~PAGE_MASK;

Note (pos - io_align) simply rounds "pos" down to the nearest multiple
of the page size.

We also have:
 	buf_align = (unsigned long)data & ~PAGE_MASK;

Adding buf_align to that rounded-down "pos" value will stay within
the same page; the result will just be offset by the page offset for
the "data" pointer.  The final mask therefore leaves just the value
of "buf_align".

One more simplification.  Note that the result of calc_pages_for()
is invariant of which page the offset starts in--the only thing that
matters is the offset within the starting page.  We will have
put the proper page offset to use into "page_align", so just use
that in calculating num_pages.

This resolves:
    http://tracker.ceph.com/issues/4166

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
---
 fs/ceph/file.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 9c4325e..805678e 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -526,15 +526,10 @@ more:
 	io_align = pos & ~PAGE_MASK;
 	buf_align = (unsigned long)data & ~PAGE_MASK;
 	len = left;
-	if (file->f_flags & O_DIRECT) {
-		/* write from beginning of first page, regardless of
-		   io alignment */
-		page_align = (pos - io_align + buf_align) & ~PAGE_MASK;
-		num_pages = calc_pages_for((unsigned long)data, len);
-	} else {
-		page_align = pos & ~PAGE_MASK;
-		num_pages = calc_pages_for(pos, len);
-	}
+
+	/* write from beginning of first page, regardless of io alignment */
+	page_align = file->f_flags & O_DIRECT ? buf_align : io_align;
+	num_pages = calc_pages_for(page_align, len);
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
 				    ceph_vino(inode), pos, &len,
 				    CEPH_OSD_OP_WRITE, flags,
-- 
1.7.9.5

