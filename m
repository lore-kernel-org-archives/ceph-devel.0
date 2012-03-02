From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/4] libceph: miscellaneous cleanups
Date: Fri, 2 Mar 2012 13:42:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203021341280.6413@cobra.newdream.net>
References: <4F4DAD34.2030202@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42541 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313Ab2CBVmT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 16:42:19 -0500
In-Reply-To: <4F4DAD34.2030202@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

These look good, modulo the socket state switch() warning, and the 
rearranging of zero page addr code (which i think belongs inside 
write_partial_message_pages()).

Reviewed-by: Sage Weil <sage@newdream.net>


On Tue, 28 Feb 2012, Alex Elder wrote:

> More cleanups, this time in the messenger code.	-Alex
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
