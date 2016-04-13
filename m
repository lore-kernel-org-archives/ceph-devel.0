From: Dan van der Ster <dan@vanderster.com>
Subject: Re: MADV_MERGEABLE for osdmaps etc...
Date: Wed, 13 Apr 2016 14:06:22 +0200
Message-ID: <CABZ+qqmDV6tY9d4Ci3o6UxZcJgEJZy9x2nQvt-=hw=L=7uuC8w@mail.gmail.com>
References: <CABZ+qqkWELvQbpgxQ-chtsWTEEarGAsVN7t=7Tcm8+4zjQPopw@mail.gmail.com>
 <CAL-rCA3ZTzTO9G9V41a5CW5ug++OhxB1wrR_6Dw9U8nYi=5KZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35903 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbcDMMHG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 08:07:06 -0400
Received: by mail-lf0-f54.google.com with SMTP id g184so66347457lfb.3
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 05:07:05 -0700 (PDT)
Received: from mail-lf0-f54.google.com (mail-lf0-f54.google.com. [209.85.215.54])
        by smtp.gmail.com with ESMTPSA id e66sm6174617lfg.23.2016.04.13.05.07.02
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2016 05:07:02 -0700 (PDT)
Received: by mail-lf0-f54.google.com with SMTP id e190so66561832lfe.0
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 05:07:02 -0700 (PDT)
In-Reply-To: <CAL-rCA3ZTzTO9G9V41a5CW5ug++OhxB1wrR_6Dw9U8nYi=5KZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?0K7RgNC40Lkg0KHQvtC60L7Qu9C+0LI=?= <funny.falcon@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks for the quick reply.
I'm trying anyway with this LD_PRELOAD hack: http://vleu.net/ksm_preloa=
d/
But I don't manage to start the osd (jewel) with that :( ... still tryi=
ng.

-- dan


On Wed, Apr 13, 2016 at 1:22 PM, =D0=AE=D1=80=D0=B8=D0=B9 =D0=A1=D0=BE=D0=
=BA=D0=BE=D0=BB=D0=BE=D0=B2 <funny.falcon@gmail.com> wrote:
> Doubtfully they looks similar in memory now, cause they use a lot
> std::map and std::strings,
> and there is almost no possibility to guarantee memory layout.
>
> 2016-04-13 12:59 GMT+03:00 Dan van der Ster <dan@vanderster.com>:
>> Hi ceph-devel,
>>
>> Did anyone ever consider using madvise MADV_MERGEABLE to enable kern=
el
>> samepage merging for the ceph-osd? Typically this is used on kvm hos=
ts
>> to dedupe the VM memories, but naively I was thinking that since our
>> osdmaps are duplicated (a few 100MB per daemon) we might profit as
>> well. Though, perhaps these maps are changing often enough that KSM
>> wouldn't help... no idea.
>>
>> Any thoughts here?
>>
>> -- Dan
>> CERN IT
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> With regards,
> Sokolov Yura aka funny_falcon
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
