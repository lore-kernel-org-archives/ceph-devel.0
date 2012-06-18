From: Tommi Virtanen <tv@inktank.com>
Subject: Re: RBD layering design draft
Date: Mon, 18 Jun 2012 09:25:59 -0700
Message-ID: <CADvuQREO95qJsd6netR+3RSjeddZR3U+B4++XJFsAiz3ZfomEA@mail.gmail.com>
References: <4FDB9FBB.9000807@inktank.com> <Pine.LNX.4.64.1206151742380.28086@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46807 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894Ab2FRQ0T convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 12:26:19 -0400
Received: by dady13 with SMTP id y13so7159101dad.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 09:26:19 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1206151742380.28086@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jun 15, 2012 at 5:46 PM, Sage Weil <sage@inktank.com> wrote:
> Is 'preserve' and 'unpreserve' the verbiage we want to use here? =C2=A0=
Not sure
> I have a better suggestion, but preserve is unusual.

protect/unprotect? The flag protects the image snapshot from being dele=
ted.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
