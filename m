From: Travis Rhoden <trhoden@gmail.com>
Subject: error for Translation-en .deb package
Date: Fri, 18 Jan 2013 12:54:42 -0500
Message-ID: <CACkq2mqyOYUgLqUy0uJZb-+0wHtrLfTdRGhLeL5zAa55UTwoQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:64351 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab3ARRzE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 12:55:04 -0500
Received: by mail-ee0-f41.google.com with SMTP id c13so1947793eek.0
        for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 09:55:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hey folks,

Anyone else seeing this issue?

# apt-get update

<snip>
Ign http://ceph.com precise/main Translation-en_US
Err http://ceph.com precise/main Translation-en
  Error reading from server. Remote end closed connection
Fetched 2,746 kB in 2min 35s (17.6 kB/s)
W: Failed to fetch
http://ceph.com/debian-bobtail/dists/precise/main/i18n/Translation-en
Error reading from server. Remote end closed connection

E: Some index files failed to download. They have been ignored, or old
ones used instead.


I get it on all my servers.

# cat /etc/apt/sources.list.d/ceph.list
deb http://ceph.com/debian-bobtail/ precise main
