From: Matt Conner <matt.conner@keepertech.com>
Subject: Failed OSDs not getting marked down or out
Date: Wed, 18 Mar 2015 15:50:25 -0400
Message-ID: <CAKeiORT21fyG0WcdgJC6Gbnpe90y_SM+VuOJDML8NXR9dG2sZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36425 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964989AbbCRTu0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Mar 2015 15:50:26 -0400
Received: by obdfc2 with SMTP id fc2so40357722obd.3
        for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2015 12:50:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm working with a 6 rack, 18 server (3 racks of 2 servers , 3 racks
of 4 servers), 640 OSD cluster and have run into an issue when failing
a storage server or rack where the OSDs are not getting marked down
until the monitor timeout is reached - typically resulting in all
writes being blocked until the timeout.

Each of our storage servers contains 36 OSDs, so in order to prevent a
server from marking a OSD out (in case of network issues), we have set
our "mon_osd_min_down_reporters" value to 37. This value is working
great for a smaller cluster, but unfortunately seems to not work so
well in this large cluster. Tailing the monitor logs I can see that
the monitor is only receiving failed reports from 9-10 unique OSDs per
failed OSD.

I've played around with "osd_heartbeat_min_peers", and it seems to
help, but I still run into issues where an OSD is not marked down. Can
anyone explain how the number of heartbeat peers is determined and
how, if necessary, I can can use "osd_heartbeat_min_peers" to ensure I
have enough peering to detect failures in large clusters?

Has anyone had a similar experience with a large cluster? Any
recommendations on how to correct this?

Thanks,
Matt
