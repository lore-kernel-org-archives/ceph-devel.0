From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: cap mask differences for `Client::stat` vs `Client::fstat`
Date: Sat, 23 Apr 2016 16:48:16 -0700
Message-ID: <CAB2gnbWUAdEWfwu2qYPYBNLdbVVa7PXwTsH9P8E5O2KU5hMu=g@mail.gmail.com>
References: <CAB2gnbUz9D9VWz6=PtDdAQ7u+hVWeHa3rz=5CypGAFLq-bSboA@mail.gmail.com>
	<CAAM7YA=+4wjN0TJFrrBovzkxLGJp1ngqC-Y-2fgV_mywaJx2Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37797 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbcDWXsR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Apr 2016 19:48:17 -0400
Received: by mail-ig0-f177.google.com with SMTP id g8so46734282igr.0
        for <ceph-devel@vger.kernel.org>; Sat, 23 Apr 2016 16:48:16 -0700 (PDT)
In-Reply-To: <CAAM7YA=+4wjN0TJFrrBovzkxLGJp1ngqC-Y-2fgV_mywaJx2Uw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I have a patch for this (below), but I see something that doesn't seem
quite right.

Here is a simple fs client. When its running by itself the fstat/sec
rate is high. When a second client copy of this client starts, the
first client slows down as expected, but the new client blocks. I
would expect both clients to make progress, but until the first client
exits, the second client is blocked.

fd = cephfs.open('file-1', 'w', 0755)
count = 0
start = time.time()
while True:
    stat = cephfs.fstat(fd)
    count += 1
    if time.time() > (start + 1):
        print(count)
        count = 0
        start = time.time()

- Noah

Patch:

709840b - fsclient: fstat can take inode all cap (10 minutes ago) <Noah Watkins>
diff --git a/src/client/Client.cc b/src/client/Client.cc
index 7fcd907..94e4db5 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -8668,16 +8668,16 @@ int Client::_fsync(Fh *f, bool syncdataonly)
   return _fsync(f->inode.get(), syncdataonly);
 }

-int Client::fstat(int fd, struct stat *stbuf)
+int Client::fstat(int fd, struct stat *stbuf, int mask)
 {
   Mutex::Locker lock(client_lock);
-  tout(cct) << "fstat" << std::endl;
+  tout(cct) << "fstat" << " mask " << mask << std::endl;
   tout(cct) << fd << std::endl;

   Fh *f = get_filehandle(fd);
   if (!f)
     return -EBADF;
-  int r = _getattr(f->inode, -1);
+  int r = _getattr(f->inode, mask);
   if (r < 0)
     return r;
   fill_stat(f->inode, stbuf, NULL);
diff --git a/src/client/Client.h b/src/client/Client.h
index d912db0..860f28b 100644
--- a/src/client/Client.h
+++ b/src/client/Client.h
@@ -981,7 +981,7 @@ public:
   int fake_write_size(int fd, loff_t size);
   int ftruncate(int fd, loff_t size);
   int fsync(int fd, bool syncdataonly);
-  int fstat(int fd, struct stat *stbuf);
+  int fstat(int fd, struct stat *stbuf, int mask=CEPH_STAT_CAP_INODE_ALL);
   int fallocate(int fd, int mode, loff_t offset, loff_t length);

On Wed, Apr 13, 2016 at 6:49 PM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Thu, Apr 14, 2016 at 1:26 AM, Noah Watkins <noahwatkins@gmail.com> wrote:
>> In the libcephfs client it looks like both `Client::stat` and
>> `Client::lstat` use a default mask of CEPH_STAT_CAP_INODE_ALL and are
>> able to return immediately from `Client::_getattr` without making an
>> MDS request. However, `Client::fstat` uses hard-coded -1 as the cap
>> mask and always issues a MDS request. Is this the intended behavior,
>> and if so, what are different semantics of fstat that make this a
>> requirement?
>
> I think it's a bug, Client::fstat should use CEPH_STAT_CAP_INODE_ALL too.
>
> Regards
> Yan, Zheng
>
>>
>> Thanks,
>> Noah
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
