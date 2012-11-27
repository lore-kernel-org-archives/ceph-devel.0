From: David Zafman <david.zafman@inktank.com>
Subject: Re: Hadoop and Ceph client/mds view of modification time
Date: Tue, 27 Nov 2012 09:09:41 -0800
Message-ID: <D8FEE2D6-D5EF-41AB-83E6-11518DBB6B38@inktank.com>
References: <CAPrxi5-pcHrxKsteGioaQ3haMOj0V3im1bXRL_TW28SD6R=qZw@mail.gmail.com> <50B4EE31.5020908@inktank.com> <alpine.DEB.2.00.1211270857370.30109@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:59306 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390Ab2K0RJn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Nov 2012 12:09:43 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so4330149dak.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Nov 2012 09:09:43 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211270857370.30109@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Sam Lang <sam.lang@inktank.com>, Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>


On Nov 27, 2012, at 9:03 AM, Sage Weil <sage@inktank.com> wrote:

> On Tue, 27 Nov 2012, Sam Lang wrote:
> 
>> 3. When a client acquires the cap for a file, have the mds provide its current
>> time as well.  As the client updates the mtime, it uses the timestamp provided
>> by the mds and the time since the cap was acquired.
>> Except for the skew caused by the message latency, this approach allows the
>> mtime to be based off the mds time, so it will be consistent across clients
>> and the mds.  It does however, allow a client to set an mtime to the future
>> (based off of its local time), which might be undesirable, but that is more
>> like how  NFS behaves.  Message latency probably won't be much of an issue
>> either, as the granularity of mtime is a second. Also, the client can set its
>> cap acquired timestamp to the time at which the cap was requested, ensuring
>> that the relative increment includes the round trip latency so that the mtime
>> will always be set further ahead. Of course, this approach would be a lot more
>> intrusive to implement. :-)
> 
> Yeah, I'm less excited about this one.
> 
> I think that giving consistent behavior from a single client despite clock 
> skew is a good goal.  That will make things like pjd's test behave 
> consistently, for example.
> 

My suggestion is that a client writing to a file will try to use it's local clock unless it would cause the mtime to go backward.  In that case it will simply perform the minimum mtime advance possible (1 second?).  This handles the case in which one client created a file using his clock (per previous suggested change), then another client writes with a clock that is behind.

David

