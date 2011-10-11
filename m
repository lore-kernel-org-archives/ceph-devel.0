From: Christian Brunner <chb@muc.de>
Subject: OSD: no current directory
Date: Tue, 11 Oct 2011 19:28:06 +0200
Message-ID: <CAO47_-9FW_wD7+fD_ihGFivZD=FN1mx=32FJumNehtmvKGhqFg@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43237 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab1JKR2I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2011 13:28:08 -0400
Received: by vws1 with SMTP id 1so5782895vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Oct 2011 10:28:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Maybe this one is easier:

One of our OSDs isn't starting, because ther is no "current"
directory. What I have are three snap directories.

total 0
-rw-r--r-- 1 root root   37 Oct  9 15:57 ceph_fsid
-rw-r--r-- 1 root root    8 Oct  9 15:57 fsid
-rw-r--r-- 1 root root   21 Oct  9 15:57 magic
drwxr-xr-x 1 root root 7986 Oct 11 18:34 snap_506043
drwxr-xr-x 1 root root 7986 Oct 11 18:34 snap_507364
drwxr-xr-x 1 root root 7814 Oct 11 18:36 snap_507417
-rw-r--r-- 1 root root    4 Oct  9 15:57 store_version
-rw-r--r-- 1 root root    2 Oct  9 15:57 whoami

Is there a way to rollback the latest?

Thanks,
Christian
