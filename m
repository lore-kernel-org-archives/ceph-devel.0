From: Gregory Farnum <greg@inktank.com>
Subject: Re: [Discussion] Enhancement for CRUSH rules
Date: Sat, 24 Nov 2012 08:54:20 -0800
Message-ID: <5E2C9C0151BC449E92C111CBB0D8596C@inktank.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC5C7BD1@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:47918 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab2KXQyY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Nov 2012 11:54:24 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so3064240dak.19
        for <ceph-devel@vger.kernel.org>; Sat, 24 Nov 2012 08:54:22 -0800 (PST)
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC5C7BD1@SHSMSX102.ccr.corp.intel.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Chen=2C_Xiaoxi?= <xiaoxi.chen@intel.com>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Thursday, November 22, 2012 at 7:38 PM, Chen, Xiaoxi wrote:
> Hi list,
> I am thinking about the possibility to add some primitive in CRUSH to=
 meet the following user stories:
> A. "Same host", "Same rack"
> To balance between availability and performance ,one may like such a =
rule: 3 Replicas, Replica 1 and Replica 2 should in the same rack while=
 Replica 3 reside in another rack.This is common because a typical d ep=
loyment in datacenter usually has much fewer uplink bandwidth than back=
bone bandwidth.
> =20
> More aggressive guys may even want same host, since the most common f=
ailure is disk failure. And we have several disk (also means several OS=
Ds) reside in the same physical machine. If we can place Replica 1 & 2 =
on the same host but replica 3 in somewhere else.It will not only reduc=
e replication traffic but also saving a lot of time & bandwidth when di=
sk failure happened and a recovery take place.
This is a feature we're definitely interested in! The difficulty with t=
his (as I understand it) is that right now the CRUSH code is very paral=
lel and even-handed =E2=80=94 each instruction in a CRUSH rule is execu=
ted in sequence on every bucket it has in its set. Somebody would need =
to change it so that you could say something like:
step take root
step choose firstn -1 rack
step rack0 choose 2 device
step rackn choose 1 device
emit
 =20
> B."local"
> Although we cannot mount RBD volumes to where a OSD running at, but Q=
EMU canbe used. This scenarios is really common in cloud computing. We =
have a large amount of compute-nodes, just plug in some disks and make =
the machines reused for Ceph cluster. To reduce network traffic and lat=
ency , if it is possible to have some placement-group-maybe 3 PG for a =
compute-node. Define the rules like: primary copy of the PG should (if =
possible) reside in localhost, the second replica should go different p=
laces
> =20
> By doing this , a significant amount of network bandwidth & a RTT can=
 be saved. What's more ,since read always go to primary, it will benefi=
t a lot from such mechanism.
> =20
> It looks to me that A is simpler but B seems much complex. Hoping for=
 inputs.
This has existed previously, in the form of local PGs and CRUSH force-f=
eeding. We ripped it out in the name of simplicity and due to never rea=
lly finding a justifiable use-case =E2=80=94 the one we had was Hadoop,=
 and the rumors we heard out of the big shops were that for that worklo=
ad, local writes weren't actually a win=E2=80=A6
The other issue with it is that the data use over the cluster's disks c=
an become pretty badly unbalanced since placement is no longer pseudo-r=
andom, and Ceph still needs a lot of work on full-disk management befor=
e that's something we want to allow.
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
