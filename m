From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: monitor crashing
Date: Tue, 13 Oct 2015 06:25:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510130624270.6589@cobra.newdream.net>
References: <CACx0BdM2qsO0n492Y7R=+FBfJzJT+4HxbBYaU1rkG0mZV=caJw@mail.gmail.com> <CACx0BdNRPk64Etwvs7_tEce=xwFw7E4Ube=8raav_-EFhhP2Fw@mail.gmail.com> <CACx0BdMi79jokSX4aPy9XJrUorE-2Fa-_oBDjYwW3bBuee5A7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42565 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbbJMNZ4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 09:25:56 -0400
In-Reply-To: <CACx0BdMi79jokSX4aPy9XJrUorE-2Fa-_oBDjYwW3bBuee5A7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Periquito <periquito@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 13 Oct 2015, Luis Periquito wrote:
> Any ideas? I'm growing desperate :(
> 
> I've tried compiling from source, and including
> https://github.com/ceph/ceph/pull/5276, but it still crashes on boot
> of the ceph-mon

If you can email a (link to a) tarball of your mon data directory I'd love 
to extract the osdmap and see why crush is crashing.. it's obviously not 
supposed to do that (even with a bad rule).  You can also use 
the ceph-post-file utility.

Thanks!
sage


> 
> ---------- Forwarded message ----------
> From: Luis Periquito <periquito@gmail.com>
> Date: Tue, Oct 13, 2015 at 12:26 PM
> Subject: Re: monitor crashing
> To: Ceph Users <ceph-users@lists.ceph.com>
> 
> 
> I'm currently running Hammer (0.94.3), created an invalid LRC profile
> (typo in the l=, should have been l=4 but was l=3, and now I don't
> have enough different ruleset-locality) and created a pool. Is there
> any way to delete this pool? remember I can't start the ceph-mon...
> 
> On Tue, Oct 13, 2015 at 11:56 AM, Luis Periquito <periquito@gmail.com> wrote:
> > It seems I've hit this bug:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1231630
> >
> > is there any way I can recover this cluster? It worked in our test
> > cluster, but crashed the production one...
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
