From: Aleksei Gutikov <aleksey.gutikov@synesis.ru>
Subject: Re: Is it possible to restrict to map rbd image on different client
 hosts same time?
Date: Tue, 8 Aug 2017 19:35:12 +0300
Message-ID: <f41f41fc-2a75-1584-80d3-f17e29d191a0@synesis.ru>
References: <95c441d8-007c-8e2e-3767-1b85ec8453f0@synesis.ru>
 <CAOi1vP9Aw4CM1U326_T3wDmpTa3ZEK9fX_7un676PBqdUf4Pkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:38344 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbdHHQfP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Aug 2017 12:35:15 -0400
Received: by mail-lf0-f50.google.com with SMTP id y15so17152612lfd.5
        for <ceph-devel@vger.kernel.org>; Tue, 08 Aug 2017 09:35:15 -0700 (PDT)
In-Reply-To: <CAOi1vP9Aw4CM1U326_T3wDmpTa3ZEK9fX_7un676PBqdUf4Pkw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


Ilya, thank you for your suggestion, it works for me.

But during testing I realized that what actually I need is not just 
exclusive lock, but some kind of idempotent exclusive lock.
I mean the last who exclusively mapped image should kick out others.
Is it possible now?

Thanks
-- 
Aleksei
