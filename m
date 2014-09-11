From: Samuel Just <sam.just@inktank.com>
Subject: set_alloc_hint old osds
Date: Thu, 11 Sep 2014 13:19:58 -0700
Message-ID: <CA+4uBUaAW7Umzg=jb-ksWx_ief2f1oq498KrBJY22ZBATU6EMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:52131 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165AbaIKUT7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Sep 2014 16:19:59 -0400
Received: by mail-qa0-f45.google.com with SMTP id s7so3987533qap.18
        for <ceph-devel@vger.kernel.org>; Thu, 11 Sep 2014 13:19:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, Ilya Dryomov <idryomov@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

http://tracker.ceph.com/issues/9419

librbd unconditionally sends set_alloc_hint.  Do we require that users
upgrade the osds first?  Also, should the primary respond with
ENOTSUPP if any replicas don't support it?
-Sam
