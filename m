From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/5] rbd: only set up Linux files for mapped devices
Date: Mon, 29 Apr 2013 12:59:12 -0500
Message-ID: <517EB4F0.1070607@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:45402 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757417Ab3D2R7P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 13:59:15 -0400
Received: by mail-qc0-f181.google.com with SMTP id a22so3303621qcs.12
        for <ceph-devel@vger.kernel.org>; Mon, 29 Apr 2013 10:59:14 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id kn10sm34860109qeb.8.2013.04.29.10.59.13
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 10:59:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series does a few more things to separate the
ceph and Linux side of rbd device initialization,
and to make sure things get cleaned up in a sane
way when errors occur.  The last patch makes it so
only the rbd image getting mapped has Linux device
and sysfs stuff associated with them.  The parent
rbd devices for layered images never needed this
stuff, and things have now been rearranged such
that we can do away with that.

These patches are available in the ceph-client git
repository in the branch "review/wip-rbd-cleanup-5".

					-Alex
[PATCH 1/5] rbd: drop module later
[PATCH 2/5] rbd: don't destroy rbd_dev in device release function
[PATCH 3/5] rbd: define rbd_dev_unprobe()
[PATCH 4/5] rbd: don't have device release destroy rbd_dev
[PATCH 5/5] rbd: set up devices only for mapped images
