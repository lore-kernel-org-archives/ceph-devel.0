From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] rbd: fix leak in qemu_rbd_open failure paths
Date: Thu, 8 Sep 2011 10:49:09 +0100
Message-ID: <CAJSP0QXGx5YhSC0Ds-EYoSn_4y6SAqU_xTiAj1TF3zRnpaT5Hw@mail.gmail.com>
References: <1315412886-21092-1-git-send-email-sage@newdream.net>
	<1315412886-21092-3-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40523 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758152Ab1IHJtJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2011 05:49:09 -0400
Received: by yxp4 with SMTP id 4so299599yxp.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Sep 2011 02:49:09 -0700 (PDT)
In-Reply-To: <1315412886-21092-3-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ceph-devel@vger.kernel.org

On Wed, Sep 7, 2011 at 5:28 PM, Sage Weil <sage@newdream.net> wrote:
> Fix leak of s->snap in failure path. =A0Simplify error paths for the =
whole
> function.
>
> Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Sage Weil <sage@newdream.net>
> ---
> =A0block/rbd.c | =A0 28 +++++++++++++---------------
> =A01 files changed, 13 insertions(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
