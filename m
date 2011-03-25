From: huang jun <hjwsm1989@gmail.com>
Subject: handle flushing stray dentry
Date: Fri, 25 Mar 2011 10:13:48 +0800
Message-ID: <AANLkTik-hfQUzG7qoR=Zmo+2uzv=2XEmwAndrj8xarnF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59905 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610Ab1CYCNt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2011 22:13:49 -0400
Received: by vws1 with SMTP id 1so493225vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2011 19:13:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi,
after i remove the  local dentries ,metadata will store in stray
dentry.and now metadata of removed dentries will not be removed,did
the remove of stray depends on LRU ?if not ,on which circumstance
should we remove stray dentry? how to judge LRU's expire info?
thanks!
