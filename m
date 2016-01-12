From: Marcel Lauhoff <lauhoff@uni-mainz.de>
Subject: An Evaluation of Object Name Hashing
Date: Tue, 12 Jan 2016 14:17:27 +0100
Message-ID: <87a8obhr88.fsf@uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgate-02.zdv.uni-mainz.de ([134.93.178.246]:63967 "EHLO
	mailgate-02.zdv.uni-mainz.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934757AbcALN1Z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Jan 2016 08:27:25 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>


Hi,

I wrote a Master's Thesis about Ceph and cold storage last year. One of
the things I looked at was modifications to object placement.

Among others, what would happen to balance (e.g objects / OSD) when
all objects of a file end up on the same OSD. I also ran tests with a
different hash algorithm (Linux dcache).

I wrote an article on my website with the analysis, changes to the
source and how I ran the tests:

  http://irq0.org/articles/ceph/object_name_hashing


~irq0

--
Marcel Lauhoff
lauhoff@uni-mainz.de
