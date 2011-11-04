From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: radosgw-admin temp remove
Date: Fri, 4 Nov 2011 13:15:37 -0700
Message-ID: <CAC-hyiEih53S81D+Fnosv_nmChVmZ+0hugFqbta6Ft_4zN5Y2Q@mail.gmail.com>
References: <CANExM-NKpof7kQ1sMCkcnwdAQ-F6e3QH5g5i3VKnCGyKrj4gaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49609 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab1KDUPi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Nov 2011 16:15:38 -0400
Received: by bke11 with SMTP id 11so2304954bke.19
        for <ceph-devel@vger.kernel.org>; Fri, 04 Nov 2011 13:15:37 -0700 (PDT)
In-Reply-To: <CANExM-NKpof7kQ1sMCkcnwdAQ-F6e3QH5g5i3VKnCGyKrj4gaQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Nov 4, 2011 at 1:47 AM, Henry C Chang <henry.cy.chang@gmail.com=
> wrote:
> Hi all,
>
> I used to schedule a cron job to do "radosgw-admin --date `date
> +%Y-%m-%d` temp remove".
> It works fine in v0.36, but got an error in v0.37. See the error mess=
age below:
>
> root@ceph1:~# radosgw-admin --date 2011-11-04 temp remove -d
> 2011-11-04 16:34:27.373509 7f277c6ab760 cls_bucket_list .intent-log
> start =A0num 1000
> 2011-11-04 16:34:27.373538 7f277c6ab760 ERROR: empty marker for
> cls_rgw bucket operation
> failed to list objects
>
> I wonder if it is a bug or the command changed?
>

That's a bug. We recently modified rgw to index bucket objects,
however, this was only done for non-system buckets. On the bright
side, it prevented a more severe bug that would eat your data to show
itself. I just pushed a fix for both these bugs to the master branch.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
