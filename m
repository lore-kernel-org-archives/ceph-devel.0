From: Ugis <ugis22@gmail.com>
Subject: how to protect rbd from multiple simultaneous mapping
Date: Thu, 24 Jan 2013 15:30:55 +0200
Message-ID: <CAE63xUMSqAFGLtm-ObkbYETQtMDdtwLsPAEgMLFtEpM6azfxqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:36862 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab3AXNa4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 08:30:56 -0500
Received: by mail-ia0-f182.google.com with SMTP id w33so4814792iag.13
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 05:30:56 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I have rbd which contains non-cluster filesystem. If this rbd is
mapped+mounted on one host, it should not be mapped+mounted on the
other simultaneously.
How to protect such rbd from being mapped on the other host?

At ceph level the only option is to use "lock add [image-name]
[lock-id]" and check for existance of this lock on the other client or
is it possible to protect rbd in a way that on other clients "rbd map
" command would just fail with something like Permission denied
without using arbitrary locks? In other words, can one limit the count
of clients that may map certain rbd?

Regards,
Ugis Racko
