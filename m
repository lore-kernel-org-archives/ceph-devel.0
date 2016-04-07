From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: v10.1.1 Contributor credits
Date: Fri, 8 Apr 2016 02:39:49 +0530
Message-ID: <CANA9Uk6xpb4mMXhq3j0ZwnEM42tkkk8dh7CnsoyOEVh8-hZoFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33069 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbcDGVJv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2016 17:09:51 -0400
Received: by mail-vk0-f54.google.com with SMTP id k1so115619537vkb.0
        for <ceph-devel@vger.kernel.org>; Thu, 07 Apr 2016 14:09:50 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v10.1.1, by number of commits or reviews back to v10.1.0. The
affiliation of
authors to organizations can be updated by submitting a patch to
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of
the number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at
http://tracker.ceph.com/projects/ceph/wiki/Ceph_contributors_list_maint=
enance_guide

=3D=3D=3D
Number of lines added and removed, by authors
     1    5981 Jason Dillaman <dillaman@redhat.com>
     2    2766 Sage Weil <sweil@redhat.com>
     3     962 Ricardo Dias <rdias@suse.com>
     4     831 Mykola Golub <mgolub@mirantis.com>
     5     775 John Spray <jspray@redhat.com>
     6     765 Loic Dachary <ldachary@redhat.com>
     7     531 Samuel Just <sjust@redhat.com>
     8     524 Matt Benjamin <mbenjamin@redhat.com>
     9     481 Erwan Velu <erwan@redhat.com>
    10     393 Yehuda Sadeh <ysadehwe@redhat.com>
    11     254 Roi Dayan <roid@mellanox.com>
    12     225 Nathan Cutler <ncutler@suse.com>
    13     219 Kefu Chai <kchai@redhat.com>
    14     209 Xie Xingguo <xie.xingguo@zte.com.cn>
    15     187 Adam Kupczyk <akupczyk@mirantis.com>
    16     154 Casey Bodley <cbodley@redhat.com>
    17     143 Yan, Zheng <zyan@redhat.com>
    18     127 Somnath Roy <somnath.roy@sandisk.com>
    19     123 David Zafman <dzafman@redhat.com>
    20      90 Song Baisen <song.baisen@zte.com.cn>
    21      72 Ali Maredia <amaredia@redhat.com>
    22      54 Abhishek Lekshmanan <abhishek@suse.com>
    23      53 Marcus Watts <mwatts@redhat.com>
    24      40 Ma Jianpeng <jianpeng.ma@intel.com>
    25      38 Alexey Sheplyakov <asheplyakov@mirantis.com>
    26      35 Zhiqiang Wang <zhiqiang@xsky.com>
    27      33 Wido den Hollander <wido@42on.com>
    28      32 runsisi <runsisi@hust.edu.cn>
    29      29 Dongsheng Yang <dongsheng.yang@easystack.cn>
    30      26 sunspot <sunspot0105@gmail.com>
    31      22 Vikhyat Umrao <vumrao@redhat.com>
    32      15 Xiaoxi Chen <xiaoxchen@ebay.com>
    33      15 Richard W.M. Jones <rjones@redhat.com>
    34      12 Xinze Chi <xinze@xsky.com>
    35      12 Venky Shankar <vshankar@redhat.com>
    36      12 Orit Wasserman <owasserm@redhat.com>
    37      12 Dan Mick <dmick@redhat.com>
    38      12 Brad Hubbard <bhubbard@redhat.com>
    39      10 Wei Jin <wjin.cn@gmail.com>
    40       8 Xiaowei Chen <chen.xiaowei@h3c.com>
    41       8 Vitja Makarov <vitja.makarov@gmail.com>
    42       8 John Coyle <dx9err@gmail.com>
    43       8 Jenkins <jenkins@ceph.com>
    44       6 Mehdi Abaakouk <sileht@redhat.com>
    45       6 Josh Durgin <jdurgin@redhat.com>
    46       5 Willem Jan Withagen <wjw@digiware.nl>
    47       5 Haomai Wang <haomai@xsky.com>
    48       4 scienceluo <luo.kexue@zte.com.cn>
    49       4 Qiankun Zheng <zheng.qiankun@h3c.com>
    50       2 Star Guo <star.guo@mevoco.com>
    51       2 Robin H. Johnson <robin.johnson@dreamhost.com>
    52       2 Qinghua Jin <qhjin_dev@163.com>
    53       1 Ning Yao <yaoning@unitedstack.com>
    54       1 Javier M. Mellid <jmunhoz@igalia.com>
    55       1 Ira Cooper <ira@redhat.com>

