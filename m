From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: v9.0.2 Contributor credits
Date: Fri, 17 Jul 2015 11:28:25 +0530
Message-ID: <87io9jfhq6.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35584 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbbGQGCK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jul 2015 02:02:10 -0400
Received: by pactm7 with SMTP id tm7so55586659pac.2
        for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2015 23:02:10 -0700 (PDT)
Received: from trusty ([49.32.0.131])
        by smtp.gmail.com with ESMTPSA id ys3sm9806886pbb.96.2015.07.16.23.02.07
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Jul 2015 23:02:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v9.0.2, by number of commits or reviews back to v9.0.1. The affiliation=
 of
authors to organizations can be updated by submitting a patch to
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the
number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at https://wiki.ceph.com/Community/=
Ceph_contributors_list_maintenance_guide


Number of lines added and removed, by authors
     1	  9065 Loic Dachary <ldachary@redhat.com>
     2	  4859 Jason Dillaman <dillaman@redhat.com>
     3	  4563 Haomai Wang <haomaiwang@gmail.com>
     4	  3679 Sage Weil <sweil@redhat.com>
     5	  2976 David Zafman <dzafman@redhat.com>
     6	  1999 Kefu Chai <kchai@redhat.com>
     7	  1376 Samuel Just <sjust@redhat.com>
     8	   859 John Spray <jspray@redhat.com>
     9	   554 Yan, Zheng <zyan@redhat.com>
    10	   546 Xiaoxi Chen <xiaoxi.chen@intel.com>
    11	   317 Yehuda Sadeh <ysadehwe@redhat.com>
    12	   255 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    13	   206 Pavan Rallabhandi <pavan.rallabhandi@sandisk.com>
    14	   204 Michal Jarzabek <stiopa@gmail.com>
    15	   180 Ilya Dryomov <idryomov@redhat.com>
    16	   154 Owen Synge <osynge@suse.com>
    17	   135 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    18	   115 Mykola Golub <mgolub@mirantis.com>
    19	   107 Casey Bodley <casey@cohortfs.com>
    20	   101 Ma Jianpeng <jianpeng.ma@intel.com>
    21	    86 Raju Kurunkad <raju.kurunkad@sandisk.com>
    22	    84 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    23	    83 Robin H. Johnson <robbat2@gentoo.org>
    24	    82 Ken Dreyer <kdreyer@redhat.com>
    25	    52 Nathan Cutler <ncutler@suse.com>
    26	    51 Jon Bernard <jbernard@tuxion.com>
    27	    49 Tim Serong <tserong@suse.com>
    28	    46 Josh Durgin <jdurgin@redhat.com>
    29	    34 Nilamdyuti Goswami <ngoswami@redhat.com>
    30	    30 Zhiqiang Wang <zhiqiang.wang@intel.com>
    31	    30 Dmitry Yatsushkevich <dyatsushkevich@mirantis.com>
    32	    24 Orit Wasserman <owasserm@redhat.com>
    33	    21 Vasu Kulkarni <vasu@redhat.com>
    34	    21 Fran=C3=A7ois Lafont <flafdivers@free.fr>
    35	    20 Varada Kari <varada.kari@sandisk.com>
    36	    20 Joseph McDonald <joseph.mcdonald@alcatel-lucent.com>
    37	    18 Shu, Xinxin <xinxin.shu@intel.com>
    38	    14 Ilja Slepnev <islepnev@gmail.com>
    39	    13 Yuri Weinstein <yuri.weinstein@redhat.com>
    40	    11 Huang Jun <hjwsm1989@gmail.com>
    41	    10 Greg Farnum <gfarnum@redhat.com>
    42	     8 Jenkins <jenkins@inktank.com>
    43	     7 Douglas Fuller <dfuller@redhat.com>
    44	     6 David Disseldorp <ddiss@suse.de>
    45	     5 Travis Rhoden <trhoden@redhat.com>
    46	     5 Anton Aksola <anton.aksola@nebula.fi>
    47	     4 Xinze Chi <xmdxcxz@gmail.com>
    48	     4 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    49	     4 Henry Chang <henry@bigtera.com>
    50	     4 Boris Ranto <branto@redhat.com>
    51	     4 Alistair Strachan <alistair.strachan@imgtec.com>
    52	     3 Vu Pham <vu@mellanox.com>
    53	     3 Pete Zaitcev <zaitcev@redhat.com>
    54	     2 Zhe Zhang <zzxuanyuan@gmail.com>
    55	     2 Wido den Hollander <wido@42on.com>
    56	     2 Joaquim Rocha <joaquim.rocha@cern.ch>
    57	     2 Ismael Serrano <ismael.serrano@gmail.com>
    58	     1 Ketor Meng <d.ketor@gmail.com>
    59	     1 Javier M. Mellid <jmunhoz@igalia.com>

