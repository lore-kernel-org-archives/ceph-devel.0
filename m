From: Sage Weil <sweil@redhat.com>
Subject: Re: A problem when restarting OSD
Date: Fri, 22 Aug 2014 07:06:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408220705270.31169@cobra.newdream.net>
References: <D01CC247.1B4AD%dmsimard@iweb.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52811 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152AbaHVOHA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Aug 2014 10:07:00 -0400
In-Reply-To: <D01CC247.1B4AD%dmsimard@iweb.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Moreau Simard <dmsimard@iweb.com>
Cc: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>, "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>

On Fri, 22 Aug 2014, David Moreau Simard wrote:
> Hi Wang,
> 
> Thanks, I?ll try that for the time being. This still raises a few
> questions I?d like to discuss.
> 
> I?m convinced we can agree that the CRUSH map is ultimately the authority
> as far as the location of the devices currently are.
> My understanding is that we are relying on another source for device
> location when (in this case) restarting OSDs: the ceph.conf file.
> 
> 1) Does this imply that we probably shouldn?t specify device locations
> directly in the crush map but in our ceph.conf file instead ?
> 2) If what is in the crush map is different than what is configured in
> ceph.conf, how does Ceph decide which is the authority ? Shouldn?t it be
> the crush map ? In this case, it appears to be the ceph.conf file.
> 
> Just trying to wrap my head around the vision of how things should be
> managed.

Generally speaking, you have three options:

 - 'osd crush update on start = false' and do it all manually, like you're 
   used to.
 - set 'crush location = a=b c=d e=f' in ceph.conf.  The expectation is 
   that chef or puppet or whatever will fill this in with "host=foo 
   rack=bar dc=asdf".
 - customize ceph-crush-location to do something trickier (like multiple 
   trees)

sage


