From: huang jun <hjwsm1989@gmail.com>
Subject: Re: how to print bad crc data message body to logfile
Date: Wed, 13 May 2015 01:06:13 +0800
Message-ID: <CABAwU-aVyJ=ix5Rqm0eRbcjhDjJoi_3STgw-MyB-1_0X5Yc6Gw@mail.gmail.com>
References: <CABAwU-ZNTo==+H-RjsUP8Zp_0FMMGrzH6Ao3uXFOEXSD=8aVZQ@mail.gmail.com>
	<alpine.DEB.2.00.1505120937290.28239@cobra.newdream.net>
	<CABAwU-ZsQR8eNjLS0RvvKrTO26=YmZ-0DbwQDNtqgb+wdnwF1g@mail.gmail.com>
	<alpine.DEB.2.00.1505120956590.28239@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:33566 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306AbbELRGO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 13:06:14 -0400
Received: by layy10 with SMTP id y10so10897406lay.0
        for <ceph-devel@vger.kernel.org>; Tue, 12 May 2015 10:06:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1505120956590.28239@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

ah, it's also at level 20 in v0.80.7,
the control code is:

ldout(cct, 20) << " ";
 data.hexdump(*_dout);
 *_dout << dendl;

_dout is a ostream pointer, i think it should print to stdout or stderr,
but seems i was wrong.

2015-05-13 0:57 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Wed, 13 May 2015, huang jun wrote:
>> we use 0.80.7 version, do you mean the newer ceph release will print
>> the message content to log file if we set debug_ms=20?
>
> I mean I verified that current master prints at level 20, but maybe 0.80.7
> doesn't.. I didn't check :)
>
>>
>> 2015-05-13 0:37 GMT+08:00 Sage Weil <sage@newdream.net>:
>> > On Tue, 12 May 2015, huang jun wrote:
>> >> hi,all
>> >> we see the bad data crc warning and we have set debug_ms=20, but the
>> >> message body doesn't logged into /var/log/ceph/ceph-osd.x.log file.
>> >> Did i miss something? or i need to change the buffer::list::hexdump()
>> >> function and recompile it?
>> >
>> > Hrm, it should be there at level 20.  Unless that was added in a version
>> > newer than what you're running?
>> >
>> > sage
>>
>>
>>
>> --
>> thanks
>> huangjun
>>
>>



-- 
thanks
huangjun
