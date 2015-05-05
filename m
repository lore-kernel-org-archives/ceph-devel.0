From: Loic Dachary <loic@dachary.org>
Subject: v9.0.0 contributors credits
Date: Wed, 06 May 2015 01:39:32 +0200
Message-ID: <554954B4.5010103@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="u4iuraoPhQjDpk57pIFAT2xrRw4EIb6uE"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58190 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753007AbbEEXjf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 May 2015 19:39:35 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 2C2DB42B45
	for <ceph-devel@vger.kernel.org>; Wed,  6 May 2015 01:39:33 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u4iuraoPhQjDpk57pIFAT2xrRw4EIb6uE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to v9.=
0.0, by number of commits or reviews back to v0.94. The affiliation of au=
thors to organizations can be updated by submitting a patch to https://gi=
thub.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the n=
umber of commits. More often than not, the reviewer(s) is only mentioned =
in the message of the merge although it means that all associated commits=
 have been reviewed. If you are curious about how it is done, the details=
 are at https://wiki.ceph.com/Community/Ceph_contributors_list_maintenanc=
e_guide

The number of lines added and removed can be surprisingly high when a dev=
eloper refactors part of the code, transforms a directory into a submodul=
e etc.=20

Number of lines added and removed, by authors
     1	184873 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     2	 34777 Kefu Chai <kchai@redhat.com>
     3	  9643 Sage Weil <sweil@redhat.com>
     4	  8572 Yuan Zhou <yuan.zhou@intel.com>
     5	  4717 John Spray <jspray@redhat.com>
     6	  3828 Nilamdyuti Goswami <ngoswami@redhat.com>
     7	  2167 Yan, Zheng <zyan@redhat.com>
     8	  1991 Haomai Wang <haomaiwang@gmail.com>
     9	  1398 Jason Dillaman <dillaman@redhat.com>
    10	  1380 Loic Dachary <ldachary@redhat.com>
    11	   814 Kiseleva Alyona <akiselyova@mirantis.com>
    12	   794 Xavier Roche <roche+git@exalead.com>
    13	   472 Michal Jarzabek <stiopa@gmail.com>
    14	   440 Zhiqiang Wang <zhiqiang.wang@intel.com>
    15	   311 Ma Jianpeng <jianpeng.ma@intel.com>
    16	   266 Xiaoxi Chen <xiaoxi.chen@intel.com>
    17	   242 Mykola Golub <mgolub@mirantis.com>
    18	   229 Zhi (David) Zhang <zhangz@yahoo-inc.com>
    19	   221 Dmitry Yatsushkevich <dyatsushkevich@mirantis.com>
    20	   214 Noah Watkins <nwatkins@redhat.com>
    21	   179 Yann Dupont <yann@objoo.org>
    22	   162 Douglas Fuller <dfuller@redhat.com>
    23	   149 Takeshi Miyamae <miyamae.takeshi@jp.fujitsu.com>
    24	   136 Yazen Ghannam <yazen.ghannam@linaro.org>
    25	   136 Ilya Dryomov <idryomov@redhat.com>
    26	   134 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    27	   119 Xinze Chi <xmdxcxz@gmail.com>
    28	   110 Josh Durgin <jdurgin@redhat.com>
    29	   108 Alexandre Marangone <amarango@redhat.com>
    30	   105 Rajesh Nambiar <rajesh.n@msystechnologies.com>
    31	   102 Robin Dehu <robindehu@gmail.com>
    32	   102 Dmytro Iurchenko <diurchenko@mirantis.com>
    33	   100 Yehuda Sadeh <ysadehwe@redhat.com>
    34	    88 Travis Rhoden <trhoden@redhat.com>
    35	    69 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    36	    68 Alfredo Deza <adeza@redhat.com>
    37	    63 Matt Benjamin <matt@cohortfs.com>
    38	    56 Ken Dreyer <kdreyer@redhat.com>
    39	    54 Raju Kurunkad <raju.kurunkad@sandisk.com>
    40	    46 Ning Yao <yaoning@ruijie.com.cn>
    41	    40 Vu Pham <vu@mellanox.com>
    42	    40 Orit Wasserman <owasserm@redhat.com>
    43	    28 Vartika Rai <vartikarai17@gmail.com>
    44	    20 Guang Yang <yguang@yahoo-inc.com>
    45	    18 Ian Kelling <ian@iankelling.org>
    46	    16 Andreas Peters <andreas.joachim.peters@cern.ch>
    47	    13 Lee Revell <rlrevell@gmail.com>
    48	    12 Greg Farnum <gfarnum@redhat.com>
    49	    12 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
    50	    12 Dan van der Ster <daniel.vanderster@cern.ch>
    51	    11 David Zafman <dzafman@redhat.com>
    52	    10 Thomas Johnson <NTmatter@gmail.com>
    53	    10 Shu, Xinxin <xinxin.shu@intel.com>
    54	     9 James Page <james.page@ubuntu.com>
    55	     8 Jenkins <jenkins@inktank.com>
    56	     8 Florian Haas <florian@hastexo.com>
    57	     7 Xiong Yiliang <xiongyiliang@xunlei.com>
    58	     6 Samuel Just <sjust@redhat.com>
    59	     6 Neha Ummareddy <nehaummareddy@gmail.com>
    60	     6 Bosse Klykken <larkly@gmail.com>
    61	     5 Swami Reddy <swami.reddy@ril.com>
    62	     5 Javier Guerra <javier@guerrag.com>
    63	     4 Gregory Meno <gmeno@redhat.com>
    64	     2 Zhicheng Wei <zhicheng@opensourceforge.net>
    65	     2 Xingyi Wu <wuxingyi2015@outlook.com>
    66	     2 Vicente Cheng <freeze.bilsted@gmail.com>
    67	     2 Pete Zaitcev <zaitcev@redhat.com>
    68	     2 Florian Marsylle <florian.marsylle@hotmail.fr>
    69	     2 Fabio Alessandro Locati <fabiolocati@gmail.com>
    70	     2 Andy Allan <andy@gravitystorm.co.uk>
    71	     2 Alexis Normand <n.al3xis@gmail.com>
    72	     0 Patrick McGarry <pmcgarry@redhat.com>

