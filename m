From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: is it possible to support backend pluggable for RGW bucket index
Date: Tue, 28 Feb 2017 10:48:03 +0800
Message-ID: <CACKY0b9r12+w+g3NJuGT4jq1o7ZgRudJ0E8e_U6igqOVdGZsAA@mail.gmail.com>
References: <CACKY0b9fEy9XBY4434X3Rhv_r1nyjhZit8v_eC6eqKEvkVcung@mail.gmail.com>
 <1802697872.111896194.1488218287095.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34828 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdB1CsE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2017 21:48:04 -0500
Received: by mail-yw0-f182.google.com with SMTP id d1so37913783ywd.2
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2017 18:48:04 -0800 (PST)
In-Reply-To: <1802697872.111896194.1488218287095.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi, Matt

I'm very honored to join RGW standup and share my ideas. We are trying
to use RGW in our service, but bucket index limits cluster scalability
and availability. I have some ideas about bucket index, and wrote a
document(but in Chinese).  There are:

1. two-level prefix-shard based on current hash-shard
2. pre-defined range shard
3. abstract Bucket Index operations and support more back-end.

I am very pleasure to prepare a slide to discuss those ideas.

Thanks

Chang Liu
