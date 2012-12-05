From: Dan Mick <dan.mick@inktank.com>
Subject: Re: 0.55 init script Issue?
Date: Wed, 05 Dec 2012 11:41:08 -0800
Message-ID: <50BFA354.7040308@inktank.com>
References: <50BF7314.2020809@gammacode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36818 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176Ab2LETlL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Dec 2012 14:41:11 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3831595pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Dec 2012 11:41:11 -0800 (PST)
In-Reply-To: <50BF7314.2020809@gammacode.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mdawson@gammacode.com>
Cc: ceph-devel@vger.kernel.org

The story as best I know it is that we're trying to transition to and 
use upstart where possible, but that the upstart config does not (yet?) 
try to do what the init.d config did.  That is, it doesn't support 
options to the one script, but rather separates daemons into separate 
services, and does not reach out to remote machines to start daemons, etc.

The intent is that init.d/ceph is left for non-Upstart distros, AFAICT.

Tv had some design notes here:

http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg09314.html

We need better documentation/rationale here at least.



On 12/05/2012 08:15 AM, Mike Dawson wrote:
> All,
>
> After upgrading from 0.54 to 0.55, the command "service ceph start"
> fails. But "/etc/init.d/ceph start" works. This is the case for start.
> stop, etc. Here is an example:
>
> root@node2:~# /etc/init.d/ceph stop
> === mon.a ===
> Stopping Ceph mon.a on node2...kill 2505...done
> === osd.0 ===
> Stopping Ceph osd.0 on node2...kill 5042...done
> === osd.1 ===
> Stopping Ceph osd.1 on node2...kill 5116...done
> === osd.17 ===
> Stopping Ceph osd.17 on node2...kill 5275...done
>
>
> root@node2:~# service ceph start
> start: Job is already running: ceph
>
>
> root@node2:~# /etc/init.d/ceph start
> === mon.a ===
> Starting Ceph mon.a on node2...
> starting mon.a rank 0 at 172.16.1.2:6789/0 mon_data
> /var/lib/ceph/mon/ceph-a fsid 4951e786-945e-47b6-b1b1-4043b6cc3b55
> === osd.0 ===
> Starting Ceph osd.0 on node2...
> starting osd.0 at :/0 osd_data /var/lib/ceph/osd/ceph-0 /dev/sda6
> === osd.1 ===
> Starting Ceph osd.1 on node2...
> starting osd.1 at :/0 osd_data /var/lib/ceph/osd/ceph-1 /dev/sda7
> === osd.17 ===
> Starting Ceph osd.17 on node2...
> starting osd.17 at :/0 osd_data /var/lib/ceph/osd/ceph-17 /dev/sda8
>
>
> This is Ubuntu 12.10 with packages from debian-testing. One other user
> on IRC confirmed the same behavior. Is this a known issue?
>
>
> Thanks,
> Mike Dawson
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
