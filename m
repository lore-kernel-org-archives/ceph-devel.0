From: Samuel Just <sjust@redhat.com>
Subject: ms_inject_delay* in async messenger
Date: Mon, 4 Apr 2016 15:33:02 -0700
Message-ID: <CAN=+7FX+m0bnunHha1XgTybw=Vbd_6aFRMxzYJxAaKAj6n6hiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36012 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbcDDWdE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Apr 2016 18:33:04 -0400
Received: by mail-yw0-f179.google.com with SMTP id g3so271787427ywa.3
        for <ceph-devel@vger.kernel.org>; Mon, 04 Apr 2016 15:33:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Wang, Haomai" <haomaiwang@gmail.com>

I just noticed that these don't appear to be implemented.  It's really
important that they be implemented for catching subtle ordering bugs.

http://tracker.ceph.com/issues/15372
-Sam
