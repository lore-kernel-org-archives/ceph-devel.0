From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: Has http://ceph.com/docs problems?
Date: Sun, 1 Jan 2017 14:24:28 +0800
Message-ID: <CACKY0b-Fr3X8jmbCD_J=Kat0+jfqi0SnuhD5t+Lx6V5Jq69QvQ@mail.gmail.com>
References: <CACKY0b96L31_L=KugUYQwdfU2CSkD167fgU5N495rpye1Toj3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:36400 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753689AbdAAGY3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Jan 2017 01:24:29 -0500
Received: by mail-qt0-f173.google.com with SMTP id k15so183479107qtg.3
        for <ceph-devel@vger.kernel.org>; Sat, 31 Dec 2016 22:24:29 -0800 (PST)
In-Reply-To: <CACKY0b96L31_L=KugUYQwdfU2CSkD167fgU5N495rpye1Toj3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I have tried with both my PC and a DigitalOcean VPS. Doc website down
definitely.

*   Trying 208.113.135.117...
* connect to 208.113.135.117 port 80 failed: Connection timed out
* Failed to connect to docs.ceph.com port 80: Connection timed out
* Closing connection 0
curl: (7) Failed to connect to docs.ceph.com port 80: Connection timed out

2017-01-01 14:11 GMT+08:00 liuchang0812 <liuchang0812@gmail.com>:
> I can't open http://ceph.com/docs, i seems that website is down.
