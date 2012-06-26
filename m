From: Sage Weil <sage@inktank.com>
Subject: Re: how client handle the errors with OSD and MDS?
Date: Tue, 26 Jun 2012 10:46:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206261044280.17502@cobra.newdream.net>
References: <CAGffWzo65eSRSr05No8u6hAoJtUwZPDRft5Mj2CbGLF23yfa0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50175 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab2FZRqv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 13:46:51 -0400
In-Reply-To: <CAGffWzo65eSRSr05No8u6hAoJtUwZPDRft5Mj2CbGLF23yfa0Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ming zhang <ming.zhang.china@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 26 Jun 2012, ming zhang wrote:
> Hi All
> 
> I am trying to read the code to understand this.
> 
> A scenario like this.
> 
> client opens the file and finishes the write with OSD. But for some
> reason Client could not contact MDS and fails to update MDS. What will
> client do now in order to maintain the rightness of metadata in MDS?
> 
> Wonder which code this error handling is implemented?

When the client session times out, the MDS will probe the file objects to 
recover the file size and mtime.  The NEEDSRECOVER flag gets set by 
Locker::revoke_stale_caps() on those files, and they are queued via 
MDCache::queue_file_recover().  You should be able to pick up the trail 
from there.

sage
