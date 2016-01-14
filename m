From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: [ceph-users] v10.0.2 released
Date: Thu, 14 Jan 2016 16:16:43 -0500 (EST)
Message-ID: <916045695.9704326.1452806203442.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.11.1601141033010.21258@cpach.fuggernut.com> <CADRKj5TXdCmDS5aX5+HRee9fOr7Za4y_WGJhja0eyxhdTcHefA@mail.gmail.com> <CAEhqmjLGJN_c1wXW3yHc=kKab7w2mgfH6E8TqTds-VvKxDNfWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:58681 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700AbcANVQq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jan 2016 16:16:46 -0500
In-Reply-To: <CAEhqmjLGJN_c1wXW3yHc=kKab7w2mgfH6E8TqTds-VvKxDNfWA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bill Sanders <billysanders@gmail.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

rbd-nbd uses librbd directly -- it runs as a user-space daemon process and interacts with the kernel NBD commands via a UNIX socket.  As a result, it supports all image features supported by librbd.  You can use the rbd CLI to map/unmap RBD-based NBDs [1] similar to how you map/unmap images via krbd.

I wouldn't see this as a replacement for krbd, but rather another tool to support certain RBD use-cases [2].

[1] http://docs.ceph.com/docs/master/man/8/rbd/#commands
[2] https://github.com/ceph/ceph/pull/6595

-- 

Jason Dillaman 


----- Original Message -----
> From: "Bill Sanders" <billysanders@gmail.com>
> To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> Cc: "Sage Weil" <sweil@redhat.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, ceph-users@ceph.com,
> ceph-maintainers@ceph.com, ceph-announce@ceph.com
> Sent: Thursday, January 14, 2016 2:27:17 PM
> Subject: Re: [ceph-users] v10.0.2 released
> 
> Is there some information about rbd-nbd somewhere?  If it has feature
> parity with librbd and is easier to maintain, will this eventually
> deprecate krbd?  We're using the RBD kernel client right now, and so
> this looks like something we might want to explore at my employer.
> 
> Bill
> 
> On Thu, Jan 14, 2016 at 9:04 AM, Yehuda Sadeh-Weinraub
> <yehuda@redhat.com> wrote:
> > On Thu, Jan 14, 2016 at 7:37 AM, Sage Weil <sweil@redhat.com> wrote:
> >> This development release includes a raft of changes and improvements for
> >> Jewel. Key additions include CephFS scrub/repair improvements, an AIX and
> >> Solaris port of librados, many librbd journaling additions and fixes,
> >> extended per-pool options, and NBD driver for RBD (rbd-nbd) that allows
> >> librbd to present a kernel-level block device on Linux, multitenancy
> >> support for RGW, RGW bucket lifecycle support, RGW support for Swift
> >
> > rgw bucket lifecycle isn't there, it still has some more way to go
> > before we merge it in.
> >
> > Yehuda
> >
> >> static large objects (SLO), and RGW support for Swift bulk delete.
> >>
> >> There are also lots of smaller optimizations and performance fixes going
> >> in all over the tree, particular in the OSD and common code.
> >>
> >> Notable Changes
> >> ---------------
> >>
> >> See
> >>
> >>         http://ceph.com/releases/v10-0-2-released/
> >>
> >> [I'd include the changelog here but I'm missing a oneliner that renders
> >> the rst in email-suitable form...]
> >>
> >> Getting Ceph
> >> ------------
> >>
> >> * Git at git://github.com/ceph/ceph.git
> >> * Tarball at http://download.ceph.com/tarballs/ceph-10.0.2.tar.gz
> >> * For packages, see http://ceph.com/docs/master/install/get-packages
> >> * For ceph-deploy, see
> >> http://ceph.com/docs/master/install/install-ceph-deploy
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
