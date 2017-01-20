From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: BlueStore: Multi sharded kv pull request
Date: Fri, 20 Jan 2017 23:32:25 +0000
Message-ID: <5E3E05AED7F0F044904275810D0CB465055CCA@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2nam02on0082.outbound.protection.outlook.com ([104.47.38.82]:31616
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752474AbdATXcd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 20 Jan 2017 18:32:33 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Mark Nelson (mnelson@redhat.com)" <mnelson@redhat.com>, "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Mark/Sage,
Please find the different comparison data in the following document.

https://drive.google.com/file/d/0B7W-S0z_ymMJUXVmOUhINU01c3c/view?usp=3Dsha=
ring

Please download the doc (and open in xls) as google is not able to show the=
 graphs properly.

Setup:
------
Single osd on 700G nvme drive and single osd on 2 700G nvme drive (LVM ed)
48 core server, 40G link
Test is only for 4K RW from fio.

1. The first sheet is showing iops and cpu utilization for Bluestor + rocks=
 , Bluestore + Zs and filestore.
This is with small shards and with the hack we are using for preconditionin=
g.
Bluestore + rocks with 16K min_alloc and ZS with 4k min_alloc

WE can see Bluestore with rocks and ZS is behaving almost similarly for a 6=
00G image and it is ~2X higher than filestore. ZS cpu utilization and WA (d=
ata not there in xls) is higher than rocks.

2. Next, I created 3 LVM volumes (data/db/wal) out of 2 NVMe drives and cre=
ated an image of 1TB. See in the next sheet how bluestore + rocks performan=
ce came down. Didn't have time for the filestore data but expectation is it=
 will remain similar to previous sheet. Now, ZS is running with 16k min_all=
oc size here with the prototype shim implementation I was talking about in =
the standup.
This is with this implementation is not fully crash safe but expectation is=
 when we will be done with implementing this write ahead log implementation=
 in ZS it should produce similar throughput.
This is giving ~90% benefir over rocks and ZS with 4k min_alloc (like previ=
ous sheet) is giving ~50% benefit (not plotted here). Cpu util is similar t=
o rocks.


3. This sheet is to demonstrate the benefit of single kv sync vs multi kv s=
ync with rocks. With ZS we *need* multi kv but with rocks as you can see we=
 are gaining (~20%) only during the peak performance.
Later db is getting in the way. I think peak performance is limited to day =
by osd upstream , if in future we can optimize that and allow more traffic =
to come in the Bluestore (objectstore) , the benefit of multiple sharded kv=
 sync will be more. Here is the pull request for this..

https://github.com/ceph/ceph/pull/13037

Thanks & Regards
Somnath

________________________________

PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).

