From: Tommi Virtanen <tv@inktank.com>
Subject: Re: How will Ceph cope with a failed Journal device?
Date: Fri, 18 May 2012 13:01:55 -0700
Message-ID: <CADvuQREBg4GfouqSVTmBXaTRTfoDSuvZdhMK7MdperStT4Utqw@mail.gmail.com>
References: <2465580.E9977TXsHv@pc10> <CADxhoDTe5mO5-pAzBoZYesCw8MV4TUUzBCYMmmwPfKU4otTrNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35012 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967148Ab2ERUCQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 May 2012 16:02:16 -0400
Received: by pbbrp8 with SMTP id rp8so4374113pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 May 2012 13:02:16 -0700 (PDT)
In-Reply-To: <CADxhoDTe5mO5-pAzBoZYesCw8MV4TUUzBCYMmmwPfKU4otTrNg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Calvin Morrow <calvin.morrow@gmail.com>
Cc: Guido Winkelmann <guido-ceph@thisisnotatest.de>, ceph-devel@vger.kernel.org

On Fri, May 18, 2012 at 11:36 AM, Calvin Morrow <calvin.morrow@gmail.co=
m> wrote:
> I posted the same question to the list last week and never got a
> reply. =C2=A0In addition, I'd also like to know if there's a differen=
ce in
> failure behavior between XFS backed Ceph (writeahead journaling) and
> BTRFS backed Ceph (parallel journaling).

Actually, Sam replied to your email a week ago:

http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/6258/focus=3D=
6358

Summarizing/rephrasing:

On both xfs & btrfs, a journal device giving I/O errors should make
the osd stop operating.

Losing a journal with xfs: you should destroy & recreate the osd, and
your data is safe because of Ceph replication across osds.

Losing a journal with btrfs: creating a new journal should let the osd
recover the missing parts from replicas (and your data is safe mostly
because of Ceph replication, recovery is just faster).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
