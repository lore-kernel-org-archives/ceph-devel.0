From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Odd "data used" reporting behavior by ceph -w
Date: Tue, 1 Feb 2011 14:57:56 -0700
Message-ID: <1296597476.23762.233.camel@sale659.sandia.gov>
References: <1291412399.4879.288.camel@sale659.sandia.gov>
 <AANLkTi=3fJz8aoywUCMzBrOWtENfaqEJ__76PXHrmppQ@mail.gmail.com>
 <1291418749.4879.319.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1012042048060.28007@cobra.newdream.net>
 <1291734873.4879.347.camel@sale659.sandia.gov>
 <AANLkTi=wo0LxhsKTSpRAMRc=Owb6wfV3D8=fYTxR+BMR@mail.gmail.com>
 <1296595866.23762.226.camel@sale659.sandia.gov>
 <AANLkTinJ6RWM6L9hF6yJ5KYEs3qYEwvY0EaZFCcHL-t1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:54007 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203Ab1BAV6L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Feb 2011 16:58:11 -0500
In-Reply-To: <AANLkTinJ6RWM6L9hF6yJ5KYEs3qYEwvY0EaZFCcHL-t1@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Tue, 2011-02-01 at 14:44 -0700, Gregory Farnum wrote:
> On Tue, Feb 1, 2011 at 1:31 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> > I've just lightly tested current stable branch, commit 0f3198e8c63.
> >
> > For me both problems seem to still exist.
> Well that's a bummer.
> 
> > I'm running 4 osds per host on 4 hosts, 1 mon, 1 mds, 64 clients.
> >
> > For me a "ls" on the file system root from one of
> > the clients still doesn't complete until the dd commands
> > running on each client complete.
> >
> > Also, it is still true for me if I truncate all the files
> > to zero from one of the clients, then write them again,
> > one file per client, that second set of writes goes very
> > slow.
> >
> > Am I maybe testing the wrong commit?
> Nope, that commit should do it.
> 
> What version of the client software are you running?

I'm running 

1f0324caef from git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
+
a3f5274e53 from git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
+
90ba60990b from git://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-work.git

I actually run that kernel on both clients and servers, FWIW.
I haven't updated my remotes for a few days, so
I can run anything newer that you need me to run.


>  I'll have to look
> over the change logs to see if maybe there are changes in there that
> would impact this as well. Also my test environment is smaller than
> yours; I'll endeavor to look this over again on a larger one with more
> clients and see if I can spot any extra interactions causing problems.

OK, great.

-- Jim

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


