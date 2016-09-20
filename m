From: John Spray <jspray@redhat.com>
Subject: richacl packaging for cephfs
Date: Tue, 20 Sep 2016 15:57:04 +0100
Message-ID: <CALe9h7f_q9iGzTRYhXHKiNFfn2qKfc-UUh+eWJ_XqTh9YoqQWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34099 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbcITO50 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2016 10:57:26 -0400
Received: by mail-qt0-f178.google.com with SMTP id 38so8673767qte.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Sep 2016 07:57:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: James Page <james.page@canonical.com>, Tim Serong <tserong@suse.com>, Ken Dreyer <kdreyer@redhat.com>

Hi all,

I was just taking an updated look at how we could proceed to get
richacl support[1,2,3] built and tested in cephfs (probably for
luminous).

The packages exist currently for Fedora.  For testing, we will need
them for Ubuntu (probably just Xenial?), CentOS and RHEL (once there
are RHEL nodes in the sepia lab).

I'm not very aware of ways forward for Ubuntu, but on the CentOS front
it seems like we have at least a couple of possibilities:
 * Build ourselves (using some branch of the fedora packaging?) on a
Ceph gitbuilder/jenkins job and install from that repo in teuthology
jobs
 * Get packages into CentOS Storage SIG and point teuthology at
external storage SIG repos during testing

I believe we could ask nicely for some help from the storage SIG to
package richacl, but I'm not immediately sure if that's actually our
preferred approach for consuming packages in our CI vs. self-building
anything that's not in the distro.

Does anybody have thoughts on the best way to go?

Would also love to hear any thoughts about richacl  SUSE and Ubuntu

John

1. https://github.com/ceph/ceph/pull/6341
2. https://github.com/andreas-gruenbacher/richacl
3. http://pkgs.fedoraproject.org/cgit/rpms/richacl.git/
