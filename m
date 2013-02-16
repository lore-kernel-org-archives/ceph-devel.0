From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Backups
Date: Sat, 16 Feb 2013 17:15:37 +0100
Message-ID: <CAJH6TXjWNmc15TZKEhyPbJ5HPKcL4EC_YBQsQtOfYJOYuk1S9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:65182 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab3BPQPj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:15:39 -0500
Received: by mail-we0-f174.google.com with SMTP id r6so3615142wey.33
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:15:37 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

Hi,
let's assume a huge ceph clusters, with 300TB full of datas (rgw, rbd
and the future cephfs)
How will you manage backups of this cluster?

Will snapshot be enough? For example, one snapshot per day should be
allow me to revert or restore a single file from the previous day.
