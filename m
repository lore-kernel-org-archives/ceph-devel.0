From: Sage Weil <sage@inktank.com>
Subject: Re: Reduce log verbosity
Date: Wed, 7 Aug 2013 08:12:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308070811140.3006@cobra.newdream.net>
References: <CANB=HGgxw3fzcDhn7JKQA00eO4SfZHBptPi7Y=UxVQwUWny8yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43573 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756750Ab3HGPMy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Aug 2013 11:12:54 -0400
In-Reply-To: <CANB=HGgxw3fzcDhn7JKQA00eO4SfZHBptPi7Y=UxVQwUWny8yA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jean-Daniel BUSSY <silversurfer972@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 7 Aug 2013, Jean-Daniel BUSSY wrote:
> Hi all,
> 
> We have log aggregation on our ceph cluster and verbosity is a problem
> on the cluster log file at /etc/ceph/ceph.conf
> I got advice from some nice folk on IRC and I tried to use syslog and
> setup the log level to WARN but the INF logs are still pouring.
> I confirmed settings are changed in the admin socked and got these:
> 
>   "clog_to_syslog_level": "warn",
>   "clog_to_syslog_facility": "daemon",
>   "mon_cluster_log_to_syslog": "true",
>   "mon_cluster_log_to_syslog_level": "warn",
>   "mon_cluster_log_to_syslog_facility": "daemon",
>   "mon_cluster_log_file": "\/var\/log\/ceph\/ceph.log",
> 
> I guess I am missing some option flag or something. Any hint?

Currently the ceph.log gets the log messages unconditionally.  You can set 
mon_cluster_log_file to /dev/null so that only warn and higher goes to 
syslog?

And we should add a mon_cluster_log_level option :)

sage

