From: Brian Jackson <iggy@theiggy.com>
Subject: Re: CEPH distributed filesystem on two sites
Date: Mon, 12 Jul 2010 14:09:00 -0500
Message-ID: <201007121409.00765.iggy@theiggy.com>
References: <AANLkTikDlZd0AUFzJ_VCnWYYsTnHlTmilok2o4_ErFvq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from theiggy.com ([66.220.1.110]:44600 "EHLO mail.theiggy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057Ab0GLTJE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 12 Jul 2010 15:09:04 -0400
In-Reply-To: <AANLkTikDlZd0AUFzJ_VCnWYYsTnHlTmilok2o4_ErFvq@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roland Rabben <roland@jotta.no>
Cc: ceph-devel@vger.kernel.org

On Monday, July 12, 2010 01:59:38 pm Roland Rabben wrote:
> Have there been any work to get CEPH working with two datacenters?


We've talked about it on irc in the past. It's not really what ceph was 
designed for, but given sufficient bandwidth between the DCs it should work.

In your particular situation if 1 DC was disconnected but not down, you could 
have an issue if things changed in both locations. You would also have an 
issue if connectivity was lost because ceph would try to replicate things up 
to 3x at both sites.


> 
> I would like to have two copies of a file at site 1 and a third copy
> at site two.


That should be achievable.


> And would you be able to continue running with one of the sites down?


Well, taking into consideration the things I already mentioned, you should 
continue to have access to the filesystem.


> 
> Best regards
> 
> Roland Rabben
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
