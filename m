From: Sage Weil <sage@inktank.com>
Subject: Re: v0.51 released
Date: Mon, 27 Aug 2012 08:28:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208270827150.4250@cobra.newdream.net>
References: <alpine.DEB.2.00.1208260858010.11218@cobra.newdream.net> <503B8F29.4070001@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47684 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab2H0P2f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 11:28:35 -0400
In-Reply-To: <503B8F29.4070001@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 27 Aug 2012, Martin Mailand wrote:
> Hi Sage,
> 
> is in this release the rbd layering/cloning already testable?
> Do you have a link to the docs how to use it?

Not yet.  It is functional in the 'next' branch, though, which will be 
v0.52.  The documentation isn't done yet, but it mostly boils down to the 
'rbd clone ...' command, and 'rbd -h' should get you going.

sage


> 
> Best Regards,
>  martin
> 
> 
> Am 26.08.2012 17:58, schrieb Sage Weil:
> > The latest development release v0.51 is ready. Notable changes include:
> > 
> >   * crush: tunables documented; feature bit now present and enforced
> >   * osd: various fixes for out-of-order op replies
> >   * osd: several rare peering cases fixed
> >   * osd: fixed detection of EIO errors from fs on read
> >   * osd: new 'lock' rados class for generic object locking
> >   * librbd: fixed memory leak on discard
> >   * librbd: image layering/cloning
> >   * radosgw: fix range header for large objects, ETag quoting, GMT dates,
> >     other compatibility fixes
> >   * mkcephfs: fix for default keyring, osd data/journal locations
> >   * wireshark: ceph protocol dissector patch updated
> >   * ceph.spec: fixed packaging problem with crush headers
> > 
> > Full RBD cloning support will be in place in v0.52, as will a refactor of
> > the messenger code with many bug fixes in the socket failure handling.
> > This is available for testing now in 'next' for the adventurous. Improved
> > OSD scrubbing is also coming soon. We should (finally) be building some
> > release RPMs for v0.52 as well.
> > 
> > You can get v0.51 from the usual locations:
> > 
> >   * Git at git://github.com/ceph/ceph.git
> >   * Tarball athttp://ceph.newdream.net/download/ceph-0.51.tar.gz
> >   * For Debian/Ubuntu packages,
> > seehttp://ceph.newdream.net/docs/master/install/debian
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
