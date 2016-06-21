From: Ning Yao <zay11022@gmail.com>
Subject: RAID Controller containing cache with battery
Date: Tue, 21 Jun 2016 23:46:13 +0800
Message-ID: <CALZt5jxQotzw=KuXWUvF8EV+C63DGOgojJLgpZntg5rgE8vJSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33070 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbcFUPyS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jun 2016 11:54:18 -0400
Received: by mail-qk0-f195.google.com with SMTP id a186so3828810qkf.0
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jun 2016 08:54:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all

As some RAID Controllers provides non-violate cache with battery to
protect data during power loss. For SATA disk, we want enable
nobarrier options to boost IO performance. But no barrier option
require us to use a real File on filesystem instead of a raw device,
which may cause more inode content updating and degrade performance. I
wonder, is that meaningful to add an option such like
enable_journal_nobarrier to tell whether open raw device with O_DSYNC
or not (default set to false), to guide the journal write without
barrier if we are definitely sure that our cache on SSD or RAID
Controller is non-violate?

Regards
Ning Yao
