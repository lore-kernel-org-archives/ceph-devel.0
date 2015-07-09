From: Ken Dreyer <kdreyer@redhat.com>
Subject: debian packaging for wip-10587-split-servers
Date: Thu, 9 Jul 2015 09:57:12 -0600
Message-ID: <559E99D8.9060208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40229 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177AbbGIP5O (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Jul 2015 11:57:14 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-maintainers@ceph.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I need some Debian packaging help :)

For http://tracker.ceph.com/issues/10587 I'm working to split out the
"ceph-mon" and "ceph-osd" servers from the main "ceph" package. The goal
is to allow someone to "apt-get install" only a monitor or an OSD
without having to install the binaries for both. (ceph-mds is already
split out in this fashion.)

Here's what I'd like the process to look like for users:

1) User installs a Hammer MON/OSD with "apt-get install ceph".
2) User adjusts the sources.list to point to a newer Ceph version with
   the server split.
3) User runs "apt-get update"
4) Apt installs all three packages onto the user's system: "ceph",
   "ceph-mon", and "ceph-osd".
5) User then has the freedom to uninstall "ceph-mon" or "ceph-osd" as
   appropriate.

I've gotten about 90% of the way there with the Debian changes, but I
can't make "apt-get upgrade" do what I want in step 4. The only way I
can make Apt pull in all three (ceph/ceph-mon/ceph-osd) during an
"upgrade" operation is to make the "ceph" package depend on the -mon and
-osd sub-packages. That option means that step 5 above doesn't work.

I must be missing something in ./debian/control to make this work.

For the RPMs, I was able to make this work by introducing a
"ceph-compat" metapackage that used RPM's "Obsoletes" to replace the old
"ceph" and require "ceph-mon" and "ceph-osd" (which in turn required the
new "ceph"). But I'm not sure how to do that with Debian.

Should I use a ceph-compat package? Something else?

My WIP branch in GitHub is
https://github.com/ceph/ceph/tree/wip-10587-split-servers . Any tips
appreciated!

- Ken
