From: Samuel Just <sam.just@inktank.com>
Subject: Re: Re: [ceph] update op added to a waiting queue or discarded (2c57719)
Date: Tue, 14 May 2013 15:29:07 -0700
Message-ID: <CA+4uBUY7EwZ4hwCVeD8DehvNAALnQzQVcroRsPM6bQTfoE+xEA@mail.gmail.com>
References: <dachary/ceph/commit/2c57719b658f41c34f8077899718956cc95f09b4/3210554@github.com>
	<5192A4F4.6010108@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:54284 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758222Ab3ENW3I convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 May 2013 18:29:08 -0400
Received: by mail-ee0-f51.google.com with SMTP id e51so639714eek.24
        for <ceph-devel@vger.kernel.org>; Tue, 14 May 2013 15:29:07 -0700 (PDT)
In-Reply-To: <5192A4F4.6010108@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Merged.
-Sam

On Tue, May 14, 2013 at 1:56 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sam,
>
> I'm not sure how this should be done thru github, therefore I send a =
regular mail instead ;-)
>
> The https://github.com/ceph/ceph/pull/283 pull request was updated wi=
th an amended patch, hopefully taking into account the changes from nex=
t.
>
> https://github.com/dachary/ceph/commit/dbddffef0604a5fc672e503fbb1b78=
b11234c7ca#L0R78
>
> Cheers
>
> -------- Original Message --------
> Subject:        Re: [ceph] update op added to a waiting queue or disc=
arded (2c57719)
> Date:   Tue, 14 May 2013 10:45:19 -0700
> From:   athanatos <notifications@github.com>
> Reply-To:       dachary/ceph <reply+c-3210554-727dd2f4c2b657262485968=
0949de999defe5985-433594@reply.github.com>
> To:     dachary/ceph <ceph@noreply.github.com>
> CC:     Loic Dachary <loic@dachary.org>
>
>
>
> Some of the details of the PG op queueing have changed again in next.=
 See fd90105 <https://github.com/dachary/ceph/commit/fd901056831586e813=
5e28c8f4ba9c2ec44dfcf6>.
>
> =97
> Reply to this email directly or view it on GitHub <https://github.com=
/dachary/ceph/commit/2c57719b658f41c34f8077899718956cc95f09b4#commitcom=
ment-3210554>.
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
