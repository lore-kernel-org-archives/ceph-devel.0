From: Dan Carpenter <error27@gmail.com>
Subject: potential null dereference in __dcache_readdir()
Date: Fri, 19 Nov 2010 14:52:20 +0300
Message-ID: <20101119115220.GA2111@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37239 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab0KSLwn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Nov 2010 06:52:43 -0500
Received: by wwa36 with SMTP id 36so4527546wwa.1
        for <ceph-devel@vger.kernel.org>; Fri, 19 Nov 2010 03:52:42 -0800 (PST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi hi!

This is a smatch thing.  We check if last is NULL and then dereference
it later with out checking.  It might be worth looking at.  I'm not
familiar enough with the code to know the fix.

It comes from:
	commit 2817b000b02c5f0c05af67c01fb2684e1381d6ef
	Author: Sage Weil <sage@newdream.net>
	Date:   Tue Oct 6 11:31:08 2009 -0700

	    ceph: directory operations

regards,
dan carpenter

fs/ceph/dir.c +124 __dcache_readdir(28) error: we previously assumed 'last' could be null.
   116          /* start at beginning? */
   117          if (filp->f_pos == 2 || (last &&
                                         ^^^^
	checked here.

   118                                   filp->f_pos < ceph_dentry(last)->offset)) {
   119                  if (list_empty(&parent->d_subdirs))
   120                          goto out_unlock;
   121                  p = parent->d_subdirs.prev;
   122                  dout(" initial p %p/%p\n", p->prev, p->next);
   123          } else {
   124                  p = last->d_u.d_child.prev;
                            ^^^^^^^^^^^^^^^^^^^^^^
	dereferenced here.
   125          }

