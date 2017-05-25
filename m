From: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Subject: Re: Problem with query and any operation on PGs
Date: Thu, 25 May 2017 13:22:54 +0200
Message-ID: <1316202582.20170525132254@tlen.pl>
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
  <2910218531.20170524233842@tlen.pl>  
  <alpine.DEB.2.11.1705242149300.3646@piezo.novalocal>
  <804507840.20170525000904@tlen.pl>
  <alpine.DEB.2.11.1705242227320.3646@piezo.novalocal>
  <154794248.20170525004623@tlen.pl>
  <alpine.DEB.2.11.1705250200270.3646@piezo.novalocal>
Reply-To: =?iso-8859-2?Q?=A3ukasz_Chrustek?= <skidoo@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx-out.tlen.pl ([193.222.135.140]:47402 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751420AbdEYLW6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 25 May 2017 07:22:58 -0400
In-Reply-To: <alpine.DEB.2.11.1705250200270.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Cze¶æ,

> On Thu, 25 May 2017, £ukasz Chrustek wrote:
>> Cze¶æ,
>> 
>> > On Thu, 25 May 2017, £ukasz Chrustek wrote:
>> >> Cze¶æ,
>> >> 
>> >> > On Wed, 24 May 2017, £ukasz Chrustek wrote:
>> >> >> Hello,
>> >> >> 
>> >> >> >>
>> >> >> >> > This
>> >> >> >> 
>> >> >> >> osd 6 - isn't startable
>> >> >> 
>> >> >> > Disk completely 100% dead, or just borken enough that ceph-osd won't 
>> >> >> > start?  ceph-objectstore-tool can be used to extract a copy of the 2 pgs
>> >> >> > from this osd to recover any important writes on that osd.
>> >> >> 
>> >> >> >> osd 10, 37, 72 are startable
>> >> >> 
>> >> >> > With those started, I'd repeat the original sequence and get a fresh pg
>> >> >> > query to confirm that it still wants just osd.6.
>> >> >> 
>> >> >> > use ceph-objectstore-tool to export the pg from osd.6, stop some other
>> >> >> > ranodm osd (not one of these ones), import the pg into that osd, and start
>> >> >> > again.  once it is up, 'ceph osd lost 6'.  the pg *should* peer at that
>> >> >> > point.  repeat with the same basic process with the other pg.
>> >> >> 
>> >> >> Here is output from ceph-objectstore-tool - also didn't success:
>> >> >> 
>> >> >> https://pastebin.com/7XGAHdKH
>> >> 
>> >> > Hmm, btrfs:
>> >> 
>> >> > 2017-05-24 23:28:58.547456 7f500948e940 -1 
>> >> > filestore(/var/lib/ceph/osd/ceph-84) ERROR: 
>> >> > /var/lib/ceph/osd/ceph-84/current/nosnap exists, not rolling back to avoid
>> >> > losing new data
>> >> 
>> >> > You could try setting --osd-use-stale-snap as suggested.
>> >> 
>> >> Yes... tried... and I simply get rided of 39GB data...
>> 
>> > What does "get rided" mean?
>> 
>> according to this pastebin: https://pastebin.com/QPcpkjg4
>> 
>> ls -R /var/lib/ceph/osd/ceph-33/current/
>> 
>> /var/lib/ceph/osd/ceph-33/current/:
>> 
>> commit_op_seq  omap
>> 
>> 
>> 
>> /var/lib/ceph/osd/ceph-33/current/omap:
>> 
>> 000003.log  CURRENT  LOCK  MANIFEST-000002
>> 
>> earlier there were same data files.

> Yeah, looks like all the data was deleted from the device.  :(

>> >> 
>> >> > Is it the same error with the other one?
>> >> 
>> >> Yes: https://pastebin.com/7XGAHdKH
>> >> 
>> >> 
>> >> 
>> >> 
>> >> > in particular, osd 37 38 48 67 all have incomplete copies of the PG (they
>> >> > are mid-backfill) and 68 has nothing.  Some data is lost unless you can
>> >> > recovery another OSD with that PG.
>> >> 
>> >> > The set of OSDs that might have data are: 6,10,33,72,84
>> >> 
>> >> > If that bears no fruit, then you can force last_backfill to report
>> >> complete on one of those OSDs and it'll think it has all the data even
>> >> though some of it is likely gone.  (We can pick one that is farther
>> >> along... 38 48 and 67 seem to all match.
>> 
>> Can  You  explain  what  do You mean by 'force last_backfill to report
>> complete'  ?  The  current  value  for PG 1.60 is MAX and for 1.165 is
>> 1\/db616165\/rbd_data.ed9979641a9d82.000000000001dcee\/head 

> ceph-objectstore-tool has a mark-complete operation.  Do that one one of
> the OSDs that has the more advanced last_backfill (like the one above).
> After you restart the PG should recover.

It is (https://pastebin.com/Jv2DpcB3) pg dump_stuck BEFORE running:
ceph-objectstore-tool --debug --op mark-complete --pgid 1.165 --data-path /var/lib/ceph/osd/ceph-48 --journal-path /var/lib/ceph/osd/ceph-48/journal --osd-use-stale-snap

as in previous usage of this tool data gone away:

[root@stor5 /var/lib/ceph/osd/ceph-48]# du -sh current
20K     current

[root@stor5 /var/lib/ceph/osd/ceph-48/current]# ls -R
.:
commit_op_seq  nosnap  omap/

./omap:
000011.log  CURRENT  LOCK  LOG  LOG.old  MANIFEST-000010

after running ceph-objectstore-tool it is:

ceph pg dump_stuck
ok
pg_stat state   up      up_primary      acting  acting_primary
1.39    active+remapped+backfilling     [11,4,39]       11      [5,39,70]       5
1.1a9   active+remapped+backfilling     [11,30,3]       11      [0,30,8]        0
1.b     active+remapped+backfilling     [11,36,94]      11      [38,97,70]      38
1.12f   active+remapped+backfilling     [14,11,47]      14      [14,5,69]       14
1.1d2   active+remapped+backfilling     [11,2,38]       11      [0,36,49]       0
1.133   active+remapped+backfilling     [42,11,83]      42      [42,89,21]      42
40.69   stale+active+undersized+degraded        [48]    48      [48]    48
1.9d    active+remapped+backfilling     [39,2,11]       39      [39,2,86]       39
1.a2    active+remapped+backfilling     [11,12,34]      11      [14,35,95]      14
1.10a   active+remapped+backfilling     [11,2,87]       11      [1,87,81]       1
1.70    active+remapped+backfilling     [14,39,11]      14      [14,39,4]       14
1.60    down+remapped+peering   [83,69,68]      83      [9]     9
1.eb    active+remapped+backfilling     [11,18,53]      11      [14,53,69]      14
1.8d    active+remapped+backfilling     [11,0,30]       11      [36,0,30]       36
1.118   active+remapped+backfilling     [34,11,12]      34      [34,20,86]      34
1.121   active+remapped+backfilling     [43,11,35]      43      [43,35,2]       43
1.177   active+remapped+backfilling     [14,1,11]       14      [14,1,38]       14
1.17c   active+remapped+backfilling     [5,94,11]       5       [5,94,7]        5
1.16d   active+remapped+backfilling     [96,11,53]      96      [96,52,9]       96
1.19a   active+remapped+backfilling     [11,0,14]       11      [0,17,35]       0
1.165   down+peering    [39,55,82]      39      [39,55,82]      39
1.1a    active+remapped+backfilling     [36,52,11]      36      [36,52,96]      36
1.e7    active+remapped+backfilling     [11,35,44]      11      [34,44,9]       34


Is there any chance to rescue this cluster ?


-- 
Regards,
 £ukasz Chrustek

