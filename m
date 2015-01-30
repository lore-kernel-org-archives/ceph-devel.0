From: Samuel Just <sam.just@inktank.com>
Subject: Re: Supporting partial writes for EC backend
Date: Fri, 30 Jan 2015 08:59:55 -0800
Message-ID: <CA+4uBUZWqWqy=gddVB=sWT7PsLsvq4mYVMn8_-tjM3sUL50Qsw@mail.gmail.com>
References: <BLU436-SMTP14889EB55A90A7C338308A9A7310@phx.gbl>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61639 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759333AbbA3Q75 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jan 2015 11:59:57 -0500
Received: by mail-lb0-f174.google.com with SMTP id f15so37332278lbj.5
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jan 2015 08:59:56 -0800 (PST)
In-Reply-To: <BLU436-SMTP14889EB55A90A7C338308A9A7310@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bassam Tabbara <bassamtabbara@hotmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Basically, it's an architectural choice:

https://github.com/ceph/ceph/blob/master/doc/dev/osd_internals/erasure_=
coding/pgbackend.rst#client-writes

If we wanted to support partial writes, we'd probably want to
introduce a second EC pool type with different tradeoffs.  Note, you
can get slow partial writes on an EC pool by placing a replicated
cache in front.
-Sam

On Fri, Jan 30, 2015 at 8:36 AM, Bassam Tabbara
<bassamtabbara@hotmail.com> wrote:
> Hello,
>
> I realize that the EC Backend does not support all operations like pa=
rtial writes, truncate, and others. I=E2=80=99d like to understand whet=
her adding the missing operations is something that is architecturally =
possible, or if this is a limitation of the architecture / approach. Ca=
n someone shed some light on this?
>
> I realize that partial writes are going to be slow/inefficient on an =
EC backend compared to a replicated backend.
>
> Thanks!
> Bassam--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
