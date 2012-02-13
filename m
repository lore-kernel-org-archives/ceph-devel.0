From: Sage Weil <sage@newdream.net>
Subject: Re: OSD id in configuration file
Date: Mon, 13 Feb 2012 09:28:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202130917220.13736@cobra.newdream.net>
References: <8512670932FB654F81AF0FEF1BE6D49DE23C32@WHQBEMAIL1.whq.wistron>
 <Pine.LNX.4.64.1202130905260.13736@cobra.newdream.net>
 <78276ffb22ef20e17ca2580f1d8b308e@pl1.haspere.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46337 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757200Ab2BMR26 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2012 12:28:58 -0500
In-Reply-To: <78276ffb22ef20e17ca2580f1d8b308e@pl1.haspere.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Cc: Eric_YH_Chen@wistron.com, ceph-devel@vger.kernel.org

On Mon, 13 Feb 2012, Dyweni - Ceph-Devel wrote:
> Hi,
> 
> That doesn't make sense... Would you explain further?
> 
> This page (http://ceph.newdream.net/wiki/Cluster_configuration) says the id
> can be a number or a name, which applies to (mon|mds|ods).$id.

The monitors and mds's are identified by name, but the OSDs are identified 
by number only.  See the 'node names' heading.

sage


> 
> Will I have problems using SHA1 sums to uniquely identify each OSD in my
> cluster? (i.e. OSD.$sha1sum)
> 
> ---
> Thanks,
> Dyweni
> 
> On Mon, 13 Feb 2012 09:07:16 -0800 (PST), Sage Weil wrote:
> 
> > On Mon, 13 Feb 2012, Eric_YH_Chen@wistron.com [1] wrote:
> > > Hi, all: For the scalability consideration, we would like to name the
> > > first harddisk as "00101" on first server. And named the first harddisk
> > > as "00201" on second server. The ceph.conf seems like this: [osd] osd
> > > data = /srv/osd.$id osd journal = /srv/osd.$id.journal osd journal size
> > > = 1000 [osd.00101]
> > The leading 0's are meaningless (or at worst, misleading) here. ceph-osd
> > identifiers are integers.
> > 
> > > host = server-001 btrfs dev= /dev/sda [osd.00102] host = server-001
> > > btrfs dev= /dev/sdb [osd.00103] host = server-001 btrfs dev= /dev/sdc
> > > [osd.00201] host = server-002 btrfs dev= /dev/sda [osd.00202] host =
> > > server-002 btrfs dev= /dev/sdb [osd.00203] host = server-002 btrfs dev=
> > > /dev/sdc [osd.00301] host = server-003 btrfs dev= /dev/sda [osd.00302]
> > > host = server-003 btrfs dev= /dev/sdb [osd.00303] host = server-003
> > > btrfs dev= /dev/sdc But we are worried about if it is an acceptable
> > > configuration for ceph. As I see, the maximum osd is 304 now, although
> > > there are only 9 osds in the cluster. Will this configuration influence
> > > about the performance? And what if we add osd.00204 in the future?
> > They are stored as an array currently, so if the max is 304 using
> > anything below that is better, not worse. ~300 is a small number, so this
> > isn't really problematic. Just don't label an OSD osd.200302 or you'll be
> > unhappy. sage -- To unsubscribe from this list: send the line
> > "unsubscribe ceph-devel" in the body of a message to
> > majordomo@vger.kernel.org [2] More majordomo info at
> > http://vger.kernel.org/majordomo-info.html [3]
> 
> 
