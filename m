From: Sage Weil <sage@newdream.net>
Subject: Re: MDS stuck in a crash loop
Date: Thu, 22 Oct 2015 06:14:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510220612500.16833@cobra.newdream.net>
References: <CANP1eJGesJ_wGKDNQRJ952x8jkNHiJybeX075wxmJDurbSTMNw@mail.gmail.com> <CAJ4mKGY5uTZ6oiqZY4VbU5LdECXx5sko6VOd5aD2aEhtq74NDA@mail.gmail.com> <CANP1eJFNpLu3-HeqJ28L7xCTuKh-MhUT2j7A_tM7reofZ94FTQ@mail.gmail.com> <CANP1eJFGy4psfmUHpsgdPFT+UUW=NTzLTgAsnGqeuD6iWuF-cQ@mail.gmail.com>
 <CANP1eJHnavBzJRnDLa9gQ93haJ2QzKJsLj4+ZbS_vd1kquV8Lw@mail.gmail.com> <CANP1eJGmjechy8ZkVarA-HWdL37scmHdQXToM6NdAXxU-_KVMw@mail.gmail.com> <CANP1eJHYvgUKDCKrVYY=XkJsgcdVGn6T=drvEA8hofHyVX+0YA@mail.gmail.com> <CAJ4mKGYyza=MqV8zRS3cGA0EfbB=h=UhYbwO7QBgTb6FfzXSQw@mail.gmail.com>
 <CANP1eJGiPEx49nNyQgv3qo9ugVRAWnsh_WAHt33jHXX23S=0GQ@mail.gmail.com> <CAJ4mKGYHDew0LdQ65vNODiBw6u_jBrmyL3fzOWhB1TxKP8XidQ@mail.gmail.com> <CALe9h7fwpuz8Rv5GuqJ+-S9NDw8=uy37A+BfD3qW1Sa5FTHoxw@mail.gmail.com> <CALe9h7dGSWqLd0svDNyovtNZM0VUEuF+v6nQoT9HQe5TaOQrYw@mail.gmail.com>
 <CANP1eJG=H7FGxcfeLfQpJ_10Zngm9OMzt0=0=hX9pVxK8ndWjQ@mail.gmail.com> <CALe9h7e48B7hd-zpt-sxTuXRS8mg29ELqHGM+wM3ZBVQdwdoVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39414 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbbJVNPA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Oct 2015 09:15:00 -0400
In-Reply-To: <CALe9h7e48B7hd-zpt-sxTuXRS8mg29ELqHGM+wM3ZBVQdwdoVQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Milosz Tanski <milosz@adfin.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 22 Oct 2015, John Spray wrote:
> On Thu, Oct 22, 2015 at 1:43 PM, Milosz Tanski <milosz@adfin.com> wrote:
> > On Wed, Oct 21, 2015 at 5:33 PM, John Spray <jspray@redhat.com> wrote:
> >> On Wed, Oct 21, 2015 at 10:33 PM, John Spray <jspray@redhat.com> wrote:
> >>>> John, I know you've got
> >>>> https://github.com/ceph/ceph-qa-suite/pull/647. I think that's
> >>>> supposed to be for this, but I'm not sure if you spotted any issues
> >>>> with it or if we need to do some more diagnosing?
> >>>
> >>> That test path is just verifying that we do handle dirs without dying
> >>> in at least one case -- it passes with the existing ceph code, so it's
> >>> not reproducing this issue.
> >>
> >> Clicked send to soon, I was about to add...
> >>
> >> Milosz mentioned that they don't have the data from the system in the
> >> broken state, so I don't have any bright ideas about learning more
> >> about what went wrong here unfortunately.
> >>
> >
> > Sorry about that, wasn't thinking at the time and just wanted to get
> > this up and going as quickly as possible :(
> >
> > If this happens next time I'll be more careful to keep more evidence.
> > I think multi-fs in the same rados namespace support would actually
> > helped here, since it makes it easier to create a newfs and leave the
> > other one around (for investigation)
> 
> Yep, good point.  I am a known enthusiast for multi-filesystem support :-)

A rados pool export on the metadata pool would have helped, too.  That 
doesn't include data object backtrace metadata, though.  I wonder if we 
should make a cephfs metadata imager tool to capture the metadata state of 
the file system (similar to the tools that are available for xfs) that 
captures both.  On the data pool side it'd just record the object names, 
xattrs, and object size, ignoring the data.

It wouldn't anonymize filenames (that is tricky without breaking the mds 
dir hashing), but it excludes data and would probably be 
sufficient for most users...

sage
