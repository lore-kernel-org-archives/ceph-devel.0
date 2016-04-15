From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: v10.1.2 Contributor credits
Date: Fri, 15 Apr 2016 11:56:36 +0530
Message-ID: <CANA9Uk4ayNQUojr0M-+emNgT7U27H4iS7X7Xorn1yzWh_3Nb1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34621 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbcDOG0h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2016 02:26:37 -0400
Received: by mail-vk0-f53.google.com with SMTP id e185so136259985vkb.1
        for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2016 23:26:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v10.1.2, by number of commits or reviews back to v10.1.2. The
affiliation of authors to organizations can be updated by submitting a
patch to https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of
the number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at
http://tracker.ceph.com/projects/ceph/wiki/Ceph_contributors_list_maintenance_guide

==
Number of lines added and removed, by authors
     1     959 Sage Weil <sweil@redhat.com>
     2     798 Samuel Just <sjust@redhat.com>
     3     385 Greg Farnum <gfarnum@redhat.com>
     4     282 Jason Dillaman <dillaman@redhat.com>
     5     208 Loic Dachary <ldachary@redhat.com>
     6     102 John Spray <jspray@redhat.com>
     7      94 Robin H. Johnson <robin.johnson@dreamhost.com>
     8      60 Xie Xingguo <xie.xingguo@zte.com.cn>
     9      54 Yan, Zheng <zyan@redhat.com>
    10      37 Matt Benjamin <mbenjamin@redhat.com>
    11      25 Casey Bodley <cbodley@redhat.com>
    12      24 Javier M. Mellid <jmunhoz@igalia.com>
    13      18 You Ji <youji@ebay.com>
    14      16 Ricardo Dias <rdias@suse.com>
    15      15 Orit Wasserman <owasserm@redhat.com>
    16      13 Adam C. Emerson <aemerson@redhat.com>
    17      10 Swami Reddy <swami.reddy@ril.com>
    18       8 Ren Huanwen <ren.huanwen@zte.com.cn>
    19       8 Jenkins <jenkins@ceph.com>
    20       5 James Page <james.page@ubuntu.com>
    21       4 Kris Jurka <kjurka@locatortechnologies.com>
    22       3 runsisi <runsisi@zte.com.cn>
    23       3 Karol Mroz <kmroz@suse.com>
    24       2 weiqiaomiao <wei.qiaomiao@zte.com.cn>
    25       2 Wei Jin <wjin.cn@gmail.com>
    26       2 Michal Jarzabek <stiopa@gmail.com>
    27       2 Kefu Chai <kchai@redhat.com>
    28       2 Josh Durgin <jdurgin@redhat.com>
    29       2 John Wilkins <jwilkins@redhat.com>
    30       2 John Coyle <dx9err@gmail.com>
    31       2 Abhishek Lekshmanan <abhishek@suse.com>

Number of lines added and removed, by organization
     1    2892 Red Hat <contact@redhat.com>
     2      94 DreamHost <contact@dreamhost.com>
     3      73 ZTE <contact@zte.com.cn>
     4      24 Igalia <contact@igalia.com>
     5      21 SUSE <contact@suse.com>
     6      18 Ebay <contact@ebay.com>
     7      10 Reliance Jio Infocomm Ltd. <contact@ril.com>
     8       6 Unaffiliated <no@organization.net>
     9       5 Canonical <contact@canonical.com>
    10       4 Locator Technologies <contact@locatortechnologies.com>

Commits, by authors
     1       22 Sage Weil <sweil@redhat.com>
     2       12 Samuel Just <sjust@redhat.com>
     3       10 Xie Xingguo <xie.xingguo@zte.com.cn>
     4       10 Swami Reddy <swami.reddy@ril.com>
     5       10 Greg Farnum <gfarnum@redhat.com>
     6        7 Jason Dillaman <dillaman@redhat.com>
     7        5 Matt Benjamin <mbenjamin@redhat.com>
     8        5 Loic Dachary <ldachary@redhat.com>
     9        5 John Spray <jspray@redhat.com>
    10        4 You Ji <youji@ebay.com>
    11        4 Yan, Zheng <zyan@redhat.com>
    12        3 Robin H. Johnson <robin.johnson@dreamhost.com>
    13        3 Orit Wasserman <owasserm@redhat.com>
    14        2 Ricardo Dias <rdias@suse.com>
    15        2 Karol Mroz <kmroz@suse.com>
    16        2 Javier M. Mellid <jmunhoz@igalia.com>
    17        2 Adam C. Emerson <aemerson@redhat.com>
    18        1 weiqiaomiao <wei.qiaomiao@zte.com.cn>
    19        1 Wei Jin <wjin.cn@gmail.com>
    20        1 runsisi <runsisi@zte.com.cn>
    21        1 Ren Huanwen <ren.huanwen@zte.com.cn>
    22        1 Michal Jarzabek <stiopa@gmail.com>
    23        1 Kris Jurka <kjurka@locatortechnologies.com>
    24        1 Kefu Chai <kchai@redhat.com>
    25        1 Josh Durgin <jdurgin@redhat.com>
    26        1 John Wilkins <jwilkins@redhat.com>
    27        1 John Coyle <dx9err@gmail.com>
    28        1 Jenkins <jenkins@ceph.com>
    29        1 James Page <james.page@ubuntu.com>
    30        1 Casey Bodley <cbodley@redhat.com>
    31        1 Abhishek Lekshmanan <abhishek@suse.com>

Commits, by organizations
     1       80 Red Hat <contact@redhat.com>
     2       13 ZTE <contact@zte.com.cn>
     3       10 Reliance Jio Infocomm Ltd. <contact@ril.com>
     4        5 SUSE <contact@suse.com>
     5        4 Ebay <contact@ebay.com>
     6        3 Unaffiliated <no@organization.net>
     7        3 DreamHost <contact@dreamhost.com>
     8        2 Igalia <contact@igalia.com>
     9        1 Locator Technologies <contact@locatortechnologies.com>
    10        1 Canonical <contact@canonical.com>

Reviews, by authors (one review spans multiple commits)
     1        8 Sage Weil <sweil@redhat.com>
     2        7 Greg Farnum <gfarnum@redhat.com>
     3        6 Kefu Chai <kchai@redhat.com>
     4        5 Josh Durgin <jdurgin@redhat.com>
     5        4 John Spray <jspray@redhat.com>
     6        3 Samuel Just <sjust@redhat.com>
     7        3 Orit Wasserman <owasserm@redhat.com>
     8        3 Loic Dachary <ldachary@redhat.com>
     9        3 Jason Dillaman <dillaman@redhat.com>
    10        2 Abhishek Lekshmanan <abhishek@suse.com>
    11        1 Ricardo Dias <rdias@suse.com>
    12        1 Mykola Golub <mgolub@mirantis.com>
    13        1 David Zafman <dzafman@redhat.com>
    14        1 Dan Mick <dmick@redhat.com>

Reviews, by organizations (one review spans multiple commits)
     1       44 Red Hat <contact@redhat.com>
     2        2 Reliance Jio Infocomm Ltd. <contact@ril.com>
     3        1 SUSE <contact@suse.com>
     4        1 Mirantis <contact@mirantis.com>
===

Cheers
Swami
