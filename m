From: Fred Yang <frederic.yang@gmail.com>
Subject: ceph-disk handling journal device with persistent path name
Date: Fri, 12 Dec 2014 16:42:08 -0500
Message-ID: <CAPHS-z5CuGOHtjpBSuVY0XfaLbMmWi2pZWBVKXvyu3HFXDBoiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:60797 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbaLLVmJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Dec 2014 16:42:09 -0500
Received: by mail-qc0-f177.google.com with SMTP id x3so6089416qcv.8
        for <ceph-devel@vger.kernel.org>; Fri, 12 Dec 2014 13:42:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

ceph-disk does not support journal device using path /dev/disk/by-path
currently since the the device name has colon, this has been reported
over 1 year ago:

http://tracker.ceph.com/issues/5283

But it was set to "Won't fix" few months ago, can particular reason?
From user's perspective, after journal disk got replaced, the device
name can shift to be different as original /dev/sdX, instead of
relinking the journal device in OSD after disk replace, it's much
easier to just reference H/W path like /dev/disk/by-path.

Thanks,
Fred
