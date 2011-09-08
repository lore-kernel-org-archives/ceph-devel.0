From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] rbd: clean up, fix style
Date: Thu, 8 Sep 2011 10:48:50 +0100
Message-ID: <CAJSP0QVyaZatW3kM10ZqWrTWPM_02vtmPxLJhtPySKkc1uMPwQ@mail.gmail.com>
References: <1315412886-21092-1-git-send-email-sage@newdream.net>
	<1315412886-21092-2-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:45868 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758128Ab1IHJsv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2011 05:48:51 -0400
Received: by gwb17 with SMTP id 17so804209gwb.1
        for <ceph-devel@vger.kernel.org>; Thu, 08 Sep 2011 02:48:50 -0700 (PDT)
In-Reply-To: <1315412886-21092-2-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ceph-devel@vger.kernel.org

On Wed, Sep 7, 2011 at 5:28 PM, Sage Weil <sage@newdream.net> wrote:
> No assignment in condition. =A0Remove duplicate ret > 0 check.
>
> Signed-off-by: Sage Weil <sage@newdream.net>
> ---
> =A0block/rbd.c | =A0 17 ++++++++---------
> =A01 files changed, 8 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