> -- 
> David Moreau Simard
> 
> 
> Le 2014-08-21, 10:57 PM, ? Wang, Zhiqiang ? <zhiqiang.wang@intel.com> a
> ?crit :
> 
> >Hi David,
> >
> >Yes, I think adding a hook in your ceph.conf can solve your problem. At
> >least this is what I did, and it solves the problem.
> >
> >For example:
> >
> >[osd.3]
> >osd crush location = "host=osd02 root=default disktype=osd02_ssd"
> >
> >You need to add this for every osd.
> >
> >-----Original Message-----
> >From: David Moreau Simard [mailto:dmsimard@iweb.com]
> >Sent: Friday, August 22, 2014 10:34 AM
> >To: Wang, Zhiqiang; Sage Weil
> >Cc: 'ceph-devel@vger.kernel.org'
> >Subject: Re: A problem when restarting OSD
> >
> >I?m glad you mention this because I?ve also been running into the same
> >issue and this took me a while to figure out too.
> >
> >Is this new behaviour ? I don?t remember running into this before...
> >
> >Sage does mention multiple trees but I?ve had this happen with a single
> >root.
> >It is definitely not my expectation that restarting an OSD would move
> >things around in the crush map.
> >
> >I?m in the process of developing a crush map, looks like this (note:
> >unfinished and does not make much sense as is):
> >http://pastebin.com/6vBUQTCk
> >This results in this tree:
> ># id	weight	type name	up/down	reweight
> >-1	18	root default
> >-2	9		host osd02
> >-4	2			disktype osd02_ssd
> >3	1				osd.3	up	1
> >9	1				osd.9	up	1
> >-5	7			disktype osd02_spinning
> >8	1				osd.8	up	1
> >17	1				osd.17	up	1
> >5	1				osd.5	up	1
> >11	1				osd.11	up	1
> >1	1				osd.1	up	1
> >13	1				osd.13	up	1
> >15	1				osd.15	up	1
> >-3	9		host osd01
> >-6	2			disktype osd01_ssd
> >2	1				osd.2	up	1
> >7	1				osd.7	up	1
> >-7	7			disktype osd01_spinning
> >0	1				osd.0	up	1
> >4	1				osd.4	up	1
> >12	1				osd.12	up	1
> >6	1				osd.6	up	1
> >14	1				osd.14	up	1
> >10	1				osd.10	up	1
> >16	1				osd.16	up	1
> >
> >Only restarting the OSDs on both hosts modifies the crush map:
> >http://pastebin.com/rP8Y8qcH
> >With the resulting tree:
> ># id	weight	type name	up/down	reweight
> >-1	18	root default
> >-2	9		host osd02
> >-4	0			disktype osd02_ssd
> >-5	0			disktype osd02_spinning
> >13	1			osd.13	up	1
> >3	1			osd.3	up	1
> >5	1			osd.5	up	1
> >1	1			osd.1	up	1
> >11	1			osd.11	up	1
> >15	1			osd.15	up	1
> >17	1			osd.17	up	1
> >8	1			osd.8	up	1
> >9	1			osd.9	up	1
> >-3	9		host osd01
> >-6	0			disktype osd01_ssd
> >-7	0			disktype osd01_spinning
> >0	1			osd.0	up	1
> >10	1			osd.10	up	1
> >12	1			osd.12	up	1
> >14	1			osd.14	up	1
> >16	1			osd.16	up	1
> >2	1			osd.2	up	1
> >4	1			osd.4	up	1
> >7	1			osd.7	up	1
> >6	1			osd.6	up	1
> >
> >Would a hook really be the solution I need ?
> >--
> >David Moreau Simard
> >
> >Le 2014-08-21, 9:36 PM, ? Wang, Zhiqiang ? <zhiqiang.wang@intel.com> a
> >?crit :
> >
> >>Hi Sage,
> >>
> >>Yes, I understand that we can customize the crush location hook to let
> >>the OSD go to the right location. But does the ceph user have the idea
> >>of this if he/she has more than 1 root in the crush map? At least I
> >>don't know this at the beginning. We need to either emphasize this or
> >>do it in some ways for the user.
> >>
> >>One question for the hot-swapping support of moving an OSD to another
> >>host. What if the journal is not located at the same disk of the OSD?
> >>Is the OSD still able to be available in the cluster?
> >>
> >>-----Original Message-----
> >>From: Sage Weil [mailto:sweil@redhat.com]
> >>Sent: Thursday, August 21, 2014 11:28 PM
> >>To: Wang, Zhiqiang
> >>Cc: 'ceph-devel@vger.kernel.org'
> >>Subject: Re: A problem when restarting OSD
> >>
> >>On Thu, 21 Aug 2014, Wang, Zhiqiang wrote:
> >>> Hi all,
> >>> 
> >>> I ran into a problem when restarting an OSD.
> >>> 
> >>> Here is my OSD tree before restarting the OSD:
> >>> 
> >>> # id    weight  type name       up/down reweight
> >>> -6      8       root ssd
> >>> -4      4               host zqw-s1-ssd
> >>> 16      1                       osd.16  up      1
> >>> 17      1                       osd.17  up      1
> >>> 18      1                       osd.18  up      1
> >>> 19      1                       osd.19  up      1
> >>> -5      4               host zqw-s2-ssd
> >>> 20      1                       osd.20  up      1
> >>> 21      1                       osd.21  up      1
> >>> 22      1                       osd.22  up      1
> >>> 23      1                       osd.23  up      1
> >>> -1      14.56   root default
> >>> -2      7.28            host zqw-s1
> >>> 0       0.91                    osd.0   up      1
> >>> 1       0.91                    osd.1   up      1
> >>> 2       0.91                    osd.2   up      1
> >>> 3       0.91                    osd.3   up      1
> >>> 4       0.91                    osd.4   up      1
> >>> 5       0.91                    osd.5   up      1
> >>> 6       0.91                    osd.6   up      1
> >>> 7       0.91                    osd.7   up      1
> >>> -3      7.28            host zqw-s2
> >>> 8       0.91                    osd.8   up      1
> >>> 9       0.91                    osd.9   up      1
> >>> 10      0.91                    osd.10  up      1
> >>> 11      0.91                    osd.11  up      1
> >>> 12      0.91                    osd.12  up      1
> >>> 13      0.91                    osd.13  up      1
> >>> 14      0.91                    osd.14  up      1
> >>> 15      0.91                    osd.15  up      1
> >>> 
> >>> After I restart one of the OSD with id from 16 to 23, say restarting
> >>>osd.16, osd.16 goes to 'root default' and 'host zqw-s1', and ceph
> >>>cluster begins to do rebalance. This surely is not what I want.
> >>> 
> >>> # id    weight  type name       up/down reweight
> >>> -6      7       root ssd
> >>> -4      3               host zqw-s1-ssd
> >>> 17      1                       osd.17  up      1
> >>> 18      1                       osd.18  up      1
> >>> 19      1                       osd.19  up      1
> >>> -5      4               host zqw-s2-ssd
> >>> 20      1                       osd.20  up      1
> >>> 21      1                       osd.21  up      1
> >>> 22      1                       osd.22  up      1
> >>> 23      1                       osd.23  up      1
> >>> -1      15.56   root default
> >>> -2      8.28            host zqw-s1
> >>> 0       0.91                    osd.0   up      1
> >>> 1       0.91                    osd.1   up      1
> >>> 2       0.91                    osd.2   up      1
> >>> 3       0.91                    osd.3   up      1
> >>> 4       0.91                    osd.4   up      1
> >>> 5       0.91                    osd.5   up      1
> >>> 6       0.91                    osd.6   up      1
> >>> 7       0.91                    osd.7   up      1
> >>> 16      1                       osd.16  up      1
> >>> -3      7.28            host zqw-s2
> >>> 8       0.91                    osd.8   up      1
> >>> 9       0.91                    osd.9   up      1
> >>> 10      0.91                    osd.10  up      1
> >>> 11      0.91                    osd.11  up      1
> >>> 12      0.91                    osd.12  up      1
> >>> 13      0.91                    osd.13  up      1
> >>> 14      0.91                    osd.14  up      1
> >>> 15      0.91                    osd.15  up      1
> >>> 
> >>> After digging into the problem, I find it's because in the ceph init
> >>>script, we change the OSD's crush location in some way. It uses the
> >>>script 'ceph-crush-location' to get the crush location from the
> >>>ceph.conf file for the restarting OSD. If there isn't such an entry in
> >>>ceph.conf, it uses the default one 'host=$(hostname -s) root=default'.
> >>>Since I don't have the crush location configuration in my ceph.conf (I
> >>>guess most of people don't have this in their ceph.conf), when I
> >>>restarting osd.16, it goes to 'root default' and 'host zqw-s1'.
> >>> 
> >>> Here is a fix for this:
> >>> When the ceph init script uses 'ceph osd crush create-or-move' to
> >>> change the OSD's crush location, do a check first, if this OSD is
> >>> already existing in the crush map, return without making the location
> >>> change. This change is at:
> >>> https://github.com/wonzhq/ceph/commit/efdfa23664caa531390d141bd153987
> >>> 8
> >>> 761412fe
> >>> 
> >>> What do you think?
> >>
> >>The goal of this behavior is to allow hot-swapping of devices.  You can
> >>pull disks out of one host and put them in another and the udev
> >>machinery will start up the daemon, update the crush location, and the
> >>disk and data will become available.  It's not 'ideal' in the sense
> >>that there will be rebalancing, but it does make the data available to
> >>the cluster to preserve data safety.
> >>
> >>We haven't come up with a great scheme yet to managing multiple trees
> >>yet.
> >>The idea is that the ceph-crush-location hook can be customized to do
> >>whatever is necessary, for example by putting root=ssd if the device
> >>type appears to be an ssd (maybe look at the sysfs metadata, or put a
> >>marker file in the osd data directory?).  You can point to your own
> >>hook for your environment with
> >>
> >>  osd crush location hook = /path/to/my/script
> >>
> >>sage
> >>
> >>
> >>
> >>--
> >>To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> >>in the body of a message to majordomo@vger.kernel.org More majordomo
> >>info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
