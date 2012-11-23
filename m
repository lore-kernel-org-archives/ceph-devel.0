From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] overflow of int ret: use ssize_t for ret
Date: Fri, 23 Nov 2012 15:11:27 +0100
Message-ID: <CAJSP0QUhb4J6GQjuJ3OU2cgiFo+t25ERZhibMkYVLW0RuFeamA@mail.gmail.com>
References: <1353575275-1343-1-git-send-email-s.priebe@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52890 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab2KWOL3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 09:11:29 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so4237143lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 23 Nov 2012 06:11:27 -0800 (PST)
In-Reply-To: <1353575275-1343-1-git-send-email-s.priebe@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: qemu-devel <qemu-devel@nongnu.org>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>

On Thu, Nov 22, 2012 at 10:07 AM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> diff --git a/block/rbd.c b/block/rbd.c
> index 5a0f79f..0384c6c 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -69,7 +69,7 @@ typedef enum {
>  typedef struct RBDAIOCB {
>      BlockDriverAIOCB common;
>      QEMUBH *bh;
> -    int ret;
> +    ssize_t ret;
>      QEMUIOVector *qiov;
>      char *bounce;
>      RBDAIOCmd cmd;
> @@ -86,7 +86,7 @@ typedef struct RADOSCB {
>      int done;
>      int64_t size;
>      char *buf;
> -    int ret;
> +    ssize_t ret;
>  } RADOSCB;
>
>  #define RBD_FD_READ 0

I preferred your previous patch:

ssize_t on 32-bit hosts has sizeof(ssize_t) == 4.  In
qemu_rbd_complete_aio() we may assign acb->ret = rcb->size.  Here the
size field is int64_t, so ssize_t ret would truncate the value.

But BlockDriverCompetionFunc only takes an int argument so we're back
to square one.

The types are busted and changing the type of ret won't fix that :(.

Stefan
