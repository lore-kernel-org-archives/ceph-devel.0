From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: Evict op on a watched object
Date: Tue, 12 Apr 2016 09:55:07 -0400 (EDT)
Message-ID: <374757380.50053913.1460469307261.JavaMail.zimbra@redhat.com>
References: <CA+cZ7sid2YxNRcNzXS3CF=qPx3UWUw0jC0DaEpV9mxZ3E_piJw@mail.gmail.com> <322414041.49670668.1460387920039.JavaMail.zimbra@redhat.com> <CA+cZ7sgv3t2wP79EbNbyi6nMLxOHt61QFBTs-RuWL8kqWft-jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:55419 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932659AbcDLNzJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 09:55:09 -0400
In-Reply-To: <CA+cZ7sgv3t2wP79EbNbyi6nMLxOHt61QFBTs-RuWL8kqWft-jw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhiqiang Wang <wonzhq@gmail.com>
Cc: ceph-devel@vger.kernel.org

I am not too familiar with the detailed inner-workings of the OSD, but that looks right.  In theory, if all the registered watches can support pings, you can queue up watch disconnect messages in the transaction context and proceed with the eviction.  The v2 watch clients will receive the notification that they have been disconnected and they will attempt to re-register the watch.

Jason

----- Original Message -----
> Thanks Jason.
> 
> Looks like in the osd side, the only difference between 'watch' and
> 'legacy watch' is whether 'will_ping' is set. Can we use this to check
> for 'legacy watch'? Or as we don't use 'legacy watch' any more, we
> just don't care about it?
> 
> (forgot to cc the mail list, sorry for the dup mails)
> 
> 2016-04-11 23:18 GMT+08:00 Jason Dillaman <dillaman@redhat.com>:
> >> Currently it is not allowed to issue an evict op
> >> (CEPH_OSD_OP_CACHE_EVICT) on an object which has watchers (e.g. the
> >> rbd header). EBUSY is returned in this case. This leads to the the
> >> flush-evict-all failure during removing a cache tier, something like
> >> below:
> >>
> >> rbd_header.4fc06b8b4567
> >> failed to evict /rbd_header.4fc06b8b4567: (16) Device or resource busy
> >>
> >> My question is that do we actually need to do so? The object in the
> >> base pool should have the watcher information as well after the flush.
> >> Probably we could remove this 'watcher' check to make flush-evict-all
> >> happy?
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> > I opened a ticket [1] a couple of months ago to address this issue.
> >
> > [1] http://tracker.ceph.com/issues/14865
> >
> > --
> >
> > Jason Dillaman
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 

Jason Dillaman 
