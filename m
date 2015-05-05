From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: Default config value for osd_disk_thread_ioprio_class
Date: Tue, 5 May 2015 09:46:01 +0300
Message-ID: <20150505064600.GA21225@gmail.com>
References: <5540CA47.8010201@pcextreme.nl>
 <5540CD3C.4080409@42on.com>
 <alpine.DEB.2.00.1504290949400.24030@cobra.newdream.net>
 <55412922.7020300@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36344 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbbEEGqj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 May 2015 02:46:39 -0400
Received: by lbbqq2 with SMTP id qq2so120800927lbb.3
        for <ceph-devel@vger.kernel.org>; Mon, 04 May 2015 23:46:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55412922.7020300@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Apr 29, 2015 at 08:55:30PM +0200, Wido den Hollander wrote:

> In the process of upgrading a cluster from Giant to Hammer I saw this
> on the OSD logs:
> 
> 2015-04-29 14:02:37.015454 7f887875e900 -1 osd.456 43089
> set_disk_tp_priority(22) Invalid argument:
> osd_disk_thread_ioprio_class is  but only the following values are
> allowed: idle, be or rt

Could you please provide "ceph version" line from this log, somewhere
before this error?

-- 
Mykola Golub
