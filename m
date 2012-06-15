From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: ceph next branch: error creating empty object store in /srv/osd.10:
 (22) Invalid argument
Date: Fri, 15 Jun 2012 07:50:30 +0200
Message-ID: <4FDACD26.4030803@profihost.ag>
References: <4FD9D187.8030601@profihost.ag> <4FD9D366.3060305@profihost.ag> <Pine.LNX.4.64.1206141315390.23137@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:53957 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab2FOFui (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 01:50:38 -0400
In-Reply-To: <Pine.LNX.4.64.1206141315390.23137@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 14.06.2012 22:17, schrieb Sage Weil:
> On Thu, 14 Jun 2012, Stefan Priebe - Profihost AG wrote:
> Is it possible that the osd journal you configured is a file in the osd
> data directory that doesn't already exist
Sure is this wrong?
[osd]
         osd journal = /journal/osd.$id.journal
         osd journal size = 1000

and the /journal dir is empty.

 >, and you didn't specify the 'osd
> journal size' option in ceph.conf?
no it is - see above


> The change here is that ceph-osd --mkfs no longer wipes out previous data,
> so that's now your job.
ah OK ;-) didn't know that.

 > But it only creates the journal file when the
> size is specified, otherwise it needs to already be present...
It wasn't present but the size was set. Strangely the error occours but 
it still creates the file... ?!

Stefan
