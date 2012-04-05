From: Bernard Grymonpon <bernard@openminds.be>
Subject: Re: defaults paths
Date: Thu, 5 Apr 2012 08:57:45 +0200
Message-ID: <3177659F-3D4D-45A2-80D3-B344CF604901@openminds.be>
References: <Pine.LNX.4.64.1204042320010.28065@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from november.openminds.be ([195.47.215.47]:43495 "EHLO
	november.openminds.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab2DEG5r convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 02:57:47 -0400
In-Reply-To: <Pine.LNX.4.64.1204042320010.28065@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


On 05 Apr 2012, at 08:32, Sage Weil wrote:

> We want to standardize the locations for ceph data directories, configs, 
> etc.  We'd also like to allow a single host to run OSDs that participate 
> in multiple ceph clusters.  We'd like easy to deal with names (i.e., avoid 
> UUIDs if we can).
> 
> The metavariables are:
> cluster = ceph (by default)
> type = osd, mon, mds
> id = 1, foo, 
> name = $type.$id = osd.0, mds.a, etc.
> 
> The $cluster variable will come from the command line (--cluster foo) or, 
> in the case of a udev hotplug tool or something, matching the uuid on the 
> device with the 'fsid = <uuid>' line in the available config files found 
> in /etc/ceph.
> 
> The locations could be:
> 
> ceph config file:
>  /etc/ceph/$cluster.conf     (default is thus ceph.conf)
> 
> keyring:
>  /etc/ceph/$cluster.keyring  (fallback to /etc/ceph/keyring)
> 
> osd_data, mon_data:
>  /var/lib/ceph/$cluster.$name
>  /var/lib/ceph/$cluster/$name
>  /var/lib/ceph/data/$cluster.$name
>  /var/lib/ceph/$type-data/$cluster-$id
> 
> TV and I talked about this today, and one thing we want is for items of a 
> given type to live together in separate directory so that we don't have to 
> do any filtering to, say, get all osd data directories.  This suggests the 
> last option (/var/lib/ceph/osd-data/ceph-1, 
> /var/lib/ceph/mon-data/ceph-foo, etc.), but it's kind of fugly.
> 
> Another option would be to make it
> 
> /var/lib/ceph/$type-data/$id
> 
> (with no $cluster) and make users override the default with something that 
> includes $cluster (or $fsid, or whatever) in their $cluster.conf if/when 
> they want multicluster nodes that don't interfere.  Then we'd get 
> /var/lib/ceph/osd-data/1 for non-crazy people, which is pretty easy.

As a osd consists of data and the journal, it should stay together, with all info for that one osd in one place:

I would suggest 

/var/lib/ceph/osd/$id/data
and
/var/lib/ceph/osd/$id/journal

($id could be replaced by $uuid or $name, for which I would prefer $uuid)

Rgds,
Bernard

> 
> Any other suggestions?  Thoughts?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

