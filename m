From: Sage Weil <sage@inktank.com>
Subject: Re: v0.56 released
Date: Wed, 2 Jan 2013 10:11:28 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301021010310.13956@cobra.newdream.net>
References: <alpine.DEB.2.00.1212311721310.1906@cobra.newdream.net> <50E39A4E.1060700@conversis.de> <50E39B68.40800@inktank.com> <CAOLwVUnYP1HTfimBf2PKBW5TA7gSuKRhsB1u6YPwUQGs633mvg@mail.gmail.com> <alpine.DEB.2.00.1301020935270.13956@cobra.newdream.net>
 <CAOLwVU=3W-QQ2tsdCGU4zq2OUiiTv7tFE20z20k2dgXQL7WknQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57637 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab3ABSL3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 13:11:29 -0500
In-Reply-To: <CAOLwVU=3W-QQ2tsdCGU4zq2OUiiTv7tFE20z20k2dgXQL7WknQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Dennis Jacobfeuerborn <dennisml@conversis.de>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 2 Jan 2013, S?bastien Han wrote:
> Debian-testing shows the version 0.56-1, maybe I misunderstood but I
> thought that 0.56-1 bobtail was the new version of the stable branch.
> So I was expecting to see it here
> http://ceph.com/debian/dists/precise/main/binary-amd64/Packages
> 
> Correct me if I'm wrong :)

It will be soon, but we're doing some additional validation before calling 
it bobtail.  We may also move the URLs around a bit... more on that soon!

sage


> --
> Regards,
> S?bastien Han.
> 
> 
> On Wed, Jan 2, 2013 at 6:35 PM, Sage Weil <sage@inktank.com> wrote:
> > On Wed, 2 Jan 2013, S?bastien Han wrote:
> >> It looks the same for Debian packages, 0.56.1 is on testing branch.
> >>
> >> http://ceph.com/debian-testing/dists/precise/main/binary-amd64/Packages
> >>
> >> If someone can fix this, thanks in advance ;-)
> >
> > The repo has 0.56-1, which is correct... maybe you just misread the
> > version?
> >
> > sage
> >
> >
> >> --
> >> Regards,
> >> S?bastien Han.
> >>
> >>
> >> On Wed, Jan 2, 2013 at 3:28 AM, Mark Nelson <mark.nelson@inktank.com> wrote:
> >> > Doh!  Sorry about that.  It looks like they are still in rpm-testing:
> >> >
> >> > http://www.ceph.com/rpm-testing/el6/x86_64/
> >> >
> >> > I imagine Gary will have them in the non-testing repo some time tomorrow.
> >> >
> >> > Mark
> >> >
> >> >
> >> > On 01/01/2013 08:24 PM, Dennis Jacobfeuerborn wrote:
> >> >>
> >> >> Hi,
> >> >> apparently the RPM link points to version 0.52. Where can the RPMs for
> >> >> 0.56
> >> >> be found?
> >> >>
> >> >> Regards,
> >> >>    Dennis
> >> >>
> >> >> On 01/01/2013 07:02 AM, Sage Weil wrote:
> >> >>>
> >> >>> We're bringing in the new year with a new release, v0.56, which will form
> >> >>> the basis of the next stable series "bobtail." There is little in the way
> >> >>> of new functionality since v0.55, as we've been focusing primarily on
> >> >>> stability, performance, and upgradability from the previous argonaut
> >> >>> stable series (v0.48.x). If you are a current argonaut user, you can
> >> >>> either upgrade now, or watch the Inktank blog for the bobtail
> >> >>> announcement
> >> >>> after some additional testing has been completed. If you are a v0.55 or
> >> >>> v0.55.1 user, we recommend upgrading now.
> >> >>>
> >> >>> Notable changes since v0.55 include:
> >> >>>
> >> >>>   * librbd: fixes for read-only pools for image cloning
> >> >>>   * osd: fix for mixing argonaut and post-v0.54 OSDs
> >> >>>   * osd: some recovery tuning
> >> >>>   * osd: fix for several scrub, recovery, and watch/notify races/bugs
> >> >>>   * osd: fix pool_stat_t backwawrd compatibility with pre-v0.41 clients
> >> >>>   * osd: experimental split support
> >> >>>   * mkcephfs: misc fixes for fs initialization, mounting
> >> >>>   * radosgw: usage and op logs off by default
> >> >>>   * radosgw: keystone authentication off by default
> >> >>>   * upstart: only enabled with 'upstart' file exists in daemon data
> >> >>>     directory
> >> >>>   * mount.fuse.ceph: allow mounting of ceph-fuse via /etc/fstab
> >> >>>   * config: always complain about config parsing errors
> >> >>>   * mon: fixed memory leaks, misc bugs
> >> >>>   * mds: many misc fixes
> >> >>>
> >> >>> Notable changes since v0.48.2 ("argonaut"):
> >> >>>
> >> >>>   * auth: authentication is now on by default; see release notes!
> >> >>>   * osd: improved threading, small io performance
> >> >>>   * osd: deep scrubbing (verify object data)
> >> >>>   * osd: chunky scrubs (more efficient)
> >> >>>   * osd: improved performance during recovery
> >> >>>   * librbd: cloning support
> >> >>>   * librbd: fine-grained striping support
> >> >>>   * librbd: better caching
> >> >>>   * radosgw: improved Swift and S3 API coverage (POST, multi-object
> >> >>> delete,
> >> >>>     striping)
> >> >>>   * radosgw: OpenStack Keystone integration
> >> >>>   * radosgw: efficient usage stats aggregation (for billing)
> >> >>>   * crush: improvements in distribution (still off by default; see CRUSH
> >> >>>     tunables)
> >> >>>   * ceph-fuse, mds: general stability improvements
> >> >>>   * release RPMs for OpenSUSE, SLES, Fedora, RHEL, CentOS
> >> >>>   * tons and bug fixes and small improvements across the board
> >> >>>
> >> >>> If you are upgrading from v0.55, there are no special upgrade
> >> >>> instructions. If you are upgrading from an older version, please read the
> >> >>> release notes. Authentication is now enabled by default, and if you do
> >> >>> not
> >> >>> adjust your ceph.conf accordingly before upgrading the system will not
> >> >>> come up by itself.
> >> >>>
> >> >>> You can get this release from the usual locations:
> >> >>>
> >> >>>   * Git at git://github.com/ceph/ceph.git
> >> >>>   * Tarball at http://ceph.com/download/ceph-0.56.tar.gz
> >> >>>   * For Debian/Ubuntu packages, see
> >> >>> http://ceph.com/docs/master/install/debian
> >> >>>   * For RPMs, see http://ceph.com/docs/master/install/rpm
> >> >>>
> >> >>> --
> >> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> >>> the body of a message to majordomo@vger.kernel.org
> >> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> >>>
> >> >> --
> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> >
> >> >
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> 
> 
