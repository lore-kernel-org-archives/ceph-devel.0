From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Hadoop and Ceph client/mds view of modification time
Date: Tue, 20 Nov 2012 11:44:14 -0800
Message-ID: <CAPrxi5-pcHrxKsteGioaQ3haMOj0V3im1bXRL_TW28SD6R=qZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f179.google.com ([209.85.160.179]:48206 "EHLO
	mail-gh0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab2KTTuj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 14:50:39 -0500
Received: by mail-gh0-f179.google.com with SMTP id r14so1236897ghr.10
        for <ceph-devel@vger.kernel.org>; Tue, 20 Nov 2012 11:50:39 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Gregory Farnum <greg@inktank.com>, Sage Weil <sage@inktank.com>

This is a description of the clock synchronization issue we are facing
in Hadoop:

Components of Hadoop use mtime as a versioning mechanism. Here is an
example where Client B tests the expected 'version' of a file created
by Client A:

  Client A: create file, write data into file.
  Client A: expected_mtime <-- lstat(file)
  Client A: broadcast expected_mtime to client B
  ...
  Client B: mtime <-- lstat(file)
  Client B: test expected_mtime == mtime

Since mtime may be set in Ceph by both client and MDS, inconsistent
mtime view is possible when clocks are not adequately synchronized.

Here is a test that reproduces the problem. In the following output,
issdm-18 has the MDS, and issdm-22 is a non-Ceph node with its time
set to an hour earlier than the MDS node.

nwatkins@issdm-22:~$ ssh issdm-18 date && ./test
Tue Nov 20 11:40:28 PST 2012           // MDS TIME
local time: Tue Nov 20 10:42:47 2012  // Client TIME
fstat time: Tue Nov 20 11:40:28 2012  // mtime seen after file
creation (MDS time)
lstat time: Tue Nov 20 10:42:47 2012  // mtime seen after file write
(client time)

Here is the code used to produce that output.

#include <errno.h>
#include <sys/fcntl.h>
#include <sys/time.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <sys/xattr.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <cephfs/libcephfs.h>
#include <time.h>

int main(int argc, char **argv)
{
        struct stat st;
        struct ceph_mount_info *cmount;
        struct timeval tv;

        /* setup */
        ceph_create(&cmount, "admin");
        ceph_conf_read_file(cmount, "/users/nwatkins/Projects/ceph.conf");
        ceph_mount(cmount, "/");

        /* print local time for reference */
        gettimeofday(&tv, NULL);
        printf("local time: %s", ctime(&tv.tv_sec));

        /* create a file */
        char buf[256];
        sprintf(buf, "/somefile.%d", getpid());
        int fd = ceph_open(cmount, buf, O_WRONLY|O_CREAT, 0);
        assert(fd > 0);

        /* get mtime for this new file */
        memset(&st, 0, sizeof(st));
        int ret = ceph_fstat(cmount, fd, &st);
        assert(ret == 0);
        printf("fstat time: %s", ctime(&st.st_mtime));

        /* write some data into the file */
        ret = ceph_write(cmount, fd, buf, sizeof(buf), -1);
        assert(ret == sizeof(buf));
        ceph_close(cmount, fd);

        memset(&st, 0, sizeof(st));
        ret = ceph_lstat(cmount, buf, &st);
        assert(ret == 0);
        printf("lstat time: %s", ctime(&st.st_mtime));

        ceph_shutdown(cmount);
        return 0;
}

Note that this output is currently using the short patch from
http://marc.info/?l=ceph-devel&m=133178637520337&w=2 which forces
getattr to always go to the MDS.

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 4a9ae3c..2bb24b7 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -3858,7 +3858,7 @@ int Client::readlink(const char *relpath, char
*buf, loff_t \
size)
 int Client::_getattr(Inode *in, int mask, int uid, int gid)
 {
-  bool yes = in->caps_issued_mask(mask);
+  bool yes = false; //in->caps_issued_mask(mask);

   ldout(cct, 10) << "_getattr mask " << ccap_string(mask) << "
issued=" << yes << \
dendl;  if (yes)
