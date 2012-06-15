From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: ceph next branch: error creating empty object store in /srv/osd.10:
 (22) Invalid argument
Date: Fri, 15 Jun 2012 22:58:17 +0200
Message-ID: <4FDBA1E9.50906@profihost.ag>
References: <4FD9D187.8030601@profihost.ag> <4FD9D366.3060305@profihost.ag> <Pine.LNX.4.64.1206141315390.23137@cobra.newdream.net> <4FDACD26.4030803@profihost.ag> <Pine.LNX.4.64.1206150927040.4551@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:53505 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757812Ab2FOU6P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 16:58:15 -0400
In-Reply-To: <Pine.LNX.4.64.1206150927040.4551@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 15.06.2012 18:29, schrieb Sage Weil:
>>> But it only creates the journal file when the
>>> size is specified, otherwise it needs to already be present...
>> It wasn't present but the size was set. Strangely the error occours but it
>> still creates the file... ?!
>
> It sure is.
>
> Can you reproduce with 'debug filestore = 20' and attach the log to this
> bug?
>
> 	http://tracker.newdream.net/issues/2595

done and log attached

Stefan
