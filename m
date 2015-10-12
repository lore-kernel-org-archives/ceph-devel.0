From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Reply: [PATCH] rbd: prevent kernel stack blow up on rbd map
Date: Mon, 12 Oct 2015 15:32:57 +0200
Message-ID: <CAOi1vP_vMrHnOv+uYsbOu6UQhtKZ2PA2Kp2QX=nWxRTWLN5vUg@mail.gmail.com>
References: <5CB836F0B0F3DE4A985E180F2472FA7168CE92@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33815 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbbJLNc7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Oct 2015 09:32:59 -0400
Received: by wicgb1 with SMTP id gb1so50631649wic.1
        for <ceph-devel@vger.kernel.org>; Mon, 12 Oct 2015 06:32:58 -0700 (PDT)
In-Reply-To: <5CB836F0B0F3DE4A985E180F2472FA7168CE92@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Caoxudong <cao.xudong@h3c.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Oct 12, 2015 at 4:22 AM, Caoxudong <cao.xudong@h3c.com> wrote:
> By the way, do you think it's necessary that we add the clone-chain-length limit in user-space code too?

librbd is different in a lot of ways and there isn't a clean separation
between the client part (i.e. what is essentially reimplemented in the
kernel) and the rest (management and maintenance parts, etc).  It's
certainly not necessary, whether it's desirable - I'm not sure.  Also,
librbd limit, if we were to introduce one, would probably have to be
bigger.

Thanks,

                Ilya
