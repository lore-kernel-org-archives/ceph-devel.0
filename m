From: Sam Lang <sam.lang@inktank.com>
Subject: Re: Hadoop and Ceph client/mds view of modification time
Date: Tue, 20 Nov 2012 14:20:18 -0600
Message-ID: <50ABE602.9090600@inktank.com>
References: <CAPrxi5-pcHrxKsteGioaQ3haMOj0V3im1bXRL_TW28SD6R=qZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43387 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073Ab2KTUUX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 15:20:23 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so4525304pbc.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Nov 2012 12:20:23 -0800 (PST)
In-Reply-To: <CAPrxi5-pcHrxKsteGioaQ3haMOj0V3im1bXRL_TW28SD6R=qZw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>, Sage Weil <sage@inktank.com>

On 11/20/2012 01:44 PM, Noah Watkins wrote:
> This is a description of the clock synchronization issue we are facing
> in Hadoop:
>
> Components of Hadoop use mtime as a versioning mechanism. Here is an
> example where Client B tests the expected 'version' of a file created
> by Client A:
>
>    Client A: create file, write data into file.
>    Client A: expected_mtime <-- lstat(file)
>    Client A: broadcast expected_mtime to client B
>    ...
>    Client B: mtime <-- lstat(file)
>    Client B: test expected_mtime == mtime

Here's a patch that might work to push the setattr out to the mds every 
time (the same as Sage's patch for getattr).  This isn't quite 
writeback, as it waits for the setattr at the server to complete before 
returning, but I think that's actually what you want in this case.  It 
needs to be enabled by setting client setattr writethru = true in the 
config.  Also, I haven't tested that it sends the setattr, just a basic 
test of functionality.

BTW, if its always client B's first stat of the file, you won't need 
Sage's patch.

-sam

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 8d4a5ac..a7dd8f7 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -4165,6 +4165,7 @@ int Client::_getattr(Inode *in, int mask, int uid, 
int gid)

  int Client::_setattr(Inode *in, struct stat *attr, int mask, int uid, 
int gid)
  {
+  int orig_mask = mask;
    int issued = in->caps_issued();

    ldout(cct, 10) << "_setattr mask " << mask << " issued " << 
ccap_string(issued) << dendl;
@@ -4219,7 +4220,7 @@ int Client::_setattr(Inode *in, struct stat *attr, 
int mask, int uid, int gid)
        mask &= ~(CEPH_SETATTR_MTIME|CEPH_SETATTR_ATIME);
      }
    }
-  if (!mask)
+  if (!cct->_conf->client_setattr_writethru && !mask)
      return 0;

    MetaRequest *req = new MetaRequest(CEPH_MDS_OP_SETATTR);
@@ -4229,6 +4230,10 @@ int Client::_setattr(Inode *in, struct stat 
*attr, int mask, int uid, int gid)
    req->set_filepath(path);
    req->inode = in;

+  // reset mask back to original if we're meant to do writethru
+  if (cct->_conf->client_setattr_writethru)
+    mask = orig_mask;
+
    if (mask & CEPH_SETATTR_MODE) {
      req->head.args.setattr.mode = attr->st_mode;
      req->inode_drop |= CEPH_CAP_AUTH_SHARED;
diff --git a/src/common/config_opts.h b/src/common/config_opts.h
index cc05095..51a2769 100644
--- a/src/common/config_opts.h
+++ b/src/common/config_opts.h
@@ -178,6 +178,7 @@ OPTION(client_oc_max_dirty, OPT_INT, 1024*1024* 100) 
    // MB * n  (dirty OR tx.
  OPTION(client_oc_target_dirty, OPT_INT, 1024*1024* 8) // target dirty 
(keep this smallish)
  OPTION(client_oc_max_dirty_age, OPT_DOUBLE, 5.0)      // max age in 
cache before writeback
  OPTION(client_oc_max_objects, OPT_INT, 1000)      // max objects in cache
+OPTION(client_setattr_writethru, OPT_BOOL, false)  // send the 
attributes to the mds server
  // note: the max amount of "in flight" dirty data is roughly (max - 
target)
  OPTION(fuse_use_invalidate_cb, OPT_BOOL, false) // use fuse 2.8+ 
