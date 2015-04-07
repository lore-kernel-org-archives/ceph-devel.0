From: Yann Dupont <yann@objoo.org>
Subject: v0.94 "Hammer" contributors credits
Date: Tue, 07 Apr 2015 23:34:07 +0200
Message-ID: <55244D4F.4010100@objoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:56770 "EHLO
	4.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbbDGWL3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Apr 2015 18:11:29 -0400
Received: from mail135.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 83ACFFF9839
	for <ceph-devel@vger.kernel.org>; Tue,  7 Apr 2015 23:34:09 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Ceph,

Here is a sorted list of authors and organizations who contributed
to v0.94 "Hammer", by number of commits or reviews back to v0.93.
The affiliation of authors to organizations can be updated by
submitting a patch to :
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of
the number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, the details are at
https://wiki.ceph.com/Community/Ceph_contributors_list_maintenance_guid=
e

As hammer is a stable version, this post will be followed by another=20
with contributors back from previous stable version.

Number of lines added and removed, by authors
      1	  3811 Samuel Just <sjust@redhat.com>
      2	  3662 Boris Ranto <branto@redhat.com>
      3	  1246 Jason Dillaman <dillaman@redhat.com>
      4	  1224 David Zafman <dzafman@redhat.com>
      5	   473 Sage Weil <sweil@redhat.com>
      6	   353 Yehuda Sadeh <ysadehwe@redhat.com>
      7	   349 Ken Dreyer <kdreyer@redhat.com>
      8	   159 Loic Dachary <ldachary@redhat.com>
      9	   149 Takeshi Miyamae <miyamae.takeshi@jp.fujitsu.com>
     10	   122 Noah Watkins <nwatkins@redhat.com>
     11	    97 Josh Durgin <jdurgin@redhat.com>
     12	    61 Ilya Dryomov <idryomov@redhat.com>
     13	    59 Jo=E3o Eduardo Lu=EDs <joao@redhat.com>
     14	    29 Kefu Chai <kchai@redhat.com>
     15	    23 Matt Benjamin <matt@cohortfs.com>
     16	    22 Ma Jianpeng <jianpeng.ma@intel.com>
     17	    20 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     18	    18 Rohan Mars <code@rohanmars.com>
     19	    17 Yan, Zheng <zyan@redhat.com>
     20	    11 Raju Kurunkad <raju.kurunkad@sandisk.com>
     21	     8 Jenkins <jenkins@inktank.com>
     22	     7 Xiong Yiliang <xiongyiliang@xunlei.com>
     23	     4 Haomai Wang <haomaiwang@gmail.com>
     24	     3 Greg Farnum <gfarnum@redhat.com>

Number of lines added and removed, by organization
      1	 11665 Red Hat <contact@redhat.com>
      2	   149 Fujitsu <contact@fujitsu.com>
      3	    25 Unaffiliated <no@organization.net>
      4	    23 CohortFS, LLC <contact@cohortfs.com>
      5	    22 Intel <contact@intel.com>
      6	    20 Deutsche Telekom <contact@telekom.de>
      7	    11 SanDisk <contact@sandisk.com>
      8	     8 Inktank <contact@inktank.com>
      9	     4 UnitedStack <contact@unitedstack.com>

Commits, by authors
      1	     33 Samuel Just <sjust@redhat.com>
      2	     33 Jason Dillaman <dillaman@redhat.com>
      3	     18 Sage Weil <sweil@redhat.com>
      4	     14 David Zafman <dzafman@redhat.com>
      5	     14 Boris Ranto <branto@redhat.com>
      6	     11 Yehuda Sadeh <ysadehwe@redhat.com>
      7	     11 Loic Dachary <ldachary@redhat.com>
      8	      6 Jo=E3o Eduardo Lu=EDs <joao@redhat.com>
      9	      5 Josh Durgin <jdurgin@redhat.com>
     10	      3 Ma Jianpeng <jianpeng.ma@intel.com>
     11	      2 Noah Watkins <nwatkins@redhat.com>
     12	      2 Matt Benjamin <matt@cohortfs.com>
     13	      2 Ken Dreyer <kdreyer@redhat.com>
     14	      2 Kefu Chai <kchai@redhat.com>
     15	      2 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     16	      1 Yan, Zheng <zyan@redhat.com>
     17	      1 Xiong Yiliang <xiongyiliang@xunlei.com>
     18	      1 Takeshi Miyamae <miyamae.takeshi@jp.fujitsu.com>
     19	      1 Rohan Mars <code@rohanmars.com>
     20	      1 Raju Kurunkad <raju.kurunkad@sandisk.com>
     21	      1 Jenkins <jenkins@inktank.com>
     22	      1 Ilya Dryomov <idryomov@redhat.com>
     23	      1 Haomai Wang <haomaiwang@gmail.com>
     24	      1 Greg Farnum <gfarnum@redhat.com>

Commits, by organizations
      1	    154 Red Hat <contact@redhat.com>
      2	      3 Intel <contact@intel.com>
      3	      2 Unaffiliated <no@organization.net>
      4	      2 Deutsche Telekom <contact@telekom.de>
      5	      2 CohortFS, LLC <contact@cohortfs.com>
      6	      1 UnitedStack <contact@unitedstack.com>
      7	      1 SanDisk <contact@sandisk.com>
      8	      1 Inktank <contact@inktank.com>
      9	      1 Fujitsu <contact@fujitsu.com>

Reviews, by authors (one review spans multiple commits)
      1	     26 Sage Weil <sweil@redhat.com>
      2	      8 Samuel Just <sjust@redhat.com>
      3	      7 Loic Dachary <ldachary@redhat.com>
      4	      7 Josh Durgin <jdurgin@redhat.com>
      5	      5 Kefu Chai <kchai@redhat.com>
      6	      2 Greg Farnum <gfarnum@redhat.com>
      7	      1 Yehuda Sadeh <ysadehwe@redhat.com>
      8	      1 Yann Dupont <yann@objoo.org>
      9	      1 Nilamdyuti Goswami <ngoswami@redhat.com>
     10	      1 Jo=E3o Eduardo Lu=EDs <joao@redhat.com>
     11	      1 Jason Dillaman <dillaman@redhat.com>
     12	      1 Dan Mick <dmick@redhat.com>

Reviews, by organizations (one review spans multiple commits)
      1	     60 Red Hat <contact@redhat.com>
      2	      1 Unaffiliated <no@organization.net>


Cheers,
Yann

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