Number of lines added and removed, by organization
     1	 26098 Red Hat <contact@redhat.com>
     2	  4877 Unaffiliated <no@organization.net>
     3	   695 Intel <contact@intel.com>
     4	   312 SanDisk <contact@sandisk.com>
     5	   261 SUSE <contact@suse.com>
     6	   255 Deutsche Telekom <contact@telekom.de>
     7	   149 Mirantis <contact@mirantis.com>
     8	   135 Reliance Jio Infocomm Ltd. <contact@ril.com>
     9	   107 CohortFS, LLC <contact@cohortfs.com>
    10	    84 Fujitsu <contact@fujitsu.com>
    11	    83 Gentoo <contact@gentoo.org>
    12	    21 Inktank <contact@inktank.com>
    13	    20 Alcatel Lucent <contact@alcatel-lucent.com>
    14	     5 Nebula <info@nebula.com>
    15	     4 Imagination Technologies Ltd. <contact@imgtec.com>
    16	     3 Mellanox <contact@mellanox.com>
    17	     2 Wido 42on <contact@42on.com>
    18	     2 Cloudwatt <libre.licensing@cloudwatt.com>
    19	     2 CERN <contact@cern.ch>
    20	     1 Igalia <contact@igalia.com>

Commits, by authors
     1	    121 Loic Dachary <ldachary@redhat.com>
     2	    100 Jason Dillaman <dillaman@redhat.com>
     3	     56 David Zafman <dzafman@redhat.com>
     4	     47 Kefu Chai <kchai@redhat.com>
     5	     41 Haomai Wang <haomaiwang@gmail.com>
     6	     38 Sage Weil <sweil@redhat.com>
     7	     38 John Spray <jspray@redhat.com>
     8	     32 Samuel Just <sjust@redhat.com>
     9	     22 Yan, Zheng <zyan@redhat.com>
    10	     21 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    11	     11 Xiaoxi Chen <xiaoxi.chen@intel.com>
    12	     11 Owen Synge <osynge@suse.com>
    13	     11 Ma Jianpeng <jianpeng.ma@intel.com>
    14	      8 Ken Dreyer <kdreyer@redhat.com>
    15	      8 Casey Bodley <casey@cohortfs.com>
    16	      7 Yehuda Sadeh <ysadehwe@redhat.com>
    17	      7 Nathan Cutler <ncutler@suse.com>
    18	      7 Ilya Dryomov <idryomov@redhat.com>
    19	      6 Michal Jarzabek <stiopa@gmail.com>
    20	      6 Dmitry Yatsushkevich <dyatsushkevich@mirantis.com>
    21	      5 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    22	      4 Zhiqiang Wang <zhiqiang.wang@intel.com>
    23	      4 Orit Wasserman <owasserm@redhat.com>
    24	      4 Josh Durgin <jdurgin@redhat.com>
    25	      3 Varada Kari <varada.kari@sandisk.com>
    26	      3 Douglas Fuller <dfuller@redhat.com>
    27	      2 Vu Pham <vu@mellanox.com>
    28	      2 Travis Rhoden <trhoden@redhat.com>
    29	      2 Shu, Xinxin <xinxin.shu@intel.com>
    30	      2 Robin H. Johnson <robbat2@gentoo.org>
    31	      2 Pavan Rallabhandi <pavan.rallabhandi@sandisk.com>
    32	      2 Joseph McDonald <joseph.mcdonald@alcatel-lucent.com>
    33	      2 Huang Jun <hjwsm1989@gmail.com>
    34	      2 David Disseldorp <ddiss@suse.de>
    35	      1 Zhe Zhang <zzxuanyuan@gmail.com>
    36	      1 Yuri Weinstein <yuri.weinstein@redhat.com>
    37	      1 Xinze Chi <xmdxcxz@gmail.com>
    38	      1 Wido den Hollander <wido@42on.com>
    39	      1 Vasu Kulkarni <vasu@redhat.com>
    40	      1 Tim Serong <tserong@suse.com>
    41	      1 Raju Kurunkad <raju.kurunkad@sandisk.com>
    42	      1 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    43	      1 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    44	      1 Pete Zaitcev <zaitcev@redhat.com>
    45	      1 Nilamdyuti Goswami <ngoswami@redhat.com>
    46	      1 Mykola Golub <mgolub@mirantis.com>
    47	      1 Ketor Meng <d.ketor@gmail.com>
    48	      1 Jon Bernard <jbernard@tuxion.com>
    49	      1 Joaquim Rocha <joaquim.rocha@cern.ch>
    50	      1 Jenkins <jenkins@inktank.com>
    51	      1 Javier M. Mellid <jmunhoz@igalia.com>
    52	      1 Ismael Serrano <ismael.serrano@gmail.com>
    53	      1 Ilja Slepnev <islepnev@gmail.com>
    54	      1 Henry Chang <henry@bigtera.com>
    55	      1 Greg Farnum <gfarnum@redhat.com>
    56	      1 Fran=C3=A7ois Lafont <flafdivers@free.fr>
    57	      1 Boris Ranto <branto@redhat.com>
    58	      1 Anton Aksola <anton.aksola@nebula.fi>
    59	      1 Alistair Strachan <alistair.strachan@imgtec.com>