Number of lines added and removed, by organization
     1	184873 Deutsche Telekom <contact@telekom.de>
     2	 59027 Red Hat <contact@redhat.com>
     3	  9599 Intel <contact@intel.com>
     4	  2982 Unaffiliated <no@organization.net>
     5	  1448 Mirantis <contact@mirantis.com>
     6	   794 Exalead <contact@exalead.com>
     7	   249 Yahoo! <contact@yahoo-inc.com>
     8	   149 Fujitsu <contact@fujitsu.com>
     9	   139 Reliance Jio Infocomm Ltd. <contact@ril.com>
    10	   136 Linaro <contact@linaro.org>
    11	   105 MSys Technologies <contact@msystechnologies.com>
    12	    63 CohortFS, LLC <contact@cohortfs.com>
    13	    54 SanDisk <contact@sandisk.com>
    14	    46 Ruijie Networks <contact@ruijie.com.cn>
    15	    40 Mellanox <contact@mellanox.com>
    16	    28 CERN <contact@cern.ch>
    17	     9 Canonical <contact@canonical.com>
    18	     8 Inktank <contact@inktank.com>
    19	     8 Hastexo <contact@hastexo.com>

Commits, by authors
     1	     70 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     2	     69 John Spray <jspray@redhat.com>
     3	     50 Loic Dachary <ldachary@redhat.com>
     4	     48 Sage Weil <sweil@redhat.com>
     5	     46 Haomai Wang <haomaiwang@gmail.com>
     6	     41 Yan, Zheng <zyan@redhat.com>
     7	     40 Kefu Chai <kchai@redhat.com>
     8	     37 Yann Dupont <yann@objoo.org>
     9	     34 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    10	     24 Jason Dillaman <dillaman@redhat.com>
    11	     21 Nilamdyuti Goswami <ngoswami@redhat.com>
    12	     19 Ma Jianpeng <jianpeng.ma@intel.com>
    13	     12 Zhiqiang Wang <zhiqiang.wang@intel.com>
    14	      9 Xinze Chi <xmdxcxz@gmail.com>
    15	      9 Kiseleva Alyona <akiselyova@mirantis.com>
    16	      8 Yehuda Sadeh <ysadehwe@redhat.com>
    17	      8 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    18	      8 Ken Dreyer <kdreyer@redhat.com>
    19	      7 Xavier Roche <roche+git@exalead.com>
    20	      7 Noah Watkins <nwatkins@redhat.com>
    21	      6 Josh Durgin <jdurgin@redhat.com>
    22	      5 Mykola Golub <mgolub@mirantis.com>
    23	      5 Ilya Dryomov <idryomov@redhat.com>
    24	      4 Xiaoxi Chen <xiaoxi.chen@intel.com>
    25	      4 David Zafman <dzafman@redhat.com>
    26	      3 Travis Rhoden <trhoden@redhat.com>
    27	      3 Swami Reddy <swami.reddy@ril.com>
    28	      3 Rajesh Nambiar <rajesh.n@msystechnologies.com>
    29	      3 Matt Benjamin <matt@cohortfs.com>
    30	      3 Guang Yang <yguang@yahoo-inc.com>
    31	      3 Greg Farnum <gfarnum@redhat.com>
    32	      3 Dmitry Yatsushkevich <dyatsushkevich@mirantis.com>
    33	      3 Alfredo Deza <adeza@redhat.com>
    34	      2 Yuan Zhou <yuan.zhou@intel.com>
    35	      2 Vu Pham <vu@mellanox.com>
    36	      2 Thomas Johnson <NTmatter@gmail.com>
    37	      2 Raju Kurunkad <raju.kurunkad@sandisk.com>
    38	      2 Michal Jarzabek <stiopa@gmail.com>
    39	      2 Lee Revell <rlrevell@gmail.com>
    40	      2 Javier Guerra <javier@guerrag.com>
    41	      2 Florian Haas <florian@hastexo.com>
    42	      2 Douglas Fuller <dfuller@redhat.com>
    43	      2 Dmytro Iurchenko <diurchenko@mirantis.com>
    44	      2 Dan van der Ster <daniel.vanderster@cern.ch>
    45	      2 Bosse Klykken <larkly@gmail.com>
    46	      1 Zhi (David) Zhang <zhangz@yahoo-inc.com>
    47	      1 Zhicheng Wei <zhicheng@opensourceforge.net>
    48	      1 Yazen Ghannam <yazen.ghannam@linaro.org>
    49	      1 Xiong Yiliang <xiongyiliang@xunlei.com>
    50	      1 Xingyi Wu <wuxingyi2015@outlook.com>
    51	      1 Vicente Cheng <freeze.bilsted@gmail.com>
    52	      1 Vartika Rai <vartikarai17@gmail.com>
    53	      1 Takeshi Miyamae <miyamae.takeshi@jp.fujitsu.com>
    54	      1 Shu, Xinxin <xinxin.shu@intel.com>
    55	      1 Samuel Just <sjust@redhat.com>
    56	      1 Robin Dehu <robindehu@gmail.com>
    57	      1 Pete Zaitcev <zaitcev@redhat.com>
    58	      1 Patrick McGarry <pmcgarry@redhat.com>
    59	      1 Orit Wasserman <owasserm@redhat.com>
    60	      1 Ning Yao <yaoning@ruijie.com.cn>
    61	      1 Neha Ummareddy <nehaummareddy@gmail.com>
    62	      1 Jenkins <jenkins@inktank.com>
    63	      1 James Page <james.page@ubuntu.com>
    64	      1 Ian Kelling <ian@iankelling.org>
    65	      1 Gregory Meno <gmeno@redhat.com>
    66	      1 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
    67	      1 Florian Marsylle <florian.marsylle@hotmail.fr>
    68	      1 Fabio Alessandro Locati <fabiolocati@gmail.com>
    69	      1 Andy Allan <andy@gravitystorm.co.uk>
    70	      1 Andreas Peters <andreas.joachim.peters@cern.ch>
    71	      1 Alexis Normand <n.al3xis@gmail.com>
    72	      1 Alexandre Marangone <amarango@redhat.com>

