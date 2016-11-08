From: Jeff Layton <jlayton@redhat.com>
Subject: ceph rpm packaging failure -- installed but unpackaged files found
Date: Tue, 08 Nov 2016 14:02:27 -0500
Message-ID: <1478631747.6066.7.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:36236 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753860AbcKHTCa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 14:02:30 -0500
Received: by mail-qt0-f177.google.com with SMTP id w33so113146494qtc.3
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2016 11:02:30 -0800 (PST)
Received: from cpe-2606-A000-1125-405B-1A5E-FFF-FE12-8671.dyn6.twc.com (cpe-2606-A000-1125-405B-1A5E-FFF-FE12-8671.dyn6.twc.com. [2606:a000:1125:405b:1a5e:fff:fe12:8671])
        by smtp.gmail.com with ESMTPSA id s69sm11014913qks.17.2016.11.08.11.02.28
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Nov 2016 11:02:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I needed to build some rpms from a make-srpm.sh generated srpm, and hit
this failure during the packaging phase. Something with the rgw python
bindings it appears?

The tree here is based on a38d53e1d29eefc35dd5cfb14dc0996253cdc468,
with a few cephfs patches on top.

Here's the tail end of the rpm build log:

Provides: ceph-debuginfo = 1:11.0.2-1287.gbd4abb0f7496.fc24 ceph-debuginfo(x86-64) = 1:11.0.2-1287.gbd4abb0f7496.fc24
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Checking for unpackaged file(s): /usr/lib/rpm/check-files /home/jlayton/rpmbuild/BUILDROOT/ceph-11.0.2-1287.gbd4abb0f7496.fc24.x86_64
error: Installed (but unpackaged) file(s) found:
   /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/PKG-INFO
   /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/SOURCES.txt
   /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/dependency_links.txt
   /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/top_level.txt
   /usr/lib64/python2.7/site-packages/rgw.so
   /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/PKG-INFO
   /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/SOURCES.txt
   /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/dependency_links.txt
   /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/top_level.txt
   /usr/lib64/python3.5/site-packages/rgw.cpython-35m-x86_64-linux-gnu.so


RPM build errors:
    Installed (but unpackaged) file(s) found:
   /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/PKG-INFO
   /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/SOURCES.txt
   /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/dependency_links.txt
   /usr/lib64/python2.7/site-packages/rgw-2.0.0-py2.7.egg-info/top_level.txt
   /usr/lib64/python2.7/site-packages/rgw.so
   /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/PKG-INFO
   /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/SOURCES.txt
   /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/dependency_links.txt
   /usr/lib64/python3.5/site-packages/rgw-2.0.0-py3.5.egg-info/top_level.txt
   /usr/lib64/python3.5/site-packages/rgw.cpython-35m-x86_64-linux-gnu.so
-- 
Jeff Layton <jlayton@redhat.com>
