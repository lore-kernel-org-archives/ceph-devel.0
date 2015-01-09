From: Sage Weil <sweil@redhat.com>
Subject: Re: /usr/bin/cephfs tool
Date: Fri, 9 Jan 2015 10:08:19 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501091006460.5967@cobra.newdream.net>
References: <alpine.DEB.2.00.1501090719200.10528@cobra.newdream.net> <CAC6JEv9XuGSLOnzo_m1GVOYd46XyLUKysjnrJpu9623TZaxO2A@mail.gmail.com> <alpine.DEB.2.00.1501090959190.5967@cobra.newdream.net>
 <CAC6JEv_itSycn_SCaFUQNJ_qBDH2HNqkWtUB5HwBYezpqBx_nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59799 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993AbbAISIW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Jan 2015 13:08:22 -0500
In-Reply-To: <CAC6JEv_itSycn_SCaFUQNJ_qBDH2HNqkWtUB5HwBYezpqBx_nA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: gfarnum@redhat.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 9 Jan 2015, Gregory Farnum wrote:
> On Fri, Jan 9, 2015 at 10:00 AM, Sage Weil <sweil@redhat.com> wrote:
> > On Fri, 9 Jan 2015, Gregory Farnum wrote:
> >> On Fri, Jan 9, 2015 at 7:20 AM, Sage Weil <sweil@redhat.com> wrote:
> >> > Should we drop this entirely in hammer?
> >>
> >> Yes!
> >>
> >> >  If I remember correctly all of
> >> > the layout stuff is fully supported using virtual xattrs and standard
> >> > tools.  The only thing left is the tool that shows you how file blocks map
> >> > to objects map to OSDs (or something like that), which I've never used and
> >> > have never seen anyone use...
> >>
> >> ...oh, hmmm. Actually there have been people using that tool
> >> occasionally over the years, and I don't think we provide any other
> >> way to learn that information (besides calculating it yourself,
> >> obviously).
> >> Perhaps we could extend the vxattr interface to include that
> >> information as well?
> >
> > Actually, I think Andreas's librados stuff he's working on may be the
> > right path... it'll expose general information about object -> pg ->
> > osd mappings.  Then a simple script could take the ino + file size, turn
> > it into object names, and use that.
> >
> > In any case, I don't mind nuking this and waiting for a complaint before
> > investing in replacing that bit of functionality since it's such a small
> > thing...
> 
> Yeah, that's fine with me, but I'd like some idea of how we'd suggest
> any users who complain do the implementation so we can point them at a
> ticket if they do complain. ;)

Email thread subject:

RFC: new rados whereis command

Earlier pull requests:

https://github.com/ceph/ceph/pull/2729
https://github.com/ceph/ceph/pull/2730

There isn't a redmine ticket since it originated as a PR.

sage
