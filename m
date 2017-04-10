From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Forwarding Rocksdb to a new sha
Date: Mon, 10 Apr 2017 15:14:23 +0200
Message-ID: <efe3e212-13b9-c4b6-9abd-f95a6803123a@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:65228 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752963AbdDJNOr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 10 Apr 2017 09:14:47 -0400
Received: from [192.168.101.70] (vpn.ecoracks.nl [176.74.240.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 458BA3DF28
        for <ceph-devel@vger.kernel.org>; Mon, 10 Apr 2017 15:14:44 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

I have submitted a PR to RocksDB that got accepted.
But now I'd like to try it in my WIP tree.

So how do I locally roll the RocksDB version forward?

Is it as simple as going into RocksDB and go:
	'git pull' ??

--WjW
