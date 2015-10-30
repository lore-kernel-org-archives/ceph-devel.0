From: "Xue, Chendi" <chendi.xue@intel.com>
Subject: Specify omap path for filestore
Date: Fri, 30 Oct 2015 02:04:36 +0000
Message-ID: <C8CF870384EBCF4CAB89D2041A5C80B3220030ED@SHSMSX101.ccr.corp.intel.com>
References: <C8CF870384EBCF4CAB89D2041A5C80B322002AB8@SHSMSX101.ccr.corp.intel.com>
 <C8CF870384EBCF4CAB89D2041A5C80B322002D57@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:44301 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbbJ3CEm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Oct 2015 22:04:42 -0400
In-Reply-To: <C8CF870384EBCF4CAB89D2041A5C80B322002D57@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 'Samuel Just' <sjust@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, Sam

Last week I introduced about how we saw the benefit of moving omap to a=
 separate device.

And here is the pull request:
https://github.com/ceph/ceph/pull/6421

I had tested redeploy and restart ceph cluster at my setup, the codes w=
orks fine.
one problem is do you think I should *DELETE* all the files under the o=
map_path firstly? Because I notice if old pg data leaves there, osd dae=
mon may run into chaos. But I am not sure if it should leave to users t=
o DELETE.

Any thoughts?

Also I paste some data I talked , which is about the rbd and osd write =
iops ratio when doing randwrite to a rbd device.

=3D=3D=3D=3D=3D=3DHere is some data=3D=3D=3D=3D=3D
We uses 4 clients , 35 vm each to test on rbd randwrite.
4 osd physical nodes, each has 10 HDD as osd and 2 ssd as journal
2 replica
filestore_max_inline_xattr_xfs=3D0=A0=A0=20
filestore_max_inline_xattr_size_xfs=3D0

Before moving omap to separate ssd, we saw a frontend and backend iops =
ratio of 1:5.8, rbd side total iops 1206, hdd total iops 7034
Like we talked, 5.8 consists of 2 replica write, inode and omap writes
runid=A0=A0=A0=A0=A0=A0=A0=A0 op_size=A0=A0=A0 op_type=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 QD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 engine=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 serverNum=A0=A0=A0=A0=A0=A0 clientNum=
=A0=A0=A0=A0=A0=A0=A0=A0 rbdNum=A0=A0 runtime=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 fio_iops=A0=A0=A0=A0=A0=A0=A0=A0 fio_bw=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 fio_latency=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 osd_iops=A0 =A0=A0=A0=A0=A0=A0=A0=A0 osd_bw=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 osd_latency
332=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4k=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 randwrite=A0=A0=A0=A0=A0=A0=A0=A0 qd8=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 qemurbd=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 140=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 400 sec=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1206.=
000=A0=A0=A0=A0=A0=A0=A0=A0 4.987 MB/s=A0=A0=A0=A0=A0 884.617 msec=A0 =A0=
=A0=A0=A0=A0=A0=A0=A0 7034.975 =A0=A0=A0=A0=A0=A0=A0=A0 47.407 MB/s=A0=A0=
=A0 242.620 msec

And after moving omap to a separate ssd, we saw a frontend vs. backend =
ratio drops to 1:2.6, rbd side total iops 5006, hdd total iops 13089
runid=A0=A0=A0=A0=A0=A0=A0=A0 op_size=A0=A0=A0 op_type=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 QD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 engine=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 serverNum=A0=A0=A0=A0=A0=A0 clientNum=
=A0=A0=A0=A0=A0=A0=A0=A0 rbdNum=A0=A0 runtime=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 fio_iops=A0=A0=A0=A0=A0=A0=A0=A0 fio_bw=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 fio_latency=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 osd_iops=A0 =A0=A0=A0=A0=A0=A0=A0=A0 osd_bw=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 osd_latency
326=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4k=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 randwrite=A0=A0=A0=A0=A0=A0=A0=A0 qd8=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 qemurbd=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 140=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 400 sec=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5006.=
000=A0=A0=A0=A0=A0=A0=A0=A0 19.822 MB/s=A0=A0=A0 222.296 msec=A0 =A0=A0=
=A0=A0=A0=A0=A0=A0 13089.020=A0=A0=A0=A0=A0=A0=A0 82.897 MB/s=A0=A0=A0 =
482.203 msec


Best regards,
Chendi
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
