From: Jaze Lee <jazeltq@gmail.com>
Subject: Client still connect failed leader after that mon down
Date: Thu, 17 Dec 2015 17:56:51 +0800
Message-ID: <CAKZcxgeK8=au4yBxcsP+=ewtFr8_ruZCxUKJtWWSk6eGc-b8Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34987 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbbLQJ4w convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Dec 2015 04:56:52 -0500
Received: by mail-lb0-f180.google.com with SMTP id u9so41759188lbp.2
        for <ceph-devel@vger.kernel.org>; Thu, 17 Dec 2015 01:56:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello cephers:
    In our test, there are three monitors. We find client run ceph
command will slow when the leader mon is down. Even after long time, a
client run ceph command will also slow in first time.
=46rom strace, we find that the client first to connect the leader, the=
n
after 3s, it connect the second.
After some search we find that the quorum is not change, the leader is
still the down monitor.
Is that normal?  Or is there something i miss?

Thanks a lot



--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
