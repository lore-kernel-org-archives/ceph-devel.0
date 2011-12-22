From: <Eric_YH_Chen@wistron.com>
Subject: Do not understand some terms about cluster health
Date: Thu, 22 Dec 2011 11:47:58 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49DA7E3E2@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw4.wistron.com ([220.128.89.24]:62433 "EHLO
	TWNHUMSW4.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab1LVDsA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Dec 2011 22:48:00 -0500
Received: from twnhufe3.whq.wistron (unverified [10.37.31.103]) by TWNHUMSW4.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta172073e0bc0a816721e0c@TWNHUMSW4.wistron.com> for <ceph-devel@vger.kernel.org>;
 Thu, 22 Dec 2011 11:53:31 +0800
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Chris_YT_Huang@wistron.com

Hi, All

   When I type 'ceph health' to get the status of cluster, it will show
some information.

   Would you please to explain the term?

   Ex: HEALTH_WARN 3/54 degraded (5.556%)
 
         What does "degraded" mean ?  Is it a serious error and how to
fix it ? 

   Ex: HEALTH_WARN 264 pgs degraded, 6/60 degraded (10.000%); 3/27
unfound (11.111%)

         What does "unfound" mean?  Could we recover the data?  
         Would it cause the whole data in rbd image corrupted and never
access ?

   When I type 'ceph pg dump', it would show like this.  Would you
please explain what is "hb in" and "hb out" ?

	osdstat  kbused          kbavail          kb              hb in
hb out
	0       17300872        1884175720      1906311168
[6,7,8,9,10,11] [6,7,8,9,10,11]
	1       16661664        1884808728      1906311168
[6,7,8,9,10,11] [6,7,8,9,10,11]
	2       15695664        1886027584      1906311168
[6,7,8,9,10,11] [6,7,8,9,10,11]
	3       16463440        1885005328      1906311168
[6,7,8,9,10,11] [6,7,8,9,10,11]
	4       14101016        1888130760      1906311168
[6,7,8,9,10,11] [6,7,8,9,10,11]
	5       14015804        1888215124      1906311168
[6,7,8,9,10,11] [6,7,8,9,10,11]
	6       19312280        1881660776      1906311168
[0,1,2,3,4,5]   [0,1,2,3,4,5]
	7       14451992        1887521200      1906311168
[0,1,2,3,4,5]   [0,1,2,3,4,5]
	8       16336028        1885393468      1906311168
[0,1,2,3,4,5]   [0,1,2,3,4,5]
	9       16697868        1884773940      1906311168
[0,1,2,3,4,5]   [0,1,2,3,4,5]
	10      13530456        1888695776      1906311168
[0,1,2,3,4,5]   [0,1,2,3,4,5]
	11      13921908        1888307364      1906311168
[0,1,2,3,4,5]   [0,1,2,3,4,5]
	sum    188488992       22632715768     22875734016      


  And from the latest document, I know we can do the cluster snapshot by
" ceph osd cluster_snap <name>"
  Is that means we can rollback the data from the snapshot? Do you have
any related document to show how to operate it?

  Thanks a lot!




