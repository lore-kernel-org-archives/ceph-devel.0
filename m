From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Log files with 0.45
Date: Fri, 20 Apr 2012 13:40:20 -0700
Message-ID: <DE7DA5088DAF4EA0B5DC68B1974059B5@dreamhost.com>
References: <4F8E48C3.7040309@bisect.de>
 <4A32F0EAF810462DA627FE3E06945B65@dreamhost.com>
 <CAPud5_6M_f2eSz4dMT7QGXVpdbtc3Q_sPD-byAYL0Y+JQ0bAVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41141 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab2DTUkX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Apr 2012 16:40:23 -0400
Received: by obbta14 with SMTP id ta14so10015931obb.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 Apr 2012 13:40:22 -0700 (PDT)
In-Reply-To: <CAPud5_6M_f2eSz4dMT7QGXVpdbtc3Q_sPD-byAYL0Y+JQ0bAVA@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>, Danny Kukawka <danny.kukawka@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Kukawka <dkukawka@suse.de>

I checked with Sam on this and it turns out he created a new subsystem whose output you can control with the "debug optracker" (or --debug-optracker) option (in the same way as the other debug log systems). In 0.45 the output for that system was at inappropriately high levels (1) and it's fixed in our current master (5 now), but you probably want to set "debug optracker = 0" in your config. That should restore things to the way they used to be!
(And sorry for the long  wait, Danny.)
-Greg


On Friday, April 20, 2012 at 1:05 PM, Nick Bartos wrote:

> Is there a recommended log config for production systems? I'm also
> trying to decrease the verbosity in 0.45, using the options specified
> here: http://ceph.newdream.net/wiki/Debugging. Setting them down to
> '1' doesn't end the insane log sprawl I'm seeing.
> 
> On Tue, Apr 17, 2012 at 10:09 PM, Greg Farnum
> <gregory.farnum@dreamhost.com (mailto:gregory.farnum@dreamhost.com)> wrote:
> > On Tuesday, April 17, 2012 at 9:53 PM, Danny Kukawka wrote:
> > > Hi,
> > > 
> > > did something change with the default log levels for OSDs on v0.45? With
> > > 0.43 and IIRC also 0.44* the logfiles had a acceptable size, but now I
> > > get by default ~3Gbyte per OSD over 12 hours without any change in the
> > > config file.
> > > 
> > > Danny
> > I think some extra event notifications got stuck in the logs for OSD operations; they're nice for debugging but may well have a log level higher than they should. They should be easy to compress a lot, though!
> > 
> > Can you comment on this, Sam?
> > -Greg
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



