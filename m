From: Sage Weil <sage@inktank.com>
Subject: Re: rbd map command hangs for 15 minutes during system start up
Date: Thu, 15 Nov 2012 16:25:48 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211151623260.26514@cobra.newdream.net>
References: <CA+jddaMAx8OKd8-uHaj-eDx8PJwZB=ew7PkkSAy8Y3Uwm5S85g@mail.gmail.com> <509C5FA6.7010600@inktank.com> <CAPud5_4fcXZJqnds3A2nX2-jR9Nn_GBObX+Rgxf-Sou8jx5j8w@mail.gmail.com> <alpine.DEB.2.00.1211121514200.26823@cobra.newdream.net>
 <CAPud5_7+O3mJkQcBQntnx7qmgBMTM+EYL_RUVbh+wmPmG2vz4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49841 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab2KPAZs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 19:25:48 -0500
In-Reply-To: <CAPud5_7+O3mJkQcBQntnx7qmgBMTM+EYL_RUVbh+wmPmG2vz4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, Mandell Degerness <mandell@pistoncloud.com>, ceph-devel@vger.kernel.org

On Thu, 15 Nov 2012, Nick Bartos wrote:
> Sorry I guess this e-mail got missed.  I believe those patches came
> from the ceph/linux-3.5.5-ceph branch.  I'm now using the wip-3.5
> branch patches, which seem to all be fine.  We'll stick with 3.5 and
> this backport for now until we can figure out what's wrong with 3.6.
> 
> I typically ignore the wip branches just due to the naming when I'm
> looking for updates.  Where should I typically look for updates that
> aren't in released kernels?  Also, is there anything else in the wip*
> branches that you think we may find particularly useful?

You were looking in the right place.  The problem was we weren't super 
organized with our stable patches, and changed our minds about what to 
send upstream.  These are 'wip' in the sense that they were in preparation 
for going upstream.  The goal is to push them to the mainline stable 
kernels and ideally not keep them in our tree at all.

wip-3.5 is an oddity because the mainline stable kernel is EOL'd, but 
we're keeping it so that ubuntu can pick it up for quantal.

I'll make sure these are more clearly marked as stable.

sage


> 
> 
> On Mon, Nov 12, 2012 at 3:16 PM, Sage Weil <sage@inktank.com> wrote:
> > On Mon, 12 Nov 2012, Nick Bartos wrote:
> >> After removing 8-libceph-protect-ceph_con_open-with-mutex.patch, it
> >> seems we no longer have this hang.
> >
> > Hmm, that's a bit disconcerting.  Did this series come from our old 3.5
> > stable series?  I recently prepared a new one that backports *all* of the
> > fixes from 3.6 to 3.5 (and 3.4); see wip-3.5 in ceph-client.git.  I would
> > be curious if you see problems with that.
> >
> > So far, with these fixes in place, we have not seen any unexplained kernel
> > crashes in this code.
> >
> > I take it you're going back to a 3.5 kernel because you weren't able to
> > get rid of the sync problem with 3.6?
> >
> > sage
> >
> >
> >
> >>
> >> On Thu, Nov 8, 2012 at 5:43 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> >> > On 11/08/2012 02:10 PM, Mandell Degerness wrote:
> >> >>
> >> >> We are seeing a somewhat random, but frequent hang on our systems
> >> >> during startup.  The hang happens at the point where an "rbd map
> >> >> <rbdvol>" command is run.
> >> >>
> >> >> I've attached the ceph logs from the cluster.  The map command happens
> >> >> at Nov  8 18:41:09 on server 172.18.0.15.  The process which hung can
> >> >> be seen in the log as 172.18.0.15:0/1143980479.
> >> >>
> >> >> It appears as if the TCP socket is opened to the OSD, but then times
> >> >> out 15 minutes later, the process gets data when the socket is closed
> >> >> on the client server and it retries.
> >> >>
> >> >> Please help.
> >> >>
> >> >> We are using ceph version 0.48.2argonaut
> >> >> (commit:3e02b2fad88c2a95d9c0c86878f10d1beb780bfe).
> >> >>
> >> >> We are using a 3.5.7 kernel with the following list of patches applied:
> >> >>
> >> >> 1-libceph-encapsulate-out-message-data-setup.patch
> >> >> 2-libceph-dont-mark-footer-complete-before-it-is.patch
> >> >> 3-libceph-move-init-of-bio_iter.patch
> >> >> 4-libceph-dont-use-bio_iter-as-a-flag.patch
> >> >> 5-libceph-resubmit-linger-ops-when-pg-mapping-changes.patch
> >> >> 6-libceph-re-initialize-bio_iter-on-start-of-message-receive.patch
> >> >> 7-ceph-close-old-con-before-reopening-on-mds-reconnect.patch
> >> >> 8-libceph-protect-ceph_con_open-with-mutex.patch
> >> >> 9-libceph-reset-connection-retry-on-successfully-negotiation.patch
> >> >> 10-rbd-only-reset-capacity-when-pointing-to-head.patch
> >> >> 11-rbd-set-image-size-when-header-is-updated.patch
> >> >> 12-libceph-fix-crypto-key-null-deref-memory-leak.patch
> >> >> 13-ceph-tolerate-and-warn-on-extraneous-dentry-from-mds.patch
> >> >> 14-ceph-avoid-divide-by-zero-in-__validate_layout.patch
> >> >> 15-rbd-drop-dev-reference-on-error-in-rbd_open.patch
> >> >> 16-ceph-Fix-oops-when-handling-mdsmap-that-decreases-max_mds.patch
> >> >> 17-libceph-check-for-invalid-mapping.patch
> >> >> 18-ceph-propagate-layout-error-on-osd-request-creation.patch
> >> >> 19-rbd-BUG-on-invalid-layout.patch
> >> >> 20-ceph-return-EIO-on-invalid-layout-on-GET_DATALOC-ioctl.patch
> >> >> 21-ceph-avoid-32-bit-page-index-overflow.patch
> >> >> 23-ceph-fix-dentry-reference-leak-in-encode_fh.patch
> >> >>
> >> >> Any suggestions?
> >> >
> >> >
> >> > The log shows your monitors don't have time sychronized enough among
> >> > them to make much progress (including authenticating new connections).
> >> > That's probably the real issue. 0.2s is pretty large clock drift.
> >> >
> >> >
> >> >> One thought is that the following patch (which we could not apply) is
> >> >> what is required:
> >> >>
> >> >> 22-rbd-reset-BACKOFF-if-unable-to-re-queue.patch
> >> >
> >> >
> >> > This is certainly useful too, but I don't think it's the cause of
> >> > the delay in this case.
> >> >
> >> > Josh
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
