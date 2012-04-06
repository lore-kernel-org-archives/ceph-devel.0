From: Sage Weil <sage@newdream.net>
Subject: Re: defaults paths #2
Date: Thu, 5 Apr 2012 22:12:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204052204290.21401@cobra.newdream.net>
References: <CAORUGqBs3=_sVnYB+vdamAW3S7ShqY5Gz1hGiY4ozUd7enTn3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51692 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab2DFFMt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Apr 2012 01:12:49 -0400
In-Reply-To: <CAORUGqBs3=_sVnYB+vdamAW3S7ShqY5Gz1hGiY4ozUd7enTn3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 5 Apr 2012, Tommi Virtanen wrote:
> > As I think it is a very specific scenario where a machine would be
> > participating in multiple Ceph clusters I'd vote for:
> >
> >   /var/lib/ceph/$type/$id
> 
> I really want to avoid having two different cases, two different code
> paths to test, a more rare variant that can break without being
> noticed. I want everything to always look the same. "ceph-" seems a
> small enough price to pay for that.

Here's what I'm thinking:

 - No data paths are hard-coded except for /etc/ceph/*.conf

 - We initially mount osd volumes in some temporary location (say, 
   /var/lib/ceph/temp/$uuid)

 - We identify the oid, cluster uuid, etc., and determine where to mount 
   it with

	ceph-osd --cluster $cluster -i $id --show-config-value osd_data

   This will normally give you the default, unless the conf file specified 
   something else.

 - Normal people get a default of /var/lib/ceph/$type/$id

 - Multicluster crazies put

	[global]
		osd data = /var/lib/ceph/$type/$cluster-$id
		osd journal = /var/lib/ceph/$type/$cluster-$id/journal
		mon data = /var/lib/ceph/$type/$cluster-$id

   (or whatever) in /etc/ceph/$cluster.conf and get something else.

Code paths are identical, data flow is identical.  We get a simple general 
case, without closing the door on multicluster configurations, which vary 
only by the config value that is easily adjusted on a per-cluster basis...

sage
