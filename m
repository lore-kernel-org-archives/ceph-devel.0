From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Test infrastructure: 2 or more servers?
Date: Tue, 15 Jan 2013 23:00:31 +0100
Message-ID: <CAJH6TXhBucB2t-ZRmXf5bCZyNaTRJoSHZhoJ9hsW8mR7NxhWnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:55144 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012Ab3AOWAc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 17:00:32 -0500
Received: by mail-wg0-f43.google.com with SMTP id e12so430306wge.22
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 14:00:31 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

For a test infrastructure (that will be the definitive one after some
months) do you think that starting with only 2 servers and many ODSs
will be ok?

OpenStack swift suggest at least 3 servers (due to it's replica = 3),
with ceph is possible to start with 2 and then grow up to 3, 6 and so
on?

Is possible to change the number of replicas in realtime ?
