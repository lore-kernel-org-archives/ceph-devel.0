From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 2/4] libceph: have messages take a connection reference
Date: Wed, 06 Jun 2012 12:34:18 -0500
Message-ID: <4FCF949A.6080404@inktank.com>
References: <4FCECD7F.9030002@inktank.com> <4FCECF1F.3050106@inktank.com> <Pine.LNX.4.64.1206060945410.5397@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49722 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520Ab2FFReO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 13:34:14 -0400
Received: by yenm10 with SMTP id m10so5215935yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 10:34:13 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206060945410.5397@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 06/06/2012 12:06 PM, Sage Weil wrote:
> I have some reservations about this one.  Not because it's wrong, but 
> because I'm not sure what it will fix (now or later).  Right now the con 
> has references to the messages.  If we add refs the other way around, we 
> need to make sure those refs go away or else the con will leak.  And in 
> order to do that, the upper layer has to properly clean up.  Currently, if 
> it doesn't clean up, the messages would point to an invalid/released con, 
> but nothing would reference them.. they'd leak.  With this change, we 
> would also leak the con and it's containing structure.  I'm not sure 
> that's any better or worse.
> 
> The net effect here is that we're doing a lot of additional atomic 
> operations on the containing object's ref count.  Not sure if that cost is 
> important.
> 
> What do you think?

I think you make good points.

I don't know that this change directly fixes anything, but it might
help verify things as we do ongoing development.

I also think that an upper layer not properly cleaning up is a bug,
which we will fix (and which the reference counting *could* help
identify).  Also, I am not concerned about the cost of the atomic
operations, at least not now.  We have much more important performance
concerns to address before start worrying about that kind of extra
cost.  If we do find that the cost is excessive, we can remove them
(or maybe make them a debug-only feature).

The main thing I want is having the messenger pointing to its
connection, because if we are ever again debugging memory from
a crash it will be very helpful to have.  Beyond that though, the
reference counting is a nice thing to keep things validated.

So I guess--as long as it is working--I'd like to keep it in there.

					-Alex
