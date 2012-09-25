From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Determining when it's safe to reboot a node?
Date: Tue, 25 Sep 2012 20:37:51 +0200
Message-ID: <5061F9FF.7050307@widodh.nl>
References: <CAPud5_4Y2ff8Y5gNgaM0Ap_A4_NwBv2JvLpF9dWxxXKj1CZH-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:50027 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660Ab2IYShw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 14:37:52 -0400
In-Reply-To: <CAPud5_4Y2ff8Y5gNgaM0Ap_A4_NwBv2JvLpF9dWxxXKj1CZH-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org



On 09/25/2012 07:12 PM, Nick Bartos wrote:
> I need to figure out some way of determining when it's OK to safely
> reboot a single node.  I believe this involves making sure that at
> least one other monitor is running and up to date, and all the PGs on
> the local OSDs have up to date copies somewhere else in the cluster.
> We're not concerned about MDS at this time, since we're not currently
> using the POSIX filesystem.
>
> I recall having a verbal conversation with Sage on this topic, but
> apparently I didn't take good notes or I can't find them.  I do
> remember the solution was somewhat complicated.  Is there any sort of
> straight forward 'ceph' command that can do this now?  If there isn't
> one, I think it would be really great if something like that could be
> implemented.  It would seem to be a common enough use case to have a
> simple command which could tell the admin if rebooting the node would
> render the cluster partially unusable.
> --

Before rebooting that node you can mark the OSDs on that node as out.

For example, you are planning a reboot for a node with OSD 12 - 15:

$ ceph osd out 12
$ ceph osd out 13
$ ceph osd out 14
$ ceph osd out 15

Depending on what you've set "mon osd auto mark in" set to you will have 
to mark that OSDs "in" again when the node is back.

The question is if you want to mark them out, since that will cause data 
to be replicated again to meet your replication settings.

If you known the downtime will be short due to just a kernel update, you 
might want to consider just marking them down:

$ ceph osd down 12
$ ceph osd down 13
$ ceph osd down 14
$ ceph osd down 15

That won't cause a data replication as long as the node is back before 
"mon osd down out interval" which is 300 seconds by default.

Wido

> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
