From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: geo replication
Date: Wed, 9 Jan 2013 22:19:21 +0100
Message-ID: <CAJH6TXjnUTdjwi-dW6kV-2WEf58-B=gx1ubnep30x_0Td5JHTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:59245 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933574Ab3AIVTW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 16:19:22 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm2so825819wib.16
        for <ceph-devel@vger.kernel.org>; Wed, 09 Jan 2013 13:19:21 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

probably this was already asked before but i'm unable to find any answer.
Is possible to replicate a cluster geografically?

GlusterFS does this with rsync (i think called automatically on every
file write), does cheph do something similiar?

I don't think that using multiple geographically distributed OSD with
10-15ms of latency will be good
