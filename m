From: Sage Weil <sage@inktank.com>
Subject: Re: [GIT PULL v5] java: add libcephfs Java bindings
Date: Wed, 3 Oct 2012 12:39:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210031238300.23173@cobra.newdream.net>
References: <CAPrxi5-6JAWzUdsgdfHw=pG+6r5LN5i8X92DwxdejosY0xT0Dw@mail.gmail.com> <alpine.DEB.2.00.1209052051270.7974@cobra.newdream.net> <CAPrxi5-_AYV0UUuABCM+LkSpRVOM63R5XPDmjz9HE3UxFBe7AA@mail.gmail.com>
 <CAPrxi59Per-OMrc83pVLAkUs3rU=+RF9bN_X5bb+K1zC+STUng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36100 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab2JCTje (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 15:39:34 -0400
In-Reply-To: <CAPrxi59Per-OMrc83pVLAkUs3rU=+RF9bN_X5bb+K1zC+STUng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: gcs@debian.hu, Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Joe Buck <buck@soe.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 3 Oct 2012, Noah Watkins wrote:
> Hi Sage,
> 
> I wanted to touch base on this Java bindings patch series to make sure
> this can become a solid foundation for the Hadoop shim clean-up. Were
> there any specific issues with this, other than not yet having a major
> consumer?

From my perspective it's ready.  I was hoping that Laszlo could look at 
the packaging bits before I merged, but then I lost track of it.

Laszlo, do you have a minute to take a look?

Thanks!
sage

> 
> -Noah
> 
> On Thu, Sep 6, 2012 at 11:02 AM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> > On Thu, Sep 6, 2012 at 8:42 AM, Sage Weil <sage@inktank.com> wrote:
> >>
> >> Also, I noticed the automake patch removes CephException.java, added in
> >> the previous patch... probably an accident?
> >
> > I left CephException out intentionally because it could be replaced by
> > generic exceptions in Java like IOException or FileNotFoundException.
> > My belief is that CephException (and specializations of this) will
> > need to be re-introduced as more error cases are covered. For example,
> > I think we'll want a CephBadFileDescriptor, but currently libcephfs
> > doesn't appear to return -EBADF (the client is crashing do to fd_map
> > assert). So, the Java wrappers should be as stable as the C API, but
> > both seem to need some loose ends tied up.
> >
> >> Can't wait to pull this in!  BTW, Noah, do you know if this is still an
> >> issue?
> >>
> >>         http://tracker.newdream.net/issues/2778
> >
> > It does appear that -ENOENT is now returned. I added a unit test that
> > expects FileNotFoundException and that works out nicely.
> >
> > - Noah
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
