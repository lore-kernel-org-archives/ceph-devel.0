From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Questions about journals, performance and disk utilization.
Date: Tue, 22 Jan 2013 15:16:07 -0600
Message-ID: <50FF0197.6020202@inktank.com>
References: <58f5e24e5ac1a7bfff8fc6b90719ec75@skytech.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:56889 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654Ab3AVVP5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:15:57 -0500
Received: by mail-ie0-f180.google.com with SMTP id c10so12278775ieb.39
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 13:15:57 -0800 (PST)
In-Reply-To: <58f5e24e5ac1a7bfff8fc6b90719ec75@skytech.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin <martin@skytech.dk>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/22/2013 01:59 PM, martin wrote:
> Hi list,
>
> In a mixed SSD & SATA setup (5 or 8 nodes each holding 8x SATA and 4x
> SSD) would it make sense to skip having journals on SSD or is the
> advantage of doing so just too great? We're looking into having 2 pools,
> sata and ssd and will be creating guests belonging into either of these
> groups based on if they require high/heavy io.
>
> Also, we currently lean on going with a very simple setup using a
> serverboard with 8x onboard raid slots (LSI 2308) and 6x onboard sata
> slots and just attach all disks to both onboard controller and onboard
> slots (for cost and simplicity) - and just pass them along as JBOD.
>
> Any suggestions/input about:
> - Would it make sense to drop onboard controller and aim for a better
> controller (cache/battery backed 12-16 port one)
> - Attach another cheapo JBOD card like SAS2008/LSI 2308 etc.
> - or just go with this setup (to keep it simpler and cheaper)

You may be interested in reading some of our past performance articles:

http://ceph.com/community/ceph-performance-part-1-disk-controller-write-throughput/
http://ceph.com/community/ceph-performance-part-2-write-throughput-without-ssd-journals/
http://ceph.com/uncategorized/argonaut-vs-bobtail-performance-preview/

We didn't test the on-board controller on the supermicro MB, but those 
will at least give you some idea of what different controllers can do 
with and without SSDs.

>
> Journals:
> - Would it make sense to kill say 1 ssd and 1 sata and attach 2 fast SSD
> for journals? Or would that be 'redundant' in our case since we already
> have a pool with sata and ssd (we do not expect heavy io in the sata pool)
>
> Rbd striping:
> - Performance - afaik rbd is striped over objects; if one would create
> say a 20GB rbd image would this mostly be striped over very few
> objects/pg (say ~3 nodes as would be min. in our setup) or would one
> expect it to be striped over pretty much the entirety of the nodes (5 or
> 8 in our case) in smaller objects (or even across all OSD?)
>
> Disks:
> - Any advice for SATA disks? I know a vendor like Seagate have their
> 'normal' enterprise disks (ES.3-models) and are also selling their
> cloud-based disks (CS models). Any suggestions/experience what to look
> at/aim at? Or what are people using in general?
>

I've been using 1TB Seagate Constellation Enterprise SATA drives for 
testing and have had mostly good luck (1 or 2 duds out of 36) with no 
failures.  Long term experience for me is that all vendors seem to have 
bad batches here and there.

> Disk utilization:
> - I've noticed in our testsetup that we have several pg's taking up
>  >300GB data each - is this normal? This results in some odd situations
> where disk usage can vary by up to 15-20% (2TB disks). If we adjust the
> weight it eventually means one of these pg will go to another disk and
> it has to copy 300GB data. We're using 0.56.1.
>
> Some output from 'ceph pg dump':
> pg_stat objects mip     degr    unf     bytes   log     disklog state
> state_stamp     v       reported        up      acting  last_scrub
> scrub_stamp     last_deep_scrub deep_scrub_stamp
> 4.5     90772   0       0       0       379301388412    150969  150969
> active+clean    2013-01-22 00:07:13.384272      2827'412414
> 2795'3317565    [1,2]   [1,2]   2827'397587     2013-01-22
> 00:07:13.384225      2744'299767     2013-01-17 05:40:40.737279
>
> Results in disk usage like:
> Filesystem                                              Size  Used Avail
> Use% Mounted on
> /dev/sdd1                                               1.9T  1.4T 446G
> 77% /srv/ceph/osd5
> /dev/sdb1                                               1.4T  1.1T 331G
> 77% /srv/ceph/osd0
> /dev/sda1                                               1.9T  1.4T 442G
> 77% /srv/ceph/osd1
> /dev/sdc1                                               1.9T  1.8T 84G
> 96% /srv/ceph/osd2
>
> If we reweight sdc down (even with 0.00X % at a time) one of those big
> pg's will eventually move to any one of the above disks and the image
> will look exactly the same with the exception another disk will have 96%
> usage instead (I've bumped cluster full % to 98% in this setup).
>

It may (or may not) help to use a power-of-2 number of PGs.  It's 
generally a good idea to do this anyway, so if you haven't set up your 
production cluster yet, you may want to play around with this. 
Basically just take whatever number you were planning on using and round 
it up (or down slightly).  IE if you were going to use 7,000 PGs, round 
up to 8192.

Mark

> Apologies up front if questions like these are not supposed to go to
> this mailling-list.
>
> Any advice/ideas/suggestions are very welcome!
>
> Cheers,
> Martin Nielsen
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

