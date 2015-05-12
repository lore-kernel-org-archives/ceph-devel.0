From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: rocksdb with jemalloc
Date: Mon, 11 May 2015 18:41:25 -0700
Message-ID: <CAFkUHxeqZGTiipGdb1voLzRGChDnumRnOgd50Ce8LjBm6eL0Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:32840 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbbELBlZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 May 2015 21:41:25 -0400
Received: by pacwv17 with SMTP id wv17so125513244pac.0
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2015 18:41:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,


I am trying to use newstore + rocksdb + jemalloc. Currently rocksdb in
ceph compiles only with tcmalloc and not with jemalloc.

Is there any reason for this limitation ?

-Neo
