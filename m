From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: packages on download.ceph.com
Date: Mon, 9 Mar 2015 21:03:47 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF9155566A60@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91555668ED@SATLEXDAG01.amd.com>
 <54FDF605.9000302@redhat.com> <54FE066C.2070902@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0104.outbound.protection.outlook.com ([65.55.169.104]:19180
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752475AbbCIVDx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2015 17:03:53 -0400
In-Reply-To: <54FE066C.2070902@bisect.de>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>, Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>



> -----Original Message-----
> From: Danny Al-Gaaf [mailto:danny.al-gaaf@bisect.de]
> Sent: Monday, March 09, 2015 3:46 PM
> To: Mark Nelson; Deneau, Tom; ceph-devel
> Subject: Re: packages on download.ceph.com
> 
> Am 09.03.2015 um 20:35 schrieb Mark Nelson:
> >
> >
> > On 03/09/2015 02:06 PM, Deneau, Tom wrote:
> >> I'm trying to gather information on what it would take to get packages
> >> for an architecture other than x86_64 up on http://download.ceph.com
> >
> > What we've done in the past for certain non-X86 architectures (such as
> > ARM) is to get build nodes in place that can be used with our gitbuilder
> > setup to continuously make development builds:
> >
> > http://www.ceph.com/gitbuilder.cgi
> >
> > Which get put here:
> >
> > http://gitbuilder.ceph.com/
> >
> > Usually the problem is two fold:  Someone's time to set it up, and
> > making sure we have enough (or fast enough) build systems for that
> > architecture to keep up.
> 
> It would be much easier to use OpenBuildService [1] for package build.
> It supports many distributions and architectures.
> 
> If you don't care that it's openSUSE infrastructure you/we could use
> build.opensuse.org to build packages e.g. for RHEL/Centos/Fedora,
> openSUSE/SLES, Debian, Ubuntu and others (I did so in the past.)
> 
> At least openSUSE/SLES packages could be also build on armv7l and e.g.
> ppc/s390x ... for other distros we have to check.
> 
> The question is: should we build packages (and which) or is this more a
> task for the distributions?
> 
> Danny
> 
> [1] http://openbuildservice.org
> [2] https://build.opensuse.org

Building packages should indeed be a task for the distributions but some distros are
slow to add new packages so this would be a stopgap measure until they do.

-- Tom
