From: Jerker Nyberg <jerker@Update.UU.SE>
Subject: docs
Date: Fri, 22 Mar 2013 13:37:16 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1303221315230.22502@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from Psilocybe.Update.UU.SE ([130.238.19.25]:35537 "EHLO
	Psilocybe.Update.UU.SE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab3CVMpo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Mar 2013 08:45:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by Psilocybe.Update.UU.SE (Postfix) with ESMTP id DA04630076
	for <ceph-devel@vger.kernel.org>; Fri, 22 Mar 2013 13:37:16 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


There seem to be a missing argument to ceph osd lost (also in help for the 
command).

http://ceph.com/docs/master/rados/operations/control/#osd-subsystem

src/tools/ceph.cc
src/test/cli/ceph/help.t
doc/rados/operations/control.rst


The documentation for development release packages is slightly confused. 
Should it not refer to http://ceph.com/rpm-testing for development release 
packages? (Also, the ceph-release package in the development release does 
not refer to itself (in /etc/yum.repos.d/ceph.repo) but to 
(http://ceph.com/rpms) packages.)

http://ceph.com/docs/master/install/rpm/


Do you want patches?

--jerker
