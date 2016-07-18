From: John Spray <jspray@redhat.com>
Subject: ceph-mgr update
Date: Mon, 18 Jul 2016 12:40:42 +0100
Message-ID: <CALe9h7fdMEtxSKQGi4B6OeeWV77=Fbv5LzV8231Pz28+wHzfrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34913 "EHLO
	mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbcGRLlE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jul 2016 07:41:04 -0400
Received: by mail-qt0-f172.google.com with SMTP id x25so9905694qtx.2
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jul 2016 04:41:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

The ceph-mgr code has come on a long way since my last update, and
there are now pull requests open:
https://github.com/ceph/ceph/pull/10328
https://github.com/ceph/ceph-qa-suite/pull/1086

If you have comments, please think about whether they need addressing
before merging the initial code, or if they could be handled
subsequently.  As much as possible I'd like to do the ongoing work in
more pull requests rather than in updates to this PR.

The major stuff that's been added since my last update to the list:
 * Python modules can declare CLI commands (currently invoked via
`tell`, pending cleaner CLI integration)
 * Python modules can load and save config settings
 * Python modules have a special logger instance that passes through
to the ceph log.
 * Integration with the mon for active/standby HA of mgr daemons
 * OSDs have a MgrClient that sends home performance counters
 * Initial framework for writing tests exists (the ceph-qa-suite PR)
 * ...and lots lots more.

John
