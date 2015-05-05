From: Wido den Hollander <wido@42on.com>
Subject: Re: Default config value for osd_disk_thread_ioprio_class
Date: Tue, 05 May 2015 10:43:34 +0200
Message-ID: <554882B6.1090609@42on.com>
References: <5540CA47.8010201@pcextreme.nl> <5540CD3C.4080409@42on.com> <alpine.DEB.2.00.1504290949400.24030@cobra.newdream.net> <55412922.7020300@42on.com> <20150505064600.GA21225@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:56035 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757050AbbEEInl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 May 2015 04:43:41 -0400
In-Reply-To: <20150505064600.GA21225@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On 05/05/2015 08:46 AM, Mykola Golub wrote:
> On Wed, Apr 29, 2015 at 08:55:30PM +0200, Wido den Hollander wrote:
> 
>> In the process of upgrading a cluster from Giant to Hammer I saw this
>> on the OSD logs:
>>
>> 2015-04-29 14:02:37.015454 7f887875e900 -1 osd.456 43089
>> set_disk_tp_priority(22) Invalid argument:
>> osd_disk_thread_ioprio_class is  but only the following values are
>> allowed: idle, be or rt
> 
> Could you please provide "ceph version" line from this log, somewhere
> before this error?
> 

This was with 0.94.1 with the Ubuntu 14.04 packages from eu.ceph.com

I currently don't have access to this cluster anymore, but it was not
build from source by myself.


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
