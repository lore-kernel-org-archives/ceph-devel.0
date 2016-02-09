From: Yann Dupont <yd@objoo.org>
Subject: v10.0.3 Contributor credits
Date: Wed, 10 Feb 2016 00:04:25 +0100
Message-ID: <56BA7079.4030404@objoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48327 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226AbcBIXEd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Feb 2016 18:04:33 -0500
Received: from mfilter28-d.gandi.net (mfilter28-d.gandi.net [217.70.178.159])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 03480A80AA
	for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 00:04:31 +0100 (CET)
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter28-d.gandi.net (mfilter28-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id ao3lCFdX60Iz for <ceph-devel@vger.kernel.org>;
	Wed, 10 Feb 2016 00:04:26 +0100 (CET)
Received: from [192.168.21.156] (familledupont.org [78.201.40.7])
	(Authenticated sender: yann@familledupont.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 43696A80BF
	for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 00:04:26 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v10.0.3, by number of commits or reviews back to v10.0.2. The
affiliation of authors to organizations can be updated by submitting a
patch tohttps://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed, but the number of reviews is a fraction of
the number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge, although it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at
http://tracker.ceph.com/projects/ceph/wiki/Ceph_contributors_list_maint=
enance_guide

Number of lines added and removed, by authors
      1	111036 Sage Weil <sweil@redhat.com>
      2	 11573 Jason Dillaman <dillaman@redhat.com>
      3	  5851 Adam C. Emerson <aemerson@redhat.com>
      4	  4059 Yan, Zheng <zyan@redhat.com>
      5	  2396 John Spray <jspray@redhat.com>
      6	  1830 Ali Maredia <amaredia@redhat.com>
      7	   911 Loic Dachary <ldachary@redhat.com>
      8	   785 Xie Xingguo <xie.xingguo@zte.com.cn>
      9	   739 Kiseleva Alyona <akiselyova@mirantis.com>
     10	   719 Wido den Hollander <wido@42on.com>
     11	   438 Xinze Chi <xinze@xsky.com>
     12	   409 Mykola Golub <mgolub@mirantis.com>
     13	   402 Kefu Chai <kchai@redhat.com>
     14	   397 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
     15	   383 Igor Podoski <igor.podoski@ts.fujitsu.com>
     16	   329 Haomai Wang <haomai@xsky.com>
     17	   200 Sangdi Xu <xu.sangdi@h3c.com>
     18	   163 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@suse.de>
     19	   155 Xiaoxi Chen <xiaoxi.chen@intel.com>
     20	   139 Ma Jianpeng <jianpeng.ma@intel.com>
     21	   106 Dunrong Huang <riegamaths@gmail.com>
     22	   102 Radoslaw Zarzynski <rzarzynski@mirantis.com>
     23	    99 Ning Yao <yaoning@ruijie.com.cn>
     24	    99 Guang Yang <yguang@yahoo-inc.com>
     25	    94 David Zafman <dzafman@redhat.com>
     26	    87 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
     27	    82 Xiaowei Chen <chen.xiaowei@h3c.com>
     28	    80 Michal Jarzabek <stiopa@gmail.com>
     29	    62 Xiangwei Wu <wuxiangwei@h3c.com>
     30	    58 Yongqiang He <he.yongqiang@h3c.com>
     31	    58 John Coyle <dx9err@gmail.com>
     32	    50 Ruifeng Yang <yangruifeng.09209@h3c.com>
     33	    43 Yehuda Sadeh <ysadehwe@redhat.com>
     34	    42 Cilang Zhao <zhao.cilang@h3c.com>
     35	    33 Zhiqiang Wang <zhiqiang.wang@intel.com>
     36	    28 Casey Bodley <cbodley@redhat.com>
     37	    24 Dan Mick <dmick@redhat.com>
     38	    23 Zhiqiang Wang <zhiqiang@xsky.com>
     39	    23 Dunrong Huang <dunrong.huang@eayun.com>
     40	    22 Swami Reddy <swami.reddy@ril.com>
     41	    22 Song Baisen <song.baisen@zte.com.cn>
     42	    20 Matt Benjamin <mbenjamin@redhat.com>
     43	    18 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
     44	    16 Zengran Zhang <zhangzengran@h3c.com>
     45	    16 Bo Cai <cai.bo@h3c.com>
     46	    15 Na Xie <xie.na@h3c.com>
     47	    15 Nathan Cutler <ncutler@suse.com>
     48	    15 Li Wang <li.wang@kylin-cloud.com>
     49	    15 Kongming Wu <wu.kongming@h3c.com>
     50	    12 Ren Huanwen <ren.huanwen@zte.com.cn>
     51	    12 Orit Wasserman <owasserm@redhat.com>
     52	    11 Igor Fedotov <ifedotov@mirantis.com>
     53	    10 Somnath Roy <somnath.roy@sandisk.com>
     54	     9 Venky Shankar <vshankar@redhat.com>
     55	     9 Liu Peiyan <liu.peiyang@h3c.com>
     56	     8 Zhi Zhang <willzzhang@tencent.com>
     57	     8 Fran=C3=A7ois Lafont <flafdivers@free.fr>
     58	     7 YankunLi <YankunLi@users.noreply.github.com>
     59	     6 YiQiang Chen <cyqsign@163.com>
     60	     6 Ji Chen <insomnia@139.com>
     61	     5 Pete Zaitcev <zaitcev@redhat.com>
     62	     5 Luo Kexue <luo.kexue@zte.com.cn>
     63	     5 Ken Dreyer <kdreyer@redhat.com>
     64	     5 Greg Farnum <gfarnum@redhat.com>
     65	     5 David Disseldorp <ddiss@suse.de>
     66	     4 Wei Feng <feng.wei@h3c.com>
     67	     4 Josh Durgin <jdurgin@redhat.com>
     68	     4 Jie Wang <jie.wang@kylin-cloud.com>
     69	     4 Donghai Xu <xu.donghai@h3c.com>
     70	     4 Brad Hubbard <bhubbard@redhat.com>
     71	     4 Aron Gunn <ritz_303@yahoo.com>
     72	     3 Yuan Zhou <yuan.zhou@intel.com>
     73	     3 Yehua Chen <chen.yehua@h3c.com>
     74	     3 Weijun Duan <duanweijun@h3c.com>
     75	     2 Li Tianqing <tianqing@unitedstack.com>
     76	     2 Douglas Fuller <dfuller@redhat.com>
     77	     2 Dongmao Zhang <deanraccoon@gmail.com>
     78	     2 Darrell Enns <darrell@darrellenns.com>
     79	     2 Abhishek Lekshmanan <abhishek@suse.com>
     80	     1 Qiankun Zheng <zheng.qiankun@h3c.com>
     81	     1 Ilya Shipitsin <ilia@localhost.localdomain>

Number of lines added and removed, by organization
      1	138313 Red Hat <contact@redhat.com>
      2	  1261 Mirantis <contact@mirantis.com>
      3	   824 ZTE <contact@zte.com.cn>
      4	   790 XSky <contact@xsky.com>
      5	   780 Fujitsu <contact@fujitsu.com>
      6	   719 Wido 42on <contact@42on.com>
      7	   580 H3C <contact@h3c.com>
      8	   330 Intel <contact@intel.com>
      9	   272 Unaffiliated <no@organization.net>
     10	   185 SUSE <contact@suse.com>
     11	   106 Kylin Cloud <contact@kylin-cloud.com>
     12	    99 Yahoo! <contact@yahoo-inc.com>
     13	    99 Ruijie Networks <contact@ruijie.com.cn>
     14	    28 SanDisk <contact@sandisk.com>
     15	    23 Eayun <contact@eayun.com>
     16	    22 Reliance Jio Infocomm Ltd. <contact@ril.com>
     17	     8 Tencent <contact@tencent.com>
     18	     8 LETV <contact@letv.com>
     19	     2 UnitedStack <contact@unitedstack.com>

Commits, by authors
      1	    269 Sage Weil <sweil@redhat.com>
      2	     80 Xie Xingguo <xie.xingguo@zte.com.cn>
      3	     47 Yan, Zheng <zyan@redhat.com>
      4	     44 Jason Dillaman <dillaman@redhat.com>
      5	     37 John Spray <jspray@redhat.com>
      6	     31 Loic Dachary <ldachary@redhat.com>
      7	     20 Ali Maredia <amaredia@redhat.com>
      8	     19 Swami Reddy <swami.reddy@ril.com>
      9	     16 Kefu Chai <kchai@redhat.com>
     10	     15 Ma Jianpeng <jianpeng.ma@intel.com>
     11	     12 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
     12	     12 Haomai Wang <haomai@xsky.com>
     13	      9 Dunrong Huang <riegamaths@gmail.com>
     14	      9 David Zafman <dzafman@redhat.com>
     15	      8 Mykola Golub <mgolub@mirantis.com>
     16	      8 Adam C. Emerson <aemerson@redhat.com>
     17	      7 Sangdi Xu <xu.sangdi@h3c.com>
     18	      7 Ning Yao <yaoning@ruijie.com.cn>
     19	      6 Xinze Chi <xinze@xsky.com>
     20	      5 Michal Jarzabek <stiopa@gmail.com>
     21	      4 Zhiqiang Wang <zhiqiang.wang@intel.com>
     22	      4 Xiaowei Chen <chen.xiaowei@h3c.com>
     23	      4 Xiangwei Wu <wuxiangwei@h3c.com>
     24	      4 Ren Huanwen <ren.huanwen@zte.com.cn>
     25	      4 Orit Wasserman <owasserm@redhat.com>
     26	      4 Matt Benjamin <mbenjamin@redhat.com>
     27	      4 Igor Podoski <igor.podoski@ts.fujitsu.com>
     28	      3 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
     29	      3 Yehuda Sadeh <ysadehwe@redhat.com>
     30	      3 Xiaoxi Chen <xiaoxi.chen@intel.com>
     31	      3 Wido den Hollander <wido@42on.com>
     32	      3 Ruifeng Yang <yangruifeng.09209@h3c.com>
     33	      3 Kongming Wu <wu.kongming@h3c.com>
     34	      3 John Coyle <dx9err@gmail.com>
     35	      3 Casey Bodley <cbodley@redhat.com>
     36	      2 Zhi Zhang <willzzhang@tencent.com>
     37	      2 Zengran Zhang <zhangzengran@h3c.com>
     38	      2 Yongqiang He <he.yongqiang@h3c.com>
     39	      2 YankunLi <YankunLi@users.noreply.github.com>
     40	      2 Weijun Duan <duanweijun@h3c.com>
     41	      2 Song Baisen <song.baisen@zte.com.cn>
     42	      2 Radoslaw Zarzynski <rzarzynski@mirantis.com>
     43	      2 Pete Zaitcev <zaitcev@redhat.com>
     44	      2 Na Xie <xie.na@h3c.com>
     45	      2 Nathan Cutler <ncutler@suse.com>
     46	      2 Kiseleva Alyona <akiselyova@mirantis.com>
     47	      2 Guang Yang <yguang@yahoo-inc.com>
     48	      2 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
     49	      2 Dunrong Huang <dunrong.huang@eayun.com>
     50	      2 Cilang Zhao <zhao.cilang@h3c.com>
     51	      2 Brad Hubbard <bhubbard@redhat.com>
     52	      2 Bo Cai <cai.bo@h3c.com>
     53	      1 Zhiqiang Wang <zhiqiang@xsky.com>
     54	      1 Yuan Zhou <yuan.zhou@intel.com>
     55	      1 YiQiang Chen <cyqsign@163.com>
     56	      1 Yehua Chen <chen.yehua@h3c.com>
     57	      1 Wei Feng <feng.wei@h3c.com>
     58	      1 Venky Shankar <vshankar@redhat.com>
     59	      1 Somnath Roy <somnath.roy@sandisk.com>
     60	      1 Qiankun Zheng <zheng.qiankun@h3c.com>
     61	      1 Luo Kexue <luo.kexue@zte.com.cn>
     62	      1 Li Wang <li.wang@kylin-cloud.com>
     63	      1 Liu Peiyan <liu.peiyang@h3c.com>
     64	      1 Li Tianqing <tianqing@unitedstack.com>
     65	      1 Ken Dreyer <kdreyer@redhat.com>
     66	      1 Josh Durgin <jdurgin@redhat.com>
     67	      1 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@suse.de>
     68	      1 Jie Wang <jie.wang@kylin-cloud.com>
     69	      1 Ji Chen <insomnia@139.com>
     70	      1 Ilya Shipitsin <ilia@localhost.localdomain>
     71	      1 Igor Fedotov <ifedotov@mirantis.com>
     72	      1 Greg Farnum <gfarnum@redhat.com>
     73	      1 Fran=C3=A7ois Lafont <flafdivers@free.fr>
     74	      1 Douglas Fuller <dfuller@redhat.com>
     75	      1 Dongmao Zhang <deanraccoon@gmail.com>
     76	      1 Donghai Xu <xu.donghai@h3c.com>
     77	      1 David Disseldorp <ddiss@suse.de>
     78	      1 Darrell Enns <darrell@darrellenns.com>
     79	      1 Dan Mick <dmick@redhat.com>
     80	      1 Aron Gunn <ritz_303@yahoo.com>
     81	      1 Abhishek Lekshmanan <abhishek@suse.com>

Commits, by organizations
      1	    505 Red Hat <contact@redhat.com>
      2	     87 ZTE <contact@zte.com.cn>
      3	     38 H3C <contact@h3c.com>
      4	     24 Unaffiliated <no@organization.net>
      5	     23 Intel <contact@intel.com>
      6	     19 XSky <contact@xsky.com>
      7	     19 Reliance Jio Infocomm Ltd. <contact@ril.com>
      8	     16 Fujitsu <contact@fujitsu.com>
      9	     13 Mirantis <contact@mirantis.com>
     10	      7 Ruijie Networks <contact@ruijie.com.cn>
     11	      5 SUSE <contact@suse.com>
     12	      5 Kylin Cloud <contact@kylin-cloud.com>
     13	      3 Wido 42on <contact@42on.com>
     14	      3 SanDisk <contact@sandisk.com>
     15	      2 Yahoo! <contact@yahoo-inc.com>
     16	      2 Tencent <contact@tencent.com>
     17	      2 LETV <contact@letv.com>
     18	      2 Eayun <contact@eayun.com>
     19	      1 UnitedStack <contact@unitedstack.com>

Reviews, by authors (one review spans multiple commits)
      1	     71 Sage Weil <sweil@redhat.com>
      2	     34 Kefu Chai <kchai@redhat.com>
      3	     23 Josh Durgin <jdurgin@redhat.com>
      4	     17 Loic Dachary <ldachary@redhat.com>
      5	     16 Jason Dillaman <dillaman@redhat.com>
      6	     12 Yehuda Sadeh <ysadehwe@redhat.com>
      7	     11 Greg Farnum <gfarnum@redhat.com>
      8	      6 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@suse.de>
      9	      5 John Spray <jspray@redhat.com>
     10	      3 Samuel Just <sjust@redhat.com>
     11	      3 David Zafman <dzafman@redhat.com>
     12	      2 Casey Bodley <cbodley@redhat.com>
     13	      2 Abhishek Lekshmanan <abhishek@suse.com>
     14	      1 Yan, Zheng <zyan@redhat.com>
     15	      1 Nathan Cutler <ncutler@suse.com>
     16	      1 Ilya Dryomov <idryomov@redhat.com>
     17	      1 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
     18	      1 Daniel Gryniewicz <dang@redhat.com>
     19	      1 Chengyuan Li <chengyli@ebay.com>

Reviews, by organizations (one review spans multiple commits)
      1	    199 Red Hat <contact@redhat.com>
      2	      7 SUSE <contact@suse.com>
      3	      2 Reliance Jio Infocomm Ltd. <contact@ril.com>
      4	      1 SanDisk <contact@sandisk.com>
      5	      1 Inktank <contact@inktank.com>
      6	      1 Ebay <contact@ebay.com>


Cheers,
Yann.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
