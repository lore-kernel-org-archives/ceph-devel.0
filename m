From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 2/2] ceph: mark user pages dirty on direct-io reads
Date: Wed, 15 Dec 2010 22:23:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012152220090.13669@cobra.newdream.net>
References: <1292474959-2834-1-git-send-email-sage@newdream.net>
 <1292474959-2834-2-git-send-email-sage@newdream.net>
 <Pine.LNX.4.64.1012152115140.13669@cobra.newdream.net>
 <AANLkTim3vynUFKPFtciL7zqAmiefR5GVHfR-U9tBEjdh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1853872315-1292480600=:13669"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51118 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab0LPGSH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Dec 2010 01:18:07 -0500
In-Reply-To: <AANLkTim3vynUFKPFtciL7zqAmiefR5GVHfR-U9tBEjdh@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1853872315-1292480600=:13669
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 16 Dec 2010, Henry C Chang wrote:
> > That aside, I have no idea if this patch is the right thing to do. =A0I
> > thought the page bits were mainly important for the page cache... what =
do
> > we accomplish by marking user pages dirty this way?
>=20
> Hmm.... It's just because I read this:
> http://www.makelinux.net/ldd3/chp-15-sect-3.shtml
>=20
> It says:
> "Once your direct I/O operation is complete, you must release the user
> pages. Before doing so, however, you must inform the kernel if you
> changed the contents of those pages. Otherwise, the kernel may think
> that the pages are "clean," meaning that they match a copy found on
> the swap device, and free them without writing them out to backing
> store. So, if you have changed the pages (in response to a user-space
> read request), you must mark each affected page dirty with a call to:
> void SetPageDirty(struct page *page);"

Oh, I see now; I was looking at the wrong implementation of=20
get_user_pages.  I fixed it up to use the put_page_vector helper in the=20
error path (to put the pages we _did_ get).

For the dirtying, that makes sense now too.  The get_user_pages() comment=
=20
indicates that set_page_dirty_lock() and put_page() should be used, though=
=20
(see mm/memory.c line ~1500).

Pushed a patch that does this.  Care to test it out?

=09git://ceph.newdream.net/git/ceph-client.git master

Thanks!
sage
--557981400-1853872315-1292480600=:13669--
