From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: why we should use two Mutex in OSD ShardData?
Date: Fri, 30 Oct 2015 21:34:44 +0800
Message-ID: <CANE=7sWr3c3pa7ZkbJ2NvZPppiXsF=n6maeMQ2=BZQXdoNx_0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36004 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758628AbbJ3Nep (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Oct 2015 09:34:45 -0400
Received: by oiao187 with SMTP id o187so59253013oia.3
        for <ceph-devel@vger.kernel.org>; Fri, 30 Oct 2015 06:34:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, all:

   There are two Mutex in ShardData, one is sdata_lock and the other
one is sdata_op_ordering_lock.

    I wonder could we replace sdata_lock with sdata_op_ordering_lock?

-- 
Regards,
xinze
