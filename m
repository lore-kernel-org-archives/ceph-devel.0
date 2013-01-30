From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 0/6] fix build (ceph.spec)
Date: Wed, 30 Jan 2013 11:55:18 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301301153510.18801@cobra.newdream.net>
References: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de> <92E15B6073484C53B4AE3A0B85F0FC25@inktank.com> <510966CF.6070501@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53977 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769Ab3A3TzS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 14:55:18 -0500
In-Reply-To: <510966CF.6070501@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: Gregory Farnum <greg@inktank.com>, dan.mick@inktank.com, ceph-devel@vger.kernel.org, Watkins Noah <noah.watkins@inktank.com>

On Wed, 30 Jan 2013, Danny Al-Gaaf wrote:
> Am 30.01.2013 19:07, schrieb Gregory Farnum:
> > On Wednesday, January 30, 2013 at 10:00 AM, Danny Al-Gaaf wrote:
> >> This set fixes some issues in the spec file.
> >> 
> >> I'm not sure what the reason for
> >> #35e5d74e5c5786bc91df5dc10b5c08c77305df4e was. But I would revert
> >> it and fix the underlaying issues instead.
> > 
> > 
> > That is a pretty obtuse commit message, but it was actually because
> > while rbd-fuse is ready to be in-tree, we don't think it's ready for
> > people to be using; there are some undocumented gotchas involved with
> > it and not a lot of testing. :)
> 
> Hm, but this is git master and not a released ceph version or the next
> tree. IMO rbd-fuse should be installed in the master branch to be
> tested. Otherwise it will be build but maybe never tested by others than
> developers which know it's there.

I think the end goal is to build an rbd-fuse package, just like ceph-fuse.  
I'm not sure it matters how mature the tool is before it goes into the 
package; as long as it is separate, people can not install it, and the 
distros can keep it out of their supported repos as they like.

s

> 
> > I'll let others comment on the Java library moves and other packaging
> > changes. -Greg
> 
> Only an additional comment: I've moved the libcephfs_jni.* files to
> %{_libdir} because this is what SUSE already do for e.g. the *.so files
> in the libjnidispatch package.
> 
> Danny
> 
> 
