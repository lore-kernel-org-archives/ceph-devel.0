From: Sage Weil <sage@newdream.net>
Subject: Re: Missing prettytable during ceph-disk runs
Date: Fri, 2 Jun 2017 15:39:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706021539070.3646@piezo.novalocal>
References: <92db6d6a-420d-3f89-9631-8376b5d7d6a2@digiware.nl> <CAC-Np1y1hBFVnor9OhMxmj+xXZO5cnHvcQz6wAbjJ-7xhLhPBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33218 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdFBPjz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jun 2017 11:39:55 -0400
In-Reply-To: <CAC-Np1y1hBFVnor9OhMxmj+xXZO5cnHvcQz6wAbjJ-7xhLhPBw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 2 Jun 2017, Alfredo Deza wrote:
> On Fri, Jun 2, 2017 at 6:42 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> > Hi,
> >
> > During run-tox tests, ceph-disk complains that it is missing prettytable.
> > It is however installed on my system, and I can load it. So that part
> > works. But one way or another it is not loaded into the tox environment.
> >
> > How or what are all other dependancies loaded?
> > Is there a config file where I need to add that this test needs prettytable?
> 
> I am not sure what tox file you are running, but tox will create a
> virtual environment where it installs dependencies
> for the project you are testing. These dependencies should be defined
> by the project, the tox file, or by configuring tox to
> use dependencies installed system-wide.
> 
> For example, in ceph-installer, we tell tox to install a dependency
> that is only needed for tests like this:
> 
> https://github.com/ceph/ceph-installer/blob/master/tox.ini#L5-L6
> 
> I think that prettytable is a Python dependency so you can go ahead
> and add it there and it should work.
> 
> This also sounds like a bug :)

I've been having the ceph-disk tox test fail on my local machine for a 
week or two. I haven't been able to figure out why (prettytable is also 
installed here).  I've tried blowing away my build/ directory but that 
doesn't seem to help..

sage
