From: Sage Weil <sage@inktank.com>
Subject: Re: Fwd: Waiters on OSD operations will hang if replies invalid?
Date: Fri, 8 Nov 2013 22:06:49 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311082204190.4750@cobra.newdream.net>
References: <527B0428.7090306@ubuntukylin.com> <527D96BC.3020502@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58167 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab3KIGGt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Nov 2013 01:06:49 -0500
In-Reply-To: <527D96BC.3020502@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: ceph-devel@vger.kernel.org

On Sat, 9 Nov 2013, Li Wang wrote:
> Hi Sage,
>   I am wondering if this issue is there. My understanding is that, for OSD
> requests, if replies get lost, each request will get re-sent, even to
> different OSDs, if the Monitor tells the client corresponding OSD error. Then
> each request will finally get handled in handle_reply(), right? But, how about
> if the replies are invalid, as described below.
>   If this issue is really there, I will try to prepare patches.

Yeah, I think you are right.  If we get an invalid reply something is 
clearly wrong with the cluster, so this isn't the highest concern, but it 
would definitely be better if the client failed with EIO instead of 
hanging forever.  I suspect this is mainly a matter of making the bad_put 
label also set r_result and kick the waiters, although there is probably 
some reorganization that can be done to reorganize the flow in this 
function a bit and avoid duplicating any code.

Thanks!
sage

> 
> Cheers,
> Li Wang
> 
> -------- Original Message --------
> Subject: Waiters on OSD operations will hang if replies invalid?
> Date: Thu, 07 Nov 2013 11:08:24 +0800
> From: Li Wang <liwang@ubuntukylin.com>
> To: ceph-devel@vger.kernel.org <ceph-devel@vger.kernel.org>
> CC: Sage Weil <sage@inktank.com>
> 
> For ceph_sync_write()/ceph_osdc_readpages()/ceph_osdc_writepages(), the
> user process or kernel thread will
> wait for the pending OSD requests to complete on the corresponding
> req->r_completion. But it seems they only are waked up in handle_reply()
> and provided the replies are correct. What about if the replies are
> invalid, as the situations of label 'bad_put' in this function intended
> to capture, the waiters gotta hang there?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> 
