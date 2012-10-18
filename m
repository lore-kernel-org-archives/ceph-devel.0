From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: Braindump: multiple clusters on the same hardware
Date: Thu, 18 Oct 2012 07:50:39 +0100
Message-ID: <4F329E1D-EACC-497E-B9E4-445992BA4F35@tchpc.tcd.ie>
References: <sfid-H20121017-203541-+031.28-1@marduk.tchpc.tcd.ie> <CADvuQREhkrqxm1dMo3XXFpwhtCzC7SM7cK_7+r5HnACGbCnJLw@mail.gmail.com>  (sfid-H20121017-203541-+031.28-1@marduk.tchpc.tcd.ie)
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:52425 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab2JRGur convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Oct 2012 02:50:47 -0400
In-Reply-To: <CADvuQREhkrqxm1dMo3XXFpwhtCzC7SM7cK_7+r5HnACGbCnJLw@mail.gmail.com>  (sfid-H20121017-203541-+031.28-1@marduk.tchpc.tcd.ie)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org, John Wilkins <john.wilkins@inktank.com>

Hi All,

Given that there is the capability of running two clusters on the same hosts (monitors) are there plans to add cluster to cluster features?

e.g. would it be possible to mount two separate ceph clusters from one host?


Jimmy.

On 17 Oct 2012, at 20:35, Tommi Virtanen wrote:

> You can run multiple Ceph clusters on the same hardware. They will
> have completely separate monitors, OSDs (including separate data disks
> and journals that will not be shared between clusters), MDSs etc.
> 
> This provides a higher level of isolation than e.g. just using
> multiple RADOS pools and CRUSH rulesets.
> 
> This multiple cluster support is activated in all the Ceph commands,
> such as ``ceph``, with the ``--cluster=`` option. For example, to see
> the status of the cluster ``uswest1a``, run ``ceph --cluster=uswest1a
> -s``. This will read ``/etc/ceph/uswest1a.conf`` instead of the
> default ``ceph.conf``, and use the monitor addresses and keyrings
> specified in that file. In the configuration file, the name of the
> cluster can be referred to as ``$cluster``. Cluster names must consist
> of letters a-z and digits 0-9 only.
> 
> This also means that when preparing disks for OSD hotplugging, you may
> want to specify a non-default cluster with ``ceph-disk-prepare
> --cluster=NAME /dev/sdb``.
> 
> To guard against typos in IP addresses and port numbers, make sure
> each ``CLUSTER.conf`` file specifies an ``fsid``. You should also have
> a distinct ``mon.`` key for each cluster. Following documented
> installation procedures makes sure they are both randomly generated
> for each cluster.
> 
> Current status: multi-cluster support has not been fully QA'ed, and
> there are known issues (e.g. http://tracker.newdream.net/issues/3253
> http://tracker.newdream.net/issues/3277 ).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

