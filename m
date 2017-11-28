From: Wido den Hollander <wido@42on.com>
Subject: Integers as String in osd_metadata (memory, rotational)
Date: Tue, 28 Nov 2017 12:06:50 +0100 (CET)
Message-ID: <83609177.5513.1511867211100@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from se07-out.mail.pcextreme.nl ([185.107.227.76]:37654 "EHLO
        se07-out.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751818AbdK1LhB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 28 Nov 2017 06:37:01 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Looking at 'ceph osd metadata' I see that we return a lot of values as Strings in the JSON instead of a Integer, for example:

$ ceph osd metadata 2033

{
    "id": 2033,
    "arch": "x86_64",
    "journal_rotational": "0",
    "mem_swap_kb": "1046524",
    "mem_total_kb": "63641808",
    "rotational": "1"
}

Looking at some code I found this:

(*m)["mem_total_kb"] = std::to_string(size);
(*pm)["rotational"] = store_is_rotational ? "1" : "0";
(*pm)["journal_rotational"] = journal_is_rotational ? "1" : "0";

Why can't we return a int/long there? Is it the internal JSON parser which can't handle it?

Otherwise I'll write a PR for this. Saves me casting the things to Integers again afterwards in Python.

Wido
