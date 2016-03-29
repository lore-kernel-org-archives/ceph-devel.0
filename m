From: Loic Dachary <loic@dachary.org>
Subject: v10.1.0 Contributor credits
Date: Tue, 29 Mar 2016 12:55:13 +0200
Message-ID: <56FA5F11.6090105@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:40823 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbcC2KzS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2016 06:55:18 -0400
Received: from mfilter43-d.gandi.net (mfilter43-d.gandi.net [217.70.178.174])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 3ED7941C0A5
	for <ceph-devel@vger.kernel.org>; Tue, 29 Mar 2016 12:55:16 +0200 (CEST)
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter43-d.gandi.net (mfilter43-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id Hz1C0Qo44ZEl for <ceph-devel@vger.kernel.org>;
	Tue, 29 Mar 2016 12:55:14 +0200 (CEST)
Received: from [192.168.2.115] (LPuteaux-657-1-295-15.w90-63.abo.wanadoo.fr [90.63.253.15])
	(Authenticated sender: loic@dachary.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 47A0C41C091
	for <ceph-devel@vger.kernel.org>; Tue, 29 Mar 2016 12:55:14 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v10.1.0, by number of commits or reviews back to v10.0.5. The affiliati=
on of
authors to organizations can be updated by submitting a patch to
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the
number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at http://tracker.ceph.com/projects=
/ceph/wiki/Ceph_contributors_list_maintenance_guide

Number of lines added and removed, by authors
     1	 35232 Yehuda Sadeh <ysadehwe@redhat.com>
     2	 30478 Matt Benjamin <mbenjamin@redhat.com>
     3	 18099 Jason Dillaman <dillaman@redhat.com>
     4	 11324 Orit Wasserman <owasserm@redhat.com>
     5	 11052 Sage Weil <sweil@redhat.com>
     6	 10736 Mehdi Abaakouk <sileht@redhat.com>
     7	  6729 Loic Dachary <ldachary@redhat.com>
     8	  6628 John Spray <jspray@redhat.com>
     9	  6109 Casey Bodley <cbodley@redhat.com>
    10	  4365 Mykola Golub <mgolub@mirantis.com>
    11	  4306 Samuel Just <sjust@redhat.com>
    12	  4172 Yan, Zheng <zyan@redhat.com>
    13	  2171 Kefu Chai <kchai@redhat.com>
    14	  2042 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    15	  1729 Nathan Cutler <ncutler@suse.com>
    16	  1697 Javier M. Mellid <jmunhoz@igalia.com>
    17	  1529 Haomai Wang <haomai@xsky.com>
    18	   903 Ricardo Dias <rdias@suse.com>
    19	   852 Jianjian Huo <samuel.huo@gmail.com>
    20	   625 Robert LeBlanc <robert.leblanc@endurance.com>
    21	   557 Ali Maredia <amaredia@redhat.com>
    22	   517 Josh Durgin <jdurgin@redhat.com>
    23	   478 Xie Xingguo <xie.xingguo@zte.com.cn>
    24	   396 Ma Jianpeng <jianpeng.ma@intel.com>
    25	   383 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    26	   382 Yann Dupont <yann@objoo.org>
    27	   349 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    28	   233 Ji Chen <insomnia@139.com>
    29	   229 Wido den Hollander <wido@42on.com>
    30	   199 Somnath Roy <somnath.roy@sandisk.com>
    31	   195 Igor Fedotov <ifedotov@mirantis.com>
    32	   152 Sarthak Munshi <sarthakmunshi@gmail.com>
    33	   142 Karol Mroz <kmroz@suse.com>
    34	   120 Erwan Velu <erwan@redhat.com>
    35	   117 Pete Zaitcev <zaitcev@redhat.com>
    36	   104 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@suse.de>
    37	    91 Tao Chang <changtao@hihuron.com>
    38	    91 Hector Martin <marcan@marcan.st>
    39	    86 Dan van der Ster <daniel.vanderster@cern.ch>
    40	    83 Greg Farnum <gfarnum@redhat.com>
    41	    79 Mike Shuey <shuey@purdue.edu>
    42	    78 Ken Dreyer <kdreyer@redhat.com>
    43	    75 Abhishek Lekshmanan <abhishek@suse.com>
    44	    71 Song Baisen <song.baisen@zte.com.cn>
    45	    70 Boris Ranto <branto@redhat.com>
    46	    66 Dongsheng Yang <dongsheng.yang@easystack.cn>
    47	    62 Abhishek Varshney <abhishek.varshney@flipkart.com>
    48	    51 Michal Jarzabek <stiopa@gmail.com>
    49	    50 Javen Wu <javen.wu@xtaotech.com>
    50	    49 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
    51	    48 Dan Mick <dmick@redhat.com>
    52	    45 James Liu <james.liu@ssi.samsung.com>
    53	    43 Roi Dayan <roid@mellanox.com>
    54	    43 Dunrong Huang <riegamaths@gmail.com>
    55	    37 Wenjun Huang <wenjunhuang@tencent.com>
    56	    33 Zhi Zhang <willzzhang@tencent.com>
    57	    28 Subramanyam Varanasi <s.varanasi@ssi.samsung.com>
    58	    28 Avner BenHanoch <avnerb@mellanox.com>
    59	    26 Zhiqiang Wang <zhiqiang.wang@intel.com>
    60	    25 Ren Huanwen <ren.huanwen@zte.com.cn>
    61	    21 Shu, Xinxin <xinxin.shu@intel.com>
    62	    20 Robin H. Johnson <robin.johnson@dreamhost.com>
    63	    20 Marcus Watts <mwatts@redhat.com>
    64	    19 Luis Periquito <luis.periquito@ocado.com>
    65	    19 Adam C. Emerson <aemerson@redhat.com>
    66	    18 Zengran Zhang <zhangzengran@h3c.com>
    67	    17 David Disseldorp <ddiss@suse.de>
    68	    16 Florent Bautista <florent@coppint.com>
    69	    15 You Ji <youji@ebay.com>
    70	    14 James Page <james.page@ubuntu.com>
    71	    12 Igor Podoski <igor.podoski@ts.fujitsu.com>
    72	    10 Zhao Junwang <zhjwpku@gmail.com>
    73	    10 Wei Jin <wjin.cn@gmail.com>
    74	    10 Eric Lee <eric.lee@hgst.com>
    75	    10 Edward Yang <eyang@us.fujitsu.com>
    76	     8 Jenkins <jenkins@ceph.com>
    77	     7 Rust Shen <rustinpeace@163.com>
    78	     5 Brad Hubbard <bhubbard@redhat.com>
    79	     4 Zack Cerza <zack@redhat.com>
    80	     4 You Ji <jiyou09@gmail.com>
    81	     4 Yan Jun <yan.jun8@zte.com.cn>
    82	     4 Patrick Donnelly <batrick@batbytes.com>
    83	     4 Li Tianqing <tianqing@unitedstack.com>
    84	     4 Eric Cook <llua@gmx.com>
    85	     4 Bo Cai <cai.bo@h3c.com>
    86	     3 Xinze Chi <xinze@xsky.com>
    87	     3 Na Xie <xie.na@h3c.com>
    88	     2 Yankun Li <liyankun@unitedstack.com>
    89	     2 Willem Jan Withagen <wjw@digiware.nl>
    90	     2 Owen Synge <osynge@suse.com>
    91	     2 Noah Watkins <nwatkins@redhat.com>
    92	     2 Daniel Gryniewicz <dang@redhat.com>
    93	     2 Adam Kupczyk <akupczyk@mirantis.com>
    94	     2 Aaron Bassett <abassett@gmail.com>
    95	     1 R=C3=A9mi Buisson <remi.buisson@cdiscount.com>

Number of lines added and removed, by organization
     1	148686 Red Hat <contact@redhat.com>
     2	  6604 Mirantis <contact@mirantis.com>
     3	  2972 SUSE <contact@suse.com>
     4	  1697 Igalia <contact@igalia.com>
     5	  1678 Unaffiliated <no@organization.net>
     6	  1532 XSky <contact@xsky.com>
     7	   625 Endurance International Group <contact@endurance.com>
     8	   578 ZTE <contact@zte.com.cn>
     9	   443 Intel <contact@intel.com>
    10	   405 Fujitsu <contact@fujitsu.com>
    11	   349 Deutsche Telekom <contact@telekom.de>
    12	   248 SanDisk <contact@sandisk.com>
    13	   233 LETV <contact@letv.com>
    14	   229 Wido 42on <contact@42on.com>
    15	    91 Hihuron <contact@huron.com>
    16	    86 CERN <contact@cern.ch>
    17	    79 Purdue University <contact@purdue.edu>
    18	    73 Samsung <contact@samsung.com>
    19	    71 Mellanox <contact@mellanox.com>
    20	    70 Tencent <contact@tencent.com>
    21	    66 Easystack <contact@easystack.cn>
    22	    62 Flipkart <contact@flipkart.com>
    23	    25 H3C <contact@h3c.com>
    24	    20 DreamHost <contact@dreamhost.com>
    25	    19 Ocado <contact@ocado.com>
    26	    15 Ebay <contact@ebay.com>
    27	    14 Canonical <contact@canonical.com>
    28	    10 HGST <contact@hgst.com>
    29	     6 UnitedStack <contact@unitedstack.com>
    30	     2 Digiware <contact@digiware.nl>
    31	     1 Cdiscount <contact@cdiscount.com>

Commits, by authors
     1	    466 Yehuda Sadeh <ysadehwe@redhat.com>
     2	    286 Matt Benjamin <mbenjamin@redhat.com>
     3	    205 Orit Wasserman <owasserm@redhat.com>
     4	    154 Sage Weil <sweil@redhat.com>
     5	    149 Jason Dillaman <dillaman@redhat.com>
     6	    113 Casey Bodley <cbodley@redhat.com>
     7	     81 Xie Xingguo <xie.xingguo@zte.com.cn>
     8	     80 Yan, Zheng <zyan@redhat.com>
     9	     59 Samuel Just <sjust@redhat.com>
    10	     52 Yann Dupont <yann@objoo.org>
    11	     51 Kefu Chai <kchai@redhat.com>
    12	     47 Mykola Golub <mgolub@mirantis.com>
    13	     46 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    14	     44 John Spray <jspray@redhat.com>
    15	     37 Haomai Wang <haomai@xsky.com>
    16	     35 Loic Dachary <ldachary@redhat.com>
    17	     29 Javier M. Mellid <jmunhoz@igalia.com>
    18	     26 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    19	     25 Abhishek Lekshmanan <abhishek@suse.com>
    20	     23 Ma Jianpeng <jianpeng.ma@intel.com>
    21	     17 Nathan Cutler <ncutler@suse.com>
    22	     16 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    23	     14 Jianjian Huo <samuel.huo@gmail.com>
    24	     13 Ricardo Dias <rdias@suse.com>
    25	     12 Erwan Velu <erwan@redhat.com>
    26	     10 Mehdi Abaakouk <sileht@redhat.com>
    27	     10 Josh Durgin <jdurgin@redhat.com>
    28	      9 Dongsheng Yang <dongsheng.yang@easystack.cn>
    29	      8 Greg Farnum <gfarnum@redhat.com>
    30	      7 Wido den Hollander <wido@42on.com>
    31	      7 Roi Dayan <roid@mellanox.com>
    32	      7 Ken Dreyer <kdreyer@redhat.com>
    33	      7 Dan Mick <dmick@redhat.com>
    34	      6 Robert LeBlanc <robert.leblanc@endurance.com>
    35	      6 Ren Huanwen <ren.huanwen@zte.com.cn>
    36	      6 Igor Fedotov <ifedotov@mirantis.com>
    37	      5 Karol Mroz <kmroz@suse.com>
    38	      5 Boris Ranto <branto@redhat.com>
    39	      5 Avner BenHanoch <avnerb@mellanox.com>
    40	      4 Pete Zaitcev <zaitcev@redhat.com>
    41	      4 Marcus Watts <mwatts@redhat.com>
    42	      4 Dan van der Ster <daniel.vanderster@cern.ch>
    43	      4 Ali Maredia <amaredia@redhat.com>
    44	      3 Zhi Zhang <willzzhang@tencent.com>
    45	      3 Shu, Xinxin <xinxin.shu@intel.com>
    46	      3 Mike Shuey <shuey@purdue.edu>
    47	      3 Hector Martin <marcan@marcan.st>
    48	      3 Dunrong Huang <riegamaths@gmail.com>
    49	      3 Brad Hubbard <bhubbard@redhat.com>
    50	      2 Zhiqiang Wang <zhiqiang.wang@intel.com>
    51	      2 You Ji <youji@ebay.com>
    52	      2 Somnath Roy <somnath.roy@sandisk.com>
    53	      2 Sarthak Munshi <sarthakmunshi@gmail.com>
    54	      2 Patrick Donnelly <batrick@batbytes.com>
    55	      2 Na Xie <xie.na@h3c.com>
    56	      2 Michal Jarzabek <stiopa@gmail.com>
    57	      2 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@suse.de>
    58	      2 James Page <james.page@ubuntu.com>
    59	      2 James Liu <james.liu@ssi.samsung.com>
    60	      2 David Disseldorp <ddiss@suse.de>
    61	      2 Adam C. Emerson <aemerson@redhat.com>
    62	      2 Abhishek Varshney <abhishek.varshney@flipkart.com>
    63	      1 Zhao Junwang <zhjwpku@gmail.com>
    64	      1 Zengran Zhang <zhangzengran@h3c.com>
    65	      1 Zack Cerza <zack@redhat.com>
    66	      1 You Ji <jiyou09@gmail.com>
    67	      1 Yankun Li <liyankun@unitedstack.com>
    68	      1 Yan Jun <yan.jun8@zte.com.cn>
    69	      1 Xinze Chi <xinze@xsky.com>
    70	      1 Willem Jan Withagen <wjw@digiware.nl>
    71	      1 Wenjun Huang <wenjunhuang@tencent.com>
    72	      1 Wei Jin <wjin.cn@gmail.com>
    73	      1 Tao Chang <changtao@hihuron.com>
    74	      1 Subramanyam Varanasi <s.varanasi@ssi.samsung.com>
    75	      1 Song Baisen <song.baisen@zte.com.cn>
    76	      1 Rust Shen <rustinpeace@163.com>
    77	      1 Robin H. Johnson <robin.johnson@dreamhost.com>
    78	      1 R=C3=A9mi Buisson <remi.buisson@cdiscount.com>
    79	      1 Owen Synge <osynge@suse.com>
    80	      1 Noah Watkins <nwatkins@redhat.com>
    81	      1 Luis Periquito <luis.periquito@ocado.com>
    82	      1 Li Tianqing <tianqing@unitedstack.com>
    83	      1 Ji Chen <insomnia@139.com>
    84	      1 Jenkins <jenkins@ceph.com>
    85	      1 Javen Wu <javen.wu@xtaotech.com>
    86	      1 Igor Podoski <igor.podoski@ts.fujitsu.com>
    87	      1 Florent Bautista <florent@coppint.com>
    88	      1 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
    89	      1 Eric Lee <eric.lee@hgst.com>
    90	      1 Eric Cook <llua@gmx.com>
    91	      1 Edward Yang <eyang@us.fujitsu.com>
    92	      1 Daniel Gryniewicz <dang@redhat.com>
    93	      1 Bo Cai <cai.bo@h3c.com>
    94	      1 Adam Kupczyk <akupczyk@mirantis.com>
    95	      1 Aaron Bassett <abassett@gmail.com>

Commits, by organizations
     1	   1722 Red Hat <contact@redhat.com>
     2	    100 Mirantis <contact@mirantis.com>
     3	     89 ZTE <contact@zte.com.cn>
     4	     86 Unaffiliated <no@organization.net>
     5	     65 SUSE <contact@suse.com>
     6	     38 XSky <contact@xsky.com>
     7	     29 Igalia <contact@igalia.com>
     8	     28 Intel <contact@intel.com>
     9	     26 Deutsche Telekom <contact@telekom.de>
    10	     18 Fujitsu <contact@fujitsu.com>
    11	     12 Mellanox <contact@mellanox.com>
    12	      9 Easystack <contact@easystack.cn>
    13	      7 Wido 42on <contact@42on.com>
    14	      6 Endurance International Group <contact@endurance.com>
    15	      4 Tencent <contact@tencent.com>
    16	      4 H3C <contact@h3c.com>
    17	      4 CERN <contact@cern.ch>
    18	      3 SanDisk <contact@sandisk.com>
    19	      3 Samsung <contact@samsung.com>
    20	      3 Purdue University <contact@purdue.edu>
    21	      2 UnitedStack <contact@unitedstack.com>
    22	      2 Flipkart <contact@flipkart.com>
    23	      2 Ebay <contact@ebay.com>
    24	      2 Canonical <contact@canonical.com>
    25	      1 Ocado <contact@ocado.com>
    26	      1 LETV <contact@letv.com>
    27	      1 Hihuron <contact@huron.com>
    28	      1 HGST <contact@hgst.com>
    29	      1 DreamHost <contact@dreamhost.com>
    30	      1 Digiware <contact@digiware.nl>
    31	      1 Cdiscount <contact@cdiscount.com>

Reviews, by authors (one review spans multiple commits)
     1	     86 Sage Weil <sweil@redhat.com>
     2	     63 Josh Durgin <jdurgin@redhat.com>
     3	     53 Kefu Chai <kchai@redhat.com>
     4	     43 Yehuda Sadeh <ysadehwe@redhat.com>
     5	     28 Loic Dachary <ldachary@redhat.com>
     6	     26 Jason Dillaman <dillaman@redhat.com>
     7	     22 Greg Farnum <gfarnum@redhat.com>
     8	     19 Samuel Just <sjust@redhat.com>
     9	     12 Haomai Wang <haomai@xsky.com>
    10	     10 Orit Wasserman <owasserm@redhat.com>
    11	      8 Nathan Cutler <ncutler@suse.com>
    12	      7 Matt Benjamin <mbenjamin@redhat.com>
    13	      7 John Spray <jspray@redhat.com>
    14	      5 Ken Dreyer <kdreyer@redhat.com>
    15	      5 Casey Bodley <cbodley@redhat.com>
    16	      4 Yan, Zheng <zyan@redhat.com>
    17	      4 Dan Mick <dmick@redhat.com>
    18	      4 Boris Ranto <branto@redhat.com>
    19	      4 Alfredo Deza <adeza@redhat.com>
    20	      4 Abhishek Lekshmanan <abhishek@suse.com>
    21	      3 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@suse.de>
    22	      2 Willem Jan Withagen <wjw@digiware.nl>
    23	      2 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    24	      2 Mehdi Abaakouk <sileht@redhat.com>
    25	      2 Huang Jun <hjwsm1989@gmail.com>
    26	      2 Adam C. Emerson <aemerson@redhat.com>
    27	      1 Tim Serong <tserong@suse.com>
    28	      1 Mark Nelson <mnelson@redhat.com>
    29	      1 Igor Fedotov <ifedotov@mirantis.com>
    30	      1 Hector Martin <marcan@marcan.st>
    31	      1 David Zafman <dzafman@redhat.com>
    32	      1 Brad Hubbard <bhubbard@redhat.com>
    33	      1 Ali Maredia <amaredia@redhat.com>

Reviews, by organizations (one review spans multiple commits)
     1	    397 Red Hat <contact@redhat.com>
     2	     16 SUSE <contact@suse.com>
     3	     12 XSky <contact@xsky.com>
     4	      3 Unaffiliated <no@organization.net>
     5	      2 Fujitsu <contact@fujitsu.com>
     6	      2 Digiware <contact@digiware.nl>
     7	      1 Mirantis <contact@mirantis.com>
     8	      1 Cloudwatt <libre.licensing@cloudwatt.com>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
