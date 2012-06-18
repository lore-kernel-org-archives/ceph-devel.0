From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: iostat show constants write to osd disk with writeahead journal, normal behaviour ?
Date: Mon, 18 Jun 2012 14:34:52 +0200 (CEST)
Message-ID: <de0635df-9b2a-4848-89ed-8eda179147db@mailpro>
References: <9b922de7-7e17-4b9f-a388-c612b019627a@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:58468 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab2FRMfP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 08:35:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 116DB1806BC1E
	for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 14:34:58 +0200 (CEST)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mftnPn7oF6c5 for <ceph-devel@vger.kernel.org>;
	Mon, 18 Jun 2012 14:34:52 +0200 (CEST)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.112])
	by mailpro.odiso.net (Postfix) with ESMTP id B864818008DE3
	for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 14:34:52 +0200 (CEST)
In-Reply-To: <9b922de7-7e17-4b9f-a388-c612b019627a@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm doing test with rados bench, and I see constant writes to osd disks.
Is it the normal behaviour ? with write-ahead should write occur each 20-30 seconde ?


Cluster is 
3 nodes (ubuntu precise - glibc 2.14 - ceph 0.47.2) with each node 1 journal on tmpfs 8GB - 1 osd (xfs) on sas disk  - 1 gigabit link


8GB journal can handle easily 20s of write (1 gigabit link)

[osd]
        osd data = /srv/osd.$id
        osd journal = /tmpfs/osd.$id.journal
        osd journal size = 8000
        journal dio = false
        filestore journal parallel = false
        filestore journal writeahead = true
        filestore fiemap = false




I have done tests with differents kernel (3.0,3.2,3.4) , differents filesystem (xfs,btrfs,ext4), forced journal mode to writeahead.
Bench were done write rados bench and fio.

I always have constant write since the first second of bench start.

Any idea ?

Regards,

-Alexandre
