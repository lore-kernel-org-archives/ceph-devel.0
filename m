From: Jeremy Allison <jra@samba.org>
Subject: Re: [samba PATCH] vfs:ceph: convert to using ceph_statx structures
 and functions, when available
Date: Thu, 8 Sep 2016 09:56:30 -0700
Message-ID: <20160908165630.GA29600@jra3>
References: <1473344984-22564-1-git-send-email-jlayton@samba.org>
 <1473345355.2564.8.camel@samba.org>
Reply-To: Jeremy Allison <jra@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hr2.samba.org ([144.76.82.148]:60278 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965359AbcIHQ4l (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 8 Sep 2016 12:56:41 -0400
Content-Disposition: inline
In-Reply-To: <1473345355.2564.8.camel@samba.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@samba.org>
Cc: samba-technical@lists.samba.org, ceph-devel@vger.kernel.org, ira@wakeful.net

On Thu, Sep 08, 2016 at 10:35:55AM -0400, Jeff Layton wrote:
> On Thu, 2016-09-08 at 10:29 -0400, Jeff Layton wrote:
> > Add a configure test for the ceph_statx function, and use that to
> > determine whether to compile in new functions that use it and its
> > variants, or whether to use a the older code that fetches birthtimes
> > from an xattr.
> > 
> > For cephwrap_lstat, we can use ceph_statx with the AT_SYMLINK_NOFOLLOW
> > flag to get the right lookup semantics.
> > 
> > For setting the times via cephwrap_ntimes, We can just use ceph_setattrx
> > and pass them all in at the same time.
> > 
> > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > ---
> >  source3/modules/vfs_ceph.c | 216 ++++++++++++++++++++++++++++++++++++++-------
> >  source3/wscript            |   2 +
> >  2 files changed, 185 insertions(+), 33 deletions(-)
> > 
> 
> The new interfaces are now merged in the ceph master branch and should
> ship with the Kraken release. I know however, that Greg F. has some
> libcephfs API changes queued up that might change these function
> prototypes.
> 
> So, it may be good to hold off on merging this into samba master until
> his work has been merged.

Fair enough. I'll file these away in my samba-ceph folder until
you tell me to go look at them :-).

Cheers,

	Jeremy.
