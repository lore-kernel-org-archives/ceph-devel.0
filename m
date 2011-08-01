From: Christian Brunner <chb@muc.de>
Subject: rados callbacks
Date: Mon, 1 Aug 2011 11:03:00 +0200
Message-ID: <CAO47_-9LwTQFfzZko=8oKz+nM5OKrcfW6ch0A9ZX6hqedhieTw@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48284 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab1HAJDA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 05:03:00 -0400
Received: by vws1 with SMTP id 1so4272111vws.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Aug 2011 02:03:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm not sure if I have asked for this already, but I can't remember
and google is not my friend either.

Librados has two different callback types for an async write:

- ack
- safe

What is the difference between these two types? Is ack faster than safe?

Thanks
Christian
