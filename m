From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: Re: cmds segfault on pdj-fstest (ceph.git unstable)
Date: Thu, 10 Jun 2010 19:38:14 +0800
Message-ID: <AANLkTikoEestUHujD0_TcG0haFOcOX4pYPVodpr6NOKF@mail.gmail.com>
References: <hundgq$ums$1@dough.gmane.org>
	<huqcjt$khk$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52714 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601Ab0FJLiR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jun 2010 07:38:17 -0400
Received: by vws17 with SMTP id 17so3705197vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jun 2010 04:38:15 -0700 (PDT)
In-Reply-To: <huqcjt$khk$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

>
>    add checks for being a snapshot root to dir_is_nonempty
>
> :040000 040000 6c45c68b84800b105299133374f0f91d82948659 2c1b290125ae435679ab29d6fbab7f5b8f81e4b9 M      src
>

I also got this segfault today. The segfault is caused by:
_dir_is_nonempty() has already done reply_request(), but the caller,
handle_client_unlink(), did it again.

I suggest to move out reply_request() from _dir_is_nonempty(), and
leave it to the caller.
Maybe as below:

Henry


===========================================
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 29d0a32..4a90f4e 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -3976,7 +3976,6 @@ bool Server::_dir_is_nonempty(MDRequest *mdr, CInode *in)
               << dir->inode->get_projected_inode()->dirstat.size()
               << " on " << *dir->inode
               << dendl;
-      reply_request(mdr, -ENOTEMPTY);
       return true;
     }

@@ -4070,8 +4069,10 @@ void Server::handle_client_rename(MDRequest *mdr)
     }

     // non-empty dir?
-    if (oldin->is_dir() && _dir_is_nonempty(mdr, oldin))
+    if (oldin->is_dir() && _dir_is_nonempty(mdr, oldin)) {
+      reply_request(mdr, -ENOTEMPTY);
       return;
+    }
   }

   // -- some sanity checks --
