From: Junwang Zhao <zhjwpku@gmail.com>
Subject: [wip-addr-features] make sure I am doing the right thing
Date: Mon, 16 May 2016 16:30:16 +0800
Message-ID: <CAEG8a3LQuro2zXu90im0aQ58XxdGLDQvLxnjkJ+Rd8C6k70QVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35949 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbcEPIaR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 May 2016 04:30:17 -0400
Received: by mail-vk0-f67.google.com with SMTP id c189so19891938vkb.3
        for <ceph-devel@vger.kernel.org>; Mon, 16 May 2016 01:30:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage A. Weil" <sweil@redhat.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage, Haomai,

I am working on the require-features-patch, I use 'make' to see the conflicts,
and change the code to fit the required-feature-patch, [1] is a huge patch
that I am still working on, it has not been finished. I really need to check
with you whether I am doing it right, since it seems the errors are endless.

There are some comments where I am not sure in the patch, like 'not sure'.

I didn't split this huge patch into small ones, I am not sure is that a must, if
yes, I will split it into small ones.

Any comments and critisize are welcomed.

[1]https://github.com/zhjwpku/ceph/commit/706ea2eca3bf8849bd4c2ff0cd9757318c6bbb14

Thanks!
Zhao
