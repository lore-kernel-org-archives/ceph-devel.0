From: Sam Just <sam.just@inktank.com>
Subject: Re: Question regarding API doc
Date: Tue, 29 May 2012 11:28:24 -0700
Message-ID: <CA+4uBUZeF7UrdUTUxMddLphocs29uNA_bFfKCU2-z6CDKUHrPg@mail.gmail.com>
References: <4FC0492F.3080901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48134 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754999Ab2E2S2Z convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 14:28:25 -0400
Received: by pbbrp8 with SMTP id rp8so6309392pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 11:28:25 -0700 (PDT)
In-Reply-To: <4FC0492F.3080901@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaopong Tran <xiaopong.tran@gmail.com>
Cc: ceph-devel@vger.kernel.org

You are quite right.  I've updated the documentation in master, commit
f953c4c0b0ba69342cab52243c1b73987f7f94f6.  Thanks for the info!
-Sam

On Fri, May 25, 2012 at 8:08 PM, Xiaopong Tran <xiaopong.tran@gmail.com=
> wrote:
> I'm looking at the description in this API:
>
> http://ceph.com/docs/master/api/librados/#rados_objects_list_next
>
> For the parameters entry and key, the doc said "(caller must free)".
> I looked up in the code, and found this statement in the doc
> a bit misleading.
>
> Is the doc outdated, or did I miss anything?
>
> Cheers
>
> xp
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
