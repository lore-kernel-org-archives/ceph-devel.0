From: Noah Watkins <noah.watkins@inktank.com>
Subject: [ann] fio plugin for libcephfs
Date: Mon, 17 Nov 2014 13:31:18 -0800
Message-ID: <CA+Hcz5-sW=7+77oswf+9cKSmhAuh41g9uYkzNTzwV48przBLng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:37120 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbaKQVbT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Nov 2014 16:31:19 -0500
Received: by mail-qg0-f44.google.com with SMTP id z60so1384418qgd.31
        for <ceph-devel@vger.kernel.org>; Mon, 17 Nov 2014 13:31:19 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I've posted a preliminary patch set to support a libcephfs io engine in fio:

   http://github.com/noahdesu/fio cephfs

You can use this right now to generate load through libcephfs, but the
plugin needs a bit more work before it goes upstream (patches
welcome), but feel free to play around with it. There is an example
script in examples/cephfs.fio.

Issues:
  Currently all the files that are created get the same size as the
total job size rather than the total size being divided by the number
of threads.

- Noah
