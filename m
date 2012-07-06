From: <Eric_YH_Chen@wiwynn.com>
Subject: rbd map fail when the crushmap algorithm changed to tree
Date: Fri, 6 Jul 2012 15:27:52 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49D019C0EA7@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw3.wistron.com ([220.128.89.23]:64751 "EHLO
	TWNHUMSW3.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561Ab2GFHjY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 03:39:24 -0400
Received: from twnhufe2.whq.wistron (unverified [10.37.31.102]) by TWNHUMSW3.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta56953336fc0a816711e0c@TWNHUMSW3.wistron.com> for <ceph-devel@vger.kernel.org>;
 Fri, 6 Jul 2012 15:31:04 +0800
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

Hi all:

Here is the original crushmap, I change the algorithm of host to "tree"
and 
set back to ceph cluster. However, when I try to map one imge to 
rados block device (RBD), it would hang and no response until I press
ctrl-c.
( rbd map xxxx  => then hang)

Is there any wrong in the crushmap? Thanks for help.

=============================================
# devices
device 0 osd.0
device 1 osd.1
device 2 osd.2
device 3 osd.3
device 4 osd.4
device 5 osd.5
device 6 osd.6
device 7 osd.7
device 8 osd.8
device 9 osd.9
device 10 osd.10
device 11 osd.11

# types
type 0 osd
type 1 host
type 2 rack
type 3 row
type 4 room
type 5 datacenter
type 6 pool

# buckets
host store-001 {
        id -2           # do not change unnecessarily
        # weight 12.000
        alg straw
        hash 0  # rjenkins1
        item osd.0 weight 1.000
        item osd.1 weight 1.000
        item osd.10 weight 1.000
        item osd.11 weight 1.000
        item osd.2 weight 1.000
        item osd.3 weight 1.000
        item osd.4 weight 1.000
        item osd.5 weight 1.000
        item osd.6 weight 1.000
        item osd.7 weight 1.000
        item osd.8 weight 1.000
        item osd.9 weight 1.000
}
rack unknownrack {
        id -3           # do not change unnecessarily
        # weight 12.000
        alg straw
        hash 0  # rjenkins1
        item store-001 weight 12.000
}
pool default {
        id -1           # do not change unnecessarily
        # weight 12.000
        alg straw
        hash 0  # rjenkins1
        item unknownrack weight 12.000
}

# rules
rule data {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take default
        step choose firstn 0 type osd
        step emit
}
rule metadata {
        ruleset 1
        type replicated
        min_size 1
        max_size 10
        step take default
        step choose firstn 0 type osd
        step emit
}
rule rbd {
        ruleset 2
        type replicated
        min_size 1
        max_size 10
        step take default
        step choose firstn 0 type osd
        step emit
}


