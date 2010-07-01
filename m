From: Paul <paul_chiang@tcloudcomputing.com>
Subject: OSD scalability & thread stacksize
Date: Thu, 1 Jul 2010 19:57:02 +0800
Message-ID: <AANLkTilDYesH_4FFEPUdLGvQRoZcW99czwfGru44RW3i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49376 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357Ab0GAL5E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jul 2010 07:57:04 -0400
Received: by ewy23 with SMTP id 23so765017ewy.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Jul 2010 04:57:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Follow up on the discussion on IRC late last night:

On x86_64 2.6 kernels, pthread_create seems to allocate by default
8196KB stack size for the newly created thread. Since there can be
potentially a large number of SimpleMessenger::Pipe instances (for
example, when there are many OSDs and they need to heartbeat each
other) and each instance has a reader and writer thread, a system can
quickly run out of available memory to create new threads.

A short term solution would be to decrease the amount of stack space
allocated for the reader and writer threads. I guess something along
the lines of:
http://github.com/tcloud/ceph/commit/39ffa236f3de2082c475a5ea5edc8afa09941bd6
and
http://github.com/tcloud/ceph/commit/1dbd42a5c4b064c581ddc152d41b9553f346df8a

Yehudasa suggested a stacksize of 512KB, and it seems to work fine.

However, as the cluster grows, there will eventually be some point
where we hit a hard limit on either the number of concurrent threads
or the number of concurrent tcp connections. Is it possible to
redesign SimpleMessenger and/or the heartbeat mechanism so that only a
constant number of connections are established?


-Paul C
