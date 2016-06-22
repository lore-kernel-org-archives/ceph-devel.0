From: Samuel Just <sjust@redhat.com>
Subject: http://tracker.ceph.com/issues/16416
Date: Wed, 22 Jun 2016 09:45:45 -0700
Message-ID: <CAN=+7FXx6YMjeGUPuHgRGP+YMbwr19HD+A49SniDOHBNy-HNhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36037 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbcFVQpq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 12:45:46 -0400
Received: by mail-qk0-f175.google.com with SMTP id p10so72845521qke.3
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 09:45:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Haomai" <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I think this may be due to an async messenger thing, can you take a look?
-sam
