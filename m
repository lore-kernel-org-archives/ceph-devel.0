From: Sage Weil <sage@inktank.com>
Subject: Re: libcephfs create file with layout and replication
Date: Sat, 17 Nov 2012 15:23:32 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211171520280.31628@cobra.newdream.net>
References: <CAPrxi5-eQ=unNbUMO5b_dJpFERySAuWD9GXratMEo9XGPpkrkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45502 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab2KQXXc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Nov 2012 18:23:32 -0500
In-Reply-To: <CAPrxi5-eQ=unNbUMO5b_dJpFERySAuWD9GXratMEo9XGPpkrkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, 17 Nov 2012, Noah Watkins wrote:
> The Hadoop VFS layer assumes that block size and replication can be
> set on a per-file basis, which is important to users for file
> layout/workload optimizations.
> 
> The libcephfs interface doesn't make this entirely easy. Here is one
> approach, but it isn't thread safe as the default values are global
> variables in the client.
> 
>   orig_obj_size = ceph_get_default_object_size() //save
>   set_default_object_size(new size)
>   open(path, O_CREAT)
>   set_default_object_size(new size) //reset
> 
> Something more convenient might be:
> 
>   ceph_open_layout(path, flags, mode, layout, replication)
> 
> where layout and replication are used with O_CREAT | O_EXCL, or and
> interface for setting these values explicitly on newly created files:
> 
>   ceph_open(path, O_CREAT|O_EXCL)
>   ceph_set_layout(path, layout, replication)

This is basically what we have now... at least that's how things work for 
the kernel client.  We should make sure there is a clean way via libcephfs 
to do that.

The client/mds protocol also allows you to specify the layout on file 
creation.  This is better since it has one less round trip to the MDS.  
Let's just create a new open call with those additional arguments.

FWIW, the striping parameters are object size, stripe unit, stripe count, 
and data pool.

sage



> 
> where ceph_set_layout would succeed ostensibly on zero-length files.
> 
> Any thoughts on how to handle this?
> 
> Thanks,
> Noah
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