Commits, by organizations
     1	    493 Red Hat <contact@redhat.com>
     2	     57 Unaffiliated <no@organization.net>
     3	     28 Intel <contact@intel.com>
     4	     21 SUSE <contact@suse.com>
     5	     21 Deutsche Telekom <contact@telekom.de>
     6	      8 Mirantis <contact@mirantis.com>
     7	      8 CohortFS, LLC <contact@cohortfs.com>
     8	      6 SanDisk <contact@sandisk.com>
     9	      5 Reliance Jio Infocomm Ltd. <contact@ril.com>
    10	      2 Mellanox <contact@mellanox.com>
    11	      2 Inktank <contact@inktank.com>
    12	      2 Gentoo <contact@gentoo.org>
    13	      2 Alcatel Lucent <contact@alcatel-lucent.com>
    14	      1 Wido 42on <contact@42on.com>
    15	      1 Nebula <info@nebula.com>
    16	      1 Imagination Technologies Ltd. <contact@imgtec.com>
    17	      1 Igalia <contact@igalia.com>
    18	      1 Fujitsu <contact@fujitsu.com>
    19	      1 Cloudwatt <libre.licensing@cloudwatt.com>
    20	      1 CERN <contact@cern.ch>

Reviews, by authors (one review spans multiple commits)
     1	     47 Loic Dachary <ldachary@redhat.com>
     2	     35 Kefu Chai <kchai@redhat.com>
     3	     32 Sage Weil <sweil@redhat.com>
     4	     28 Josh Durgin <jdurgin@redhat.com>
     5	     20 Greg Farnum <gfarnum@redhat.com>
     6	     10 Samuel Just <sjust@redhat.com>
     7	     10 Joao Eduardo Luis <joao@suse.de>
     8	      9 Yehuda Sadeh <ysadehwe@redhat.com>
     9	      9 Ken Dreyer <kdreyer@redhat.com>
    10	      8 John Spray <jspray@redhat.com>
    11	      8 Haomai Wang <haomaiwang@gmail.com>
    12	      5 Andreas Peters <andreas.joachim.peters@cern.ch>
    13	      4 Nathan Cutler <ncutler@suse.com>
    14	      4 Jason Dillaman <dillaman@redhat.com>
    15	      2 Travis Rhoden <trhoden@redhat.com>
    16	      2 David Zafman <dzafman@redhat.com>
    17	      2 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    18	      1 Yuan Zhou <yuan.zhou@intel.com>
    19	      1 Varada Kari <varada.kari@sandisk.com>
    20	      1 Takeshi Miyamae <miyamae.takeshi@jp.fujitsu.com>
    21	      1 Shylesh Kumar <shmohan@redhat.com>
    22	      1 Rajesh Nambiar <rajesh.n@msystechnologies.com>
    23	      1 Ning Yao <yaoning@ruijie.com.cn>
    24	      1 Michal Jarzabek <stiopa@gmail.com>
    25	      1 Ma Jianpeng <jianpeng.ma@intel.com>
    26	      1 Kernel Neophyte <neophyte.hacker001@gmail.com>
    27	      1 Ilya Dryomov <idryomov@redhat.com>
    28	      1 Dmitry Yatsushkevich <dyatsushkevich@mirantis.com>
    29	      1 Dan Mick <dmick@redhat.com>
    30	      1 Boris Ranto <branto@redhat.com>

Reviews, by organizations (one review spans multiple commits)
     1	    210 Red Hat <contact@redhat.com>
     2	     14 SUSE <contact@suse.com>
     3	     10 Unaffiliated <no@organization.net>
     4	      5 CERN <contact@cern.ch>
     5	      2 Reliance Jio Infocomm Ltd. <contact@ril.com>
     6	      2 Intel <contact@intel.com>
     7	      1 SanDisk <contact@sandisk.com>
     8	      1 Ruijie Networks <contact@ruijie.com.cn>
     9	      1 MSys Technologies <contact@msystechnologies.com>
    10	      1 Mirantis <contact@mirantis.com>
    11	      1 Fujitsu <contact@fujitsu.com>

Thanks everyone for contributing

Cheers=20
Abhishek
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJVqJmKAAoJEPnwZB8bZe1fK9EH/1oOvrrVRe3yIcTnAIAImiiW
2N+AeMFFRktOrEfjoV+06CJlm3+sf3clz1tqhKd7/8HLslTIGajyzR3BILhK7EJa
UgVDGAU7Sh20+1jzghw0GmoVn2yTt43IUFbGs+6ifTfwgvJ6LAc3yWqhQbfeFaBT
AkFj6q6JDgqUJi0saSh2w9afU5gfU/5q1XlwahhpYMys96gdC4nN9UgHrW2YKWTI
xtZ74Ncn8jWDppUBn0aw4UtG0eEVVtNyRGWO945Tf40iK8T/+G+kkTgbCFriUYTC
u6Gs/lKS7DRE0e6S7EIH/o7RcuPr4hGAjeUmzzCnpOQ2wY9xxYqZ7206KXcSewo=3D
=3DNezT
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
