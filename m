From: John Spray <jspray@redhat.com>
Subject: Random thought: adding a tracker custom field for feature/"topic"
 (separate to category/component)
Date: Tue, 31 May 2016 11:54:49 +0100
Message-ID: <CALe9h7eLOBYq+AHQU_kiB97NaPSg5Fmj90xSK7xyqLK8_TOa_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:37857 "EHLO
	mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbcEaLCR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2016 07:02:17 -0400
Received: by mail-it0-f52.google.com with SMTP id z123so47944336itg.0
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2016 04:02:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

Currently we have "Category", which is sort of a mixture of physical
components (e.g. MDS, OSD, client, librados) and higher level
features/topics.

Lots of tickets actually refer to both a feature and a component, for
example in cephfs we have lots of tickets related to FSCK, and some of
them are MDS changes while some are tool changes.  Currently we sort
of work around this by prefacing things to subjects.

I'm thinking that maybe we need two fields, one saying which component
(i.e. which subdir in the git tree), and one giving a higher level
category (which I'm imagining calling "topics").

In a CephFS context, examples of components would be MDS, client,
ceph-fuse, libcephfs, libcephfs-python, cephfs-volume-client, kernel
client, hadoop plugin, samba plugin, ganesha plugin, tools,
MDSMonitor, qa-suite.

...whereas topics would be features that affect multiple components
like: multi-mds, multi-fs, snapshots, fsck.

Thoughts?

John
