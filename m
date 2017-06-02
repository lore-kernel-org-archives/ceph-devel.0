From: Willem Jan Withagen <wjw@digiware.nl>
Subject: VLA detection ...
Date: Fri, 2 Jun 2017 20:50:07 +0200
Message-ID: <174f417f-02f5-beb1-0f8b-96ff4a70349b@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:35260 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751007AbdFBSuH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Jun 2017 14:50:07 -0400
Received: from [192.168.11.152] (unknown [192.168.11.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id CF5C342820
        for <ceph-devel@vger.kernel.org>; Fri,  2 Jun 2017 20:50:04 +0200 (CEST)
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Now that we have -Wvla set:
===
    Adds C++ warning flag for C Variable-Length Arrays.

    C VLAs are not supported in C++. However, the GNU compiler allows
    them as an extension, which it does not warn about when not in
    pedantic mode. Unfortunately, it's easy to accidentally write
    a VLA, even unintentionally-- adding this warning will help us
    catch that.
===

Are there going to be attempts to eradicate this usage?
Note that Clang also supports VLAs:
===
GCC and C99 allow an array's size to be determined at run time. This
extension is not permitted in standard C++. However, Clang supports such
variable length arrays for compatibility with GNU C and C99 programs.
===

--WjW