invalidate callback to keep page cache consistent
  OPTION(fuse_big_writes, OPT_BOOL, true)


>
> Since mtime may be set in Ceph by both client and MDS, inconsistent
> mtime view is possible when clocks are not adequately synchronized.
>
> Here is a test that reproduces the problem. In the following output,
> issdm-18 has the MDS, and issdm-22 is a non-Ceph node with its time
> set to an hour earlier than the MDS node.
>
> nwatkins@issdm-22:~$ ssh issdm-18 date && ./test
> Tue Nov 20 11:40:28 PST 2012           // MDS TIME
> local time: Tue Nov 20 10:42:47 2012  // Client TIME
> fstat time: Tue Nov 20 11:40:28 2012  // mtime seen after file
> creation (MDS time)
> lstat time: Tue Nov 20 10:42:47 2012  // mtime seen after file write
> (client time)
>
> Here is the code used to produce that output.
>
> #include <errno.h>
> #include <sys/fcntl.h>
> #include <sys/time.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <dirent.h>
> #include <sys/xattr.h>
> #include <stdio.h>
> #include <string.h>
> #include <assert.h>
> #include <cephfs/libcephfs.h>
> #include <time.h>
>
> int main(int argc, char **argv)
> {
>          struct stat st;
>          struct ceph_mount_info *cmount;
>          struct timeval tv;
>
>          /* setup */
>          ceph_create(&cmount, "admin");
>          ceph_conf_read_file(cmount, "/users/nwatkins/Projects/ceph.conf");
>          ceph_mount(cmount, "/");
>
>          /* print local time for reference */
>          gettimeofday(&tv, NULL);
>          printf("local time: %s", ctime(&tv.tv_sec));
>
>          /* create a file */
>          char buf[256];
>          sprintf(buf, "/somefile.%d", getpid());
>          int fd = ceph_open(cmount, buf, O_WRONLY|O_CREAT, 0);
>          assert(fd > 0);
>
>          /* get mtime for this new file */
>          memset(&st, 0, sizeof(st));
>          int ret = ceph_fstat(cmount, fd, &st);
>          assert(ret == 0);
>          printf("fstat time: %s", ctime(&st.st_mtime));
>
>          /* write some data into the file */
>          ret = ceph_write(cmount, fd, buf, sizeof(buf), -1);
>          assert(ret == sizeof(buf));
>          ceph_close(cmount, fd);
>
>          memset(&st, 0, sizeof(st));
>          ret = ceph_lstat(cmount, buf, &st);
>          assert(ret == 0);
>          printf("lstat time: %s", ctime(&st.st_mtime));
>
>          ceph_shutdown(cmount);
>          return 0;
> }
>
> Note that this output is currently using the short patch from
> http://marc.info/?l=ceph-devel&m=133178637520337&w=2 which forces
> getattr to always go to the MDS.
>
> diff --git a/src/client/Client.cc b/src/client/Client.cc
> index 4a9ae3c..2bb24b7 100644
> --- a/src/client/Client.cc
> +++ b/src/client/Client.cc
> @@ -3858,7 +3858,7 @@ int Client::readlink(const char *relpath, char
> *buf, loff_t \
> size)
>   int Client::_getattr(Inode *in, int mask, int uid, int gid)
>   {
> -  bool yes = in->caps_issued_mask(mask);
> +  bool yes = false; //in->caps_issued_mask(mask);
>
>     ldout(cct, 10) << "_getattr mask " << ccap_string(mask) << "
> issued=" << yes << \
> dendl;  if (yes)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

