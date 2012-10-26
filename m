From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Client hanging on mkdirs with logs
Date: Fri, 26 Oct 2012 10:14:51 -0700
Message-ID: <CAPrxi58_00WVutZV-zO5sa3Rx+QahVO90oVeUEc+neOmvxcf3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:46803 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809Ab2JZROw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 13:14:52 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so3286730vcb.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 10:14:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage,

In the client log below on line 852 we start a mkdirs call, and it
doesn't finish for 60 seconds.

Here are logs:

  https://dl.dropbox.com/u/7899675/client.log
  https://dl.dropbox.com/u/7899675/mds.a.log
  https://dl.dropbox.com/u/7899675/mon.a.log
  https://dl.dropbox.com/u/7899675/osd.0.log

- Noah
