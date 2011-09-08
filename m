From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] rbd: allow client id to be specified in
 config string
Date: Thu, 8 Sep 2011 10:48:34 +0100
Message-ID: <CAJSP0QVmPomkm84Adc+RpfXBQ=Evvfo=PXVCr0VH9o7Q8mgbDQ@mail.gmail.com>
References: <1315412886-21092-1-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:43764 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758128Ab1IHJsf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2011 05:48:35 -0400
Received: by yie30 with SMTP id 30so495074yie.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Sep 2011 02:48:34 -0700 (PDT)
In-Reply-To: <1315412886-21092-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ceph-devel@vger.kernel.org

On Wed, Sep 7, 2011 at 5:28 PM, Sage Weil <sage@newdream.net> wrote:
> Allow the client id to be specified in the config string via 'id=3D' =
so that
> users can control who they authenticate as. =A0Currently they are stu=
ck with
> the default ('admin'). =A0This is necessary for anyone using authenti=
cation
> in their environment.
>
> Signed-off-by: Sage Weil <sage@newdream.net>
> ---
> =A0block/rbd.c | =A0 52 ++++++++++++++++++++++++++++++++++++++++++++-=
-------
> =A01 files changed, 44 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
