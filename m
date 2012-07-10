From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Re: Keys & caps
Date: Wed, 11 Jul 2012 01:57:31 +0200
Message-ID: <2271403.zD842C8ZM7@mranderson>
References: <4183318.yLl07ggMzS@mranderson> <1619446.aT01BgUE1G@mranderson> <alpine.DEB.2.00.1207101619230.693@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from strudel.ki.iif.hu ([193.6.222.244]:59326 "EHLO
	strudel.ki.iif.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755687Ab2GJX5i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 19:57:38 -0400
Received: from bolha.lvs.iif.hu (bolha.lvs.iif.hu [193.225.14.181])
	by strudel.ki.iif.hu (Postfix) with ESMTP id E1F0C3ED
	for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 01:57:36 +0200 (CEST)
Received: from strudel.ki.iif.hu ([IPv6:::ffff:193.6.222.244])
	by bolha.lvs.iif.hu (bolha.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id ZuDo2zPgMJ1z for <ceph-devel@vger.kernel.org>;
	Wed, 11 Jul 2012 01:57:33 +0200 (CEST)
Received: from mranderson.localnet (catv-89-132-116-194.catv.broadband.hu [89.132.116.194])
	by strudel.ki.iif.hu (Postfix) with ESMTPSA id E10063AF
	for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 01:57:32 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.00.1207101619230.693@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2012. July 10. 16:25:47 Sage Weil wrote:
> On Wed, 11 Jul 2012, Sz?kelyi Szabolcs wrote:
> > > >> The problem is that the mount.ceph command doesn't understand
> > > >> keyrings;
> > > >> it
> > > >> only understands secret= and secretfile=.  There is a longstanding
> > > >> feature
> > > >> bug open for this
> > > >> 
> > > >>       http://tracker.newdream.net/issues/266
> > > >> 
> > > >> but it hasn't been prioritized.  Sorry for the confusion!  It will
> > > >> happen
> > > >> soon.
> > > >> 
> > > >> In the meantime, you need
> > > >> 
> > > >>        -o secretfile=/path/to/secretfile,name=access_fs
> > > > 
> > > > Is this also true for the FUSE client? I have obscure memories about
> > > > big
> > > > differences between the kernel and the FUSE client, for example the
> > > > latter
> > > > being able to read ceph.conf, and get the necessary info, including
> > > > the
> > > > keyring file, from there. Maybe I didn't emphasize it, but that's what
> > > > I'm
> > > > using.
> > > 
> > > When using ceph-fuse, you want to specify the name with
> > > --name=access_fs ? no -o required.
> > 
> > Okay, so I don't need the "client." prefix for the key name, but how can I
> > specify the --name= option in fstab? Or is it possible to specify it in
> > ceph.conf, so it can be read by ceph-fuse when called by mount?
> 
> Er sorry, you actually want either --id foo or --name client.foo (they are
> equivalent) when dealing with ceph-fuse (or other userland daemons/tools).
> 
> I'm not sure what the best way of putting fuse-based file systems in fstab
> is, though.  One way or another, though, ceph-fuse needs to be told on the
> command line who to authenticate as (and which sections of ceph.conf to
> pay attention to).

This seems to be possible to pass a single argument to the userspace mount 
program with the following syntax in fstab:

ceph-fuse#--name=client.access_fs	/mnt/ceph	fuse	defaults	0 0

-- 
cc


