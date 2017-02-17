From: Sage Weil <sweil@redhat.com>
Subject: Re: hammer 0.94.10 QE status
Date: Fri, 17 Feb 2017 14:14:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702171413480.7782@piezo.novalocal>
References: <CAMMFjmHCAM6wmygytBDqwh89UOEex24_GGqrLJvXcOUS+QEg9A@mail.gmail.com> <CAOi1vP9rX_r3Rg2ZiXzS3QrEC3piM4hwhxBqHqDTU=zpCy3uwQ@mail.gmail.com> <CAOi1vP9FQJJxzE_SnaJ3QLFJ6NiZGqozswyT8scMUmqjZkbjRw@mail.gmail.com> <90f9fb1d-74fa-3ae0-e5b7-186e5d1b2638@suse.cz>
 <CAMMFjmH-+w8H7V0WjDUPStT5+3=doBH2OsWD5DNE3ij=zS7wzA@mail.gmail.com> <CAMMFjmHd1kJfBfjE7b8jOcXUZp74hi5Gbh-bQmOStPJoZ397UQ@mail.gmail.com> <CAObvjwPb_PosEnGOXP2tV4aWjnTyed7-275svyK+vu4uxYdTzQ@mail.gmail.com> <alpine.DEB.2.11.1702131624230.7782@piezo.novalocal>
 <CABo9giShGk2sdYyoJmuF9J-4kqDHmfzTrWq8H02aCCEJAa7tFA@mail.gmail.com> <22868a53-b99e-0686-e7e1-a288558aed27@suse.cz> <CAMMFjmFtrwGMaVweDt9eefWta22UdjgmdVg0it1t0SwWma_FXg@mail.gmail.com> <473edf7d-c46a-be4c-bc8a-35be4c095b2b@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934328AbdBQOOT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 17 Feb 2017 09:14:19 -0500
In-Reply-To: <473edf7d-c46a-be4c-bc8a-35be4c095b2b@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Yuri Weinstein <yweinste@redhat.com>, Orit Wasserman <owasserm@redhat.com>, Tamilarasi Muthamizhan <tmuthami@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, "Development, Ceph" <ceph-devel@vger.kernel.org>, "Durgin, Josh" <jdurgin@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 17 Feb 2017, Nathan Cutler wrote:
> From re-reading this thread I determined that the only two outstanding issues
> are upgrade/firefly-x and rgw+centos (can anyone confirm?)
> 
> I don't think upgrade/firefly-x should be a blocker. Rationale: as of the
> jewel release, firefly clusters were supposed to be upgraded to at least
> hammer. As of the kraken release, support of hammer has been focused on
> facilitating users to upgrade from hammer to jewel. In other words, firefly
> clusters should already have been upgraded and upgrading from firefly to
> hammer is no longer supported.
> 
> As for the rgw valgrind/libtcmalloc failures on centos, I made a
> wip-hammer-baseline branch based on "hammer" but with a different SHA1 ("git
> commit --amend --reset-author") and pushed it to ceph/ceph-ci.git so Shaman
> will re-build it. This should ensure that "flavor=notcmalloc" really means
> what it says. Re-running rgw+centos on this wip-hammer-baseline branch will
> tell us more.

I do'nt think these are a blocker either.. it's a problem with the 
hammer 'notcmalloc' builds with are only for teuthology valgrind testing.

sage
