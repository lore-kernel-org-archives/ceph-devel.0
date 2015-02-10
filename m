From: Sage Weil <sage@newdream.net>
Subject: Re: dumpling integration branch for v0.67.12 ready for QE
Date: Tue, 10 Feb 2015 10:37:46 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502101028380.1652@cobra.newdream.net>
References: <54DA3A5B.5050509@dachary.org> <54483038.14900677.1423588756901.JavaMail.zimbra@redhat.com> <54DA3E72.9010600@dachary.org> <867276671.14905190.1423589356764.JavaMail.zimbra@redhat.com> <54DA4843.10901@dachary.org>
 <CAC6JEv-37ga5X0M4GG=fBmo-T9OWWgSTkMSgfVt1eXXmm9XhTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56362 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbbBJShr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 13:37:47 -0500
In-Reply-To: <CAC6JEv-37ga5X0M4GG=fBmo-T9OWWgSTkMSgfVt1eXXmm9XhTg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Loic Dachary <loic@dachary.org>, Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 10 Feb 2015, Gregory Farnum wrote:
> On Tue, Feb 10, 2015 at 10:04 AM, Loic Dachary <loic@dachary.org> wrote:
> >
> >
> > On 10/02/2015 18:29, Yuri Weinstein wrote:>
> >> On 10/02/2015 18:19, Yuri Weinstein wrote:>
> >>> Loic,
> >>>
> >>> The only difference between options if we run suits on merged dumpling vs dumpling-backports first - is time.
> >>> We will have to run suites on the final branch after the merge anyway.
> >>
> >> Could you explain why ? After merging dumpling and dumpling-backports will be exactly the same.
> >>
> >> Loic - I feel that finial QE validation should be done on the code that gets actually released to customers, e.g. dumpling branch after the merge.  I do see your point about branches being identical and ready to change my mind if you insist.  Does my reasoning make sense?  Please advice, how we should proceed.
> >
> > The dumpling-backports branch currently is at
> >
> > https://github.com/ceph/ceph/commit/3944c77c404c4a05886fe8276d5d0dd7e4f20410
> >
> > after a successful test run from QE and a merge into dumpling, the dumpling branch will be at
> >
> > https://github.com/ceph/ceph/commit/3944c77c404c4a05886fe8276d5d0dd7e4f20410
> >
> > as well. In other words they are identical and there is no point in running a test again. The only reason why they could be different is if a commit is inadvertently added to the dumpling branch while testing happens on the dumpling-backport branc. In this case the presence of this new commit would be reason enough to run another round of test indeed. So the process could be:
> >
> > If tests are ok and merge can fast forward, then release.
> > If tests are ok and merge cannot fast forward, send back to loic because a commit was added by accident and needs to be approved by the leads.
> >
> > If testing happens on the dumpling branch, adding a commit to the dumpling branch would have side effects that could taint the results of the tests or, even worse, go unnoticed. There is zero chance that someone adds a commit to the dumpling-backports branch and that gives us something stable. On the contrary, the odds that someone adds a commit to the dumpling branch are high, specially if the tests take a few weeks to complete.
> >
> > As Greg mentioned, merging in dumpling does not matter much for this round because it is what has been done in the past. And to be honest, I would not mind if an additional commit taints the process by accident. However, unless there is a reason not to, it would be good to establish a process that is solid if we can.
> >
> > I've witnessed Alfredo's pain on each release and an additional benefit of having a dumpling-backports branch that nobody tampers with just occured to me. When and if QE finds that dumpling-backports is fit for release, instead of merging it into dumpling it could be handed over to Alfredo for release. And he would be able to proceed knowing it is stable and won't be moving forward. Once the release is done and the tag set to the proper commit, the dumpling branch can be reset to dumpling-backports. If commits were added during the process, their authors could be notified that they were discarded and need to be merge again. That would not work for the master branch but it would definitely be possible for the stable branches because such "out of process" commits are rarely added.
> >
> > I've not thought this through, but the more I think about it the more I like the idea of using dumpling-backports as a staging area until the release is final.
> 
> What's the purpose of even having a dumpling branch at that point?
> We're not using it for anything under your model.

Yeah, it seems to me like the same general process we use for 'next' and 
'master' would work here:

 - prepare a batch of backports, say dumpling-rgw-next
 - run it through the rgw suite
 - if that is okay, merge to dumpling
 - run regular tests on dumpling (all suites)

so that dumpling acts as in integration branch the same way the others do.   
This is reasonably lightweight on process and means that our periodic 
scheduled runs are doing double duty for the integration testing and 
catching long-tail bugs.

After talking through the last release vs 'next' branch race with Alfredo 
I think (?) we've established that it is a non-issue.  If a release build 
races with a branch update it shows up as a merge commit in the history 
(just like a regular 'git pull').

Unless we're specifically concerned about things landing in dumpling (or 
whatever) just prior to a release?

sage
