From: =?ISO-8859-1?Q?S=E9bastien_Paolacci?=
	<sebastien.paolacci@gmail.com>
Subject: Re: "umount" of ceph filesystem that has become unavailable hangs
	forever
Date: Fri, 23 Jul 2010 13:36:46 +0200
Message-ID: <AANLkTi=EgtWA6+jGODrsVreODwFgDrKkfWcrnL15_K32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38113 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348Ab0GWLgr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jul 2010 07:36:47 -0400
Received: by wwj40 with SMTP id 40so4456025wwj.1
        for <ceph-devel@vger.kernel.org>; Fri, 23 Jul 2010 04:36:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello Sage,

I would like to emphasize that this issue is somewhat annoying, even
for experiment purpose: I definitely expect my test server to not
behave safely, crash, burn or whatever, but having a client side
impact as deep as needed a (hard) reboot to solved a hanged ceph
really prevent me from testing with real life payloads.

I understand that it's not an easy point but a lot of my colleagues
are not really whiling to sacrifice even their dev workstation to play
during spare time... sad world ;)

Sebastien

On Wed, 16 Jun 2010, Peter Niemayer wrote:
> Hi,
>
> trying to "umount" a formerly mounted ceph filesystem that has become
> unavailable (osd crashed, then msd/mon were shut down using /etc/init.d/ceph
> stop) results in "umount" hanging forever in
> "D" state.
>
> Strangely, "umount -f" started from another terminal reports
> the ceph filesystem as not being mounted anymore, which is consistent
> with what the mount-table says.
>
> The kernel keeps emitting the following messages from time to time:
> > Jun 16 17:25:29 gitega kernel: ceph:  tid 211912 timed out on osd0, will
> > reset osd
> > Jun 16 17:25:35 gitega kernel: ceph: mon0 10.166.166.1:6789 connection
> > failed
> > Jun 16 17:26:15 gitega last message repeated 4 times
>
> I would have expected the "umount" to terminate at least after some generous
> timeout.
>
> Ceph should probably support something like the "soft,intr" options
> of NFS, because if the only supported way of mounting is one where
> a client is more or less stuck-until-reboot when the service fails,
> many potential test-configurations involving Ceph are way too dangerous
> to try...

Yeah, being able to force it to shut down when servers are unresponsive is
definitely the intent.  'umount -f' should work.  It sounds like the
problem is related to the initial 'umount' (which doesn't time out)
followed by 'umount -f'.

I'm hesitant to add a blanket umount timeout, as that could prevent proper
writeout of cached data/metadata in some cases.  So I think the goal
should be that if a normal umount hangs for some reason, you should be
able to intervene to add the 'force' if things don't go well.

sage
--
