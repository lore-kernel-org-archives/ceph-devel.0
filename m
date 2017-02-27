From: liuchang0812 <liuchang0812@gmail.com>
Subject: is it possible to support backend pluggable for RGW bucket index
Date: Mon, 27 Feb 2017 16:44:27 +0800
Message-ID: <CACKY0b9fEy9XBY4434X3Rhv_r1nyjhZit8v_eC6eqKEvkVcung@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33607 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751614AbdB0Ioa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Feb 2017 03:44:30 -0500
Received: by mail-yw0-f179.google.com with SMTP id l138so7808667ywc.0
        for <ceph-devel@vger.kernel.org>; Mon, 27 Feb 2017 00:44:28 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, Yehuda and Cephers

Is it possible to make RGW bucket index pluggable? If it's possible,
We could save those index into Hbase cluster and improve the
scalability and available.



thanks
