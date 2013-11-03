From: Michael Sevilla <mikesevilla3@gmail.com>
Subject: CephFS use cases + MDS limitations
Date: Sun, 3 Nov 2013 15:53:37 -0800
Message-ID: <CAD=PzHJTOnSw24egLutyGEFUZFEo6brcurpwyjmYZabvU_1aMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:52414 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab3KCXxh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Nov 2013 18:53:37 -0500
Received: by mail-pa0-f48.google.com with SMTP id kq14so6228128pab.21
        for <ceph-devel@vger.kernel.org>; Sun, 03 Nov 2013 15:53:37 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Ceph community,

I=92d like to get a feel for some of the problems that CephFS users are
encountering with single MDS deployments. There were requests for
stable distributed metadata/MDS services [1] and I=92m guessing its
because your workloads exhibit many, many metadata operations. Some of
you mentioned opening many files in a directory for checkpointing,
recursive stats on a directory, etc. [2] and I=92d like more details,
such as:
- workloads/applications that stress the MDS service that would cause
you to call for multi-MDS support
- use cases for the Ceph file system (I=92m not really too interested i=
n
users using CephFS to host VMs, since many of these use cases are
migrating to RBD)

I=92m just trying to get an idea of what=92s out there and the problems
CephFS users encounter as a result of a bottlenecked MDS (single node
or cluster).

Thanks!

Michael

[1] CephFS MDS Status Discussion,
http://ceph.com/dev-notes/cephfs-mds-status-discussion/
[2] CephFS First Product Release Discussion,
http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/13524
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
