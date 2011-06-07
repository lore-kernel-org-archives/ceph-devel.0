From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: O_DIRECT change
Date: Tue, 7 Jun 2011 17:39:42 +0800
Message-ID: <BANLkTi=-opE84qCKbzw0+3mjiJGP+Nzp6A@mail.gmail.com>
References: <Pine.LNX.4.64.1106030939020.27322@cobra.newdream.net>
	<BANLkTimgt0aW800==OCj72ocrAizJSfFjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46076 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab1FGJjn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jun 2011 05:39:43 -0400
Received: by fxm17 with SMTP id 17so2951229fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jun 2011 02:39:42 -0700 (PDT)
In-Reply-To: <BANLkTimgt0aW800==OCj72ocrAizJSfFjw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

I checked the stripe_read function and think the following two patches
are needed:

1. Move hit_stripe/was_short checking after the adjustment of
ceph_osdc_readpages return code

    Fix the following case:
    (i) Create a sparse file
        dd if=/dev/zero of=/mnt/fs_depot/dd3 bs=1 seek=1048576 count=0

    (ii) Read the file
        dd if=/mnt/fs_depot/dd3 of=/root/ddout1 skip=8 bs=500 count=2
iflag=direct

diff --git a/ceph/file.c b/ceph/file.c
index 1f36e2c..6e6297a 100644
--- a/ceph/file.c
+++ b/ceph/file.c
@@ -313,16 +313,18 @@ more:
                page_align = (pos - io_align + buf_align) & ~PAGE_MASK;
        else
                page_align = pos & ~PAGE_MASK;
+
        this_len = left;
        ret = ceph_osdc_readpages(&fsc->client->osdc, ceph_vino(inode),
                                  &ci->i_layout, pos, &this_len,
                                  ci->i_truncate_seq,
                                  ci->i_truncate_size,
                                  page_pos, pages_left, page_align);
-       hit_stripe = this_len < left;
-       was_short = ret >= 0 && ret < this_len;
        if (ret == -ENOENT)
                ret = 0;
+
+       hit_stripe = this_len < left;
+       was_short = ret >= 0 && ret < this_len;
        dout("striped_read %llu~%u (read %u) got %d%s%s\n", pos, left, read,
             ret, hit_stripe ? " HITSTRIPE" : "", was_short ? " SHORT" : "");


2. Fix didpages and the starting position of ceph_zero_page_vector_range

    This fixes segfault caused by the following scenario:
    (i) generate a sparse file by
        dd if=/dev/urandom of=/mnt/fs_depot/dd10 bs=500 seek=8388 count=1
    (ii) read the file from offset 4194300~500
        dd if=/mnt/fs_depot/dd10 of=/root/dd10out bs=500 skip=8388 count=1

diff --git a/ceph/file.c b/ceph/file.c
index 6e6297a..d7932bc 100644
--- a/ceph/file.c
+++ b/ceph/file.c
@@ -291,7 +291,6 @@ static int striped_read(struct inode *inode,
        struct ceph_inode_info *ci = ceph_inode(inode);
        u64 pos, this_len;
        int io_align, page_align;
-       int page_off = off & ~PAGE_CACHE_MASK; /* first byte's offset in page */
        int left, pages_left;
        int read;
        struct page **page_pos;
@@ -329,12 +328,11 @@ more:
             ret, hit_stripe ? " HITSTRIPE" : "", was_short ? " SHORT" : "");

        if (ret > 0) {
-               int didpages =
-                       ((pos & ~PAGE_CACHE_MASK) + ret) >> PAGE_CACHE_SHIFT;
+               int didpages = (page_align + ret) >> PAGE_CACHE_SHIFT;

                if (read < pos - off) {
                        dout(" zero gap %llu to %llu\n", off + read, pos);
-                       ceph_zero_page_vector_range(page_off + read,
+                       ceph_zero_page_vector_range(page_align + read,
                                                    pos - off - read, pages);
                }
                pos += ret;
@@ -359,7 +357,7 @@ more:
                                left = inode->i_size - pos;

                        dout("zero tail %d\n", left);
-                       ceph_zero_page_vector_range(page_off + read, left,
+                       ceph_zero_page_vector_range(page_align + read, left,
                                                    pages);
                        read += left;
                }
