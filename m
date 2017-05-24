From: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Subject: Re: Problem with query and any operation on PGs
Date: Wed, 24 May 2017 17:54:47 +0200
Message-ID: <806057225.20170524175447@tlen.pl>
References: <175484591.20170523135449@tlen.pl> <483467685.20170523144818@tlen.pl>           
    <alpine.DEB.2.11.1705231415400.3646@piezo.novalocal>     
  <1464688590.20170523185052@tlen.pl>     
  <alpine.DEB.2.11.1705231738520.3646@piezo.novalocal>    
  <1075363645.20170523234331@tlen.pl>   
  <alpine.DEB.2.11.1705232146500.3646@piezo.novalocal>   
  <135176900.20170524151952@tlen.pl>   
  <alpine.DEB.2.11.1705241335190.3646@piezo.novalocal>  
  <1203308391.20170524155848@tlen.pl>  
  <alpine.DEB.2.11.1705241401260.3646@piezo.novalocal>
  <379087365.20170524161815@tlen.pl>
  <alpine.DEB.2.11.1705241444150.3646@piezo.novalocal>
  <419974552.20170524170005@tlen.pl>
  <alpine.DEB.2.11.1705241510290.3646@piezo.novalocal>
Reply-To: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx-out.tlen.pl ([193.222.135.145]:37486 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759445AbdEXPyu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 May 2017 11:54:50 -0400
In-Reply-To: <alpine.DEB.2.11.1705241510290.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hello,

> On Wed, 24 May 2017, 즩kasz Chrustek wrote:

>> Hello,
>> 
>> > On Wed, 24 May 2017, 즩kasz Chrustek wrote:
>> >> Cze뜻,
>> >> 
>> >> > On Wed, 24 May 2017, 즩kasz Chrustek wrote:
>> >> >> Cze뜻,
>> >> >> 
>> >> >> > On Wed, 24 May 2017, 즩kasz Chrustek wrote:
>> >> >> >> Cze뜻,
>> >> >> >> 
>> >> >> >> > On Tue, 23 May 2017, 즩kasz Chrustek wrote:
>> >> >> >> >> Cze뜻,
>> >> >> >> >> 
>> >> >> >> >> > On Tue, 23 May 2017, 즩kasz Chrustek wrote:
>> >> >> >> >> >> I'm  not  sleeping for over 30 hours, and still can't find solution. I
>> >> >> >> >> >> did,      as      You      wrote,     but     turning     off     this
>> >> >> >> >> >> (https://pastebin.com/1npBXeMV) osds didn't resolve issue...
>> >> >> >> >> 
>> >> >> >> >> > The important bit is:
>> >> >> >> >> 
>> >> >> >> >> >             "blocked": "peering is blocked due to down osds",
>> >> >> >> >> >             "down_osds_we_would_probe": [
>> >> >> >> >> >                 6,
>> >> >> >> >> >                 10,
>> >> >> >> >> >                 33,
>> >> >> >> >> >                 37,
>> >> >> >> >> >                 72
>> >> >> >> >> >             ],
>> >> >> >> >> >             "peering_blocked_by": [
>> >> >> >> >> >                 {
>> >> >> >> >> >                     "osd": 6,
>> >> >> >> >> >                     "current_lost_at": 0,
>> >> >> >> >> >                     "comment": "starting or marking this osd lost may let
>> >> >> >> >> > us proceed"
>> >> >> >> >> >                 },
>> >> >> >> >> >                 {
>> >> >> >> >> >                     "osd": 10,
>> >> >> >> >> >                     "current_lost_at": 0,
>> >> >> >> >> >                     "comment": "starting or marking this osd lost may let
>> >> >> >> >> > us proceed"
>> >> >> >> >> >                 },
>> >> >> >> >> >                 {
>> >> >> >> >> >                     "osd": 37,
>> >> >> >> >> >                     "current_lost_at": 0,
>> >> >> >> >> >                     "comment": "starting or marking this osd lost may let
>> >> >> >> >> > us proceed"
>> >> >> >> >> >                 },
>> >> >> >> >> >                 {
>> >> >> >> >> >                     "osd": 72,
>> >> >> >> >> >                     "current_lost_at": 113771,
>> >> >> >> >> >                     "comment": "starting or marking this osd lost may let
>> >> >> >> >> > us proceed"
>> >> 
>> >> > These are the osds (6, 10, 37, 72).
>> >> 
>> >> >> >> >> >                 }
>> >> >> >> >> >             ]
>> >> >> >> >> >         },
>> >> >> >> >> 
>> >> >> >> >> > Are any of those OSDs startable?
>> >> 
>> >> > This
>> >> 
>> >> osd 6 - isn't startable
>> 
>> > Disk completely 100% dead, or just borken enough that ceph-osd won't 
>> > start?  ceph-objectstore-tool can be used to extract a copy of the 2 pgs
>> > from this osd to recover any important writes on that osd.
>> 
>> 2017-05-24 11:21:23.341938 7f6830a36940  0 ceph version 9.2.1 (752b6a3020c3de74e07d2a8b4c5e48dab5a6b6fd), process ceph-osd, pid 1375
>> 2017-05-24 11:21:23.350180 7f6830a36940  0 filestore(/var/lib/ceph/osd/ceph-6) backend btrfs (magic 0x9123683e)
>> 2017-05-24 11:21:23.350610 7f6830a36940  0 genericfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_features: FIEMAP ioctl is supported and appears to work
>> 2017-05-24 11:21:23.350617 7f6830a36940  0 genericfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_features: SEEK_DATA/SEEK_HOLE is disabled via 'filestore seek data hole' config option
>> 2017-05-24 11:21:23.350633 7f6830a36940  0 genericfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_features: splice is supported
>> 2017-05-24 11:21:23.351897 7f6830a36940  0 genericfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_features: syncfs(2) syscall fully supported (by glibc and kernel)
>> 2017-05-24 11:21:23.351951 7f6830a36940  0 btrfsfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_feature: CLONE_RANGE ioctl is supported
>> 2017-05-24 11:21:23.351970 7f6830a36940  0 btrfsfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_feature: failed to create simple subvolume test_subvol: (17) File exists
>> 2017-05-24 11:21:23.351981 7f6830a36940  0 btrfsfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_feature: SNAP_CREATE is supported
>> 2017-05-24 11:21:23.351984 7f6830a36940  0 btrfsfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_feature: SNAP_DESTROY failed: (1) Operation not permitted
>> 2017-05-24 11:21:23.351987 7f6830a36940  0 btrfsfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_feature: failed with EPERM as non-root; remount with -o user_subvol_rm_allowed
>> 2017-05-24 11:21:23.351996 7f6830a36940  0 btrfsfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_feature: snaps enabled, but no SNAP_DESTROY ioctl; DISABLING
>> 2017-05-24 11:21:23.352573 7f6830a36940  0 btrfsfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_feature: START_SYNC is supported (transid 252877)
>> 2017-05-24 11:21:23.353001 7f6830a36940  0 btrfsfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_feature: WAIT_SYNC is supported
>> 2017-05-24 11:21:23.353012 7f6830a36940  0 btrfsfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_feature: removing old async_snap_test
>> 2017-05-24 11:21:23.353016 7f6830a36940  0 btrfsfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_feature: failed to remove old async_snap_test: (1) Operation not permitted
>> 2017-05-24 11:21:23.353021 7f6830a36940  0 btrfsfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_feature: SNAP_CREATE_V2 is supported
>> 2017-05-24 11:21:23.353022 7f6830a36940  0 btrfsfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_feature: SNAP_DESTROY failed: (1) Operation not permitted
>> 2017-05-24 11:21:23.353027 7f6830a36940  0 btrfsfilestorebackend(/var/lib/ceph/osd/ceph-6) detect_feature: failed to remove test_subvol: (1) Operation not permitted
>> 2017-05-24 11:21:23.355156 7f6830a36940  0 filestore(/var/lib/ceph/osd/ceph-6) mount: enabling WRITEAHEAD journal mode: checkpoint is not enabled
>> 2017-05-24 11:21:23.355881 7f6830a36940 -1 filestore(/var/lib/ceph/osd/ceph-6) could not find -1/23c2fcde/osd_superblock/0 in index: (2) No such file or directory
>> 2017-05-24 11:21:23.355891 7f6830a36940 -1 osd.6 0 OSD::init() : unable to read osd superblock
>> 2017-05-24 11:21:23.356411 7f6830a36940 -1 ^[[0;31m ** ERROR: osd init failed: (22) Invalid argument^[[0m
>> 
>> it is all I get for this osd in logs, when I try to start it.
>> 
>> >> osd 10, 37, 72 are startable
>> 
>> > With those started, I'd repeat the original sequence and get a fresh pg
>> > query to confirm that it still wants just osd.6.
>> 
>> You  mean about procedure with loop and taking down OSDs, which broken
>> PGs are pointing to ?
>> pg 1.60 is down+remapped+peering, acting [66,40]
>> pg 1.165 is down+peering, acting [67,88,48]
>> 
>> for pg 1.60 <--> 66 down, then in loop check pg query ?

> Right.

And  now  it  is very weird.... I made osd.37 up, and loop
while true;do; ceph tell 1.165 query ;done

catch this:

https://pastebin.com/zKu06fJn

Can You tell, what is wrong now ?

>> > use ceph-objectstore-tool to export the pg from osd.6, stop some other
>> > ranodm osd (not one of these ones), import the pg into that osd, and start
>> > again.  once it is up, 'ceph osd lost 6'.  the pg *should* peer at that
>> > point.  repeat with the same basic process with the other pg.
>> 
>> I have already did 'ceph osd lost 6', do I need to do this once again ?

> Hmm not sure, if the OSD is empty then there is no harm in doing it again.
> Try that first since it might resolve it.  If not, do the query loop 
> above.

> s



-- 
Regards,,
 즩kasz Chrustek

