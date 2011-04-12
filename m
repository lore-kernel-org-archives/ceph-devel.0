From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: osd stops
Date: Tue, 12 Apr 2011 11:24:14 -0700
Message-ID: <E54DF381DDD4475587E24CDF6D4C25D0@gmail.com>
References: <688456938.14487.1302631558862.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39498 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758262Ab1DLSYU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2011 14:24:20 -0400
Received: by iwn34 with SMTP id 34so6881668iwn.19
        for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2011 11:24:20 -0700 (PDT)
In-Reply-To: <688456938.14487.1302631558862.JavaMail.root@mail.linserv.se>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel@vger.kernel.org

On Tuesday, April 12, 2011 at 11:05 AM, Martin Wilderoth wrote:
Thanks for the answer, now I know the reson. Some of my osd had 90% of data, dmesg also shows error with the btrfs on the hosts. I will run the test with another file system ext3 :-) or is any other filesystem better. It's a backuppc filesystem with a lot of hardlinks and data I would like to test to run in ceph.

ext3 or really any other FS will handle it better, although Ceph itself is also not super-resilient to such situations. Eventually we will have automatic rebalancing of data but it's not in there right now.

Could you maybe send along your config file and the local filesystem statistics on each of your OSDs? CRUSH is psuedo-random and so it's not going to have perfectly even utilization but if the variance is too high we'll want to look into it sooner rather than later.
-Greg



