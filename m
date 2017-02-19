From: Sage Weil <sage@newdream.net>
Subject: Re: Client test suite
Date: Sun, 19 Feb 2017 02:19:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702190214590.7782@piezo.novalocal>
References: <c53ba163-a424-de03-040b-70ff381001ba@suse.cz> <CAJ4mKGZH8zgYVfo+fuL7v5jzU8A-pc2KfcuiGa8i0dvpqbggkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53842 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdBSCUv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 18 Feb 2017 21:20:51 -0500
In-Reply-To: <CAJ4mKGZH8zgYVfo+fuL7v5jzU8A-pc2KfcuiGa8i0dvpqbggkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Nathan Cutler <ncutler@suse.cz>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 18 Feb 2017, Gregory Farnum wrote:
> On Sat, Feb 18, 2017 at 1:29 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> > I'm preparing the beginnings of a sketch of a possible design for a Ceph
> > client integration test suite.
> >
> > The need for a way to test different versions/platforms/architectures of
> > clients against different versions/platforms/architectures of server is, I
> > think, obvious.
> >
> > Such a client test suite could be run by teuthology within a conventional
> > teuthology cluster like Sepia, but it would also need to be runnable outside
> > of a such an environment. (For example, think of how one would test an
> > aarch64 client against a Ceph cluster running on x86_64, or vice versa.)
> 
> I don't understand. Why do you think teuthology couldn't handle
> multiple architectures within a test lab? We already allow scheduling
> based on OS restrictions, and although they're not in the test running
> database I think we have some ARM machines in sepia.

Also, this is what the upgrade/client-upgrade test suite is intended to 
cover.  It doesn't do architectures currently, but it could.  The main 
purpose was just to verify that various client versions interoperate 
properly with various server verseions.  In particular, our upgrade tests 
generally verify clients from $version-1 work against $version servers, 
but not the other way around, and never +/- 2 or more releases.  This is 
probably where I'd start.

I'd suggest putting together a set of workunits for each version that 
represent the client workload.  All of the workunits assume the 
environment is sufficient to connect (e.g., /etc/ceph/* is there 
and everything is in the $PATH).  Then we can structure the test suite so 
that for any client version X, we run the workunit from the X branch of 
the repo.  And then the test suite would just generate a matrix of client 
and server versions.  We'd need to curate the client workloads so that 
they are general enough to run across different server versions.

Would that address your goals?

sage


> -Greg
> 
> >
> > This got me thinking about how teuthology could be leveraged to implement a
> > client integration test suite.
> >
> > First, the test suite itself could (optionally) take a set of monitor
> > hostnames/IP addresses and a cephx key as an input, so it could (again,
> > optionally) run against a Ceph cluster running outside of teuthology.
> >
> > Second, teuthology could be modified to allow it to run a test suite on a
> > single machine by creating VMs (libvirt) or containers for the tests, and
> > running the tests in series instead of in parallel.
> >
> > Any thoughts on this?
> >
> > Nathan
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
