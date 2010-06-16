From: Sage Weil <sage@newdream.net>
Subject: Re: crush update failure ("corrupt inc osdmap epoch 5 off 50")
Date: Wed, 16 Jun 2010 09:57:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006160950430.12761@cobra.newdream.net>
References: <hv9r6e$4tp$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53588 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261Ab0FPQ5I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jun 2010 12:57:08 -0400
In-Reply-To: <hv9r6e$4tp$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hi Thomas,

On Wed, 16 Jun 2010, Thomas Mueller wrote:
> i tried to change data "max_size" to 1 to disable replication for testing.

You don't actually need/want to change the crush map to adjust 
replication.  Each crush rule is written to generalize to some range of 
replication levels (hence the min/max size definitions).  To adjust 
replication for testing/whatever, just do

 $ ceph osd pool data size 1   # 1x replication

See

 http://ceph.newdream.net/wiki/Adjusting_replication_level

> what i've done (reproducable):
> 
> mkcephfs -c /etc/ceph/ceph.conf --mkbtrfs (1mds, 1mon, 2osd (2 phyiscal disks))
> start ceph
> mount ceph fs
> write some files to the mount
> ceph osd getcrushmap -o /tmp/crush
> crushtool -d /tmp/crush -o /tmp/crush.txt
> change data "max_size 10" to "max_size 1" in /tmp/crush.txt
> crushtool -c /tmp/crush.txt -o /tmp/crush.new
> ceph osd setcrushmap -i /tmp/crush.new (Output:
> * read 428 bytes from /tmp/crush.new
> * 10.06.16_08:12:57.187556 41223950 monclient(hunting): found mon0
> * 10.06.16_08:12:57.188298 mon <- [osd,setcrushmap]
> * 10.06.16_08:12:58.303241 mon0 -> 'set crush map' (0)
> )
> 
> 
> after starting to write a file to the mount, I see these kernel messages :
> http://pastebin.com/maVj9daV
> 
> ceph / kclient are yesterdays git unstable / unstable-backport versions.
> kernel is debian lenny backport 2.6.32.

We'll fix this up to not crash in that case.  :)

sage


> 
> - Thomas
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
