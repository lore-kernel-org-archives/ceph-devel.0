From: Sage Weil <sage@inktank.com>
Subject: Re: blueprint: osd: ceph on zfs
Date: Sun, 4 Aug 2013 20:53:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308042051450.5645@cobra.newdream.net>
References: <alpine.DEB.2.00.1307251649540.32741@cobra.newdream.net> <CA+Hcz59y0S31YJdP-MHQnUNKLjWo9Lezc4OWzJjx8i283=bAcQ@mail.gmail.com> <CAAM7YAnXuMUk0ZA5=LCHQp=Bu8E3S7X1soQiBt87gmOChs9gwA@mail.gmail.com>
 <CA+Hcz58t+HX5q_cNQ_as47kR+R1+7B8OftUHr_4j1CYVdhDnug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40647 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249Ab3HEDxo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Aug 2013 23:53:44 -0400
In-Reply-To: <CA+Hcz58t+HX5q_cNQ_as47kR+R1+7B8OftUHr_4j1CYVdhDnug@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 4 Aug 2013, Noah Watkins wrote:
> I was thinking along the lines of if it made sense to multi-purpose
> the BackFileSystem for non-Linux portability. In which case even
> things like posix_fallocate, xattr access, etc.. might fit in well,
> which may have equivalent functionality, under a different name.

Yeah.

In the fiemap case, incidentally, we probably are better off using 
SEEK_DATA/SEEK_HOLE for the extentmap stuff, since FIEMAP is/was buggy in 
many common kernels, and only gives you meaningful data after an fsync().  
Currently it's disabled.

sage


> 
> On Sun, Aug 4, 2013 at 5:47 PM, Yan, Zheng <ukernel@gmail.com> wrote:
> > On Mon, Aug 5, 2013 at 7:39 AM, Noah Watkins <noah.watkins@inktank.com> wrote:
> >> It seems to make sense that fiemap should be part of the `class
> >> BackingFileSystem` abstraction?
> >>
> >
> > FS_IOC_FIEMAP is a standard API, I think no need to implement it in `class
> > BackingFileSystem`.
> >
> >
> >> On Thu, Jul 25, 2013 at 4:53 PM, Sage Weil <sage@inktank.com> wrote:
> >>> http://wiki.ceph.com/01Planning/02Blueprints/Emperor/osd:_ceph_on_zfs
> >>>
> >>> We've done some preliminary testing and xattr debugging that allows
> >>> ceph-osd to run on zfsforlinux using the normal writeahead journaling mode
> >>> (the same mode used for xfs and ext4).  However, we aren't doing anything
> >>> special to take advantage of zfs's capabilities.
> >>>
> >>> This session would go over what is needed to make parallel journaling work
> >>> (which would leverage zfs snapshots).  I would also like to have a
> >>> discussion about whether other longer-term possibilities, such as storing
> >>> objects directly using the DMU, make sense given what ceph-osd's
> >>> ObjectStore interface really needs.  It might also be an appropriate time
> >>> to visit whether other snapshotting linux filesystems (like nilfs2) would
> >>> fit well into any generalization of the filestore code that comes out of
> >>> this effort.
> >>>
> >>> If anybody is interested in this, please add yourself to the interested
> >>> parties section (or claim ownership) of this blueprint!
> >>>
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
