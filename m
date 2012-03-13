From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/5] libceph: page mapping in the messenger
Date: Mon, 12 Mar 2012 22:31:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203122230590.17324@cobra.newdream.net>
References: <4F5E79C6.6040301@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52349 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754Ab2CMFbK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Mar 2012 01:31:10 -0400
In-Reply-To: <4F5E79C6.6040301@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Looks good to me,

Reviewed-by: Sage Weil <sage@newdream.net>

On Mon, 12 Mar 2012, Alex Elder wrote:

> This series fixes up some things in the messenger code related
> to how it uses pages.  A new ceph_tcp_sendpage() helper is
> created to match the existing ceph_tcp_sendmsg() interface,
> and it is used rather than the sendmsg interface when sending
> zeroes over the wire for a revoked message.  The helper is
> also used for sending message data.  Also, the address mapping
> to the zero page gets eliminated, thereby making the zero page
> get treated no differently than any other page when it is the
> source of a send operation.  Finally there is a little code
> cleanup in the message sending code.
> 
> 					-Alex
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
