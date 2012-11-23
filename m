From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: RE: [Discussion] Enhancement for CRUSH rules
Date: Fri, 23 Nov 2012 03:38:50 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC5C7BD1@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35862 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507Ab2KWDiy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 22:38:54 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi list,
=A0=A0=A0=A0 I am thinking about the possibility to add some primitive =
in CRUSH to meet the following user stories:
A. "Same host", "Same rack"
	To balance between availability and performance ,one may like such a r=
ule: 3 Replicas, Replica 1 and Replica 2 should in the same rack while =
Replica 3 reside in another rack.This is common because a typical d	epl=
oyment in datacenter usually has much fewer uplink bandwidth than backb=
one bandwidth.

More aggressive guys may even want same host, since the most common fai=
lure is disk failure. And we have several disk (also means several OSDs=
) reside in the same physical machine. If we can place Replica 1 & 2 on=
 the same host but replica 3 in somewhere else.It will not only reduce =
replication traffic but also saving a lot of time & bandwidth when disk=
 failure happened and a recovery take place.
B."local"
	 Although we cannot mount RBD volumes to where a OSD running at, but Q=
EMU canbe used. This scenarios is really common in cloud computing. We =
have a large amount of compute-nodes, just plug in some disks 	and make=
 the machines reused for Ceph cluster. To reduce network traffic and la=
tency , if it is possible to have some placement-group-maybe 3 PG for a=
 compute-node. Define the rules like: primary copy of the PG 	should (i=
f possible) reside in localhost, the second replica should go different=
 places
=09
	By doing this , a significant amount of network bandwidth & a RTT can =
be saved. What's more ,since read always go to primary, it will benefit=
 a lot from such mechanism.

It looks to me that A is simpler but B seems much complex. Hoping for i=
nputs.

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Xiao=
xi
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
