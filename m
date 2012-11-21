From: hemant surale <hemant.surale@gmail.com>
Subject: Re: OSD daemon changes port no
Date: Wed, 21 Nov 2012 11:05:15 +0530
Message-ID: <CAGfy=6k3xh_dKJRNiNL_ecKOOXnGWaQT5i2K0Gpz9wW0=C7mWg@mail.gmail.com>
References: <CAGfy=6kVyt-a+j8mKYqXYVErRWEUK8ko1ydJuBxY5dr849OD0A@mail.gmail.com>
	<alpine.DEB.2.00.1211200844240.7369@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:58535 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab2KUFfQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 00:35:16 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so3223390vcm.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Nov 2012 21:35:15 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211200844240.7369@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

>>    and one more thing how can it be possible to read from one osd and
>> then simultaneous write to direct on other osd with less/no traffic?
>
> I'm not sure I understand the question...

Scenario :
       I have written file X.txt on some osd which is primary for filr
X.txt ( direct write operation using rados cmd) .
       Now while read on file X.txt is in progress, Can I make sure
the simultaneous write request must be directed to other osd using
crushmaps/other way?

Goal of task :
       Trying to avoid read - write clashes as much as possible to
achieve faster operations (I/O) . Although CRUSH selects osd for data
placement based on pseudo random function.  is it possible ?



-
Hemant Surale.



On Tue, Nov 20, 2012 at 10:15 PM, Sage Weil <sage@inktank.com> wrote:
> On Tue, 20 Nov 2012, hemant surale wrote:
>> Hi Community,
>>    I have question about port number used by ceph-osd daemon . I
>> observed traffic (inter -osd communication while data ingest happened)
>> on port 6802 and then after some time when I ingested second file
>> after some delay port no 6804 was used . Is there any specific reason
>> to change port no here?
>
> The ports are dynamic.  Daemons bind to a random (6800-6900) port on
> startup and communicate on that.  They discover each other via the
> addresses published in the osdmap when the daemon starts.
>
>>    and one more thing how can it be possible to read from one osd and
>> then simultaneous write to direct on other osd with less/no traffic?
>
> I'm not sure I understand the question...
>
> sage
