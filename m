From: Sage Weil <sage@inktank.com>
Subject: Re: deb/rpm package purge
Date: Tue, 19 Mar 2013 15:59:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303191554590.4850@cobra.newdream.net>
References: <alpine.DEB.2.00.1303191246330.4850@cobra.newdream.net> <5148C4EE.5090205@inktank.com> <5148CEC2.2050405@inktank.com> <alpine.DEB.2.00.1303191349360.4850@cobra.newdream.net> <1363732049.12547.22.camel@julia> <alpine.DEB.2.00.1303191528510.4850@cobra.newdream.net>
 <1363733473.12547.33.camel@julia>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54203 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757425Ab3CSW7p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Mar 2013 18:59:45 -0400
In-Reply-To: <1363733473.12547.33.camel@julia>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>
Cc: Dan Mick <dan.mick@inktank.com>, Mark Nelson <mark.nelson@inktank.com>, ceph-devel@vger.kernel.org, james.page@ubuntu.com

On Tue, 19 Mar 2013, Laszlo Boszormenyi (GCS) wrote:
>  Sorry if I was not clear and/or generic enough. Use of 'dpkg --remove'
> is to remove binaries of the package, but leave other things, runtime
> data (configuration, logs, database settings/users and so on) to be left
> untouched.
> On the other hand, 'dpkg --purge' is to remove everything the package
> has installed and/or generated. This includes debconf answers as well.
> With other words, purge is used to make the system totally clean of the
> package. As such, if the sysadmin install the package again, all debconf
> questions will be asked again and all generated files will be generated
> again from scratch.

I understand that part, but the policy isn't very clear about files that 
are not part of the package but are generated as a result of the package 
being installed (i.e., user data).

/var/lib/ceph/ has all of the *user data*, like critical monitor files 
that are necessary for the cluster to function (/var/lib/ceph/mon/*), and 
actual ceph objects (/var/lib/ceph/osd/*, although these are usually mount 
points that we would unmount, not delete).  Doing a purge on the monitor 
nodes would destroy the cluster (and all of its data) in a 
not-easily-recoverable way.

As a point of comparison, mysql removes the config files but not 
/var/lib/mysql.

The question is, is that okay/typical/desireable/recommended/a bad idea?

The less important question is whether /var/log/ceph should be removed; 
I'm assuming yes?

Thanks!
sage

