From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: packages on download.ceph.com
Date: Wed, 11 Mar 2015 18:38:54 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9155567917@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91555668ED@SATLEXDAG01.amd.com>
 <54FDF605.9000302@redhat.com> <54FE066C.2070902@bisect.de>
 <alpine.DEB.2.00.1503091358380.25972@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0145.outbound.protection.outlook.com ([65.55.169.145]:64320
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750957AbbCKTKT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Mar 2015 15:10:19 -0400
In-Reply-To: <alpine.DEB.2.00.1503091358380.25972@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>



> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Monday, March 09, 2015 4:05 PM
> To: Danny Al-Gaaf
> Cc: Mark Nelson; Deneau, Tom; ceph-devel
> Subject: Re: packages on download.ceph.com
> 
> On Mon, 9 Mar 2015, Danny Al-Gaaf wrote:
> > Am 09.03.2015 um 20:35 schrieb Mark Nelson:
> > > On 03/09/2015 02:06 PM, Deneau, Tom wrote:
> > >> I'm trying to gather information on what it would take to get
> > >> packages for an architecture other than x86_64 up on
> > >> http://download.ceph.com
> 
> I'm guessing you're interested in 64-bit arm (aarch64?)?
> 
> I would love to have packages built for all architectures people are
> interested in.  In practice, there are two limitations: build hardware and
> the maintenance overhead.  For example, we have all this armv7l gear but
> stopped doing builds because it was time consuming to keep it running.
> The moment someone signs up to do that management we can set up vpn access to
> the lab and add it back it.  The other problem we hit was that the armv7l
> builds took so much longer than the x86_64 ones and the current release
> process is easier when it's all done it one go.  I suspect what we'd end up
> with is a situation where the packages for some architectures get posted
> before others (which probably isn't a big deal).  Alfredo, you should chime
> in if there are other reasons why this would make things harder.
> 
> > It would be much easier to use OpenBuildService [1] for package build.
> > It supports many distributions and architectures.
> >
> > If you don't care that it's openSUSE infrastructure you/we could use
> > build.opensuse.org to build packages e.g. for RHEL/Centos/Fedora,
> > openSUSE/SLES, Debian, Ubuntu and others (I did so in the past.)
> >
> > At least openSUSE/SLES packages could be also build on armv7l and e.g.
> > ppc/s390x ... for other distros we have to check.
> >
> > The question is: should we build packages (and which) or is this more
> > a task for the distributions?
> 
> I tried OBS way back when but found it difficult to use and not particularly
> flexible.  My main concern is that we will run into problems and not have the
> ability to address them (for example, missing or broken distro dependencies
> or something like that).
> 
> More generally, I think it has been hugely valuable to have up to date
> packages on ceph.com as the distros tend to relatively slow to release
> things.  Users also typically choose between several different major ceph
> releases.  I'm pretty hesitant to abandon this...
> 
> sage

Sage --

Yes, my original question was for aarch64.

On that topic, since Ceph is part of Red Hat,
can the Ceph developers lobby for getting some version of Ceph
included in the first RHEL aarch64 release?  My understanding is that currently
Ceph packages are not planned to be included in the default package lists.

-- Tom


