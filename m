From: Roman Hlynovskiy <roman.hlynovskiy@gmail.com>
Subject: Re: ceph stability
Date: Thu, 20 Dec 2012 13:08:51 +0600
Message-ID: <CAD5ewrryqXEDv_HDGK8RettDmi7LwH_eEOCNCx_1jduj61_=cA@mail.gmail.com>
References: <CAD5ewrosrMWD3jxznaMhab=VTL4VzQ7savVk42KDe374VSSzbA@mail.gmail.com>
	<50D1C09E.9000504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:61894 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab2LTHIw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Dec 2012 02:08:52 -0500
Received: by mail-qa0-f54.google.com with SMTP id j15so2229440qaq.6
        for <ceph-devel@vger.kernel.org>; Wed, 19 Dec 2012 23:08:51 -0800 (PST)
In-Reply-To: <50D1C09E.9000504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hello Mark,

for multi-mds solutions do you refer to multi-active arch or 1 active
and many standby arch?

http://ceph.com/docs/master/architecture/ says:
-----
The Ceph filesystem service is provided by a daemon called ceph-mds.
It uses RADOS to store all the filesystem metadata (directories, file
ownership, access modes, etc), and directs clients to access RADOS
directly for the file contents. The Ceph filesystem aims for POSIX
compatibility. ceph-mds can run as a single process, or it can be
distributed out to multiple physical machines, either for high
availability or for scalability.

High Availability: The extra ceph-mds instances can be standby, ready
to take over the duties of any failed ceph-mds that was active. This
is easy because all the data, including the journal, is stored on
RADOS. The transition is triggered automatically by ceph-mon.
Scalability: Multiple ceph-mds instances can be active, and they will
split the directory tree into subtrees (and shards of a single busy
directory), effectively balancing the load amongst all active servers.

Combinations of standby and active etc are possible, for example
running 3 active ceph-mds instances for scaling, and one standby
intance for high availability.
-----

 I saw cases while standby mds took over traffic from the active one.
Looks like it's working. Would you please clarify.
 I tried to disable 2 standby mds and happily reproduced the problem )
so, it's something else. I will try playing with mds log level and
provide more accurate details.

thanks!


2012/12/19 Mark Nelson <mark.nelson@inktank.com>:

>
>
> A quicky side-node:  multi-mds solutions aren't being supported in
> production right now.  Not sure if your stat problems below are related, but
> you may want to try starting out with a single mds and see if the problem
> goes away.  If so, there may be some hints in the mds logs regarding what's
> going on.  Bug reports are welcome!
>
>>
>> [osd.0]
>>      host = ceph-node01
>>
>> [osd.1]
>>      host = ceph-node02
>>
>> [osd.2]
>>      host = ceph-node03




--
...WBR, Roman Hlynovskiy
