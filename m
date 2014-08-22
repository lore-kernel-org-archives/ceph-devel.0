From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: RE: A problem when restarting OSD
Date: Fri, 22 Aug 2014 01:36:13 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C5348936F36@SHSMSX101.ccr.corp.intel.com>
References: <06E7D85B3BA36C4DB207FEDE871C5348936E6B@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1408210824350.31169@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63347 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754630AbaHVBgS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Aug 2014 21:36:18 -0400
In-Reply-To: <alpine.DEB.2.00.1408210824350.31169@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>

Hi Sage,

Yes, I understand that we can customize the crush location hook to let the OSD go to the right location. But does the ceph user have the idea of this if he/she has more than 1 root in the crush map? At least I don't know this at the beginning. We need to either emphasize this or do it in some ways for the user.

One question for the hot-swapping support of moving an OSD to another host. What if the journal is not located at the same disk of the OSD? Is the OSD still able to be available in the cluster?

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com] 
Sent: Thursday, August 21, 2014 11:28 PM
To: Wang, Zhiqiang
Cc: 'ceph-devel@vger.kernel.org'
Subject: Re: A problem when restarting OSD

On Thu, 21 Aug 2014, Wang, Zhiqiang wrote:
> Hi all,
> 
> I ran into a problem when restarting an OSD.
> 
> Here is my OSD tree before restarting the OSD:
> 
> # id    weight  type name       up/down reweight
> -6      8       root ssd
> -4      4               host zqw-s1-ssd
> 16      1                       osd.16  up      1
> 17      1                       osd.17  up      1
> 18      1                       osd.18  up      1
> 19      1                       osd.19  up      1
> -5      4               host zqw-s2-ssd
> 20      1                       osd.20  up      1
> 21      1                       osd.21  up      1
> 22      1                       osd.22  up      1
> 23      1                       osd.23  up      1
> -1      14.56   root default
> -2      7.28            host zqw-s1
> 0       0.91                    osd.0   up      1
> 1       0.91                    osd.1   up      1
> 2       0.91                    osd.2   up      1
> 3       0.91                    osd.3   up      1
> 4       0.91                    osd.4   up      1
> 5       0.91                    osd.5   up      1
> 6       0.91                    osd.6   up      1
> 7       0.91                    osd.7   up      1
> -3      7.28            host zqw-s2
> 8       0.91                    osd.8   up      1
> 9       0.91                    osd.9   up      1
> 10      0.91                    osd.10  up      1
> 11      0.91                    osd.11  up      1
> 12      0.91                    osd.12  up      1
> 13      0.91                    osd.13  up      1
> 14      0.91                    osd.14  up      1
> 15      0.91                    osd.15  up      1
> 
> After I restart one of the OSD with id from 16 to 23, say restarting osd.16, osd.16 goes to 'root default' and 'host zqw-s1', and ceph cluster begins to do rebalance. This surely is not what I want.
> 
> # id    weight  type name       up/down reweight
> -6      7       root ssd
> -4      3               host zqw-s1-ssd
> 17      1                       osd.17  up      1
> 18      1                       osd.18  up      1
> 19      1                       osd.19  up      1
> -5      4               host zqw-s2-ssd
> 20      1                       osd.20  up      1
> 21      1                       osd.21  up      1
> 22      1                       osd.22  up      1
> 23      1                       osd.23  up      1
> -1      15.56   root default
> -2      8.28            host zqw-s1
> 0       0.91                    osd.0   up      1
> 1       0.91                    osd.1   up      1
> 2       0.91                    osd.2   up      1
> 3       0.91                    osd.3   up      1
> 4       0.91                    osd.4   up      1
> 5       0.91                    osd.5   up      1
> 6       0.91                    osd.6   up      1
> 7       0.91                    osd.7   up      1
> 16      1                       osd.16  up      1
> -3      7.28            host zqw-s2
> 8       0.91                    osd.8   up      1
> 9       0.91                    osd.9   up      1
> 10      0.91                    osd.10  up      1
> 11      0.91                    osd.11  up      1
> 12      0.91                    osd.12  up      1
> 13      0.91                    osd.13  up      1
> 14      0.91                    osd.14  up      1
> 15      0.91                    osd.15  up      1
> 
> After digging into the problem, I find it's because in the ceph init script, we change the OSD's crush location in some way. It uses the script 'ceph-crush-location' to get the crush location from the ceph.conf file for the restarting OSD. If there isn't such an entry in ceph.conf, it uses the default one 'host=$(hostname -s) root=default'. Since I don't have the crush location configuration in my ceph.conf (I guess most of people don't have this in their ceph.conf), when I restarting osd.16, it goes to 'root default' and 'host zqw-s1'.
> 
> Here is a fix for this:
> When the ceph init script uses 'ceph osd crush create-or-move' to 
> change the OSD's crush location, do a check first, if this OSD is 
> already existing in the crush map, return without making the location 
> change. This change is at: 
> https://github.com/wonzhq/ceph/commit/efdfa23664caa531390d141bd1539878
> 761412fe
> 
> What do you think?

The goal of this behavior is to allow hot-swapping of devices.  You can pull disks out of one host and put them in another and the udev machinery will start up the daemon, update the crush location, and the disk and data will become available.  It's not 'ideal' in the sense that there will be rebalancing, but it does make the data available to the cluster to preserve data safety.

We haven't come up with a great scheme yet to managing multiple trees yet.  
The idea is that the ceph-crush-location hook can be customized to do whatever is necessary, for example by putting root=ssd if the device type appears to be an ssd (maybe look at the sysfs metadata, or put a marker file in the osd data directory?).  You can point to your own hook for your environment with

  osd crush location hook = /path/to/my/script

sage



