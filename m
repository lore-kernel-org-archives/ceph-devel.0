From: Zenon Panoussis <oracle@provocation.net>
Subject: crush rule definitions
Date: Wed, 04 May 2011 20:16:19 +0200
Message-ID: <4DC197F3.3050200@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:38308 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab1EDSQ3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 14:16:29 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi

I thought that min_size in crush is obvious, but the more I read the more
I tend to doubt. So I might as well ask:

With a crushmap like this

===
type 0 device
type 1 host
type 2 root

[definitions for the above; hosts contain devices, root contains hosts]

rule data {
        ruleset 0
        type replicated
        min_size 2
        max_size 2
        step take root
        step chooseleaf firstn 0 type host
        step emit
}
===

does "min_size 2, max_size 2" mean that I want "2 copies of the data on each
host" or "2 copies of the data in total in the entire cluster"?

Z



