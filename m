From: Sage Weil <sage@newdream.net>
Subject: C vs C++ APIs
Date: Fri, 18 Feb 2011 13:14:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102181309590.13848@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44587 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab1BRVNc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 16:13:32 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 86FD3BC766
	for <ceph-devel@vger.kernel.org>; Fri, 18 Feb 2011 13:14:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 57F52BC766
	for <ceph-devel@vger.kernel.org>; Fri, 18 Feb 2011 13:14:56 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

For librados and librbd there are currently C and C++ bindings.  The nice 
thing about the C++ bindings is the interface is cleaner (class-based) and 
they expose the native bufferlists.  On the other hand, things get messy 
when there are multiple .so's exposing C++ bindings (librados currently, 
now librbd, potentially a libceph.hpp too).  For example, where does 
bufferlist.h et al go?  (Currently /usr/include/rados/bufferlist.h.)

I see a few options...

 - stack the libraries (librbd and libceph depend on librados), even 
though internally they do not.  Export the needed C++ symbols from 
librados for the others to use (e.g. ceph::buffer_total_alloc).

 - push the bufferlist/spinlock/atomic stuff into a libceph-common that 
the others depend on.

 - drop the C++ interfaces.  probably fine, and less dangerous because we 
don't have to worry about bufferlist implementation drifting between the 
library user and library.  OTOH, we currently use it for most of our 
internal rados/rbd tools.

sage
