From: Dan van der Ster <dan@vanderster.com>
Subject: throttling PG removal
Date: Wed, 29 Jun 2016 18:40:48 +0200
Message-ID: <CABZ+qqnisScrzXiR=zbtaC291TnYxEPd=on5Ey1Ad89-02M+CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34189 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbcF2Qlb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2016 12:41:31 -0400
Received: by mail-lf0-f51.google.com with SMTP id h129so37553715lfh.1
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jun 2016 09:41:30 -0700 (PDT)
Received: from mail-lf0-f44.google.com (mail-lf0-f44.google.com. [209.85.215.44])
        by smtp.gmail.com with ESMTPSA id e65sm740030lji.30.2016.06.29.09.41.27
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jun 2016 09:41:27 -0700 (PDT)
Received: by mail-lf0-f44.google.com with SMTP id l188so37546305lfe.2
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jun 2016 09:41:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

We're deleting a large pool with lots of 4MB objects, and it's turning
out to be rather disruptive: >50 loadavg on osd machines, osd's
flapping, peering mess for the other pools.

In general, I'd like to be able to throttle this way back so that the
deleted PG objects slowly disappear without affecting IO to other
pools. And AFAICT there's no way to achieve that in current jewel or
master.

Here is the timing of the RemoveWQ on one of these OSDs:

2016-06-29 18:28:06.388530 7fee8a2e5700 12 OSD::disk_tp worker wq
OSD::RemoveWQ start processing 0x1 (1 active)
2016-06-29 18:28:07.954758 7fee8a2e5700 15 OSD::disk_tp worker wq
OSD::RemoveWQ done processing 0x1 (0 active)
2016-06-29 18:28:07.954766 7fee8a2e5700 12 OSD::disk_tp worker wq
OSD::RemoveWQ start processing 0x1 (1 active)
2016-06-29 18:28:10.599542 7fee8a2e5700 15 OSD::disk_tp worker wq
OSD::RemoveWQ done processing 0x1 (0 active)

I'd like to add a configurable osd_pg_remove_sleep, probably at the
top of OSD::RemoveWQ::_process ? Should that have the desired effect?

Moreover, it would be nice to be able to decrease the number of
objects removed per instance of the worker. It's currently limited to
osd_target_transaction_size (shared by build_past_intervals_parallel,
remove_dir, and handle_osd_map). Should it be safe to decrease that
(to, say, 5) or would it be better to introduce something specific to
remove_dir?

Thanks,

Dan
