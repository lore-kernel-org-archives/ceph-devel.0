From: Mike Dawson <mike.dawson@cloudapt.com>
Subject: Re: RADOS + deep scrubbing performance issues in production environment
Date: Tue, 28 Jan 2014 01:30:46 -0500
Message-ID: <52E74E96.8070202@cloudapt.com>
References: <20140127151321.GD26390@philipgian-mac> <CAFMfnwp4u-O8m3gZko35y5t3r05kAgt9zUWOew_pmHSJjmLPmA@mail.gmail.com> <alpine.DEB.2.00.1401271045160.2149@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36974 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbaA1Gas (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jan 2014 01:30:48 -0500
Received: by mail-ig0-f182.google.com with SMTP id uy17so805904igb.3
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jan 2014 22:30:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1401271045160.2149@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Kyle Bader <kyle.bader@gmail.com>
Cc: Filippos Giannakos <philipgian@grnet.gr>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, synnefo-devel@googlegroups.com


On 1/27/2014 1:45 PM, Sage Weil wrote:
> There is also
>
>   ceph osd set noscrub
>
> and then later
>
>   ceph osd unset noscrub
>
In my experience scrub isn't nearly as much of a problem as deep-scrub. 
On a IOPS constrained cluster with writes approaching the available 
aggregate spindle performance minus replication penalty and possibly 
co-located osd journal penalty, scrub may run without any disruption. 
But deep-scrub tends to make iowait on the spindles get ugly.

To disable/enable deep-scrub use:

ceph osd set nodeep-scrub
ceph osd unset nodeep-scrub


> I forget whether this pauses an in-progress PG scrub or just makes it stop
> when it gets to the next PG boundary.
>
> sage
>
> On Mon, 27 Jan 2014, Kyle Bader wrote:
>
>>> Are there any tools we are not aware of for controlling, possibly pausing,
>>> deep-scrub and/or getting some progress about the procedure ?
>>> Also since I believe it would be a bad practice to disable deep-scrubbing do you
>>> have any recommendations of how to work around (or even solve) this issue ?
>>
>> The periodicity of scrubs is controllable with these tunables:
>>
>> osd scrub max interval
>> osd deep scrub interval
>>
>> You may also be interested in adjusting:
>>
>> osd scrub load threshold
>>
>> More information on the docs page:
>>
>> http://ceph.com/docs/master/rados/configuration/osd-config-ref/#scrubbing

I rarely run into a situation where 1m average of load is <0.5 on a 
multi-core server running osds, so deep scrub for me is always triggered 
by the 'osd scrub max interval'. I've had a bug out there to take core 
count into consideration:

http://tracker.ceph.com/issues/6296

The documentation used to say the "Default is 50%" implying that this 
feature should allow scrub to start with a much higher load than 0.5 
will allow on multi-core systems. The documentation has changed, but the 
default of 0.5 is still artificially suppressing deep-scrub from 
opportunistically starting on relatively idle multi-core systems.

That being said, deep-scrub may be better served with an 
osd_scrub_iops_threshold mechanism instead of (or in addition to) the 
osd_scrub_load_threshold.

- Mike

>>
>> Hope that helps some!
>>
>> --
>>
>> Kyle
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
