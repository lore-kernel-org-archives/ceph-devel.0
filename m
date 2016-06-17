From: Alyona Kiselyova <akiselyova@mirantis.com>
Subject: How to propose plugin, which uses external lib
Date: Fri, 17 Jun 2016 18:51:49 +0300
Message-ID: <CAONhiy5cg+fX-A49shN9FLREpigiTO18vk7t9anM_ZK9Czc5cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35506 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628AbcFQPvx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jun 2016 11:51:53 -0400
Received: by mail-oi0-f51.google.com with SMTP id v7so11995991oig.2
        for <ceph-devel@vger.kernel.org>; Fri, 17 Jun 2016 08:51:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
I would like to propose a new compression plugin, which is based on
Isa-l open source library
(https://github.com/01org/isa-l/tree/master/igzip). I already have a
code - https://github.com/Ved-vampir/ceph/tree/wip_isal_plugin/src/compressor/isal.
I see, that there are erasure-code plugin, based on isa-l too. As I
see, library code is not loaded as submodule repo, like some others.
But if I'm right, I think, it's not the best way to use external code.
The question is, what is the right way to use external library in my case?
Thanks!
-------------------------------
Best regards,
Alyona Kiseleva
