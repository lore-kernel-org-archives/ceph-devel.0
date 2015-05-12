From: Sage Weil <sage@newdream.net>
Subject: Re: how to print bad crc data message body to logfile
Date: Tue, 12 May 2015 09:37:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505120937290.28239@cobra.newdream.net>
References: <CABAwU-ZNTo==+H-RjsUP8Zp_0FMMGrzH6Ao3uXFOEXSD=8aVZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33516 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932850AbbELQhz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 12:37:55 -0400
In-Reply-To: <CABAwU-ZNTo==+H-RjsUP8Zp_0FMMGrzH6Ao3uXFOEXSD=8aVZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 12 May 2015, huang jun wrote:
> hi,all
> we see the bad data crc warning and we have set debug_ms=20, but the
> message body doesn't logged into /var/log/ceph/ceph-osd.x.log file.
> Did i miss something? or i need to change the buffer::list::hexdump()
> function and recompile it?

Hrm, it should be there at level 20.  Unless that was added in a version 
newer than what you're running?

sage
