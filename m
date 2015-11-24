From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: v10.0.0 Contributor Credits
Date: Tue, 24 Nov 2015 10:59:04 +0530
Message-ID: <87610st17j.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35131 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbbKXFft convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Nov 2015 00:35:49 -0500
Received: by pacej9 with SMTP id ej9so10000778pac.2
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 21:35:49 -0800 (PST)
Received: from trusty ([14.99.123.111])
        by smtp.gmail.com with ESMTPSA id sm8sm12503172pac.43.2015.11.23.21.35.46
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 23 Nov 2015 21:35:48 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Everybody,

The first development release of Jewel v10.0.0 is out
This is a sorted list of authors and organizations who contributed to
v10.0.0, by number of commits or reviews back to the previous release o=
f
v9.2.0

The affiliation of authors to organizations can be updated by
submitting a patch to
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the
number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at
http://tracker.ceph.com/projects/ceph/wiki/Ceph_contributors_list_maint=
enance_guide

Thanks again for contributing & making Ceph better.

Number of lines added and removed, by authors
     1	  8209 Sage Weil <sweil@redhat.com>
     2	  1799 David Zafman <dzafman@redhat.com>
     3	   926 Zhiqiang Wang <zhiqiang.wang@intel.com>
     4	   665 Shu, Xinxin <xinxin.shu@intel.com>
     5	   598 John Spray <jspray@redhat.com>
     6	   542 Loic Dachary <ldachary@redhat.com>
     7	   425 Jashan Kamboj <jashank42@gmail.com>
     8	   419 Guang Yang <yguang@yahoo-inc.com>
     9	   330 Nishtha Rai <nishtha3rai@gmail.com>
    10	   319 Boris Ranto <branto@redhat.com>
    11	   295 Jacek J. Lakis <jacek.lakis@intel.com>
    12	   151 Jason Dillaman <dillaman@redhat.com>
    13	   135 ritz303 <ritz_303@yahoo.com>
    14	   106 Daniel Gryniewicz <dang@redhat.com>
    15	   101 Adam Kupczyk <akupczyk@mirantis.com>
    16	   100 Yan, Zheng <zyan@redhat.com>
    17	    96 Joaquim Rocha <joaquim.rocha@cern.ch>
    18	    94 John Coyle <dx9err@gmail.com>
    19	    78 Alfredo Deza <adeza@redhat.com>
    20	    76 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    21	    69 Ruifeng Yang <yangruifeng.09209@h3c.com>
    22	    58 Ken Dreyer <kdreyer@redhat.com>
    23	    48 Swami Reddy <swami.reddy@ril.com>
    24	    45 Zeqiang Zhuang <zhuang.zeqiang@h3c.com>
    25	    44 Wido den Hollander <wido@42on.com>
    26	    42 Ma Jianpeng <jianpeng.ma@intel.com>
    27	    36 Qiankun Zheng <zheng.qiankun@h3c.com>
    28	    34 Weijun Duan <duanweijun@h3c.com>
    29	    32 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    30	    26 Kefu Chai <kchai@redhat.com>
    31	    24 Wei Luo <weilluo@tencent.com>
    32	    20 Xie Xingguo <xie.xingguo@zte.com.cn>
    33	    20 Rohan Mars <code@rohanmars.com>
    34	    20 Javier M. Mellid <jmunhoz@igalia.com>
    35	    17 Orit Wasserman <owasserm@redhat.com>
    36	    14 Yuan Zhou <yuan.zhou@intel.com>
    37	    14 Vicente Cheng <freeze.bilsted@gmail.com>
    38	    14 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    39	    13 Nathan Cutler <ncutler@suse.com>
    40	    12 Douglas Fuller <dfuller@redhat.com>
    41	     9 Jevon Qiao <qiaojianfeng@unitedstack.com>
    42	     8 Jenkins <jenkins@ceph.com>
    43	     6 Zengran Zhang <zhangzengran@h3c.com>
    44	     6 Bo Cai <cai.bo@h3c.com>
    45	     5 Wenjun Huang <wenjunhuang@tencent.com>
    46	     4 You Ji <youji@ebay.com>
    47	     4 Michal Jarzabek <stiopa@gmail.com>
    48	     3 Xiaoxi Chen <xiaoxi.chen@intel.com>
    49	     3 Sangdi Xu <xu.sangdi@h3c.com>
    50	     2 Zhi Zhang <zhangz.david@outlook.com>
    51	     2 YankunLi <YankunLi@users.noreply.github.com>
    52	     2 runsisi <runsisi@hust.edu.cn>
    53	     2 Brad Hubbard <bhubbard@redhat.com>
    54	     1 Xiaowei Chen <chen.xiaowei@h3c.com>

