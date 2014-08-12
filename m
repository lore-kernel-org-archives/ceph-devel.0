From: Sage Weil <sweil@redhat.com>
Subject: Re: LTTng unfriendly with mixed static/dynamic linking
Date: Tue, 12 Aug 2014 12:50:19 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408121246500.32572@cobra.newdream.net>
References: <CAFu9Dv37reLPuQ_9fHkgqwDWtKiwQk8FCd4MAqY6wk75ASs07w@mail.gmail.com> <CAFu9Dv3FY=RkC9cAqt8p5oB0FNHsLUnK=1Nx3eh==C8Q4-i1Ww@mail.gmail.com> <alpine.DEB.2.00.1407251507160.22752@cobra.newdream.net> <53D38300.2050009@inktank.com>
 <CAFu9Dv1owC=qjte+bgDuq8N=7ykuyuytwEZLdNL+71-oOxc0ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49533 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbaHLTuT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Aug 2014 15:50:19 -0400
In-Reply-To: <CAFu9Dv1owC=qjte+bgDuq8N=7ykuyuytwEZLdNL+71-oOxc0ag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Crume <adamcrume@gmail.com>
Cc: "Noah M. Watkins" <noahwatkins@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 12 Aug 2014, Adam Crume wrote:
> Sage, if I understood you correctly on the video call, you have
> reservations about making libcommon a dynamic library because of
> incompatible changes between versions causing problems when packages
> use different versions, and you brought up the idea of having a static
> version and a dynamic version.  I don't think that would entirely
> work, because rbd (which must use the dynamic version) and libcommon
> would have to be in different packages, so they could have version
> mismatches.

Some packages will have the version match requirement:

 librados2 -> same libceph-common
 librbd1 -> same librados2
 radosgw -> same librados2
 etc.

and I think that is mostly okay.  The ones I'm concerned about are 
ceph-osd, ceph-mds, and ceph-mon, which don't use the other shared libs 
and could build it in statically.  That would allow a single host to have 
a different version of ceph-mon and ceph-osd installed (for example).

Now that I think about it, I'm not sure how useful that is; large clusters 
won't have this problem because they will be on different hosts.  But I 
can imagine some users will want to do this...

My question is if we can build a static and dynamic libcommon, and then 
require that any user of librados/librbd also use the dynamic libcommon.  
Non-users of those shared libs are free to use the static one.  That 
avoids any single binary from having libcommon linked in twice... which I 
think satisfies the original requirement?

> There's another alternative, which is to remove all tracepoints from
> libcommon.  At the moment, the only tracepoints are in Mutex, and
> they're not necessary for rbd-replay.  (Noah added them as an example
> of using LTTng in Ceph.  Noah, are you using these tracepoints?)  If
> we ever wanted to trace anything in libcommon, though, this issue
> would come up again.

That would be the short term fix, and would unblock getting wip-lttng 
merged, right?

sage

