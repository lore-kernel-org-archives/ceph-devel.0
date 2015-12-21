From: Loic Dachary <loic@dachary.org>
Subject: v10.0.1 Contributor credits
Date: Mon, 21 Dec 2015 01:33:23 +0100
Message-ID: <567748D3.2040105@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="69PCBKhNst1ExQoVwQXvuiVdQ5MIVimCl"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53521 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750847AbbLUAdb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Dec 2015 19:33:31 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 89FB3420AE
	for <ceph-devel@vger.kernel.org>; Mon, 21 Dec 2015 01:33:24 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--69PCBKhNst1ExQoVwQXvuiVdQ5MIVimCl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v10.0.1, by number of commits or reviews back to v10.0.0. The affiliation=
 of
authors to organizations can be updated by submitting a patch to
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the
number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at http://tracker.ceph.com/projects/c=
eph/wiki/Ceph_contributors_list_maintenance_guide

Number of lines added and removed, by authors
     1	 44020 Jason Dillaman <dillaman@redhat.com>
     2	 10457 Sage Weil <sweil@redhat.com>
     3	  3790 Vicente Cheng <freeze.bilsted@gmail.com>
     4	  1665 Mykola Golub <mgolub@mirantis.com>
     5	  1390 Greg Farnum <gfarnum@redhat.com>
     6	  1061 Loic Dachary <ldachary@redhat.com>
     7	   910 David Coles <dcoles@gaikai.com>
     8	   771 Rohan Mars <code@rohanmars.com>
     9	   591 John Spray <jspray@redhat.com>
    10	   449 David Zafman <dzafman@redhat.com>
    11	   381 Xinze Chi <xinze@xsky.com>
    12	   276 Xie Xingguo <xie.xingguo@zte.com.cn>
    13	   252 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    14	   249 Javier M. Mellid <jmunhoz@igalia.com>
    15	   233 MingXin Liu <mingxin.liu@kylin-cloud.com>
    16	   149 Yan, Zheng <zyan@redhat.com>
    17	   117 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    18	   115 Ilya Dryomov <idryomov@redhat.com>
    19	    98 Shu, Xinxin <xinxin.shu@intel.com>
    20	    94 Joe Julian <jjulian@io.com>
    21	    92 Guang Yang <yguang@yahoo-inc.com>
    22	    88 Xiaowei Chen <chen.xiaowei@h3c.com>
    23	    68 Ma Jianpeng <jianpeng.ma@intel.com>
    24	    67 Josh Durgin <jdurgin@redhat.com>
    25	    63 Nathan Cutler <ncutler@suse.com>
    26	    54 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
    27	    50 Dan van der Ster <daniel.vanderster@cern.ch>
    28	    46 Jianhui Yuan <zuiwanyuan@gmail.com>
    29	    30 Li Wang <li.wang@kylin-cloud.com>
    30	    28 Haomai Wang <haomai@xsky.com>
    31	    26 James Page <james.page@ubuntu.com>
    32	    22 Ning Yao <yaoning@ruijie.com.cn>
    33	    18 Yuan Zhou <yuan.zhou@intel.com>
    34	    17 Vasu Kulkarni <vasu.kulkarni@gmail.com>
    35	    16 Yehuda Sadeh <ysadehwe@redhat.com>
    36	    16 Jenkins <jenkins@ceph.com>
    37	    12 Yann Dupont <yann@objoo.org>
    38	    12 Vikhyat Umrao <vumrao@redhat.com>
    39	    11 Rahul Aggarwal <rahul.1aggarwal@gmail.com>
    40	    11 Brian Felton <bjfelton@gmail.com>
    41	     9 Xiaoxi Chen <xiaoxi.chen@intel.com>
    42	     8 Jiaying Ren <mikulely@gmail.com>
    43	     6 Kefu Chai <kchai@redhat.com>
    44	     5 Chengyuan Li <chengyli@ebay.com>
    45	     4 Tobias Suckow <tobias@suckow.biz>
    46	     4 Orit Wasserman <owasserm@redhat.com>
    47	     4 Jie Wang <jie.wang@kylin-cloud.com>
    48	     3 Ren Huanwen <ren.huanwen@zte.com.cn>
    49	     3 Ji Chen <insomnia@139.com>
    50	     2 Zhi Zhang <zhangz.david@outlook.com>
    51	     2 Sangdi Xu <xu.sangdi@h3c.com>
    52	     2 Ruifeng Yang <yangruifeng.09209@h3c.com>
    53	     2 Herv=C3=A9 Rousseau <hroussea@cern.ch>
    54	     2 Chris Holcombe <chris.holcombe@nebula.com>
    55	     2 Brad Hubbard <bhubbard@redhat.com>
    56	     1 Samuel Just <sjust@redhat.com>

