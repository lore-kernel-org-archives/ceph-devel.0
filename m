From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Ceph journal
Date: Wed, 31 Oct 2012 22:18:01 +0100
Message-ID: <CAJH6TXgdkq8ZMUpZYaTActMQ9wS76u7F=OUSvWnt9bS-crJwZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:52677 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934937Ab2JaVSD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 17:18:03 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so735130eaa.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 14:18:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In a multi replica cluster (for example, replica = 3) is safe to set
journal on a tmpfs?
As fa as I understood with journal enabled all writes are wrote on
journal and then to disk in a second time.
If node hangs when datas are still on journal (and journal is not on a
permanent disk), some data lost could happens.

In a multi replica environment, other nodes should be able to write
the same datas to disk, right? I this case, using a journal on a tmpfs
should be safe enough.

I'm missing something?
