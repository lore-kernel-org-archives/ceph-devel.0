From: Mark Nigh <mnigh@netelligent.com>
Subject: RE: Unable to Add Monitor
Date: Mon, 9 May 2011 13:27:02 -0500
Message-ID: <B828A4C02BE12543ACDFCF7EB0C693C67885FC7DC9@NC-SVR-09.netelligent.com>
References: <B828A4C02BE12543ACDFCF7EB0C693C67885FC7D23@NC-SVR-09.netelligent.com>
 <BANLkTik5FbaysoFYV-XzKX1T+K8gPAsWzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.netelligent.com ([199.255.228.152]:5154 "EHLO
	NC-SVR-132.netelligent.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753109Ab1EIS1Z convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 May 2011 14:27:25 -0400
In-Reply-To: <BANLkTik5FbaysoFYV-XzKX1T+K8gPAsWzQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Mon, May 9, 2011 at 7:22 AM, Mark Nigh <mnigh@netelligent.com> wrote:
> I have been testing Ceph for several months now but with only 2 mds and 1 mon. I would like to test failover between mon so I am trying to add the first (1st) of two (2) mon on the other mds in the cluster.
>
> I also noticed that the mon naming has been changed from numerics to names so I am trying to change that also.
>
> My Process:
>
> On the first mon, I get an error when issuing this command "ceph mon add beta 10.6.1.91:6789"
>
> I receive the following error as it repeats:
>
> 2011-05-09 09:17:05.500353 7f9248ab0700 -- :/28272 >> 10.6.1.91:6789/0 pipe(0x2167010 sd=3 pgs=0 cs=0 l=0).fault first fault
This error generally means that the daemon can't communicate with its
target -- in this case, 10.6.1.91:6789. Do you already have mon.beta
in your ceph.conf? It looks like ceph tool is trying to issue its
commands to that monitor.
You can specify which monitor to connect to using the -m switch:
ceph -m 10.6.1.90:6789 mon add beta 10.6.1.91:6789
(assuming there that mon.alpha is using address 10.6.1.90:6789).

When I run this command on the original monitor it just hangs. If I run the command, "ceph mon add msd1 10.6.1.91:6789, I receive the following message:

Mds1 is the hostname of the second monitor.

2011-05-09 12:28:01.823280 7ff64926d700 -- 10.6.1.90:0/26252 >> 10.6.1.91:6789/0 pipe(0x16168f0 sd=3 pgs=0 cs=0 l=0).fault first fault
2011-05-09 12:28:07.823488 7ff64d242700 -- 10.6.1.90:0/26252 >> 10.6.1.91:6789/0 pipe(0x16168f0 sd=3 pgs=0 cs=0 l=0).fault first fault

When I try to run the service ceph start mon.1 command on the 2nd monitor:

mon.1 does not exist in monmap

> When I try to start the monitor service on beta I get the following error:
>
> === mon.beta ===
> Starting Ceph mon.beta on mds1...
>  ** WARNING: Ceph is still under heavy development, and is only suitable for **
>  **          testing and review.  Do not trust it with important data.       **
> unable to read magic from mon data.. did you run mkcephfs?
> failed: ' /usr/bin/cmon -i beta -c /etc/ceph/ceph.conf '
Did you follow the directions at
http://ceph.newdream.net/wiki/Monitor_cluster_expansion?

Yes, I believe it maybe that I tried to change the ceph.conf file from mon.0 and mon.1 to mon.alpha and mon.beta as the wiki states. For now, I thought I would revert back to the mon.0 and mon.1 naming convention to eliminate the number of changes.

-Greg

This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.
