From: Sage Weil <sage@newdream.net>
Subject: Re: ceph auth add?
Date: Tue, 6 Jul 2010 13:07:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007061305590.32371@cobra.newdream.net>
References: <1278444535.2500.11.camel@jdlaptop.lesbg.loc>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40863 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab0GFUFm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jul 2010 16:05:42 -0400
In-Reply-To: <1278444535.2500.11.camel@jdlaptop.lesbg.loc>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jonathan Dieter <jdieter@lesbg.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 6 Jul 2010, Jonathan Dieter wrote:
> Are there any pointers on how to use "ceph auth add"?  I'm trying to add
> a second osd and am running into trouble at the step where I'm supposed
> to run "ceph auth get osd.1 -o /data/keyring.osd1" at
> http://ceph.newdream.net/wiki/OSD_cluster_expansion/contraction
> 
> It seems that osd.1 isn't in the server's keyring yet, but I haven't
> worked out how to add it yet.
> 
> Running the following commands on the server:
> ceph auth add osd.1 --in-file=/data/keyring.osd1

Try

 ceph auth add osd.1 -i /data/keyring.osd1

The long form was --in-data instead of --in-file... now fixed in unstable.  
But you can just use the short form -i.

sage


> ceph auth add osd.1 /data/keyring.osd1
> ceph auth add osd.1 < /data/keyring.osd1
> 
> all give me variants of
> 
> 10.07.06 22:23:58.953255 7f3cffc5f710 monclient(hunting): found mon0
> 10.07.06 22:23:58.953509 mon <- [auth,add,osd.1]
> 10.07.06 22:23:58.953702 mon0 -> 'error decoding keyring' (-22)
> 
> # ceph auth list
> mon.
> 	key: AQ**********************************+w==
> mds.ceph-server-01
> 	key: AQ**********************************zA==
> 	caps: [mds] allow
> 	caps: [mon] allow rwx
> 	caps: [osd] allow *
> osd.0
> 	key: AQ**********************************Ug==
> 	caps: [mon] allow rwx
> 	caps: [osd] allow *
> client.admin
> 	key: AQ**********************************zg==
> 	caps: [mds] allow
> 	caps: [mon] allow *
> 	caps: [osd] allow *
> ' (0)
> 
> # cauthtool --list /data/keyring.osd1
> osd.1
> 	key: AQ**********************************GA==
> 	auid: 18***************15
> 	caps: [mon] allow rwx
> 	caps: [osd] allow *
> 
