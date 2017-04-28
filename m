From: Sage Weil <sweil@redhat.com>
Subject: osd and/or filestore tuning for ssds?
Date: Fri, 28 Apr 2017 17:14:10 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704281712110.21526@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1426403AbdD1ROM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 28 Apr 2017 13:14:12 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ceph-users@ceph.com

Hi everyone,

Are there any osd or filestore options that operators are tuning for 
all-SSD clusters?  If so (and they make sense) we'd like to introduce them 
as defaults for ssd-backed OSDs.

BlueStore already has different hdd and ssd default values for many 
options that it chooses based on the type of device; we'd like to do that 
for other options in either filestore or the OSD if it makes sense.

Thanks!
sage
