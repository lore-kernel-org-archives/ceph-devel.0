From: Dan van der Ster <dan@vanderster.com>
Subject: Re: Bluestore cluster example
Date: Fri, 22 Apr 2016 15:38:47 +0200
Message-ID: <CABZ+qqnnOta_Y4rCV8y=v8KKstr==OWa34ryBAOcEH56xSk4tA@mail.gmail.com>
References: <5710D936.9040507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35097 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbcDVNja (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Apr 2016 09:39:30 -0400
Received: by mail-lb0-f170.google.com with SMTP id os9so44136250lbb.2
        for <ceph-devel@vger.kernel.org>; Fri, 22 Apr 2016 06:39:29 -0700 (PDT)
Received: from mail-lf0-f54.google.com (mail-lf0-f54.google.com. [209.85.215.54])
        by smtp.gmail.com with ESMTPSA id z21sm1617944lff.0.2016.04.22.06.39.27
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 22 Apr 2016 06:39:27 -0700 (PDT)
Received: by mail-lf0-f54.google.com with SMTP id e190so79521536lfe.0
        for <ceph-devel@vger.kernel.org>; Fri, 22 Apr 2016 06:39:27 -0700 (PDT)
In-Reply-To: <5710D936.9040507@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: cbt <cbt@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Mark,

On Fri, Apr 15, 2016 at 2:06 PM, Mark Nelson <mnelson@redhat.com> wrote:
> Hi all,
>
> A couple of folks have asked me how to setup bluestore clusters for
> performance testing.  I personally am using cbt for this, but you should be
> able to use ceph-disk with some other cluster creation method as well.
>
> For CBT, you really don't need to do much.  In the old newstore days, a
> "block" symlink needed to be created in the osd data dir to link to the new
> block device.  CBT did this when the "newstore_block: True" option was set
> in the cluster section of the cbt yaml file.  This isn't really needed
> anymore, as you can now specify the block, db, and wal devices directly in
> your ceph.conf file.  If your partitions are setup properly you can create
> bluestore clusters without having to do anything beyond changing the
> ceph.conf file (with cbt at least).
>
> Here's a very basic example:
>
> [global]
>         enable experimental unrecoverable data corrupting features =
> bluestore rocksdb
>         osd objectstore = bluestore
>
> [osd.0]
>         host = incerta01.front.sepia.ceph.com
>         osd data = /tmp/cbt/mnt/osd-device-0-data
>         bluestore block path = /dev/disk/by-partlabel/osd-device-0-block
>         bluestore block db path = /dev/disk/by-partlabel/osd-device-0-db
>         bluestore block wal path = /dev/disk/by-partlabel/osd-device-0-wal

The db and wal paths are optional perf boosting things, right?

If I do ceph-disk prepare --bluestore /dev/sdae, I get:

/dev/sdae :
 /dev/sdae2 ceph block, for /dev/sdae1
 /dev/sdae1 ceph data, active, cluster ceph, osd.413, block /dev/sdae2

-- Dan


>
>
> Here we enable the experimental bluestore and rocksdb features, set the
> objectstore to bluestore, and then in the OSD sections manually set the osd
> data, bluestore block, bluestore block db, and bluestore block wal paths.
> You might be wondering what all of these are for:
>
> osd data <-- very small directory on FS for bootstrapping OSD.
> bluestore block <-- where the actual object data lives
> bluestore block db path <-- where rocksdb lives
> bluestore block wal path <-- where rocksdb writeahead log lives
>
> And that's basically it.  I've uploaded an example partitioning script,
> ceph.conf file, and cbt yaml configuration file based on actual tests I'm
> running to the examples folder that I've actually been using for testing
> here:
>
> https://github.com/ceph/cbt/tree/master/example/bluestore
>
> Thanks,
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
