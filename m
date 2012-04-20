From: Calvin Morrow <calvin.morrow@gmail.com>
Subject: Re: Log files with 0.45
Date: Fri, 20 Apr 2012 16:09:58 -0400
Message-ID: <CADxhoDSjfQBoUNWwiKFzj=Hjm2C6cvacbR1si48Ad+_sta9KMA@mail.gmail.com>
References: <4F8E48C3.7040309@bisect.de>
	<4A32F0EAF810462DA627FE3E06945B65@dreamhost.com>
	<CAPud5_6M_f2eSz4dMT7QGXVpdbtc3Q_sPD-byAYL0Y+JQ0bAVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:63894 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab2DTUJ7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Apr 2012 16:09:59 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so6300952wej.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 Apr 2012 13:09:58 -0700 (PDT)
In-Reply-To: <CAPud5_6M_f2eSz4dMT7QGXVpdbtc3Q_sPD-byAYL0Y+JQ0bAVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm seeing the same.  < 12 hours with 6 OSDs resulted in ~18 GB of
logs.  I had to change my log rotate config to compress based on size
instead of once a day or I ended up with a full root partition.

I would love to know if there's a better way to handle it.

Calvin

On Fri, Apr 20, 2012 at 5:05 PM, Nick Bartos <nick@pistoncloud.com> wro=
te:
> Is there a recommended log config for production systems? =A0I'm also
> trying to decrease the verbosity in 0.45, using the options specified
> here: =A0http://ceph.newdream.net/wiki/Debugging. =A0Setting them dow=
n to
> '1' doesn't end the insane log sprawl I'm seeing.
>
> On Tue, Apr 17, 2012 at 10:09 PM, Greg Farnum
> <gregory.farnum@dreamhost.com> wrote:
>> On Tuesday, April 17, 2012 at 9:53 PM, Danny Kukawka wrote:
>>> Hi,
>>>
>>> did something change with the default log levels for OSDs on v0.45?=
 With
>>> 0.43 and IIRC also 0.44* the logfiles had a acceptable size, but no=
w I
>>> get by default ~3Gbyte per OSD over 12 hours without any change in =
the
>>> config file.
>>>
>>> Danny
>> I think some extra event notifications got stuck in the logs for OSD=
 operations; they're nice for debugging but may well have a log level h=
igher than they should. They should be easy to compress a lot, though!
>>
>> Can you comment on this, Sam?
>> -Greg
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
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
