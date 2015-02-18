From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: full_ratios - please explain?
Date: Wed, 18 Feb 2015 09:39:36 -0500
Message-ID: <CAGbvivJ89toPvbO8XOQ8ru_BDQJbJfZvbj2NhxFk1G5K=d-3Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:51517 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbbBROjh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Feb 2015 09:39:37 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp18so2406160obc.8
        for <ceph-devel@vger.kernel.org>; Wed, 18 Feb 2015 06:39:36 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Can someone explain the interaction and effects of all of these
"full_ratio" parameters?  I havent found any real good explanation of how
they affect the distribution of data once the cluster gets above the
"nearfull" and close to the "close" ratios.


mon_osd_full_ratio
mon_osd_nearfull_ratio

osd_backfill_full_ratio
osd_failsafe_full_ratio
osd_failsafe_nearfull_ratio

We have a cluster with about 144 OSDs (518 TB) and trying to get it to a
90% full rate for testing purposes.

We've found that when some of the OSDs get above the mon_osd_full_ratio
value (.95 in our system), then it stops accepting any new data, even
though there is plenty of space left on other OSDs that are not yet even up
to 90%.  Tweaking the osd_failsafe ratios enabled data to move again for a
bit, but eventually it becomes unbalanced and stops working again.

Is there a recommended combination of values to use that will allow the
cluster to continue accepting data and rebalancing correctly above 90%.

thanks,
 Wyllys Ingersoll
