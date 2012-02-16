From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: ceph-resource-agents
Date: Thu, 16 Feb 2012 12:12:42 -0800
Message-ID: <989BA3D6-5844-4566-AA9B-69A0472C0228@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:55112 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321Ab2BPUMp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2012 15:12:45 -0500
Received: from [131.106.59.173] (205.158.58.247.ptr.us.xo.net [205.158.58.247])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id 1600C774C005
	for <ceph-devel@vger.kernel.org>; Thu, 16 Feb 2012 12:12:45 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Ubuntu LTS 10.04, ceph-resource-agents package depends on resource-agents that seems to have not shown up until 11.10 so there is a dependency problem:

nwatkins@piha:~/Projects/ceph$ sudo apt-get install ceph-resource-agents
Reading package lists... Done
Building dependency tree       
Reading state information... Done
ceph-resource-agents is already the newest version.
You might want to run 'apt-get -f install' to correct these:
The following packages have unmet dependencies:
 ceph-resource-agents : Depends: resource-agents but it is not installable
                        Recommends: pacemaker but it is not going to be installed
E: Unmet dependencies. Try 'apt-get -f install' with no packages (or specify a solution).


Aside from that dependency problem, is it safe to completely omit the ceph-resource-agents package for a Ceph install?

-Noah