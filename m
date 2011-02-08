From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Odd "data used" reporting behavior by ceph -w
Date: Tue, 8 Feb 2011 11:23:02 -0700
Message-ID: <1297189382.15475.80.camel@sale659.sandia.gov>
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
Received: from sentry-three.sandia.gov ([132.175.109.17]:41229 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173Ab1BHSXV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Feb 2011 13:23:21 -0500
In-Reply-To: <AANLkTinJ6RWM6L9hF6yJ5KYEs3qYEwvY0EaZFCcHL-t1@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi Greg,

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
> What version of the client software are you running? I'll have to look
> over the change logs to see if maybe there are changes in there that
> would impact this as well. Also my test environment is smaller than
> yours; I'll endeavor to look this over again on a larger one with more
> clients and see if I can spot any extra interactions causing problems.

FWIW, I've got a little bit more data on the problem
of 'ls' not completing until writes to a filesystem 
all complete.

For me it depends on the number of osd instances.

With just 4 cosds, 'ls' with active writing returns
immediately.

At 16 cosds, 'ls' with active writing doesn't
return until the writes complete.

This is with current stable (commit d7af21020).

Also FWIW, I'm currently unable to reproduce the slow
write after truncate issue, using stable branch
on server side and 2.6.38-rc4 + ceph-client 
master branch (commit 1afeac8b0) on client side.
I'm not sure what was going on with my above
report; sorry for the noise.

-- Jim

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