Number of lines added and removed, by organization
     1	 58294 Red Hat <contact@redhat.com>
     2	  4675 Unaffiliated <no@organization.net>
     3	  1782 Mirantis <contact@mirantis.com>
     4	   910 Gaikai <contact@gaikai.com>
     5	   409 XSky <contact@xsky.com>
     6	   321 Kylin Cloud <contact@kylin-cloud.com>
     7	   279 ZTE <contact@zte.com.cn>
     8	   252 Fujitsu <contact@fujitsu.com>
     9	   249 Igalia <contact@igalia.com>
    10	   193 Intel <contact@intel.com>
    11	    94 IO <contact@io.com>
    12	    92 Yahoo! <contact@yahoo-inc.com>
    13	    92 H3C <wentao@h3c.com>
    14	    63 SUSE <contact@suse.com>
    15	    62 Inktank <contact@inktank.com>
    16	    52 CERN <contact@cern.ch>
    17	    26 Canonical <contact@canonical.com>
    18	    22 Ruijie Networks <contact@ruijie.com.cn>
    19	     3 LETV <contact@letv.com>
    20	     2 Tencent <contact@tencent.com>
    21	     2 Nebula <info@nebula.com>

Commits, by authors
     1	    121 Jason Dillaman <dillaman@redhat.com>
     2	    107 Sage Weil <sweil@redhat.com>
     3	     20 Vicente Cheng <freeze.bilsted@gmail.com>
     4	     18 Mykola Golub <mgolub@mirantis.com>
     5	     14 Loic Dachary <ldachary@redhat.com>
     6	     12 John Spray <jspray@redhat.com>
     7	     11 Yan, Zheng <zyan@redhat.com>
     8	     11 Greg Farnum <gfarnum@redhat.com>
     9	     10 David Zafman <dzafman@redhat.com>
    10	      9 Xie Xingguo <xie.xingguo@zte.com.cn>
    11	      9 Rohan Mars <code@rohanmars.com>
    12	      9 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    13	      9 Josh Durgin <jdurgin@redhat.com>
    14	      9 Ilya Dryomov <idryomov@redhat.com>
    15	      7 David Coles <dcoles@gaikai.com>
    16	      6 Li Wang <li.wang@kylin-cloud.com>
    17	      5 Xinze Chi <xinze@xsky.com>
    18	      5 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    19	      5 Nathan Cutler <ncutler@suse.com>
    20	      5 MingXin Liu <mingxin.liu@kylin-cloud.com>
    21	      5 Ma Jianpeng <jianpeng.ma@intel.com>
    22	      5 Javier M. Mellid <jmunhoz@igalia.com>
    23	      4 Yann Dupont <yann@objoo.org>
    24	      4 Haomai Wang <haomai@xsky.com>
    25	      3 Joe Julian <jjulian@io.com>
    26	      2 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
    27	      2 Yehuda Sadeh <ysadehwe@redhat.com>
    28	      2 Xiaowei Chen <chen.xiaowei@h3c.com>
    29	      2 Shu, Xinxin <xinxin.shu@intel.com>
    30	      2 Ning Yao <yaoning@ruijie.com.cn>
    31	      2 Ji Chen <insomnia@139.com>
    32	      2 Jiaying Ren <mikulely@gmail.com>
    33	      2 Jenkins <jenkins@ceph.com>
    34	      2 Guang Yang <yguang@yahoo-inc.com>
    35	      2 Dan van der Ster <daniel.vanderster@cern.ch>
    36	      1 Zhi Zhang <zhangz.david@outlook.com>
    37	      1 Yuan Zhou <yuan.zhou@intel.com>
    38	      1 Xiaoxi Chen <xiaoxi.chen@intel.com>
    39	      1 Vikhyat Umrao <vumrao@redhat.com>
    40	      1 Vasu Kulkarni <vasu.kulkarni@gmail.com>
    41	      1 Tobias Suckow <tobias@suckow.biz>
    42	      1 Sangdi Xu <xu.sangdi@h3c.com>
    43	      1 Samuel Just <sjust@redhat.com>
    44	      1 Ruifeng Yang <yangruifeng.09209@h3c.com>
    45	      1 Ren Huanwen <ren.huanwen@zte.com.cn>
    46	      1 Rahul Aggarwal <rahul.1aggarwal@gmail.com>
    47	      1 Orit Wasserman <owasserm@redhat.com>
    48	      1 Kefu Chai <kchai@redhat.com>
    49	      1 Jie Wang <jie.wang@kylin-cloud.com>
    50	      1 Jianhui Yuan <zuiwanyuan@gmail.com>
    51	      1 James Page <james.page@ubuntu.com>
    52	      1 Herv=C3=A9 Rousseau <hroussea@cern.ch>
    53	      1 Chris Holcombe <chris.holcombe@nebula.com>
    54	      1 Chengyuan Li <chengyli@ebay.com>
    55	      1 Brian Felton <bjfelton@gmail.com>
    56	      1 Brad Hubbard <bhubbard@redhat.com>

