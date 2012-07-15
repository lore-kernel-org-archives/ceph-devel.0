From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Re: ceph init script does not start
Date: Sun, 15 Jul 2012 20:05:02 +0200
Message-ID: <3046989.AgMSmANe5F@mranderson>
References: <50012AF1.4040300@gmail.com> <alpine.DEB.2.00.1207140741070.3898@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from strudel.ki.iif.hu ([193.6.222.244]:34043 "EHLO
	strudel.ki.iif.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab2GOSFJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 15 Jul 2012 14:05:09 -0400
Received: from bolha.lvs.iif.hu (bolha.lvs.iif.hu [193.225.14.181])
	by strudel.ki.iif.hu (Postfix) with ESMTP id 56732344
	for <ceph-devel@vger.kernel.org>; Sun, 15 Jul 2012 20:05:07 +0200 (CEST)
Received: from strudel.ki.iif.hu ([IPv6:::ffff:193.6.222.244])
	by bolha.lvs.iif.hu (bolha.lvs.iif.hu [::ffff:193.225.14.72]) (amavisd-new, port 10024)
	with ESMTP id nGZxz-sbDNKE for <ceph-devel@vger.kernel.org>;
	Sun, 15 Jul 2012 20:05:04 +0200 (CEST)
Received: from mranderson.localnet (adsl166.adsl.hungarnet.hu [193.6.17.166])
	by strudel.ki.iif.hu (Postfix) with ESMTPSA id A0D5C33A
	for <ceph-devel@vger.kernel.org>; Sun, 15 Jul 2012 20:05:03 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.00.1207140741070.3898@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2012. July 14. 07:42:34 Sage Weil wrote:
> On Sat, 14 Jul 2012, Xiaopong Tran wrote:
> > I'm getting this funny issue. I had setup two test clusters, and
> > mkcephfs and the ceph start up script worked just fine. We are
> > now ready to go production, we have 6 nodes, with 10 disks
> > each, and one osd per disk, with 3 mds and 3 mons.
> > 
> > The script mkcephfs ran without problem, everything was created
> > properly. See attached log file. However, when I run
> > 
> > /etc/init.d/ceph start
> > 
> > nothing happens, not even a line of message, not on concole,
> > neither in system log.
> > 
> > But can I manually start up each individual osd, mds, and mon.
> 
> This is usually related to the 'host = ...' lines in ceph.conf.  They need
> to match the output of the `hostname` command in order for that daemon to
> be automatically started or stopped.

Just a humble remark here: actually the host= setting has to match the 
hostname *until the first dot*. If your hostname contains a dot, this will not 
work. This can be useful in a number of cases, like setting the hostname to 
indicate the group of a hierarchy level in the name so that the administrator 
can extactly know what he's working on after logging in (I mean hostnames like 
node<X>.rack<Y> in a datacenter or node<X>.<site> when running a 
geographically distributed cluster).

From this comes my request: do you think it's possible to change (I mean, in 
the repository) ceph_common.sh not to cut the output of `hostname` at the first 
dot? I'm running a cluster with hostnames like that, and now I have to edit 
that file after each upgrade.

-- 
cc


