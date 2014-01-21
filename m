From: Laurent Barbe <laurent@ksperis.com>
Subject: CEPH_FEATURE_OSD_CACHEPOOL always required when osd cache pool exist
 ?
Date: Tue, 21 Jan 2014 09:28:00 +0100
Message-ID: <52DE2F90.9030201@ksperis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:38601 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbaAUI2F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jan 2014 03:28:05 -0500
Received: by mail-we0-f177.google.com with SMTP id x55so7520894wes.8
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jan 2014 00:28:04 -0800 (PST)
Received: from [10.2.6.119] ([46.218.42.103])
        by mx.google.com with ESMTPSA id dm2sm8551764wib.8.2014.01.21.00.28.01
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 Jan 2014 00:28:01 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

About 0.75, when I created cache pool, kernel client like rbd or cephfs 
make error "feature set mismatch". (Even if the device is not on the 
cached pool)

$ rbd map rbd/myrbd    => OK

$ ceph osd pool create otherpool1 100 100
$ ceph osd pool create otherpool2 100 100
$ ceph osd tier add otherpool1 otherpool2
$ ceph osd tier cache-mode otherpool2 writeback

$ rbd map rbd/myrbd
kern log >> libceph: mon2 10.2.0.90:6789 feature set mismatch, my 
4a042a42 < server's 84a042a42, missing 800000000

Does the commit 
https://github.com/ceph/ceph/commit/431a13eb370310a383abceeb509fe204a519e087
fix this ?


Regards,
Laurent Barbe
