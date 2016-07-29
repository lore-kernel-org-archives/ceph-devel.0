From: Ken Dreyer <kdreyer@redhat.com>
Subject: scoping daemon-helper replacement effort
Date: Fri, 29 Jul 2016 10:40:03 -0600
Message-ID: <CALqRxCxebmt1Anng1JxT-EU0RH8vFBvHaYs-5dFkgzg-5aWpEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:34472 "EHLO
	mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbcG2QkF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 12:40:05 -0400
Received: by mail-ua0-f172.google.com with SMTP id 35so65654349uap.1
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 09:40:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

daemon-helper predates a lot of things in Ceph, and the further we go
into systemd-land with things like unprivilged daemons, SELinux, and
cgroups, the further Teuthology diverges from what our users do. To
remedy this, I want to retire daemon-helper and have Teuthology tests
use the normal init system, particularly now that our main supported
distros are unified around systemd.

From what I understand, we use daemon-helper in Teuthology to:

  1) start a daemon and eventually stop it with either SIGTERM or
SIGKILL, depending on whether the Teuthology task has enabled the
coverage or valgrind options,

  2) send data via STDIN

  3) print some messages when the child crashes

I think we could run the services using the systemd unit files and
still accomplish #1 and #3.

For #2 (communicating to the daemons via STDIN), how could we
accomplish this? What sort of things are we writing to the daemons'
STDIN? I'm having trouble finding examples in ceph-qa-suite.git.

- Ken
