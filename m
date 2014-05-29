From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: messenger changes
Date: Thu, 29 May 2014 18:04:50 -0400 (EDT)
Message-ID: <1079621891.156.1401401090133.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <alpine.DEB.2.00.1405291345580.20692@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2512 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932963AbaE2WEy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 May 2014 18:04:54 -0400
In-Reply-To: <alpine.DEB.2.00.1405291345580.20692@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: greg@inktank.com, ceph-devel@vger.kernel.org

Hi Sage,

Sure, I'll join the core standup.  I think you have the right ideas, I'll give
it some more thought as well, before tomorrow's meeting.

Thanks,

Matt

----- "Sage Weil" <sage@inktank.com> wrote:

> Hey Matt,
> 
> Can you join us for the core standup tomorrow, or shortly after, to
> sycn 
> up on the messenger changes needed for xio?
> 
> I've taken most of the generic messenger refactoring and changes that
> I 
> see that aren't yet xio-specific and pulled them into wip-msgr:
> 
> 	https://github.com/ceph/ceph/pull/1883
> 
> The main things I see now that are blocking the rest of the xio
> stuff:
> 
>  - xio specific code in the buffer class
> 
>  - the Message completion hook and other stuff needs to be separated
> out 
> into a separate patch that goes ahead of the other pieces
> 
>  - I don't think creating multiple Messenger instances for all of the
> OSD, 
> mon, etc is going to work well.  We need to figure out a generic way
> to 
> instantiate them without adding support that is specific to every 
> subsystem/client/daemon/whatever.  Probably this means passing an
> address 
> type to the Messenger::create() method, or something similar. For now,
> I 
> think we can focus on a single transport for each part of the system 
> (e.g., osd<->osd) and not worry about multiprotocol support.  That
> will 
> get us to something usable much sooner.
> 
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
