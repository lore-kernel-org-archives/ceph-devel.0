From: Sage Weil <sage@newdream.net>
Subject: Re: Installing and configuring ceph
Date: Thu, 6 Jan 2011 07:39:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101060736150.3524@cobra.newdream.net>
References: <1294327481.3371.163.camel@hermosa.morreale.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34167 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab1AFPdz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Jan 2011 10:33:55 -0500
In-Reply-To: <1294327481.3371.163.camel@hermosa.morreale.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Peter W. Morreale" <pmorreale@novell.com>
Cc: ceph-devel@vger.kernel.org

Hi Peter,

On Thu, 6 Jan 2011, Peter W. Morreale wrote:
>
> I'm having a difficult time installing ceph for the first time by
> following the newdream wiki site.  Can some kind soul help with the
> following?
> 
> I've built ceph 0.24 from the tarball on a pristine OpenSUSE 11.3
> release, and performed:
> 
> % make 
> % make install
> % make install-data (from reading the makefiles)
> 
> The goal is to install ceph on 3 identical machines, each with a
> dedicated partition, using btrfs.  (yes, ssh access w/o passwords are
> configured among these machines)
> 
> 1) /etc/init.d/ceph is not installed, nor are the sample confs installed
> in /etc/ceph.  Is there some other make target I need to run?  The
> INSTALL file in the source is not very helpful.  Install manually?
> Where is the init.d script?  (.../src/ceph is a binary.)

Currently the init.d script isn't installed by 'make install', only by the 
debian/redhat packaging.  This is partly just ignorance on my part: I'm 
not sure to what extent the init.d script location is OS dependent.  
You can copy it yourself from src/init-ceph.
 
> 2) Do I need a kernel client?  Its not clear to me from the wiki what
> the role of the kernel module is.   Do I need the kernel client for
> client access only?  From a previous post I inferred that one could use
> fuse for client access, is that correct?

Right. The kernel module is only for client access.  You can use cfuse 
instead.

> 3) I assume I need to install the user-space portion of ceph on all
> machines?  Or do we differentiate between ceph user-space servers on on
> "server" machines and the kernel client for 'client' access. 

The daemons are only needed on the server machines.  /sbin/mount.ceph is 
needed on the client side only if you want to mount by hostname instead 
of ip.
 
> 4) Is there some other documentation that explains bringing up ceph for
> the first time?  Everything I find is vectored to the wiki. 
> 
> Clearly I am missing the larger picture on how to install.  Thanks in
> advance for any info.  

The wiki is it.  Any specific suggestions on what pieces of information 
(beyond the above) that would make it more helpful are welcome!

sage
