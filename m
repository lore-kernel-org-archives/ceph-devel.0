From: Sage Weil <sage@inktank.com>
Subject: messenger changes
Date: Thu, 29 May 2014 13:46:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405291345580.20692@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39732 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932795AbaE2Uqb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 May 2014 16:46:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: matt@linuxbox.com
Cc: greg@inktank.com, ceph-devel@vger.kernel.org

Hey Matt,

Can you join us for the core standup tomorrow, or shortly after, to sycn 
up on the messenger changes needed for xio?

I've taken most of the generic messenger refactoring and changes that I 
see that aren't yet xio-specific and pulled them into wip-msgr:

	https://github.com/ceph/ceph/pull/1883

The main things I see now that are blocking the rest of the xio stuff:

 - xio specific code in the buffer class

 - the Message completion hook and other stuff needs to be separated out 
into a separate patch that goes ahead of the other pieces

 - I don't think creating multiple Messenger instances for all of the OSD, 
mon, etc is going to work well.  We need to figure out a generic way to 
instantiate them without adding support that is specific to every 
subsystem/client/daemon/whatever.  Probably this means passing an address 
type to the Messenger::create() method, or something similar. For now, I 
think we can focus on a single transport for each part of the system 
(e.g., osd<->osd) and not worry about multiprotocol support.  That will 
get us to something usable much sooner.

sage

