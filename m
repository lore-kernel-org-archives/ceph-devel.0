From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] the state of cephfs in giant
Date: Mon, 13 Oct 2014 13:56:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410131354521.10568@cobra.newdream.net>
References: <alpine.DEB.2.00.1410131114130.10561@cobra.newdream.net> <8D1B52F9254254D-FFC-18C53@webmail-va058.sysops.aol.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58163 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbaJMU46 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Oct 2014 16:56:58 -0400
In-Reply-To: <8D1B52F9254254D-FFC-18C53@webmail-va058.sysops.aol.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric Eastman <eric0e@aol.com>
Cc: ceph-users@ceph.com, ceph-devel@vger.kernel.org, matt@linuxbox.com

On Mon, 13 Oct 2014, Eric Eastman wrote:
> I would be interested in testing the Samba VFS and Ganesha NFS integration
> with CephFS.  Are there any notes on how to configure these two interfaces
> with CephFS?

For samba, based on 
https://github.com/ceph/ceph-qa-suite/blob/master/tasks/samba.py#L106
I think you need something like

[myshare]
path = /
writeable = yes
vfs objects = ceph
ceph:config_file = /etc/ceph/ceph.conf

Not sure what the ganesha config looks like.  Matt and the other folks at 
cohortfs would know more.

sage
