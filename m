From: Sage Weil <sage@inktank.com>
Subject: Re: Wireshark
Date: Thu, 27 Jun 2013 05:33:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306270532560.14059@cobra.newdream.net>
References: <51CC127A.3090701@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44024 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab3F0MdW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jun 2013 08:33:22 -0400
In-Reply-To: <51CC127A.3090701@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Jones <k.j.jonez@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 27 Jun 2013, Kevin Jones wrote:
> Hi,
> 
> I have done some work on a version of the Wireshark plugin to re-structure it
> so it may be possible to push upstream at some point. At the moment it handles
> connection establishment, setting up some conversational state tracking and
> decoding a few of the message types. Supporting other message types is now
> fairly straight forward but will take some time to work through to double
> check the decoding logic is up to date and change to a new decoding style.
> 
> At this point I was thinking maybe would be better to check-in as an
> alternative to the existing plugin so there is a base to work incrementally
> towards the upstream goal. Sound like a good approach?

Sounds great!  I can't wait to see this make its way upstream.  :)

Thanks!
sage
