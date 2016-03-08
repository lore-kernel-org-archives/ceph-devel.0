From: Abhishek L <abhishek@suse.com>
Subject: v10.0.4 Contributor Credits
Date: Tue, 08 Mar 2016 23:17:43 +0100
Message-ID: <86lh5ssjg8.fsf@linux-stsn.suse>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:50358 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbcCHWSF (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 8 Mar 2016 17:18:05 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

The last development release before Jewel is out, here is a sorted list
of authors and organizations who contributed to v10.0.4, by number of
commits or reviews back to the previous release of v10.0.3

The affiliation of authors to organizations can be updated by
submitting a patch to
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the
number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at
http://tracker.ceph.com/projects/ceph/wiki/Ceph_contributors_list_maintenan=
ce_guide

Thanks again for contributing & making Ceph better.

Number of lines added and removed, by authors
     1	 17045 Loic Dachary <ldachary@redhat.com>
     2	 10887 Haomai Wang <haomai@xsky.com>
     3	  8180 Sage Weil <sweil@redhat.com>
     4	  5426 Jason Dillaman <dillaman@redhat.com>
     5	  5263 Yehuda Sadeh <ysadehwe@redhat.com>
     6	  5171 Robin H. Johnson <robin.johnson@dreamhost.com>
     7	  2995 Adam C. Emerson <aemerson@redhat.com>
     8	  2241 Robin H. Johnson <robbat2@gentoo.org>
     9	  2170 Kefu Chai <kchai@redhat.com>
    10	  1690 Josh Durgin <jdurgin@redhat.com>
    11	  1525 Barbora An=C4=8Dincov=C3=A1 <bara@redhat.com>
    12	  1523 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    13	  1345 Marcel Lauhoff <lauhoff@uni-mainz.de>
    14	  1320 Matt Benjamin <mbenjamin@redhat.com>
    15	  1086 Somnath Roy <somnath.roy@sandisk.com>
    16	   900 Robert LeBlanc <robert.leblanc@endurance.com>
    17	   732 Igor Fedotov <ifedotov@mirantis.com>
    18	   673 Mykola Golub <mgolub@mirantis.com>
    19	   666 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
    20	   608 Xie Xingguo <xie.xingguo@zte.com.cn>
    21	   600 Ali Maredia <amaredia@redhat.com>
    22	   514 Samuel Just <sjust@redhat.com>
    23	   507 Nathan Cutler <ncutler@suse.com>
    24	   459 Kiseleva Alyona <akiselyova@mirantis.com>
    25	   426 Abhishek Lekshmanan <abhishek@suse.com>
    26	   273 Casey Bodley <cbodley@redhat.com>
    27	   253 Shun Song <song.shun3@zte.com.cn>
    28	   240 Pete Zaitcev <zaitcev@redhat.com>
    29	   224 Wido den Hollander <wido@42on.com>
    30	   185 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    31	   167 Vikhyat Umrao <vumrao@redhat.com>
    32	   107 Michal Jarzabek <stiopa@gmail.com>
    33	   100 John Spray <jspray@redhat.com>
    34	    95 Xiaowei Chen <chen.xiaowei@h3c.com>
    35	    83 Brad Hubbard <bhubbard@redhat.com>
    36	    74 Xinze Chi <xinze@xsky.com>
    37	    63 Yuan Zhou <yuan.zhou@intel.com>
    38	    63 Sahithi R V <tansy.rv@gmail.com>
    39	    62 Weijun Duan <duanweijun@h3c.com>
    40	    59 Ma Jianpeng <jianpeng.ma@intel.com>
    41	    49 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    42	    47 John Coyle <dx9err@gmail.com>
    43	    37 Bin Zheng <zhengbin.08747@h3c.com>
    44	    32 Ken Dreyer <kdreyer@redhat.com>
    45	    32 Gu Zhongyan <guzhongyan@360.cn>
    46	    32 Florent Manens <florent@beezim.fr>
    47	    26 Tao Chang <changtao@hihuron.com>
    48	    26 Song Baisen <song.baisen@zte.com.cn>
    49	    25 Alexey Sheplyakov <asheplyakov@mirantis.com>
    50	    23 Emile Snyder <emsnyder@ebay.com>
    51	    22 Ren Huanwen <ren.huanwen@zte.com.cn>
    52	    22 Na Xie <xie.na@h3c.com>
    53	    19 David Zafman <dzafman@redhat.com>
    54	    16 Dunrong Huang <riegamaths@gmail.com>
    55	    15 Roi Dayan <roid@mellanox.com>
    56	    15 Patrick Donnelly <batrick@batbytes.com>
    57	    14 Rachana Patel <rachana83.patel@gmail.com>
    58	    14 Ji Chen <insomnia@139.com>
    59	    14 Jeffrey Lu <lzhng2000@aliyun.com>
    60	    14 Erwan Velu <erwan@redhat.com>
    61	    14 Donghai Xu <xu.donghai@h3c.com>
    62	    13 Kongming Wu <wu.kongming@h3c.com>
    63	    13 Jiaying Ren <mikulely@gmail.com>
    64	    11 Aron Gunn <ritz_303@yahoo.com>
    65	     9 Chendi Xue <chendi.xue@intel.com>
    66	     8 Sangdi Xu <xu.sangdi@h3c.com>
    67	     7 Orit Wasserman <owasserm@redhat.com>
    68	     6 Jevon Qiao <qiaojianfeng@unitedstack.com>
    69	     6 Chuanhong Wang <wang.chuanhong@zte.com.cn>
    70	     4 Wei Jin <wjin.cn@gmail.com>
    71	     4 Tianshan Qu <tianshan@xsky.com>
    72	     4 Jianjian Huo <samuel.huo@gmail.com>
    73	     4 Guang Yang <yguang@yahoo-inc.com>
    74	     3 Bo Cai <cai.bo@h3c.com>
    75	     2 Zengran Zhang <zhangzengran@h3c.com>
    76	     2 Mauricio Garavaglia <mauriciogaravaglia@gmail.com>
    77	     2 Jonas Keidel <jonas@jonas-keidel.de>
    78	     2 Jingkai Yuan <jingkai.yuan@intel.com>
    79	     2 Ivan Grcic <igrcic@gmail.com>
    80	     2 Dan Mick <dmick@redhat.com>
    81	     1 Yan, Zheng <zyan@redhat.com>
    82	     1 Douglas Fuller <dfuller@redhat.com>

Number of lines added and removed, by organization
     1	 47667 Red Hat <contact@redhat.com>
     2	 10965 XSky <contact@xsky.com>
     3	  5171 DreamHost <contact@dreamhost.com>
     4	  2241 Gentoo <contact@gentoo.org>
     5	  1938 Mirantis <contact@mirantis.com>
     6	  1752 SanDisk <contact@sandisk.com>
     7	  1523 Deutsche Telekom <contact@telekom.de>
     8	  1345 Johannes Gutenberg-Universit=C3=A4t Mainz <contact@uni-mainz.=
de>
     9	   933 SUSE <contact@suse.com>
    10	   915 ZTE <contact@zte.com.cn>
    11	   900 Endurance International Group <contact@endurance.com>
    12	   332 Unaffiliated <no@organization.net>
    13	   256 H3C <contact@h3c.com>
    14	   224 Wido 42on <contact@42on.com>
    15	   185 Fujitsu <contact@fujitsu.com>
    16	   133 Intel <contact@intel.com>
    17	    32 Beezim <contact@beezim.fr>
    18	    26 Hihuron <contact@huron.com>
    19	    23 Ebay <contact@ebay.com>
    20	    15 Mellanox <contact@mellanox.com>
    21	    14 LETV <contact@letv.com>
    22	    14 Aliyun <contact@aliyun.com>
    23	     6 UnitedStack <contact@unitedstack.com>
    24	     4 Yahoo! <contact@yahoo-inc.com>

Commits, by authors
     1	    106 Sage Weil <sweil@redhat.com>
     2	     81 Xie Xingguo <xie.xingguo@zte.com.cn>
     3	     74 Robin H. Johnson <robbat2@gentoo.org>
     4	     71 Haomai Wang <haomai@xsky.com>
     5	     49 Kefu Chai <kchai@redhat.com>
     6	     42 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     7	     37 Yehuda Sadeh <ysadehwe@redhat.com>
     8	     27 Loic Dachary <ldachary@redhat.com>
     9	     21 Jason Dillaman <dillaman@redhat.com>
    10	     20 Robin H. Johnson <robin.johnson@dreamhost.com>
    11	     17 Nathan Cutler <ncutler@suse.com>
    12	     10 Barbora An=C4=8Dincov=C3=A1 <bara@redhat.com>
    13	      8 John Spray <jspray@redhat.com>
    14	      7 Samuel Just <sjust@redhat.com>
    15	      7 Erwan Velu <erwan@redhat.com>
    16	      7 Adam C. Emerson <aemerson@redhat.com>
    17	      6 Marcel Lauhoff <lauhoff@uni-mainz.de>
    18	      6 Igor Fedotov <ifedotov@mirantis.com>
    19	      6 Casey Bodley <cbodley@redhat.com>
    20	      6 Abhishek Lekshmanan <abhishek@suse.com>
    21	      5 Robert LeBlanc <robert.leblanc@endurance.com>
    22	      5 Mykola Golub <mgolub@mirantis.com>
    23	      5 Ken Dreyer <kdreyer@redhat.com>
    24	      5 Dunrong Huang <riegamaths@gmail.com>
    25	      4 Ren Huanwen <ren.huanwen@zte.com.cn>
    26	      4 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    27	      4 Matt Benjamin <mbenjamin@redhat.com>
    28	      4 Josh Durgin <jdurgin@redhat.com>
    29	      4 Jiaying Ren <mikulely@gmail.com>
    30	      3 Wido den Hollander <wido@42on.com>
    31	      3 Song Baisen <song.baisen@zte.com.cn>
    32	      3 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    33	      3 Ma Jianpeng <jianpeng.ma@intel.com>
    34	      3 Ali Maredia <amaredia@redhat.com>
    35	      2 Xinze Chi <xinze@xsky.com>
    36	      2 Xiaowei Chen <chen.xiaowei@h3c.com>
    37	      2 Tao Chang <changtao@hihuron.com>
    38	      2 Somnath Roy <somnath.roy@sandisk.com>
    39	      2 Shun Song <song.shun3@zte.com.cn>
    40	      2 Sahithi R V <tansy.rv@gmail.com>
    41	      2 Kongming Wu <wu.kongming@h3c.com>
    42	      2 Kiseleva Alyona <akiselyova@mirantis.com>
    43	      2 John Coyle <dx9err@gmail.com>
    44	      2 Ji Chen <insomnia@139.com>
    45	      2 Jianjian Huo <samuel.huo@gmail.com>
    46	      2 David Zafman <dzafman@redhat.com>
    47	      2 Brad Hubbard <bhubbard@redhat.com>
    48	      1 Zengran Zhang <zhangzengran@h3c.com>
    49	      1 Yuan Zhou <yuan.zhou@intel.com>
    50	      1 Yan, Zheng <zyan@redhat.com>
    51	      1 Weijun Duan <duanweijun@h3c.com>
    52	      1 Wei Jin <wjin.cn@gmail.com>
    53	      1 Vikhyat Umrao <vumrao@redhat.com>
    54	      1 Tianshan Qu <tianshan@xsky.com>
    55	      1 Sangdi Xu <xu.sangdi@h3c.com>
    56	      1 Roi Dayan <roid@mellanox.com>
    57	      1 Rachana Patel <rachana83.patel@gmail.com>
    58	      1 Pete Zaitcev <zaitcev@redhat.com>
    59	      1 Patrick Donnelly <batrick@batbytes.com>
    60	      1 Orit Wasserman <owasserm@redhat.com>
    61	      1 Na Xie <xie.na@h3c.com>
    62	      1 Michal Jarzabek <stiopa@gmail.com>
    63	      1 Mauricio Garavaglia <mauriciogaravaglia@gmail.com>
    64	      1 Jonas Keidel <jonas@jonas-keidel.de>
    65	      1 Jingkai Yuan <jingkai.yuan@intel.com>
    66	      1 Jevon Qiao <qiaojianfeng@unitedstack.com>
    67	      1 Jeffrey Lu <lzhng2000@aliyun.com>
    68	      1 Ivan Grcic <igrcic@gmail.com>
    69	      1 Gu Zhongyan <guzhongyan@360.cn>
    70	      1 Guang Yang <yguang@yahoo-inc.com>
    71	      1 Florent Manens <florent@beezim.fr>
    72	      1 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
    73	      1 Emile Snyder <emsnyder@ebay.com>
    74	      1 Douglas Fuller <dfuller@redhat.com>
    75	      1 Donghai Xu <xu.donghai@h3c.com>
    76	      1 Dan Mick <dmick@redhat.com>
    77	      1 Chuanhong Wang <wang.chuanhong@zte.com.cn>
    78	      1 Chendi Xue <chendi.xue@intel.com>
    79	      1 Bo Cai <cai.bo@h3c.com>
    80	      1 Bin Zheng <zhengbin.08747@h3c.com>
    81	      1 Aron Gunn <ritz_303@yahoo.com>
    82	      1 Alexey Sheplyakov <asheplyakov@mirantis.com>

Commits, by organizations
     1	    311 Red Hat <contact@redhat.com>
     2	     91 ZTE <contact@zte.com.cn>
     3	     74 XSky <contact@xsky.com>
     4	     74 Gentoo <contact@gentoo.org>
     5	     42 Deutsche Telekom <contact@telekom.de>
     6	     24 Unaffiliated <no@organization.net>
     7	     23 SUSE <contact@suse.com>
     8	     20 DreamHost <contact@dreamhost.com>
     9	     17 Mirantis <contact@mirantis.com>
    10	     11 H3C <contact@h3c.com>
    11	      6 Johannes Gutenberg-Universit=C3=A4t Mainz <contact@uni-mainz=
.de>
    12	      6 Intel <contact@intel.com>
    13	      5 Endurance International Group <contact@endurance.com>
    14	      4 Fujitsu <contact@fujitsu.com>
    15	      3 Wido 42on <contact@42on.com>
    16	      3 SanDisk <contact@sandisk.com>
    17	      2 LETV <contact@letv.com>
    18	      2 Hihuron <contact@huron.com>
    19	      1 Yahoo! <contact@yahoo-inc.com>
    20	      1 UnitedStack <contact@unitedstack.com>
    21	      1 Mellanox <contact@mellanox.com>
    22	      1 Ebay <contact@ebay.com>
    23	      1 Beezim <contact@beezim.fr>
    24	      1 Aliyun <contact@aliyun.com>

Reviews, by authors (one review spans multiple commits)
     1	     67 Sage Weil <sweil@redhat.com>
     2	     27 Kefu Chai <kchai@redhat.com>
     3	     15 Josh Durgin <jdurgin@redhat.com>
     4	     10 Loic Dachary <ldachary@redhat.com>
     5	      9 Jason Dillaman <dillaman@redhat.com>
     6	      8 Ken Dreyer <kdreyer@redhat.com>
     7	      7 Casey Bodley <cbodley@redhat.com>
     8	      6 Yehuda Sadeh <ysadehwe@redhat.com>
     9	      5 Samuel Just <sjust@redhat.com>
    10	      5 Boris Ranto <branto@redhat.com>
    11	      4 Yan, Zheng <zyan@redhat.com>
    12	      4 Haomai Wang <haomai@xsky.com>
    13	      4 Abhishek Lekshmanan <abhishek@suse.com>
    14	      3 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@suse.de>
    15	      2 Xie Xingguo <xie.xingguo@zte.com.cn>
    16	      2 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    17	      2 Nathan Cutler <ncutler@suse.com>
    18	      2 Greg Farnum <gfarnum@redhat.com>
    19	      2 David Zafman <dzafman@redhat.com>
    20	      2 Dan Mick <dmick@redhat.com>
    21	      1 Xiaoxi Chen <xiaoxi.chen@intel.com>
    22	      1 Song Baisen <song.baisen@zte.com.cn>
    23	      1 Robin H. Johnson <robin.johnson@dreamhost.com>
    24	      1 Matt Benjamin <mbenjamin@redhat.com>
    25	      1 John Wilkins <jwilkins@redhat.com>
    26	      1 John Spray <jspray@redhat.com>
    27	      1 Igor Fedotov <ifedotov@mirantis.com>
    28	      1 Erwan Velu <erwan@redhat.com>
    29	      1 David Disseldorp <ddiss@suse.de>

Reviews, by organizations (one review spans multiple commits)
     1	    173 Red Hat <contact@redhat.com>
     2	      8 SUSE <contact@suse.com>
     3	      4 XSky <contact@xsky.com>
     4	      3 ZTE <contact@zte.com.cn>
     5	      2 Reliance Jio Infocomm Ltd. <contact@ril.com>
     6	      2 Fujitsu <contact@fujitsu.com>
     7	      1 Mirantis <contact@mirantis.com>
     8	      1 Intel <contact@intel.com>
     9	      1 DreamHost <contact@dreamhost.com>


Best Regards
=2D-=20
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJW30+UAAoJEPnwZB8bZe1fOcAH/iSTaBrfUamZRryBjDtIOlnZ
Vr1HvxURQkdh7aIwrIUy3v+EQtxzP6IGXL5zmkJGtzS8F4g+LTxTpK4naDl2lGj8
Gf7qFMxalbHGH7yfl+XHaLVSVz/irUTUsuhatKfRSFsucLu1MORnVwrChlsypcV9
TkNrAp+3mYeDKHCkSsrJ6uMQAhf86yfmau7FrpUwjdbIMhA5vCVzVP12WHi4VB15
qGhbRK7A35YZVbXP1U+VN2mPe/NMr3+eIB4ekXgPs1212BX2BlCUkTPpi7+Kig6R
3RiJ2CBL7gT0imm7G5drj2gQ483Yvy40ixxbZrdwvD+Vk2wYU2/qorwr3L8eGn8=
=Qre8
-----END PGP SIGNATURE-----
--=-=-=--
