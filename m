From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] rbd: wire up snapshot removal and
 rollback functionality
Date: Thu, 12 Jan 2012 09:40:52 +0000
Message-ID: <CAJSP0QU=gfCB2nvmMPNWhOOSxPkNMUB71fOeKnM5P=Qy4EVB8g@mail.gmail.com>
References: <CAF3hT9CSKMepR_rfbKsWUQrbYDJUyYpzsX5FpHXH30E8jBJYLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56079 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab2ALJkw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2012 04:40:52 -0500
Received: by iabz25 with SMTP id z25so2491176iab.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2012 01:40:52 -0800 (PST)
In-Reply-To: <CAF3hT9CSKMepR_rfbKsWUQrbYDJUyYpzsX5FpHXH30E8jBJYLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ceph-devel@vger.kernel.org

On Wed, Jan 11, 2012 at 7:53 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> Signed-off-by: Greg Farnum <gregory.farnum@dreamhost.com>
> ---
> Remove redundant warnings and add Kevin to the CC.
>
> =A0block/rbd.c | =A0 22 ++++++++++++++++++++++
> =A01 files changed, 22 insertions(+), 0 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
