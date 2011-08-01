From: Sage Weil <sage@newdream.net>
Subject: Re: rados callbacks
Date: Mon, 1 Aug 2011 09:12:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108010907280.6290@cobra.newdream.net>
References: <CAO47_-9LwTQFfzZko=8oKz+nM5OKrcfW6ch0A9ZX6hqedhieTw@mail.gmail.com>
 <CAC-hyiH8QWYNNbxb6d8CDr3dkFVHX=VwdcijJjRHLfv+pV=QEw@mail.gmail.com>
 <CAF3hT9C1HqWPBOvRESB2Na7xs6ECKD_WV0XFHi5H5Fy_JfLOUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49207 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab1HAQIu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 12:08:50 -0400
In-Reply-To: <CAF3hT9C1HqWPBOvRESB2Na7xs6ECKD_WV0XFHi5H5Fy_JfLOUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>, chb@muc.de, ceph-devel@vger.kernel.org

On Mon, 1 Aug 2011, Gregory Farnum wrote:
> On Mon, Aug 1, 2011 at 8:23 AM, Yehuda Sadeh Weinraub
> <yehuda.sadeh@dreamhost.com> wrote:
> > The osd first sends the ack when it receives the request
> 
> Actually it sends an ack when the request is applied in-memory to all
> the up OSDs in the PG. :)

That was the original intent, at least.  More precisely..

 * ACK means the request is in the page/buffer cache on all replicas
 * COMMIT means the request is on stable storage on all replicas
 * COMMIT implies ACK.

With a non-btrfs fs (ext4, etc.), however, the OSD is doing writeahead 
journaling, in which means the commit happens before the write is applies 
to the fs, and clients just get COMMIT (which implies ACK).  

The OSD has internal locking to ensure that behavior is consistent from 
the client's perspective.  That is, after getting a COMMIT, any subsequent 
read will return the new data (even if the read request has to wait on the
OSD to be applied to the fs).

This should go in the wiki too...

sage

