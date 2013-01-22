From: martin <martin@skytech.dk>
Subject: Questions about journals, performance and disk utilization.
Date: Tue, 22 Jan 2013 20:59:35 +0100
Message-ID: <58f5e24e5ac1a7bfff8fc6b90719ec75@skytech.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.skytech.dk ([95.154.26.34]:43910 "EHLO
	mailserver.skytech.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755195Ab3AVUIt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 15:08:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailserver.skytech.dk (Postfix) with ESMTP id AEAC7645DC6
	for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 20:59:51 +0100 (CET)
Received: from mailserver.skytech.dk ([127.0.0.1])
	by localhost (mailserver.skytech.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ihigECzaN5ei for <ceph-devel@vger.kernel.org>;
	Tue, 22 Jan 2013 20:59:36 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi list,

In a mixed SSD & SATA setup (5 or 8 nodes each holding 8x SATA and 4x 
SSD) would it make sense to skip having journals on SSD or is the 
advantage of doing so just too great? We're looking into having 2 pools, 
sata and ssd and will be creating guests belonging into either of these 
groups based on if they require high/heavy io.

Also, we currently lean on going with a very simple setup using a 
serverboard with 8x onboard raid slots (LSI 2308) and 6x onboard sata 
slots and just attach all disks to both onboard controller and onboard 
slots (for cost and simplicity) - and just pass them along as JBOD.

Any suggestions/input about:
- Would it make sense to drop onboard controller and aim for a better 
controller (cache/battery backed 12-16 port one)
- Attach another cheapo JBOD card like SAS2008/LSI 2308 etc.
- or just go with this setup (to keep it simpler and cheaper)

Journals:
- Would it make sense to kill say 1 ssd and 1 sata and attach 2 fast 
SSD for journals? Or would that be 'redundant' in our case since we 
already have a pool with sata and ssd (we do not expect heavy io in the 
sata pool)

Rbd striping:
- Performance - afaik rbd is striped over objects; if one would create 
say a 20GB rbd image would this mostly be striped over very few 
objects/pg (say ~3 nodes as would be min. in our setup) or would one 
expect it to be striped over pretty much the entirety of the nodes (5 or 
8 in our case) in smaller objects (or even across all OSD?)

Disks:
- Any advice for SATA disks? I know a vendor like Seagate have their 
'normal' enterprise disks (ES.3-models) and are also selling their 
cloud-based disks (CS models). Any suggestions/experience what to look 
at/aim at? Or what are people using in general?

Disk utilization:
- I've noticed in our testsetup that we have several pg's taking up 
 >300GB data each - is this normal? This results in some odd situations 
where disk usage can vary by up to 15-20% (2TB disks). If we adjust the 
weight it eventually means one of these pg will go to another disk and 
it has to copy 300GB data. We're using 0.56.1.

Some output from 'ceph pg dump':
pg_stat objects mip     degr    unf     bytes   log     disklog state   
state_stamp     v       reported        up      acting  last_scrub      
scrub_stamp     last_deep_scrub deep_scrub_stamp
4.5     90772   0       0       0       379301388412    150969  150969  
active+clean    2013-01-22 00:07:13.384272      2827'412414     
2795'3317565    [1,2]   [1,2]   2827'397587     2013-01-22 
00:07:13.384225      2744'299767     2013-01-17 05:40:40.737279

Results in disk usage like:
Filesystem                                              Size  Used 
Avail Use% Mounted on
/dev/sdd1                                               1.9T  1.4T  
446G  77% /srv/ceph/osd5
/dev/sdb1                                               1.4T  1.1T  
331G  77% /srv/ceph/osd0
/dev/sda1                                               1.9T  1.4T  
442G  77% /srv/ceph/osd1
/dev/sdc1                                               1.9T  1.8T   
84G  96% /srv/ceph/osd2

If we reweight sdc down (even with 0.00X % at a time) one of those big 
pg's will eventually move to any one of the above disks and the image 
will look exactly the same with the exception another disk will have 96% 
usage instead (I've bumped cluster full % to 98% in this setup).

Apologies up front if questions like these are not supposed to go to 
this mailling-list.

Any advice/ideas/suggestions are very welcome!

Cheers,
Martin Nielsen
