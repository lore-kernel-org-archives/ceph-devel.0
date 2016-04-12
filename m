From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH 3/3] ceph: kill __ceph_removexattr()
Date: Tue, 12 Apr 2016 18:34:29 +0200
Message-ID: <CAHc6FU5E8xwkzLXsZgJh29WxaOM2H9BeYsnYDh84vSOjoZp08w@mail.gmail.com>
References: <1460463566-75273-1-git-send-email-zyan@redhat.com>
	<1460463566-75273-3-git-send-email-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36063 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933334AbcDLQea (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 12:34:30 -0400
Received: by mail-vk0-f46.google.com with SMTP id c4so32270392vkb.3
        for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2016 09:34:29 -0700 (PDT)
In-Reply-To: <1460463566-75273-3-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org

Yan,

On Tue, Apr 12, 2016 at 2:19 PM, Yan, Zheng <zyan@redhat.com> wrote:
> when removing a xattr, generic_removexattr() calls __ceph_setxattr()
> with NULL value and XATTR_REPLACE flag. __ceph_removexattr() is not
> used any more.

thanks for this, and for reviewing/testing the previous two patches.

Andreas