Number of lines added and removed, by organization
     1	 12025 Red Hat <contact@redhat.com>
     2	  1945 Intel <contact@intel.com>
     3	  1024 Unaffiliated <no@organization.net>
     4	   419 Yahoo! <contact@yahoo-inc.com>
     5	   200 H3C <wentao@h3c.com>
     6	   115 Mirantis <contact@mirantis.com>
     7	    96 CERN <contact@cern.ch>
     8	    80 Reliance Jio Infocomm Ltd. <contact@ril.com>
     9	    76 Fujitsu <contact@fujitsu.com>
    10	    44 Wido 42on <contact@42on.com>
    11	    31 Tencent <contact@tencent.com>
    12	    20 ZTE <contact@zte.com.cn>
    13	    20 Igalia <contact@igalia.com>
    14	    13 SUSE <contact@suse.com>
    15	     9 UnitedStack <contact@unitedstack.com>
    16	     4 Ebay <contact@ebay.com>
    17	     2 Huazhong University of Science and Technology <contact@hu=
st.edu.cn>

Commits, by authors
     1	     79 Sage Weil <sweil@redhat.com>
     2	     38 Swami Reddy <swami.reddy@ril.com>
     3	     28 David Zafman <dzafman@redhat.com>
     4	     27 Jashan Kamboj <jashank42@gmail.com>
     5	     16 Nishtha Rai <nishtha3rai@gmail.com>
     6	     15 Loic Dachary <ldachary@redhat.com>
     7	     13 Zhiqiang Wang <zhiqiang.wang@intel.com>
     8	     13 John Coyle <dx9err@gmail.com>
     9	     10 Shu, Xinxin <xinxin.shu@intel.com>
    10	      8 John Spray <jspray@redhat.com>
    11	      7 Yan, Zheng <zyan@redhat.com>
    12	      7 Xie Xingguo <xie.xingguo@zte.com.cn>
    13	      7 Guang Yang <yguang@yahoo-inc.com>
    14	      4 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    15	      4 Boris Ranto <branto@redhat.com>
    16	      3 Yuan Zhou <yuan.zhou@intel.com>
    17	      3 Weijun Duan <duanweijun@h3c.com>
    18	      3 ritz303 <ritz_303@yahoo.com>
    19	      3 Ma Jianpeng <jianpeng.ma@intel.com>
    20	      3 Kefu Chai <kchai@redhat.com>
    21	      3 Joaquim Rocha <joaquim.rocha@cern.ch>
    22	      3 Jason Dillaman <dillaman@redhat.com>
    23	      3 Daniel Gryniewicz <dang@redhat.com>
    24	      2 Vicente Cheng <freeze.bilsted@gmail.com>
    25	      2 Ruifeng Yang <yangruifeng.09209@h3c.com>
    26	      2 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    27	      2 Ken Dreyer <kdreyer@redhat.com>
    28	      2 Jacek J. Lakis <jacek.lakis@intel.com>
    29	      2 Alfredo Deza <adeza@redhat.com>
    30	      1 Zhi Zhang <zhangz.david@outlook.com>
    31	      1 Zeqiang Zhuang <zhuang.zeqiang@h3c.com>
    32	      1 Zengran Zhang <zhangzengran@h3c.com>
    33	      1 You Ji <youji@ebay.com>
    34	      1 YankunLi <YankunLi@users.noreply.github.com>
    35	      1 Xiaoxi Chen <xiaoxi.chen@intel.com>
    36	      1 Xiaowei Chen <chen.xiaowei@h3c.com>
    37	      1 Wido den Hollander <wido@42on.com>
    38	      1 Wenjun Huang <wenjunhuang@tencent.com>
    39	      1 Wei Luo <weilluo@tencent.com>
    40	      1 Sangdi Xu <xu.sangdi@h3c.com>
    41	      1 runsisi <runsisi@hust.edu.cn>
    42	      1 Rohan Mars <code@rohanmars.com>
    43	      1 Qiankun Zheng <zheng.qiankun@h3c.com>
    44	      1 Orit Wasserman <owasserm@redhat.com>
    45	      1 Nathan Cutler <ncutler@suse.com>
    46	      1 Michal Jarzabek <stiopa@gmail.com>
    47	      1 Jevon Qiao <qiaojianfeng@unitedstack.com>
    48	      1 Jenkins <jenkins@ceph.com>
    49	      1 Javier M. Mellid <jmunhoz@igalia.com>
    50	      1 Douglas Fuller <dfuller@redhat.com>
    51	      1 Brad Hubbard <bhubbard@redhat.com>
    52	      1 Bo Cai <cai.bo@h3c.com>
    53	      1 Adam Kupczyk <akupczyk@mirantis.com>
    54	      1 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>

