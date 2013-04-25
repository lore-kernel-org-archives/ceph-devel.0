From: Sage Weil <sage@inktank.com>
Subject: Re: Unique bug in ceph start script
Date: Thu, 25 Apr 2013 10:42:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304251041340.6703@cobra.newdream.net>
References: <20130422150612.GA22006@upset.ux.pdb.fsc.net> <alpine.DEB.2.00.1304220836140.15710@cobra.newdream.net> <20130423064101.GA24976@upset.ux.pdb.fsc.net> <alpine.DEB.2.00.1304231001160.19511@cobra.newdream.net> <20130424075630.GA7395@upset.ux.pdb.fsc.net>
 <alpine.DEB.2.00.1304241104380.2772@cobra.newdream.net> <20130425070502.GA11892@upset.ux.pdb.fsc.net> <alpine.DEB.2.00.1304250909580.4411@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46887 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932422Ab3DYRml (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Apr 2013 13:42:41 -0400
In-Reply-To: <alpine.DEB.2.00.1304250909580.4411@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 25 Apr 2013, Sage Weil wrote:
> On Thu, 25 Apr 2013, Andreas Friedrich wrote:
> > On Mi, Apr 24, 2013 at 11:04:56 -0700, Sage Weil wrote:
> > 
> > Hello Sage,
> > 
> > ...
> > > > If the start script exits with or without error, the remote config 
> > > > file will be removed from <remote-host>:/tmp - but only for the last 
> > > > host (the former trap calls will be overwritten by the last trap
> > > > call)! This makes no sense to me.
> > > 
> > > Bah.. I was thinking they would stack.  How about
> > > 
> > > diff --git a/src/init-ceph.in b/src/init-ceph.in
> > > index 61c10e1..195bf76 100644
> > > --- a/src/init-ceph.in
> > > +++ b/src/init-ceph.in
> > > @@ -218,8 +218,11 @@ for name in $what; do
> > >      else
> > >         unique=`dd if=/dev/urandom bs=16 count=1 2>/dev/null | md5sum | awk '{print $1}'`
> > >         scp -q $conf $host:/tmp/ceph.conf.$unique
> > > -       trap "ssh $host rm /tmp/ceph.conf.$unique" EXIT
> > >         cur_conf="/tmp/ceph.conf.$unique"
> > > +
> > > +       # clean up on exit
> > > +       remote_configs="$host:/tmp/ceph.conf.$unique $remote_configs"
> > > +       trap 'for f in '$remote_configs' ; do ssh ${f%:*} rm ${f#*:} ; done' EXIT
> > >      fi
> > >      cmd="$cmd -c $cur_conf"
> > 
> > yes, this looks fine but I have a question:
> > 
> > I don't know the background for copying the config files to
> > <remote-host>:/tmp. Why don't use all the daemons their local config
> > /etc/ceph/ceph.conf?
> > 
> > May be you want to ensure that the remote daemons will use the same
> > config as exists on the host from which the cluster was started. But
> > if the configs on the remote hosts differ from the config of the
> > "cluster-start-host", then we still might have a problem when a remote
> > host is booting: In this case '/etc/init.d/ceph start' is called and
> > the remote host will use its local (different) config.
> > 
> > I think a clear strategy would be:
> > - All daemons always use their local config (no copying to /tmp).
> > - If a cluster-start is initiated (/etc/init.d/ceph -a start) the
> >   script first checks if the configs on all cluster hosts are equal
> >   (maybe we need a content check here - not a literal check).
> > - If the configs are not equal, the cluster-start command aborts with
> >   an error message.
> > 
> > What do you think about that?
> 
> That makes a lot more sense, although I would suggest a warning instead of 
> an error.  For cuttlefish, I'm hesitant to change behavior in the 11th 
> hour, but we should make this change going forward.
> 
> Care to send a patch?  :)

On second thought, I think we should just rip out the config pushign 
entirely.  This will break

 service ceph -a -c /some/local/config start ...

(unless /some/local/config is present on all nodes) but I don't think that 
is a use case any normal person would need...

sge

