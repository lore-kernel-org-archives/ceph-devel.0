From: Konstantin Danilov <kdanilov@mirantis.com>
Subject: Get IO request execution profile
Date: Mon, 23 Jan 2017 14:36:15 +0200
Message-ID: <CACxKWaxt5+9BiQEM-fG=iHkwHJsPYK9EukNoyPtPNQunq65adw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:36413 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbdAWMgQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 07:36:16 -0500
Received: by mail-vk0-f43.google.com with SMTP id t8so89292955vke.3
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2017 04:36:16 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

is there a way to get something like 'dump historic ops' for particular request?
Probably from client side. Ideally I'd like to send a normal IO
request with special
flag and get execution profile in response metadata.
If it's not possible right now - is this an interesting feature to
implement, or I miss
something and it's useless?

Thanks

-- 
Kostiantyn Danilov aka koder.ua
Principal software engineer, Mirantis

skype:koder.ua
http://koder-ua.blogspot.com/
http://mirantis.com
