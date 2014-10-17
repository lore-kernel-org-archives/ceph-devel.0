From: yue longguang <yuelongguang@gmail.com>
Subject: questions about erasure coded pool and rados
Date: Fri, 17 Oct 2014 18:13:41 +0800
Message-ID: <CAPaK2r_B8TjUo63P3d-XOOQzdvz_bUhpgPHw9TXLngms4=4c9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:44777 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbaJQKNm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Oct 2014 06:13:42 -0400
Received: by mail-ie0-f179.google.com with SMTP id ar1so410110iec.24
        for <ceph-devel@vger.kernel.org>; Fri, 17 Oct 2014 03:13:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

1. why erasure coded pool does not work with rbd?
2. i used rados command to put a file into erasue coded pool,then rm
it. why the file remains on osd's backend fs all the time?
3. what is the best use case with erasure coded pool?

4. command of 'rados ls' is to list objects, where are the object-name stored?
5.when a rbd file is put on erasure coded pool, where is the
infomation(rbd name) of the rbd stored?

thanks
