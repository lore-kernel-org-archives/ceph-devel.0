From: Sage Weil <sage@newdream.net>
Subject: Re: how to print bad crc data message body to logfile
Date: Tue, 12 May 2015 09:57:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505120956590.28239@cobra.newdream.net>
References: <CABAwU-ZNTo==+H-RjsUP8Zp_0FMMGrzH6Ao3uXFOEXSD=8aVZQ@mail.gmail.com> <alpine.DEB.2.00.1505120937290.28239@cobra.newdream.net> <CABAwU-ZsQR8eNjLS0RvvKrTO26=YmZ-0DbwQDNtqgb+wdnwF1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33594 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674AbbELQ5T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 12:57:19 -0400
In-Reply-To: <CABAwU-ZsQR8eNjLS0RvvKrTO26=YmZ-0DbwQDNtqgb+wdnwF1g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 13 May 2015, huang jun wrote:
> we use 0.80.7 version, do you mean the newer ceph release will print
> the message content to log file if we set debug_ms=20?

I mean I verified that current master prints at level 20, but maybe 0.80.7 
doesn't.. I didn't check :)

> 
> 2015-05-13 0:37 GMT+08:00 Sage Weil <sage@newdream.net>:
> > On Tue, 12 May 2015, huang jun wrote:
> >> hi,all
> >> we see the bad data crc warning and we have set debug_ms=20, but the
> >> message body doesn't logged into /var/log/ceph/ceph-osd.x.log file.
> >> Did i miss something? or i need to change the buffer::list::hexdump()
> >> function and recompile it?
> >
> > Hrm, it should be there at level 20.  Unless that was added in a version
> > newer than what you're running?
> >
> > sage
> 
> 
> 
> -- 
> thanks
> huangjun
> 
> 
