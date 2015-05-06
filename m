From: Sage Weil <sage@newdream.net>
Subject: Re: release notes script dependencies
Date: Wed, 6 May 2015 09:19:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505060918340.28239@cobra.newdream.net>
References: <55491259.4010003@dachary.org> <CAEw75dOCcdafHQhdc6uv+HsQVnOVE+rD8VdAAYFALFfFSEq2cg@mail.gmail.com> <554A2B55.8050203@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56502 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbbEFQTL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 May 2015 12:19:11 -0400
In-Reply-To: <554A2B55.8050203@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Abhishek L <abhishek.lekshmanan@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 6 May 2015, Loic Dachary wrote:
> 
> Hi Abhishek,
> 
> On 06/05/2015 06:27, Abhishek L wrote:
> > On Wed, May 6, 2015 at 12:26 AM, Loic Dachary <loic@dachary.org> wrote:
> >> Hi Abhishek,
> >>
> >> It would be useful to add instructions on what dependencies to pull to run http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_write_the_release_notes. Something like
> >>
> >> virtualenv /tmp/foo
> >> . /tmp/foo/bin/activate
> >> pip install GitPython # I recognized the library from the import ;-)
> >> pip install ?? # I tried half a dozen but could not find one that matches the import github semantic
> > 
> > The module was githubpy (I agree there are too many of github python
> > modules around :-)) I added a basic argparser for the script; I've put
> > it up as a github repo at
> > https://github.com/theanalyst/ceph-release-helper
> > 
> > Let me know if you're facing any problems using it
> 
> It works :-) http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_write_the_release_notes amended accordingly.

Could we put the script in ceph.git/src/scripts or similar instead of a 
separate repo?  One less thing to clone...

sage
