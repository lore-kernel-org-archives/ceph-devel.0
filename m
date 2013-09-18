From: Sage Weil <sage@inktank.com>
Subject: Re: Rados and user-provided buffers
Date: Wed, 18 Sep 2013 13:01:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309181259060.30792@cobra.newdream.net>
References: <l1d0jr$jqa$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35794 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab3IRUBL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Sep 2013 16:01:11 -0400
In-Reply-To: <l1d0jr$jqa$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rutger ter Borg <rutger@terborg.net>
Cc: ceph-devel@vger.kernel.org

On Wed, 18 Sep 2013, Rutger ter Borg wrote:
> 
> Dear all,
> 
> I've a question regarding buffers in rados (using the C++ API). I'm allocating
> and using my own buffers, and would like to read and write directly into and
> from them. I'm using a bufferlist consisting of static_buffers, which are
> passed to Rados' aio_read and aio_write.
> 
> For aio_write, rados works as expected, i.e., the bufferlist is returned as it
> was before the call. However, when doing aio_read, it seems that the
> bufferlist is destroyed (not used) in the call, despite all the buffers being
> static.
> 
> Is this expected behaviour? I read a thread "read/write on RADOS using
> external buffer" from this mailing list from 2010, but wasn't able to figure
> out whether rados does or doesn't support reading into user-provided
> static_buffers.

The read-into-existing-buffer is only wired up properly for the C 
interface.  For the C++ it isn't generally necessary: we allocate and read 
the data off the network,a nd pass the reference directly back to the user 
without making another copy.  The 2010 thread is about similarly avoiding 
such a copy for the C API.  We didn't contemplate the situation where you 
specifically want the bytes to go to a particular address via C++.  If 
that's what you need, the C++ API needs to be extended, or you can just 
use the C call for that case.

sage

