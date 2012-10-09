From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] libceph: fix backoff handling
Date: Tue, 09 Oct 2012 14:31:24 -0700
Message-ID: <507497AC.5030609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50935 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756941Ab2JIVb1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Oct 2012 17:31:27 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so5640844pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Oct 2012 14:31:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

These three patches fix some problems related to how backoff
is handled when a ceph connection faults.

					-Alex

     [PATCH 1/3] libceph: reset BACKOFF if unable to re-queue
     [PATCH 2/3] libceph: let con_work() handle backoff
     [PATCH 3/3] libceph: define common queue_con_delay()
