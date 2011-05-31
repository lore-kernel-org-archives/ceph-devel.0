From: Simon Tian <aixt2006@gmail.com>
Subject: compile error for ceph-0.28.*.tar.gz
Date: Tue, 31 May 2011 14:23:10 +0800
Message-ID: <BANLkTinCKuhzaRLKaBmJXJJCsNNHeDFuPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:44364 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757055Ab1EaGXM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2011 02:23:12 -0400
Received: by wwk4 with SMTP id 4so2095644wwk.1
        for <ceph-devel@vger.kernel.org>; Mon, 30 May 2011 23:23:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi  folks,

    When I make ceph after ./configure,  error comes both in 0.28.1
and 0.28.2 like bellow:

./include/encoding.h:294: error: no matching function for call to
?.ecode(PG::Log::Entry&, ceph::buffer::list::iterator&)?
./include/encoding.h:42: note: candidates are: void decode(__u8&,
ceph::buffer::list::iterator&)
... ...

./include/encoding.h:406: error: no matching function for call to
?.ncode(const PG::Missing::item&, ceph::buffer::list&)?
./include/encoding.h:42: note: candidates are: void encode(const
__u8&, ceph::bufferlist&)
... ...


I just download them from http://ceph.newdream.net/download/ceph-0.28.*.tar.gz

Thx!
Simon
