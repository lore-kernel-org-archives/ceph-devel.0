From: Takuya ASADA <syuu@dokukino.com>
Subject: Usage of rbd
Date: Wed, 29 Sep 2010 00:55:16 +0900
Message-ID: <AANLkTikUMZiGmjF9xPhn-9UiknrnQWLLrMgFEFU83PF7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39508 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab0I1Pzk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Sep 2010 11:55:40 -0400
Received: by wwd20 with SMTP id 20so162141wwd.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Sep 2010 08:55:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'm trying to test kvm-rbd, and I just failed to create image on it.
I followed installation sequence on the wiki
(http://ceph.newdream.net/wiki/Kvm-rbd),
and executed
$ qemu-img create -f rbd rbd:data/foo 10G
it returned

failed assigning block id
qemu-img: rbd:data/foo: error while creating rbd: Input/output error

Then I looked into source code, and realized maybe I need to load libcls_rbd.so,
so I executed
$ cclass -a
$ ceph class list
rbd class shows up.

10.09.29_00:55:53.939866 mon <- [class,list]
10.09.29_00:55:53.940230 mon0 -> 'installed classes:
rbd (v1.2 [x86-64])
' (0)

Then I tried "qemu-img create" again, also "rbd create", it didn't work at all.
Like this:

$ rbd -p hoge99 --size 10 create test.img
failed to assign a block name for image
create error: Operation not supported

$ qemu-img create -f rbd rbd:data/foo 10G
Formatting 'rbd:data/foo', fmt=rbd size=10737418240 cluster_size=0
failed assigning block id
qemu-img: rbd:data/foo: error while creating rbd: Input/output error

osd and mon are working correctly, I can use it via rados command and librados.

My question is:
- Am I missing something to start using rbd?

- Do I need rbd kernel module for kvm-rbd?
I thought it's just a userland application, which calling librados.

syuu
