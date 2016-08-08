From: Loic Dachary <loic@dachary.org>
Subject: rbd backports
Date: Mon, 8 Aug 2016 09:08:20 +0200
Message-ID: <57A82FE4.10604@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49332 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbcHHHIz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Aug 2016 03:08:55 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Mykola,

A short note to explain why you were assigned a dozen rbd jewel backports today:

https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+assignee%3Atrociny+milestone%3Ajewel

Most of them were authored by someone from the backport team. They have been tested to not break the rbd suite so we are confident they do not contain a trivial problem. But our understanding of the rbd codebase is limited and before merging them we seek approval from the person who merged the original pull request in master. You merged a number of rbd pull request in master and this is why we end up asking for your final review on these backports.

Please let us know if this work is too much of a burden to you and we will try to find an alternate solution. Except for the simplest cases, figuring out if a set of commits makes sense in a stable version can be challenging.

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
