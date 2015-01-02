From: Travis Rhoden <trhoden@gmail.com>
Subject: ceph-deploy osd destroy feature
Date: Fri, 2 Jan 2015 16:31:11 -0500
Message-ID: <CACkq2moPdXgDGCtr-jtd+rxEGT3H_SFnVGruvKqfXDuvU8eagg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:36259 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbbABVbe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jan 2015 16:31:34 -0500
Received: by mail-la0-f41.google.com with SMTP id hv19so15736763lab.14
        for <ceph-devel@vger.kernel.org>; Fri, 02 Jan 2015 13:31:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi everyone,

There has been a long-standing request [1] to implement an OSD
"destroy" capability to ceph-deploy.  A community user has submitted a
pull request implementing this feature [2].  While the code needs a
bit of work (there are a few things to work out before it would be
ready to merge), I want to verify that the approach is sound before
diving into it.

As it currently stands, the new feature would do allow for the following:

ceph-deploy osd destroy <host> --osd-id <id>

From that command, ceph-deploy would reach out to the host, do "ceph
osd out", stop the ceph-osd service for the OSD, then finish by doing
"ceph osd crush remove", "ceph auth del", and "ceph osd rm".  Finally,
it would umount the OSD, typically in /var/lib/ceph/osd/...


Does this high-level approach seem sane?  Anything that is missing
when trying to remove an OSD?


There are a few specifics to the current PR that jump out to me as
things to address.  The format of the command is a bit rough, as other
"ceph-deploy osd" commands take a list of [host[:disk[:journal]]] args
to specify a bunch of disks/osds to act on at one.  But this command
only allows one at a time, by virtue of the --osd-id argument.  We
could try to accept [host:disk] and look up the OSD ID from that, or
potentially take [host:ID] as input.

Additionally, what should be done with the OSD's journal during the
destroy process?  Should it be left untouched?

Should there be any additional barriers to performing such a
destructive command?  User confirmation?


 - Travis

[1] http://tracker.ceph.com/issues/3480
[2] https://github.com/ceph/ceph-deploy/pull/254
