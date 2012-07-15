From: Sage Weil <sage@inktank.com>
Subject: Re: ceph init script does not start
Date: Sun, 15 Jul 2012 16:06:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207151601240.16828@cobra.newdream.net>
References: <50012AF1.4040300@gmail.com> <alpine.DEB.2.00.1207140741070.3898@cobra.newdream.net> <3046989.AgMSmANe5F@mranderson>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39769 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab2GOXGn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 15 Jul 2012 19:06:43 -0400
In-Reply-To: <3046989.AgMSmANe5F@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

On Sun, 15 Jul 2012, Sz?kelyi Szabolcs wrote:
> On 2012. July 14. 07:42:34 Sage Weil wrote:
> > On Sat, 14 Jul 2012, Xiaopong Tran wrote:
> > > I'm getting this funny issue. I had setup two test clusters, and
> > > mkcephfs and the ceph start up script worked just fine. We are
> > > now ready to go production, we have 6 nodes, with 10 disks
> > > each, and one osd per disk, with 3 mds and 3 mons.
> > > 
> > > The script mkcephfs ran without problem, everything was created
> > > properly. See attached log file. However, when I run
> > > 
> > > /etc/init.d/ceph start
> > > 
> > > nothing happens, not even a line of message, not on concole,
> > > neither in system log.
> > > 
> > > But can I manually start up each individual osd, mds, and mon.
> > 
> > This is usually related to the 'host = ...' lines in ceph.conf.  They need
> > to match the output of the `hostname` command in order for that daemon to
> > be automatically started or stopped.
> 
> Just a humble remark here: actually the host= setting has to match the 
> hostname *until the first dot*. If your hostname contains a dot, this will not 
> work. This can be useful in a number of cases, like setting the hostname to 
> indicate the group of a hierarchy level in the name so that the administrator 
> can extactly know what he's working on after logging in (I mean hostnames like 
> node<X>.rack<Y> in a datacenter or node<X>.<site> when running a 
> geographically distributed cluster).
> 
> From this comes my request: do you think it's possible to change (I mean, in 
> the repository) ceph_common.sh not to cut the output of `hostname` at the first 
> dot? I'm running a cluster with hostnames like that, and now I have to edit 
> that file after each upgrade.

I think the trick here is keeping things compatible with both methods.  
Maybe it should match any prefix of the host fqdn?  e.g., for a host 
a.b.c.d, any of host = a, host = a.b, host = a.b.c, or host = a.b.c.d will 
match, but host = x.a will not.

sage
