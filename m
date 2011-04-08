From: Wido den Hollander <wido@widodh.nl>
Subject: Re: PGs Degraded
Date: Fri, 08 Apr 2011 20:38:17 +0200
Message-ID: <1302287897.2444.4.camel@wido-laptop.pcextreme.nl>
References: <B828A4C02BE12543ACDFCF7EB0C693C6788452CCA2@NC-SVR-09.netelligent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:54659 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757314Ab1DHSiT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2011 14:38:19 -0400
In-Reply-To: <B828A4C02BE12543ACDFCF7EB0C693C6788452CCA2@NC-SVR-09.netelligent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nigh <mnigh@netelligent.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Mark,

On Fri, 2011-04-08 at 12:09 -0500, Mark Nigh wrote:
> I have recently built a ceph cluster with the following nodes:
> 
> 2011-04-08 11:54:08.038841    pg v3661: 264 pgs: 264 active+clean+degraded; 9079 MB data, 9234 MB used, 811 GB / 820 GB avail; 2319/4638 degraded (50.000%)
> 2011-04-08 11:54:08.039492   mds e17: 2/2/2 up {0=up:active,1=up:active}
> 2011-04-08 11:54:08.039529   osd e18: 4 osds: 4 up, 4 in
> 2011-04-08 11:54:08.039592   log 2011-04-08 10:08:09.135994 mds0 10.6.1.90:6800/16761 4 : [INF] closing stale session client4142 10.6.1.62:0/667143763 after 304.524869
> 2011-04-08 11:54:08.039673   mon e1: 1 mons at {0=10.6.1.90:6789/0}
> 

That seems odd, your  "data" is only 200MB less then "used". What is the
replication size for the "data" and "metadata" pool?

$ ceph osd dump -o - (rep pg_size)

> I have a few files in the cluster (not much data) but have noticed from the beginning of the build (after the 2 osd) that some of my PGs are degraded.
> 
> How do I fix this and is there a tool/command to assist in determining what PGs are degraded?

You can view your degraded pg's with:

$ ceph pg dump -o -

This will tell you the degraded PG's and on which OSD's they are.

Did you remove any OSD's from this cluster? It seems very odd that the
cluster is in a 50% degraded state.

Wido

> 
> Ceph -v is as follows:
> 
> ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
> 
> I appreciate the help.
> 
> Mark Nigh
> 
> This transmission and any attached files are privileged, confidential or otherwise the exclusive property of the intended recipient or Netelligent Corporation. If you are not the intended recipient, any disclosure, copying, distribution or use of any of the information contained in or attached to this transmission is strictly prohibited. If you have received this transmission in error, please contact us immediately by responding to this message or by telephone (314-392-6900) and promptly destroy the original transmission and its attachments.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