Number of lines added and removed, by organization
     1   13086 Red Hat <contact@redhat.com>
     2    1241 SUSE <contact@suse.com>
     3    1056 Mirantis <contact@mirantis.com>
     4     303 ZTE <contact@zte.com.cn>
     5     254 Mellanox <contact@mellanox.com>
     6     127 SanDisk <contact@sandisk.com>
     7      54 Unaffiliated <no@organization.net>
     8      52 XSky <contact@xsky.com>
     9      40 Intel <contact@intel.com>
    10      33 Wido 42on <contact@42on.com>
    11      32 Huazhong University of Science and Technology
<contact@hust.edu.cn>
    12      29 Easystack <contact@easystack.cn>
    13      15 Ebay <contact@ebay.com>
    14      12 H3C <contact@h3c.com>
    15       5 Digiware <contact@digiware.nl>
    16       2 Mevoco <contact@mevoco.com>
    17       2 DreamHost <contact@dreamhost.com>
    18       1 UnitedStack <contact@unitedstack.com>
    19       1 Igalia <contact@igalia.com>

Commits, by authors
     1       61 Sage Weil <sweil@redhat.com>
     2       49 Jason Dillaman <dillaman@redhat.com>
     3       35 John Spray <jspray@redhat.com>
     4       28 Xie Xingguo <xie.xingguo@zte.com.cn>
     5       23 Loic Dachary <ldachary@redhat.com>
     6       17 Erwan Velu <erwan@redhat.com>
     7       14 Kefu Chai <kchai@redhat.com>
     8       13 Yehuda Sadeh <ysadehwe@redhat.com>
     9       10 Samuel Just <sjust@redhat.com>
    10       10 David Zafman <dzafman@redhat.com>
    11        9 Nathan Cutler <ncutler@suse.com>
    12        8 Ricardo Dias <rdias@suse.com>
    13        7 Casey Bodley <cbodley@redhat.com>
    14        6 Yan, Zheng <zyan@redhat.com>
    15        6 Mykola Golub <mgolub@mirantis.com>
    16        6 Ma Jianpeng <jianpeng.ma@intel.com>
    17        6 Abhishek Lekshmanan <abhishek@suse.com>
    18        3 Wido den Hollander <wido@42on.com>
    19        3 Wei Jin <wjin.cn@gmail.com>
    20        3 runsisi <runsisi@hust.edu.cn>
    21        3 Roi Dayan <roid@mellanox.com>
    22        3 Matt Benjamin <mbenjamin@redhat.com>
    23        3 Dongsheng Yang <dongsheng.yang@easystack.cn>
    24        3 Brad Hubbard <bhubbard@redhat.com>
    25        2 Zhiqiang Wang <zhiqiang@xsky.com>
    26        2 Vikhyat Umrao <vumrao@redhat.com>
    27        2 Orit Wasserman <owasserm@redhat.com>
    28        2 Josh Durgin <jdurgin@redhat.com>
    29        2 Haomai Wang <haomai@xsky.com>
    30        2 Dan Mick <dmick@redhat.com>
    31        2 Adam Kupczyk <akupczyk@mirantis.com>
    32        1 Xinze Chi <xinze@xsky.com>
    33        1 Xiaoxi Chen <xiaoxchen@ebay.com>
    34        1 Xiaowei Chen <chen.xiaowei@h3c.com>
    35        1 Willem Jan Withagen <wjw@digiware.nl>
    36        1 Vitja Makarov <vitja.makarov@gmail.com>
    37        1 Venky Shankar <vshankar@redhat.com>
    38        1 sunspot <sunspot0105@gmail.com>
    39        1 Star Guo <star.guo@mevoco.com>
    40        1 Song Baisen <song.baisen@zte.com.cn>
    41        1 Somnath Roy <somnath.roy@sandisk.com>
    42        1 scienceluo <luo.kexue@zte.com.cn>
    43        1 Robin H. Johnson <robin.johnson@dreamhost.com>
    44        1 Richard W.M. Jones <rjones@redhat.com>
    45        1 Qinghua Jin <qhjin_dev@163.com>
    46        1 Qiankun Zheng <zheng.qiankun@h3c.com>
    47        1 Ning Yao <yaoning@unitedstack.com>
    48        1 Mehdi Abaakouk <sileht@redhat.com>
    49        1 Marcus Watts <mwatts@redhat.com>
    50        1 John Coyle <dx9err@gmail.com>
    51        1 Jenkins <jenkins@ceph.com>
    52        1 Javier M. Mellid <jmunhoz@igalia.com>
    53        1 Ira Cooper <ira@redhat.com>
    54        1 Ali Maredia <amaredia@redhat.com>
    55        1 Alexey Sheplyakov <asheplyakov@mirantis.com>

