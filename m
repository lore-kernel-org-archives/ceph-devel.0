From: Dong Yuan <yuandong1222@gmail.com>
Subject: Bug about issue 5883
Date: Thu, 26 Sep 2013 17:11:24 +0800
Message-ID: <CAMm-wc+8GJyE1Bj6t06N+1T2c+cSzZFnSOG4qg7SSxf_6VQcCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:64488 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab3IZJLZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Sep 2013 05:11:25 -0400
Received: by mail-wi0-f179.google.com with SMTP id hm2so885366wib.0
        for <ceph-devel@vger.kernel.org>; Thu, 26 Sep 2013 02:11:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hello, Sage.

I meet the same bug as #5883. It is happy to know that the bug is
fixed, but although I spent lots of time to try to get why, I still
couldn't understand the reason.

Is there any race conditions? Or which threads? I guess the threads
about this bug are Pipe.reader and DispatchQueue.entry, But I am not
sure.

Maybe you can give me more details.

Thank you very much.

-- 
Dong Yuan
Email:yuandong1222@gmail.com
