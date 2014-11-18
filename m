From: Sage Weil <sage@newdream.net>
Subject: Re: watch/notify changes ready for review
Date: Mon, 17 Nov 2014 16:42:14 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411171635590.23009@cobra.newdream.net>
References: <alpine.DEB.2.00.1411131645430.10048@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42407 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbaKRAmO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Nov 2014 19:42:14 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 6220780068
	for <ceph-devel@vger.kernel.org>; Mon, 17 Nov 2014 16:42:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 2313580068
	for <ceph-devel@vger.kernel.org>; Mon, 17 Nov 2014 16:42:14 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1411131645430.10048@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Thu, 13 Nov 2014, Sage Weil wrote:
> My pile of watch/notify changes are ready for review:
> 
> 	https://github.com/ceph/ceph/pull/2924

Okay, I did another round of cleanup (including moving most of the code 
into Objecter) and it's now way cleaner and passing all the basic tests 
(hasn't gone through full yet).

I still have a big outstanding question:

Does the failed notify API make sense?  I'm leaning no, but want another 
opinion before I go rip it back out.  To summarize: it notifies a watcher 
if it was slow to respond to an earlier notify and caused the notifier to 
time out.  Counterargument: if the notifier wants to tell everyone they 
saw a timeout, they could send another notify; at least then they would 
know if the second piece of information was delivered (quickly).  I don't 
think that librbd or rgw will make use of it.

The last bit of work remaining is to migrate RGW over to the new API and 
make it use watch_check().  Will work with Yehuda on that, but in the 
meantime, this is ready for review!

sage
