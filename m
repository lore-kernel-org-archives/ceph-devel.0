From: liuchang0812 <liuchang0812@gmail.com>
Subject: cleanup: add override where possible when implementing an interface
Date: Tue, 14 Feb 2017 17:08:37 +0800
Message-ID: <CACKY0b8Xy5JNC-5Y8BcQEW8QDrHq85Qa7=nC9DjB3H+VmbarNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33458 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbdBNJIi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 04:08:38 -0500
Received: by mail-yw0-f171.google.com with SMTP id u68so62839881ywg.0
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 01:08:38 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

Hi, Sage and Cephers:

I saw a issue "add override where possible when implementing an
interface". So I used a LLVM tool called clang-tidy to do it
automatically. .

I have made a big changes:

      246 files changed, 1305 insertions(+), 1305 deletions(-)

I could build it successfully, should I make a Pull-Request?

BTW, I am pleasure to write a simple documentation about this tool if
we need this.


thanks.
