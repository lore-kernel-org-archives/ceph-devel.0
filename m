From: Sage Weil <sweil@redhat.com>
Subject: Re: [Ceph-maintainers] disabling updatedb
Date: Wed, 20 Aug 2014 15:06:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408201506030.28244@cobra.newdream.net>
References: <alpine.DEB.2.00.1402180845440.15052@cobra.newdream.net> <8738jg2trm.fsf@meteor.durcheinandertal.bofh> <CABZ+qqkfe_WA36vH0vf+6HNy1qR-hsy8PLTbEUJKvLC1GeTbWQ@mail.gmail.com> <A58163BA-D050-4A33-9B52-4DFDA664F65D@ecologic.eu>
 <alpine.DEB.2.00.1402201046200.16677@cobra.newdream.net> <53F5136A.2000102@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42744 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbaHTWGr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Aug 2014 18:06:47 -0400
In-Reply-To: <53F5136A.2000102@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: bernhard glomm <bernhard.glomm@ecologic.eu>, Dan van der Ster <daniel.vanderster@cern.ch>, Gaudenz Steinlin <gaudenz@debian.org>, ceph-maintainers@ceph.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 20 Aug 2014, Dan Mick wrote:
> Just adding a note in case you hadn't noticed that updatedb itself has a
> CLI for managing the .conf: --add-prune{fs,names,paths}.  Sadly, there
> is no "--remove", but at least it lets the conf file format be abstract.

In that case, let's add a .postinst for debian and a bit to the spec file 
to do this?  I'm not terribly bothered if it doesn't get cleaned up on 
package removal; updatedb should make this less painful.

sage

> 
> +1 on "everything has a .d/ dir" though.
> 
> On 02/20/2014 10:47 AM, Sage Weil wrote:
> > On Tue, 18 Feb 2014, bernhard glomm wrote:
> >> Well IMO the cleanest solution would be to convince the 
> >> mlocate devels to introduce an /etc/updatedb.d/ directory
> >> so every package could drop their snippet there.
> > 
> > I agree. Does somebody want to take the lead on that one?  It seems like 
> > the right long-term solution, even if it doesn't help us much right now.
> > 
> > sage
> > 
> >> Since that might be a rather long shot
> >> I agree that it is a a job for general management 
> >>
> >> In cfengine it would just read something like:
> >> ...
> >> edit_line	=>	regex_replace("(^\s*PRUNEFS=\")(?!ceph)(.*$)","$(match.1)ceph $(match.2)");
> >> ...
> >> With a  proper  self containing bundle once called from postinst that would survive any 
> >> upgrade of mlocate with minimal impact.
> >>
> >> Regards,
> >> Bernhard
> >>
> >>> On Feb 18, 2014, at 7:20 PM, Dan van der Ster <daniel.vanderster@cern.ch> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On Tue, Feb 18, 2014 at 6:52 PM, Gaudenz Steinlin <gaudenz@debian.org> wrote:
> >>>>
> >>>> Hi
> >>>>
> >>>> Sage Weil <sage@inktank.com> writes:
> >>>>
> >>>>> Dan at CERN noticed that his performance was tanking because updatedb was
> >>>>> running against /var/lib/ceph.  updatedb has a PRUNE line in
> >>>>> /etc/updatedb.conf that we should presumably be adding ourselves to.  One
> >>>>> user pointed out a package that uses sed to rewrite this line in the init
> >>>>> script on start.
> >>>>>
> >>>>> I have two questions:
> >>>>>
> >>>>> - is there no better way than sed to add ourselves to this list?
> >>>>> - should we do it in the init script, or postinst, or both?
> >>>>>
> >>>>> Presumably this is a problem others have solved with other packages.
> >>>>
> >>>> At least for Debian neither solution is appropriate. Changing other
> >>>> packages conffiles in postinst scripts is forbidden by policy. There is
> >>>> also no way to preserve this reliably over upgrades without user
> >>>> interaction. I'm not sure if there is an explicit policy for init
> >>>> scripts, but this seems equally wrong. Also it's unclear how one would
> >>>> handle the case were an administrator does NOT want to exclude this
> >>>> directory.
> >>>>
> >>>> The only solution I see if you really want to completely exclude the
> >>>> directory is to convince the mlocate maintainers to either add the
> >>>> directory to the default configuration or to add something like an
> >>>> /etc/updatedb.d directory where packages can drop configuration file
> >>>> snippets. But the latter seems like overkill to me.
> >>>>
> >>>> The real question to me is why an updatedb run can drastically impact
> >>>> ceph performance. At least in Debian updatedb is run with ionice
> >>>> -c3 in the "Idle" scheduling class. According to the man page this
> >>>> means: "A program running with idle I/O priority will only get disk time
> >>>> when no other program has asked for disk I/O for a defined grace period.
> >>>> The impact of an idle I/O process on normal system activity should be
> >>>> zero. This scheduling class does not take a priority argument.
> >>>> Presently, this scheduling class is permitted for an ordinary user
> >>>> (since kernel 2.6.25)." So it should not have any negative effect.
> >>>>
> >>>> Maybe CERN (or the distribution they use) should also run updatedb under
> >>>> ionice.
> >>>
> >>> updatedb _is_ run under ionice on our systems (RHEL), but IO
> >>> scheduling classes are only implemented by the cfq scheduler.
> >>> We use deadline, which is recommended for an enterprise disk server,
> >>> and indeed measured more stable IO latencies with deadline than with
> >>> cfq. And when you run updatedb on a deadline scheduled drive, there
> >>> are so many reads queued up that writes can be starved for many 10s of
> >>> seconds.
> >>>
> >>> In our case, we've already added /var/lib/ceph to the PRUNEPATHS via
> >>> their puppet configuration. Though an upstream solution is probably a
> >>> good idea since I would assume that most ceph deployments use deadline
> >>> and this would hit most of them eventually once they have enough
> >>> files. In addition, as someone else mentioned, you'd better add ceph
> >>> to the pruned fs types as well, just like /afs is pruned at the
> >>> moment, lest every client spend all day stat'ing their big cephfs
> >>> namespace.
> >>>
> >>> Cheers, Dan
> >>>
> >>> -- Dan van der Ster || Data & Storage Services || CERN IT Department --
> >>>
> >>>>
> >>>> Gaudenz
> >>>>
> >>>> --
> >>>> Ever tried. Ever failed. No matter.
> >>>> Try again. Fail again. Fail better.
> >>>> ~ Samuel Beckett ~
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
