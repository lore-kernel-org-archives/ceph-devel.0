From: Samuel Just <sam.just@inktank.com>
Subject: v0.72.1 released
Date: Fri, 15 Nov 2013 11:58:49 -0800
Message-ID: <CA+4uBUaDQ+6G12j_ze9eFNzfmOmuyiGO6JKfDqj2yCB3VSFAFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:46007 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab3KOT6u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Nov 2013 14:58:50 -0500
Received: by mail-qc0-f182.google.com with SMTP id n7so2386248qcx.41
        for <ceph-devel@vger.kernel.org>; Fri, 15 Nov 2013 11:58:49 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

This point release addresses issue #6761
(http://tracker.ceph.com/issues/6761).  Upgrades to v0.72 can cause
reads to begin returning ENFILE (Too many open files in system).

Changes:
* osd: fix upgrade issue with object_info_t encodings
* ceph_filestore_tool: add tool to repair osd stores affected by #6761

Users who have upgraded to Emperor and do not see this issue need not
use the repair tool.

For more detail and repair instructions for affected clusters:
* http://ceph.com/docs/master/release-notes/#v0-72-1-emperor
-Sam
