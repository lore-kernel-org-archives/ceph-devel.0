From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: why we use two ObjectStore::Transaction in ReplicatedBackend::submit_transaction?
Date: Sat, 31 Oct 2015 17:12:45 +0800
Message-ID: <CANE=7sWNry9QYHkV=DK8NOudeU7UNNoRya8-be1BFiG=9YGn3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33462 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbbJaJMq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 31 Oct 2015 05:12:46 -0400
Received: by oiad129 with SMTP id d129so72066904oia.0
        for <ceph-devel@vger.kernel.org>; Sat, 31 Oct 2015 02:12:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi, all:

    There are two ObjectStore::Transaction in
ReplicatedBackend::submit_transaction, one is op_t and the other one
is local_t. Is that something
    critilal logic we should consider?

    If we could reuse variable op_t it would be great. Because it is
expensive to calling local_t.append(*op_t).

    There are similar logic in ReplicatedBackend::sub_op_modify_impl.

-- 
Regards,
xinze
