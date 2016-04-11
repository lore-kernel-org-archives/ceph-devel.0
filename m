From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: Evict op on a watched object
Date: Mon, 11 Apr 2016 11:18:40 -0400 (EDT)
Message-ID: <322414041.49670668.1460387920039.JavaMail.zimbra@redhat.com>
References: <CA+cZ7sid2YxNRcNzXS3CF=qPx3UWUw0jC0DaEpV9mxZ3E_piJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:37849 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629AbcDKPSm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 11:18:42 -0400
In-Reply-To: <CA+cZ7sid2YxNRcNzXS3CF=qPx3UWUw0jC0DaEpV9mxZ3E_piJw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhiqiang Wang <wonzhq@gmail.com>
Cc: ceph-devel@vger.kernel.org

> Currently it is not allowed to issue an evict op
> (CEPH_OSD_OP_CACHE_EVICT) on an object which has watchers (e.g. the
> rbd header). EBUSY is returned in this case. This leads to the the
> flush-evict-all failure during removing a cache tier, something like
> below:
> 
> rbd_header.4fc06b8b4567
> failed to evict /rbd_header.4fc06b8b4567: (16) Device or resource busy
> 
> My question is that do we actually need to do so? The object in the
> base pool should have the watcher information as well after the flush.
> Probably we could remove this 'watcher' check to make flush-evict-all
> happy?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

I opened a ticket [1] a couple of months ago to address this issue.

[1] http://tracker.ceph.com/issues/14865

-- 

Jason Dillaman 