Commits, by organizations
     1	    158 Red Hat <contact@redhat.com>
     2	     64 Unaffiliated <no@organization.net>
     3	     39 Reliance Jio Infocomm Ltd. <contact@ril.com>
     4	     32 Intel <contact@intel.com>
     5	     11 H3C <wentao@h3c.com>
     6	      7 ZTE <contact@zte.com.cn>
     7	      7 Yahoo! <contact@yahoo-inc.com>
     8	      4 Fujitsu <contact@fujitsu.com>
     9	      3 Tencent <contact@tencent.com>
    10	      3 Mirantis <contact@mirantis.com>
    11	      3 CERN <contact@cern.ch>
    12	      1 Wido 42on <contact@42on.com>
    13	      1 UnitedStack <contact@unitedstack.com>
    14	      1 SUSE <contact@suse.com>
    15	      1 Igalia <contact@igalia.com>
    16	      1 Huazhong University of Science and Technology <contact@h=
ust.edu.cn>
    17	      1 Ebay <contact@ebay.com>

Reviews, by authors (one review spans multiple commits)
     1	     21 Sage Weil <sweil@redhat.com>
     2	     21 Kefu Chai <kchai@redhat.com>
     3	     19 Loic Dachary <ldachary@redhat.com>
     4	     15 Yehuda Sadeh <ysadehwe@redhat.com>
     5	      5 Jason Dillaman <dillaman@redhat.com>
     6	      4 Samuel Just <sjust@redhat.com>
     7	      4 Greg Farnum <gfarnum@redhat.com>
     8	      3 Nathan Cutler <ncutler@suse.com>
     9	      2 Yan, Zheng <zyan@redhat.com>
    10	      2 Ken Dreyer <kdreyer@redhat.com>
    11	      2 Josh Durgin <jdurgin@redhat.com>
    12	      2 John Spray <jspray@redhat.com>
    13	      2 David Zafman <dzafman@redhat.com>
    14	      1 Vicente Cheng <freeze.bilsted@gmail.com>
    15	      1 Sangdi Xu <xu.sangdi@h3c.com>
    16	      1 Robin H. Johnson <robin.johnson@dreamhost.com>
    17	      1 Matt Benjamin <mbenjamin@redhat.com>
    18	      1 Haomai Wang <haomai@xsky.com>
    19	      1 Dan Mick <dmick@redhat.com>

Reviews, by organizations (one review spans multiple commits)
     1	    101 Red Hat <contact@redhat.com>
     2	      3 SUSE <contact@suse.com>
     3	      1 XSky <contact@xsky.com>
     4	      1 Unaffiliated <no@organization.net>
     5	      1 H3C <wentao@h3c.com>
     6	      1 DreamHost <contact@dreamhost.com>

Best Regards,
Abhishek
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJWU/WhAAoJEPnwZB8bZe1fT9IH/1BQyAawP2oPENibd27zAH9w
4krOr/+aIYDW47swTXAeZRTMfoArYUDIUxy9MaB96E3D0gBxtA/P4vy+xKCWVX1i
NRbvMYDpqsz3ZJYBBPLQKGJsS51xCorvnKjgwYG0SIwLOWC+hwINnyLo5CsRyjnO
sldXBpUwE7bZ7yj3A3mYxqe8TmJpMT2hp/KFqTmrpVnIF9wFSA2rDFz7Rbo5IMOw
gVO2fyNqVwRo1t5tWam6q7FRl9jk98jQiIjQvOIsQL+GFfsf9LGt88CfoB4hMBYl
qt/xWa+IWBcVkIZhVhdrPYCgjXhWQHfM9O+gZNgqYFbdMGM3ylJojVZxkKNEnjQ=3D
=3DnVkR
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
