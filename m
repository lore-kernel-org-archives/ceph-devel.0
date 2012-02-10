From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: s3--object name with "%" questions
Date: Fri, 10 Feb 2012 14:52:22 -0800
Message-ID: <CAC-hyiHxCnWyYh3YKrnYZxZiCvzBdnNXdKwCyGDLzgm1KVs8Fg@mail.gmail.com>
References: <CABAwU-bsdR+kwbvUfTcw8AmiT8M_kJz8MKuFNBjpB3WfJ6OXgw@mail.gmail.com>
	<CAC-hyiFmPmZwrUh+KgVDOs8R-0gmdZvJvcDA8369MOk1zRbCdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57566 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760379Ab2BJWwX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2012 17:52:23 -0500
Received: by yhoo21 with SMTP id o21so1765250yho.19
        for <ceph-devel@vger.kernel.org>; Fri, 10 Feb 2012 14:52:22 -0800 (PST)
In-Reply-To: <CAC-hyiFmPmZwrUh+KgVDOs8R-0gmdZvJvcDA8369MOk1zRbCdw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

(resending to list)

On Fri, Feb 10, 2012 at 1:06 AM, huang jun <hjwsm1989@gmail.com> wrote:
>
> hi,list
> =A0After testing the object-name include "+" in radosgw.now we tested
> object-name with "%",
> =A0which was supported by the amazon's object-name rules, either in t=
he
> underlayer FS btrfs .
> =A0but it seems not =A0the case in radosgw, we can not create an obje=
ct
> whoes name include "%",
>
> =A0after we can create it, then the ListBucket result shows the name =
of
> the object "test%huang" is "test2608ang".
> =A0we trace the debug log, the object-name was changed by "vsnprintf"=
 in
> formatter.dump_format, because the "%" is a control character,
> =A0so, there is any methods if user want to store an object =A0with n=
ame
> string include =A0"%".
>

Yeah, this is a bug. I opened issue #2051 in the tracker.

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
