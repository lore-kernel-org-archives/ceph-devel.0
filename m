From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Changing code in a subproject ceph-erasure-code-corpus
Date: Wed, 10 Feb 2016 12:16:10 +0100
Message-ID: <56BB1BFA.6040603@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:22603 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbcBJLQf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Feb 2016 06:16:35 -0500
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id 5EBFF153431
	for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 12:16:32 +0100 (CET)
Received: from [IPv6:2001:4cb8:3:1:c07d:666c:56b3:c318] (unknown [IPv6:2001:4cb8:3:1:c07d:666c:56b3:c318])
	by smtp.digiware.nl (Postfix) with ESMTP id 152DF153416
	for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 12:16:15 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I have  one-line change in the erasure-code subproject.
but git status reports:
   modified:   ceph-erasure-code-corpus (modified content)

So that change is not going to make it in my pull...
But it is influencing my tests, and I keep fixing it after
every fetch of the tree

It is in
./ceph-erasure-code-corpus/v0.92-988/non-regression.sh:25

and it replaces
	TMP=$(mktemp --directory)
by
	TMP=$(mktemp -d)

So how do get something like this commited?

Thanx,
--WjW


