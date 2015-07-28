From: deanraccoon <deanraccoon@gmail.com>
Subject: can not get how many bytes read from rados_aio_read
Date: Tue, 28 Jul 2015 19:43:50 +0800
Message-ID: <CAHz-cgECZvH50a7RgryWCd=+xT+8-GYwhG_fsz+2ugU=WkDQ5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37085 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbbG1LoK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 07:44:10 -0400
Received: by igbpg9 with SMTP id pg9so117257958igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2015 04:44:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Dear list,
    I used the C API "rados_aio_read" to improve some read performace.
But it seems there is no way to get exactly how many bytes I read from rados.
the callback function will not return this infomation either.

so, it there anyone who could enlighten me how to do this?


cheers, Dongmao Zhang
