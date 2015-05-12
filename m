From: Sage Weil <sage@newdream.net>
Subject: Re: how to print bad crc data message body to logfile
Date: Tue, 12 May 2015 16:17:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505121616520.20395@cobra.newdream.net>
References: <CABAwU-ZNTo==+H-RjsUP8Zp_0FMMGrzH6Ao3uXFOEXSD=8aVZQ@mail.gmail.com> <alpine.DEB.2.00.1505120937290.28239@cobra.newdream.net> <CABAwU-ZsQR8eNjLS0RvvKrTO26=YmZ-0DbwQDNtqgb+wdnwF1g@mail.gmail.com> <alpine.DEB.2.00.1505120956590.28239@cobra.newdream.net>
 <CABAwU-aVyJ=ix5Rqm0eRbcjhDjJoi_3STgw-MyB-1_0X5Yc6Gw@mail.gmail.com> <CABAwU-b0y4+heqo+Xuj4JvSOcmJpq45JPENo0RzG0R69OD3_1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35633 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934025AbbELXRu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 19:17:50 -0400
In-Reply-To: <CABAwU-b0y4+heqo+Xuj4JvSOcmJpq45JPENo0RzG0R69OD3_1Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 13 May 2015, huang jun wrote:
> how to redirect the data.hexdump() to a log file,it's print to screen
> when we use "tail -f /var/log/ceph/ceph-osd.x.log"  dynamically
> monitor the log file. i'm not familiar with ceph's debug system code,
> so where should i begin?

If debug ms = 20 in the [osd] section, it really should be logged there.  
You can verify the setting with

 ceph daemon osd.NNN config show | grep debug_ms

The OSD doesn't generally log anything to stdout/stderr (except during 
startup)...

sage



> 
> 2015-05-13 1:06 GMT+08:00 huang jun <hjwsm1989@gmail.com>:
> > ah, it's also at level 20 in v0.80.7,
> > the control code is:
> >
> > ldout(cct, 20) << " ";
> >  data.hexdump(*_dout);
> >  *_dout << dendl;
> >
> > _dout is a ostream pointer, i think it should print to stdout or stderr,
> > but seems i was wrong.
> >
> > 2015-05-13 0:57 GMT+08:00 Sage Weil <sage@newdream.net>:
> >> On Wed, 13 May 2015, huang jun wrote:
> >>> we use 0.80.7 version, do you mean the newer ceph release will print
> >>> the message content to log file if we set debug_ms=20?
> >>
> >> I mean I verified that current master prints at level 20, but maybe 0.80.7
> >> doesn't.. I didn't check :)
> >>
> >>>
> >>> 2015-05-13 0:37 GMT+08:00 Sage Weil <sage@newdream.net>:
> >>> > On Tue, 12 May 2015, huang jun wrote:
> >>> >> hi,all
> >>> >> we see the bad data crc warning and we have set debug_ms=20, but the
> >>> >> message body doesn't logged into /var/log/ceph/ceph-osd.x.log file.
> >>> >> Did i miss something? or i need to change the buffer::list::hexdump()
> >>> >> function and recompile it?
> >>> >
> >>> > Hrm, it should be there at level 20.  Unless that was added in a version
> >>> > newer than what you're running?
> >>> >
> >>> > sage
> >>>
> >>>
> >>>
> >>> --
> >>> thanks
> >>> huangjun
> >>>
> >>>
> >
> >
> >
> > --
> > thanks
> > huangjun
> 
> 
> 
> -- 
> thanks
> huangjun
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
