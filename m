From: Sage Weil <sage@newdream.net>
Subject: Re: Criteria to become a Ceph project
Date: Tue, 28 Jul 2015 05:31:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507280530520.22099@cobra.newdream.net>
References: <CAC6JEv9wTCkb6XEtSSN0e-9MNuLF=2V_OEk_AnxP33t=3nG+tw@mail.gmail.com> <55B74AEC.1030709@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59271 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094AbbG1Mbu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 08:31:50 -0400
In-Reply-To: <55B74AEC.1030709@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Gregory Farnum <greg@gregs42.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 28 Jul 2015, Loic Dachary wrote:
> On 28/07/2015 10:44, Gregory Farnum wrote:
> > On Tue, Jul 28, 2015 at 7:38 AM, Loic Dachary <loic@dachary.org> wrote:
> >> Hi Ceph,
> >>
> >> The title sounds a little strange (Citerias to become a Ceph project) because I'm not aware of projects initiated by someone external to Ceph that later became part of the Ceph nebula of projects (as found at http://tracker.ceph.com/projects/ or http://github.com/ceph/). I can however imagine that a piece of software developed with no interaction with the Ceph development community could be contributed and become a valuable addition (port to non GNU/Linux Operating Systems, monitoring applications for mobile devices etc.).
> >>
> >> Although publishing the code of such a component under a Free Software license is a natural first step, there is more to do before it becomes part of what we (the community of Ceph developers) care for on a regular basis. Borrowing the OpenStack requirements ( at http://governance.openstack.org/reference/new-projects-requirements.html ), it could be expressed as:
> >>
> >>     Free Software:
> >>         The proposed project uses a Free Software license as published at http://www.gnu.org/licenses/license-list.html#SoftwareLicenses
> >>         Project must have no library dependencies which effectively restrict how the project may be distributed or deployed
> >>     Open Community:
> >>         The leadership is chosen by the contributors to the project
> >>         The project has regular public meetings on IRC and those meetings are logged and published
> >>     Open Development:
> >>         The project uses public code reviews
> >>         The project has core reviewers and adopts a test-driven gate
> >>         The project provides liaisons that serve as contacts for the work of cross-project teams in Ceph
> >>         Where it makes sense, the project cooperates with existing projects rather than gratuitously competing or reinventing the wheel
> >>         Where appropriate, the project adopts technology and patterns used by existing Ceph projects
> >>     Open Design:
> >>         The project direction is discussed at the Ceph Design Summit and/or on public forums
> >>         The project uses the ceph-devel ML to discuss issues
> >>
> >> These requirements are formal in the case of OpenStack but they could also be used in the context of Ceph, not as requirements but as a guideline.
> >>
> >> What do you think ?
> > 
> > Several small projects have been added to the Ceph constellation
> > despite being initially implemented outside of our systems. Mostly
> > things like rados-java and phprados.
> > 
> > Obviously those are small and related to Ceph, and the process was
> > "let's add this to the Ceph Github?" "Okay." I think if we need more
> > formal rules we can invent them as we go; Ceph is not OpenStack and
> > isn't going to be supervising the same volume nor breadth of
> > individual groups.
> 
> Maybe these could be "Guidelines to become a Ceph project" ? It seems to me that there is a big gap between the dynamic of phprados and say, radosgw-agent. By reading the guidelines, someone willing to contribute code to Ceph understands it's not just about pushing code to a publicly available repository.
> 
> Does that make sense ?

Sounds okay to me, although the guidelines above should be modified to 
match Ceph (for example, we don't have regular IRC meetings with published 
logs).  And some projects (e.g., calamari) have their own development 
list.

This would go on ceph.com somewhere?  Under /docs?

sage