Commits, by organizations
     1	    348 Red Hat <contact@redhat.com>
     2	    115 Unaffiliated <no@organization.net>
     3	     70 Deutsche Telekom <contact@telekom.de>
     4	     38 Intel <contact@intel.com>
     5	     37 Reliance Jio Infocomm Ltd. <contact@ril.com>
     6	     27 Mirantis <contact@mirantis.com>
     7	      7 Exalead <contact@exalead.com>
     8	      4 Yahoo! <contact@yahoo-inc.com>
     9	      3 MSys Technologies <contact@msystechnologies.com>
    10	      3 CohortFS, LLC <contact@cohortfs.com>
    11	      3 CERN <contact@cern.ch>
    12	      2 SanDisk <contact@sandisk.com>
    13	      2 Mellanox <contact@mellanox.com>
    14	      2 Hastexo <contact@hastexo.com>
    15	      1 Ruijie Networks <contact@ruijie.com.cn>
    16	      1 Linaro <contact@linaro.org>
    17	      1 Inktank <contact@inktank.com>
    18	      1 Fujitsu <contact@fujitsu.com>
    19	      1 Canonical <contact@canonical.com>

Reviews, by authors (one review spans multiple commits)
     1	     76 Loic Dachary <ldachary@redhat.com>
     2	     34 Kefu Chai <kchai@redhat.com>
     3	     30 Sage Weil <sweil@redhat.com>
     4	     26 Josh Durgin <jdurgin@redhat.com>
     5	     24 Greg Farnum <gfarnum@redhat.com>
     6	     15 Yehuda Sadeh <ysadehwe@redhat.com>
     7	     15 John Spray <jspray@redhat.com>
     8	      6 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     9	      5 Ken Dreyer <kdreyer@redhat.com>
    10	      4 Haomai Wang <haomaiwang@gmail.com>
    11	      3 Samuel Just <sjust@redhat.com>
    12	      2 Zhi (David) Zhang <zhangz@yahoo-inc.com>
    13	      2 Yann Dupont <yann@objoo.org>
    14	      2 Simon Guinot <simon.guinot@sequanux.org>
    15	      2 Owen Synge <osynge@suse.com>
    16	      2 Joao Eduardo Luis <joao@suse.de>
    17	      2 Dan Mick <dmick@redhat.com>
    18	      2 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    19	      1 Yuri Weinstein <yuriw@redhat.com>
    20	      1 Yan, Zheng <zyan@redhat.com>
    21	      1 Travis Rhoden <trhoden@redhat.com>
    22	      1 Steve Capper <steve.capper@linaro.org>
    23	      1 Raju Kurunkad <Raju.Kurunkad@sandisk.com>
    24	      1 Jian Wen <wenjian@letv.com>
    25	      1 Jason Dillaman <dillaman@redhat.com>
    26	      1 James Page <james.page@ubuntu.com>
    27	      1 David Zafman <dzafman@redhat.com>
    28	      1 Billy Olsen <billy.olsen@canonical.com>
    29	      1 Andrew Bartlett <abartlet@catalyst.net.nz>
    30	      1 Alistair Israel <aisrael@gmail.com>
    31	      1 Alfredo Deza <adeza@redhat.com>

Reviews, by organizations (one review spans multiple commits)
     1	    234 Red Hat <contact@redhat.com>
     2	      9 Unaffiliated <no@organization.net>
     3	      6 Deutsche Telekom <contact@telekom.de>
     4	      3 SUSE <contact@suse.com>
     5	      3 Cloudwatt <libre.licensing@cloudwatt.com>
     6	      2 Yahoo! <contact@yahoo-inc.com>
     7	      2 Reliance Jio Infocomm Ltd. <contact@ril.com>
     8	      2 Canonical <contact@canonical.com>
     9	      1 SanDisk <contact@sandisk.com>
    10	      1 Linaro <contact@linaro.org>
    11	      1 Catalyst <enquiries@catalyst.net.nz>
    12	      1 Acaleph <contact@acale.ph>



Cheers



--u4iuraoPhQjDpk57pIFAT2xrRw4EIb6uE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVJVLQACgkQ8dLMyEl6F20fmgCcCzn+nHYeHFlzIK54XVqZl2WG
/+cAmwavBeLA2H9OlmKoQchmP6ltYDYD
=Xzr2
-----END PGP SIGNATURE-----

--u4iuraoPhQjDpk57pIFAT2xrRw4EIb6uE--
