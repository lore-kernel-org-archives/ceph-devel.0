From: Nick Bartos <nick@pistoncloud.com>
Subject: Re: Log files with 0.45
Date: Fri, 20 Apr 2012 13:05:14 -0700
Message-ID: <CAPud5_6M_f2eSz4dMT7QGXVpdbtc3Q_sPD-byAYL0Y+JQ0bAVA@mail.gmail.com>
References: <4F8E48C3.7040309@bisect.de>
	<4A32F0EAF810462DA627FE3E06945B65@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49315 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab2DTUFP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Apr 2012 16:05:15 -0400
Received: by yenl12 with SMTP id l12so5430456yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 Apr 2012 13:05:14 -0700 (PDT)
In-Reply-To: <4A32F0EAF810462DA627FE3E06945B65@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: Danny Kukawka <danny.kukawka@bisect.de>, Samuel Just <samuel.just@dreamhost.com>, ceph-devel@vger.kernel.org, Danny Kukawka <dkukawka@suse.de>

Is there a recommended log config for production systems?  I'm also
trying to decrease the verbosity in 0.45, using the options specified
here:  http://ceph.newdream.net/wiki/Debugging.  Setting them down to
'1' doesn't end the insane log sprawl I'm seeing.

On Tue, Apr 17, 2012 at 10:09 PM, Greg Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Tuesday, April 17, 2012 at 9:53 PM, Danny Kukawka wrote:
>> Hi,
>>
>> did something change with the default log levels for OSDs on v0.45? =
With
>> 0.43 and IIRC also 0.44* the logfiles had a acceptable size, but now=
 I
>> get by default ~3Gbyte per OSD over 12 hours without any change in t=
he
>> config file.
>>
>> Danny
> I think some extra event notifications got stuck in the logs for OSD =
operations; they're nice for debugging but may well have a log level hi=
gher than they should. They should be easy to compress a lot, though!
>
> Can you comment on this, Sam?
> -Greg
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
