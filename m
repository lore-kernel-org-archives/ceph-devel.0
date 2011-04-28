From: Sage Weil <sage@newdream.net>
Subject: Re: libceph API
Date: Thu, 28 Apr 2011 10:23:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104281022200.1187@cobra.newdream.net>
References: <BANLkTim22eFcMzxL0sB4GRpUZfu7FL3x4A@mail.gmail.com>
 <Pine.LNX.4.64.1104202200100.26241@cobra.newdream.net>
 <BANLkTi=DB7sqb9aHmigGiQZWzFAp-jugAA@mail.gmail.com>
 <BANLkTik6+NewTgWodk01NceXVmZW1qpfAg@mail.gmail.com>
 <BANLkTi=w+vwA1Xx0qUx0QXsB8+=nJ0=U+g@mail.gmail.com> <20110427192827.GA6405@dreamer>
 <BANLkTi=g1tJTAuQDm4VaMNhj-f72DTKDrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45351 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab1D1RXR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Apr 2011 13:23:17 -0400
In-Reply-To: <BANLkTi=g1tJTAuQDm4VaMNhj-f72DTKDrA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, Brian Chrisman <brchrisman@gmail.com>, ceph-devel@vger.kernel.org

On Thu, 28 Apr 2011, Colin McCabe wrote:
> On Wed, Apr 27, 2011 at 12:28 PM, Tommi Virtanen
> <tommi.virtanen@dreamhost.com> wrote:
> > On Wed, Apr 27, 2011 at 11:49:11AM -0700, Brian Chrisman wrote:
> >> ceph_mount_t is forward declared as a struct in libceph.h.
> >> When referencing that within libceph.h, gcc barfs:
> >> client/libceph.h:32: error: expected ?)? before ?*? token
> >>
> >> Is libceph.h intended to be used in C-programs, and if so, am I using
> >> it incorrectly?
> >> ceph_mount_t is defined as a class in libceph.cc, and I'm unclear on
> >> how that would be translated into a struct for C-programs linking to
> >> libceph.
> >
> > We talked about this on IRC, replying here for others & historical
> > records.
> >
> > The problem is this:
> >
> > struct ceph_mount_t;
> >
> > int ceph_create(ceph_mount_t **cmount, const char * const id);
> >
> > There is no ceph_mount_t. Changing the prototype to
> >
> > int ceph_create(struct ceph_mount_t **cmount, const char * const id);
> >
> > should get things going nicely (as long as you fix up the
> > implementation also).
> 
> Yeah, the struct keyword needs to be added for the benefit of C
> clients. Sorry for any confusion.

I pushed a patch to master that adds this.  It's now

	struct ceph_mount_t;

which is sort of annoying: the _t suffix really shouldn't be there.  But 
if it's just ceph_mount it conflicts with int ceph_mount()...  :/

sage

