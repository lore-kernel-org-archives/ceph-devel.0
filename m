From: Dan Mick <dmick@redhat.com>
Subject: arm build server erroneously tagged, caused a number of build
 failures
Date: Fri, 28 Apr 2017 11:54:06 -0700
Message-ID: <bfe920f4-a15e-286c-fb5e-a21a0e954fd1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425322AbdD1SyM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 28 Apr 2017 14:54:12 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sepia@lists.ceph.com" <sepia@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

If you had a mysterious build failure you can't explain, and
particularly if it mentions 'arm64':

I added a new arm build server to Jenkins last night (omani001), but
mistakenly tagged it as amd64/x86_64, so Jenkins selected it for builds
that would not succeed, and a number of builds failed:

https://jenkins.ceph.com/computer/172.21.4.51+omani001/builds

Sorry about that.  The slave tags are fixed now.

-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