> 
> On Sat, Jul 26, 2014 at 3:29 AM, Joao Eduardo Luis
> <joao.luis@inktank.com> wrote:
> > On 07/25/2014 11:12 PM, Sage Weil wrote:
> >>
> >> On Fri, 25 Jul 2014, Adam Crume wrote:
> >>>
> >>> I tried all solutions, and it looks like only #1 works.  #2 gives the
> >>> error "/usr/bin/ld: main: hidden symbol `tracepoint_dlopen' in
> >>> common_tp.a(common_tp.o) is referenced by DSO" when linking.  #3 gives
> >>> the error "./liblibrary.so: undefined reference to
> >>> `tracepoint_dlopen'" when linking.  (Linking is complicated by the
> >>> fact that LTTng uses special symbol attributes, and tracepoint_dlopen
> >>> happens to be weak and hidden.)
> >>
> >>
> >> I think #1 is good for other reasons, too.  We already have issues (I
> >> think!) with binaries that use librados and also link libcommon
> >> statically.  Specifically, I think we've seen that having mismatched
> >> versions of librados and the binary installed lead to confusion about the
> >> contents/structure of mdconfig_t (g_conf).  This is one of the reasons
> >> why the libcommon and rgw packages require an identical version of
> >> librados or librbd or whatever--to avoid this inconsistency.
> >>
> >>> Unless I'm mistaken (and I very well
> >>> may be), we will have to ensure that all traced code is either 1)
> >>> placed in a shared library and never statically linked elsewhere, or
> >>> 2) never linked into any shared library.
> >>
> >>
> >> That sounds doable and sane to me:
> >>
> >>   - librados, librbd, libceph_common, etc. would have the tracepoints in
> >> the same .so
> >>   - ceph-osd could have its own tracepoints, as long as they are always
> >> static.  (For example, libos.la, which is linked statically by ceph-mon
> >> and ceph-osd but never dynamically.)
> >>
> >> One pain point in all of this, though, is that the libceph_common.so (or
> >> whatever) will need to go into a separate package that is required by
> >> librados.so and librbd and ceph-common and everything else.  'ceph-common'
> >> is what this ought to be called, but we've coopted it to mean 'ceph
> >> clients'.  I'm not sure it if it worthwhile to go through the hinjinx to
> >> rename ceph-common to ceph-clients and repurpose ceph-common for this?
> >>
> >> sage
> >
> >
> > I notice that ceph-common contains no libs whatsoever.  We may want to
> > change ceph-common to ceph-client or something and have libcommon shipped as
> > ceph-common, but I imagine that would be a pain as package management goes.
> > Or we could take the path of least resistance (and possibly open ourselves
> > to confusion?) and ship libcommon in a 'ceph-libs' package -- although it
> > looks like it would be a 1-lib package :)
> >
> >   -Joao
> >
> >>
> >>
> >>
> >>>
> >>> Thoughts?
> >>>
> >>> Adam
> >>>
> >>> On Fri, Jul 25, 2014 at 11:48 AM, Adam Crume <adamcrume@gmail.com> wrote:
> >>>>
> >>>> LTTng requires tracepoints to be linked into a program only once.  If
> >>>> tracepoints are linked in multiple times, the program crashes at
> >>>> startup with: "LTTng-UST: Error (-17) while registering tracepoint
> >>>> probe. Duplicate registration of tracepoint probes having the same
> >>>> name is not allowed."
> >>>>
> >>>> This is problematic when mixing static and dynamic linking.  If the
> >>>> tracepoints are in a static library, that library can end up in an
> >>>> executable multiple times by being linked in directly, as well as
> >>>> being statically linked into a dynamic library.  Even if the
> >>>> tracepoints are not linked directly into the executable, they can be
> >>>> statically linked into multiple dynamic libraries that the executable
> >>>> loads.
> >>>>
> >>>> For us, this problem shows up with libcommon, and could show up with
> >>>> others such as libosd.  (In general, I think anything added to
> >>>> noinst_LTLIBRARIES is static, and anything added to lib_LTLIBRARIES is
> >>>> dynamic.)
> >>>>
> >>>> There are a few ways of solving the issue:
> >>>> 1. Change every library that has tracepoints, like libcommon, from
> >>>> static to dynamic.  This could be a big change, as at the very least
> >>>> we'd have to rename the library to something like libceph_common to
> >>>> avoid conflicts, since now it would be an installed file.  This has
> >>>> the advantage of keeping code and its tracepoints in the same library.
> >>>> 2. Keep tracepoints in a separate static library.  For example,
> >>>> libcommon and libcommon_tp.  Unfortunately, every executable (but not
> >>>> library!) that links in libcommon (directly or indirectly) would have
> >>>> to manually link in libcommon_tp, and I don't think Automake could
> >>>> automate that.
> >>>> 3. Keep tracepoints in a separate dynamic library.  In this case, I
> >>>> think libcommon could depend on libcommon_tp, so executables would not
> >>>> have to manually link in libcommon_tp.  (I'm not an Automake expert,
> >>>> so let me know if I'm wrong on that.)  Again, libcommon_tp would be an
> >>>> installed file, so we'd want to rename it to something like
> >>>> libceph_common_tp.
> >>>>
> >>>> I attached a minimal test case of the problem.
> >>>>
> >>>> Thoughts or suggestions?
> >>>>
> >>>> Thanks,
> >>>> Adam Crume
> >>>
> >>>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> >
> > --
> > Joao Eduardo Luis
> > Software Engineer | http://inktank.com | http://ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
