From: John Spray <jspray@redhat.com>
Subject: Help maintain the CephFS Samba and/or Hadoop bindings
Date: Thu, 20 Apr 2017 11:10:36 +0100
Message-ID: <CALe9h7fXuvmAd7Xfi3uiipegkmCq03cLdyN5ge8KYNGfeJbgbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35004 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031078AbdDTKK6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Apr 2017 06:10:58 -0400
Received: by mail-wm0-f51.google.com with SMTP id w64so99881194wma.0
        for <ceph-devel@vger.kernel.org>; Thu, 20 Apr 2017 03:10:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi folks,

The Samba and Hadoop bindings for CephFS have been a bit unloved
lately, as most filesystem work has focussed on stabilizing and
finishing the core CephFS functionality (multi-mds, etc).

Consequently, the hadoop and samba test suites are both red on master.

Samba went away when the build infrastructure migrated from
gitbuilders to jenkins, and that, unfortunately, coincided with the
changes to make samba depend on libcephfs2 instead of libcephfs1.
When the jenkins version of the build eventually came back online,
something had gone wonky in the build and it's apparently trying to
build against libcephfs1 instead of libcephfs2[1], and consequently
our tests can't run[2].

Hadoop tests were consistently passing until very recently, but now
the test script is failing to fetch the upstream source tarball[3],
presumably because whoever maintains that server has removed some old
artifacts.

So: if there is anyone out there who is interested in helping maintain
those bits, let me know!  Help getting those builds/tests green again
for Luminous would be great, but I'd also like to hear from anyone
with a longer term interest in keeping them that way.

John

1. http://tracker.ceph.com/issues/19117
2. http://tracker.ceph.com/issues/18883
3. http://tracker.ceph.com/issues/19707
