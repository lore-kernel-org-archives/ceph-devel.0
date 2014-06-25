From: Sage Weil <sage@redhat.com>
Subject: Re: Ceph on Fedora
Date: Wed, 25 Jun 2014 08:52:37 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406250847320.11402@cobra.newdream.net>
References: <81484967.26606084.1403611408994.JavaMail.zimbra@redhat.com> <alpine.DEB.2.00.1406240658490.26155@cobra.newdream.net> <1933569313.26739343.1403619189180.JavaMail.zimbra@redhat.com> <alpine.DEB.2.00.1406241339320.29955@cobra.newdream.net>
 <2098519518.26968570.1403644538772.JavaMail.zimbra@redhat.com> <53A9EBC3.8090708@inktank.com> <196130012.26972749.1403645349752.JavaMail.zimbra@redhat.com> <1023335739.27158897.1403688592530.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56313 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757211AbaFYPwi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Jun 2014 11:52:38 -0400
In-Reply-To: <1023335739.27158897.1403688592530.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Federico Simoncelli <fsimonce@redhat.com>
Cc: Dan Mick <dan.mick@inktank.com>, Sage Weil <sweil@redhat.com>, icolle@redhat.com, Alfredo Deza <adeza@redhat.com>, ceph-devel@vger.kernel.org

[adding ceph-devel]

On Wed, 25 Jun 2014, Federico Simoncelli wrote:
> New version of the patch:
> 
>  http://github.com/simon3z/ceph/commit/ef42184
> 
> sadly not fully addressing the cluster problem (it is now configurable 
> but it is unique). It is clear that systemd doesn't support multiple 
> instance identifiers %i (we could have used one for the mon/osd/mds id 
> and one for the cluster) and it doesn't support parsing the single %i 
> (to be split in two).

That is unfortunate, but so it goes.  Any idea if this is something 
that systemd may get later?
 
> Instances are not even that common in systemd, I think the way fedora would
> integrate ceph is using the /etc/sysconfig/ceph file to configure the ids:
> 
> CLUSTER="ceph"
> MON_ID="ceph-node01"
> OSD_ID="0"
> MDS_ID="ceph-node01"
> 
> and then just run:
> 
>  # systemctl start ceph-mon ceph-osd ceph-mds
> 
> So I have the feeling that we're already giving an extra degree of freedom
> by using instances to run multiple mon/osd/mds (even though I am not sure
> how much that's useful if they have to be part of the same cluster).
> 
> Actually, do you feel that having multiple mon/osd/mds is useless if they
> have to be of the same cluster? I am talking about the regular deployments,
> not testing/developing.

Having multiple instances of daemons is definitely required.  The vast 
majority of deployments have many OSDs per node.  It's less common for the 
mon and mds daemons, but I think it is simplest to make them match.

That being the case, I think your original suggestion of having the 
cluster specified somewhere in /etc/ceph or /etc/sysconfig/ceph is the 
right interim solution.

Is there a way to set up meta-jobs that capture all instances of each 
daemon type, or all ceph daemons?

Thanks!
sage
