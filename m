From: Sage Weil <sage@newdream.net>
Subject: Re: write and read error handling problems
Date: Wed, 10 Aug 2011 07:36:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108100733540.2007@cobra.newdream.net>
References: <CABAwU-ao6=DfMEeJZLZnYniVnzs+Gp7BYLoGv-36oUUPCR77Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39567 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab1HJOcH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2011 10:32:07 -0400
In-Reply-To: <CABAwU-ao6=DfMEeJZLZnYniVnzs+Gp7BYLoGv-36oUUPCR77Qg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 10 Aug 2011, huang jun wrote:

> hi,all
> About OSD read ops, if osd got errors, it just return,
> that may lead memory leak. we patched it.
> diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
> index 2ab21bb..21fbca7 100644
> --- a/src/osd/ReplicatedPG.cc
> +++ b/src/osd/ReplicatedPG.cc
> @@ -588,8 +588,18 @@ void ReplicatedPG::do_op(MOSDOp *op)
>      obc->ondisk_read_unlock();
>    }
> 
> -  if (result == -EAGAIN)
> +  if (result == -EAGAIN) {
> +    delete ctx;
>      return;
> +  }
> please have a check!

That was a leak, yep!  In the current master it's already fixed up (along 
with the obc and src_obc [something new]):

  if (result == -EAGAIN) {
    // clean up after the ctx
    delete ctx;
    put_object_context(obc);
    put_object_contexts(src_obc);
    return;
  }

> So i'm confused about the Error handling strategy of write/read
> operations in OSD.
> If the ceph just return when encountered errors, pass the work to client?
> Let's take an example of writing files. Client send request to write 4MB file,
> and OSD first write the osd journal, then return commit msg to Client.
> But, if the write file op was interrupted by the borken disk sector or
> other errors, that means write ops failed. What does the OSD going to
> do? Replay it from the former writen journal item? or other methods?

Currently if cosd gets an error back from the underlying file system it 
will make itself crash, effectively escalating a sector error into a 
failure of cosd itself.  If you (the admin) are able to repair the disk/fs 
and restart cosd, it will replay from the journal and continue.  
Otherwise you can replace the disk and it will recover the whole osd's 
data set from the rest of the cluster.

sage
