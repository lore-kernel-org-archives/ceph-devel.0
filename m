From: =?gb2312?B?zNW2rLas?= <tdd21151186@gmail.com>
Subject: Journaler::_flush
Date: Sun, 26 Nov 2017 23:19:32 +0800
Message-ID: <3E5F298A-2C7C-4E70-893F-A624A7C6BB10@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:37591 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdKZPTi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Nov 2017 10:19:38 -0500
Received: by mail-pg0-f50.google.com with SMTP id m4so7649323pgc.4
        for <ceph-devel@vger.kernel.org>; Sun, 26 Nov 2017 07:19:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: "Yan, Zheng" <ukernel@gmail.com>, pdonnell@redhat.com

Hi Zheng, 

i  have one question about Journaler flush,
suppose there are two in flight flushes ?
first is flushing (a, b),  second is flushing (b+1, c)
let's assume these two range belong to two adjacent objects.  
is that possible that the second flush got the reply first ? 
if that so, the safe_pos would be wrong ?

Thanks,
Dongdong
