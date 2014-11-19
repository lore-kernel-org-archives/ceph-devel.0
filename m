From: Ding Dinghua <dingdinghua85@gmail.com>
Subject: One question about ceph code
Date: Wed, 19 Nov 2014 20:33:18 +0800
Message-ID: <CANf+_k+F0Ktt2YPHv-4EoLVnMmk30QS4VyVSX4+J-UsFVRLCBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:41290 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbaKSMdU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Nov 2014 07:33:20 -0500
Received: by mail-la0-f50.google.com with SMTP id pv20so414787lab.9
        for <ceph-devel@vger.kernel.org>; Wed, 19 Nov 2014 04:33:19 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi:
           I'm new to ceph and when I 'm reading ceph code, I find it
hard to understand the semantics of  PG::info::last_update and
PG::info::last_complete (even after reading the comments in code..),
so would you please give a explanation on the two fields and their
semantics and their usage ?
and: When last_complete will be unequal with last_update?
Many thanks.

-- 
Ding Dinghua
