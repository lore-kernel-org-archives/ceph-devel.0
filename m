From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: watch/notify changes ready for review
Date: Tue, 18 Nov 2014 14:40:29 -0500 (EST)
Message-ID: <1606502525.15819093.1416339629561.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.00.1411131645430.10048@cobra.newdream.net> <alpine.DEB.2.00.1411171635590.23009@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:38191 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbaKRTkb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Nov 2014 14:40:31 -0500
In-Reply-To: <alpine.DEB.2.00.1411171635590.23009@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On the RBD side of the house, since RBD won't be (purposely) delaying notification ACKs, about the only thing it can do is just log that it must have a laggy connection.  It might be useful for diagnostics, but I can't think of any immediate use for doing something proactive to correct the delay.

-- 

Jason Dillaman 
Red Hat 
dillaman@redhat.com 
http://www.redhat.com 


----- Original Message -----
From: "Sage Weil" <sage@newdream.net>
To: ceph-devel@vger.kernel.org
Sent: Monday, November 17, 2014 7:42:14 PM
Subject: Re: watch/notify changes ready for review

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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
