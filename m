From: Sage Weil <sage@newdream.net>
Subject: Re: operate one file in multi clients with libceph
Date: Wed, 18 May 2011 09:01:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105180858360.1988@cobra.newdream.net>
References: <BANLkTi=wd0+u774vRNDJZoXW_EoE9OP67Q@mail.gmail.com>
 <BANLkTinaHaWSpm81LeOHSSpkoqjDyqB5Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34654 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756958Ab1ERQAA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2011 12:00:00 -0400
In-Reply-To: <BANLkTinaHaWSpm81LeOHSSpkoqjDyqB5Nw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Simon,

On Wed, 18 May 2011, Simon Tian wrote:

> Hi,
> 
>     Could any one give me an answer?
> 
>    My application need to open one file with two clients in different
> hosts. One for write/read and one for read only. The client could be
> developed based on libceph or librbd.
>    I tried librbd, exception appear too.

I opened a bug for this, http://tracker.newdream.net/issues/1097.

Can you try the patch below?  I this may just be something missed in a 
locking rewrite way back when in a rare code path:

Thanks!
sage



diff --git a/src/client/Client.cc b/src/client/Client.cc
index 7f7fb08..bf0997a 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -4934,7 +4934,6 @@ public:
 
 void Client::sync_write_commit(Inode *in)
 {
-  client_lock.Lock();
   assert(unsafe_sync_write > 0);
   unsafe_sync_write--;
 
@@ -4947,8 +4946,6 @@ void Client::sync_write_commit(Inode *in)
   }
 
   put_inode(in);
-
-  client_lock.Unlock();
 }
 
 int Client::write(int fd, const char *buf, loff_t size, loff_t offset) 