Commits, by organizations
     1	    311 Red Hat <contact@redhat.com>
     2	     41 Unaffiliated <no@organization.net>
     3	     23 Mirantis <contact@mirantis.com>
     4	     14 Kylin Cloud <contact@kylin-cloud.com>
     5	     10 ZTE <contact@zte.com.cn>
     6	      9 XSky <contact@xsky.com>
     7	      9 Intel <contact@intel.com>
     8	      9 Fujitsu <contact@fujitsu.com>
     9	      7 Gaikai <contact@gaikai.com>
    10	      5 SUSE <contact@suse.com>
    11	      5 Igalia <contact@igalia.com>
    12	      4 H3C <wentao@h3c.com>
    13	      3 IO <contact@io.com>
    14	      3 CERN <contact@cern.ch>
    15	      2 Yahoo! <contact@yahoo-inc.com>
    16	      2 Ruijie Networks <contact@ruijie.com.cn>
    17	      2 LETV <contact@letv.com>
    18	      2 Inktank <contact@inktank.com>
    19	      1 Tencent <contact@tencent.com>
    20	      1 Nebula <info@nebula.com>
    21	      1 Canonical <contact@canonical.com>

Reviews, by authors (one review spans multiple commits)
     1	     19 Kefu Chai <kchai@redhat.com>
     2	     17 Josh Durgin <jdurgin@redhat.com>
     3	     16 Sage Weil <sweil@redhat.com>
     4	     16 Loic Dachary <ldachary@redhat.com>
     5	      9 Jason Dillaman <dillaman@redhat.com>
     6	      8 Yehuda Sadeh <ysadehwe@redhat.com>
     7	      8 Li Wang <li.wang@kylin-cloud.com>
     8	      5 John Spray <jspray@redhat.com>
     9	      4 Samuel Just <sjust@redhat.com>
    10	      4 David Zafman <dzafman@redhat.com>
    11	      3 Ken Dreyer <kdreyer@redhat.com>
    12	      3 Joao Eduardo Luis <joao@suse.de>
    13	      3 Haomai Wang <haomai@xsky.com>
    14	      3 Greg Farnum <gfarnum@redhat.com>
    15	      2 Yan, Zheng <zyan@redhat.com>
    16	      2 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    17	      2 Nathan Cutler <ncutler@suse.com>
    18	      2 Guang Yang <yguang@yahoo-inc.com>
    19	      1 Sebastien Ponce <sebastien.ponce@cern.ch>
    20	      1 David Coles <dcoles@gaikai.com>
    21	      1 Brad Hubbard <bhubbard@redhat.com>
    22	      1 Boris Ranto <branto@redhat.com>

Reviews, by organizations (one review spans multiple commits)
     1	    108 Red Hat <contact@redhat.com>
     2	      8 Kylin Cloud <contact@kylin-cloud.com>
     3	      5 SUSE <contact@suse.com>
     4	      3 XSky <contact@xsky.com>
     5	      2 Yahoo! <contact@yahoo-inc.com>
     6	      2 Fujitsu <contact@fujitsu.com>
     7	      1 Gaikai <contact@gaikai.com>
     8	      1 CERN <contact@cern.ch>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html




--69PCBKhNst1ExQoVwQXvuiVdQ5MIVimCl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZ3SNMACgkQ8dLMyEl6F225igCfaIQLwiyPMWEjABsEdnvQFz1N
9SQAmwRu9/m0k2pD/Ebtbv83fORK8Nl5
=2C4u
-----END PGP SIGNATURE-----

--69PCBKhNst1ExQoVwQXvuiVdQ5MIVimCl--
