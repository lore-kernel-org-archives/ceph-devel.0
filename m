From: =?UTF-8?B?0K7RgNC40Lkg0KHQvtC60L7Qu9C+0LI=?=
	<funny.falcon@gmail.com>
Subject: Re: MADV_MERGEABLE for osdmaps etc...
Date: Wed, 13 Apr 2016 14:22:33 +0300
Message-ID: <CAL-rCA3ZTzTO9G9V41a5CW5ug++OhxB1wrR_6Dw9U8nYi=5KZg@mail.gmail.com>
References: <CABZ+qqkWELvQbpgxQ-chtsWTEEarGAsVN7t=7Tcm8+4zjQPopw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34955 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbcDMLWf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 07:22:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id a140so13038160wma.2
        for <ceph-devel@vger.kernel.org>; Wed, 13 Apr 2016 04:22:34 -0700 (PDT)
In-Reply-To: <CABZ+qqkWELvQbpgxQ-chtsWTEEarGAsVN7t=7Tcm8+4zjQPopw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Doubtfully they looks similar in memory now, cause they use a lot
std::map and std::strings,
and there is almost no possibility to guarantee memory layout.

2016-04-13 12:59 GMT+03:00 Dan van der Ster <dan@vanderster.com>:
> Hi ceph-devel,
>
> Did anyone ever consider using madvise MADV_MERGEABLE to enable kernel
> samepage merging for the ceph-osd? Typically this is used on kvm hosts
> to dedupe the VM memories, but naively I was thinking that since our
> osdmaps are duplicated (a few 100MB per daemon) we might profit as
> well. Though, perhaps these maps are changing often enough that KSM
> wouldn't help... no idea.
>
> Any thoughts here?
>
> -- Dan
> CERN IT
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
With regards,
Sokolov Yura aka funny_falcon
