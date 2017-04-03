From: Aynur Shakirov <ajnur.shakirov@tionix.ru>
Subject: Ceph 12.0.0/master + DPDK = compilation failed
Date: Mon, 3 Apr 2017 14:46:44 +0300
Message-ID: <d4410ce1-5767-f1f8-5699-2288f484fb86@tionix.ru>
References: <e4303dd9-f37e-9a98-344e-df9fc43bc754@tionix.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.181.128]:60315 "EHLO
        fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752072AbdDCMLk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Apr 2017 08:11:40 -0400
Received: from smtp14.mail.ru (smtp14.mail.ru [94.100.181.95])
        by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id 4408B186B9BB7
        for <ceph-devel@vger.kernel.org>; Mon,  3 Apr 2017 14:46:49 +0300 (MSK)
In-Reply-To: <e4303dd9-f37e-9a98-344e-df9fc43bc754@tionix.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello all!

Meta:
OS: Ubuntu 16.04.1 up-to-date
Kernel: 4.8.0-42-generic
GCC: 5.4.0 (ubuntu)
Compiler flags: -O2, march=native or broadwell, -j 4
Ceph: 12.0.0, 12.0.1, master (from git)
DPDK: 16.07.2, 16.11, 16.11.1, submodule or upstream.

Description.
I want to use the DPDK messenger for Ceph, but upstream packages (looks 
like) doesn't contain the messenger as option. OK, I can compile Ceph 
with neccesary flags (-DWITH_DPDK=ON -DCRYPTOPP=ON) and build deb 
packages (thanks for make-debs script!).

To make-debs.sh I added the commands for adding flags for dpdk and 
crypto++ into debian/rules. Script starts, but when gcc are trying 
linking for ceph-syn with DPDK libraries I gets compile error. Logs of 
compilation from beginning is here: http://paste.ubuntu.com/24306084/ 
(error messages starts from 19056).

I tried to compile with another versions of DPDK and Ceph, but without 
success (see Meta for versions).

Why is this happening?  What am I doing wrong? :)

Thanks a lot!

---
Sincerely,
Aynur Shakirov, 27.
TIONIX Russia.
Planet Earth, Solar System, Milky Way.