Commits, by organizations
     1      266 Red Hat <contact@redhat.com>
     2       30 ZTE <contact@zte.com.cn>
     3       23 SUSE <contact@suse.com>
     4        9 Mirantis <contact@mirantis.com>
     5        7 Unaffiliated <no@organization.net>
     6        6 Intel <contact@intel.com>
     7        5 XSky <contact@xsky.com>
     8        3 Wido 42on <contact@42on.com>
     9        3 Mellanox <contact@mellanox.com>
    10        3 Huazhong University of Science and Technology
<contact@hust.edu.cn>
    11        3 Easystack <contact@easystack.cn>
    12        2 H3C <contact@h3c.com>
    13        1 UnitedStack <contact@unitedstack.com>
    14        1 SanDisk <contact@sandisk.com>
    15        1 Mevoco <contact@mevoco.com>
    16        1 Igalia <contact@igalia.com>
    17        1 Ebay <contact@ebay.com>
    18        1 DreamHost <contact@dreamhost.com>
    19        1 Digiware <contact@digiware.nl>

Reviews, by authors (one review spans multiple commits)
     1       25 Sage Weil <sweil@redhat.com>
     2       21 Kefu Chai <kchai@redhat.com>
     3       18 Josh Durgin <jdurgin@redhat.com>
     4       10 Orit Wasserman <owasserm@redhat.com>
     5       10 Jason Dillaman <dillaman@redhat.com>
     6        7 Samuel Just <sjust@redhat.com>
     7        7 Loic Dachary <ldachary@redhat.com>
     8        5 Boris Ranto <branto@redhat.com>
     9        4 Yehuda Sadeh <ysadehwe@redhat.com>
    10        4 Greg Farnum <gfarnum@redhat.com>
    11        3 Abhishek Lekshmanan <abhishek@suse.com>
    12        2 Yan, Zheng <zyan@redhat.com>
    13        2 Nathan Cutler <ncutler@suse.com>
    14        2 John Spray <jspray@redhat.com>
    15        2 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@suse.de>
    16        2 Casey Bodley <cbodley@redhat.com>
    17        1 Yankun Li <liyankun@unitedstack.com>
    18        1 Robert LeBlanc <robert.leblanc@endurance.com>
    19        1 Haomai Wang <haomai@xsky.com>
    20        1 David Zafman <dzafman@redhat.com>
    21        1 Dan Mick <dmick@redhat.com>

Reviews, by organizations (one review spans multiple commits)
     1      119 Red Hat <contact@redhat.com>
     2        6 SUSE <contact@suse.com>
     3        1 XSky <contact@xsky.com>
     4        1 UnitedStack <contact@unitedstack.com>
     5        1 Reliance Jio Infocomm Ltd. <contact@ril.com>
     6        1 Endurance International Group <contact@endurance.com>
=3D=3D=3D

Cheers
Swami
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
