From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: cmake
Date: Mon, 4 Jul 2016 20:37:15 +1000
Message-ID: <CAF-wwdEA+hjDa3mAZXp8jNEn_1c1-9RUzBqaVTaKBFXO0bWpOg@mail.gmail.com>
References: <alpine.DEB.2.11.1606271746590.2844@piezo.us.to> <0ba08c31-8c9e-a483-6c5b-07ce9b6b5495@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36390 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030AbcGDKhS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2016 06:37:18 -0400
Received: by mail-wm0-f47.google.com with SMTP id f126so98296019wma.1
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jul 2016 03:37:17 -0700 (PDT)
In-Reply-To: <0ba08c31-8c9e-a483-6c5b-07ce9b6b5495@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jul 4, 2016 at 7:05 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 27-6-2016 19:50, Sage Weil wrote:
>> We are switching from autotools to cmake on the master branch. Any
>> builds done post-jewel will be cmake and not autotools based.  Jewel and
>> older releases will still be built with autotools the old way.
>
> Hi Sage,
>
> Question about Cmake versions....
>
> On FreeBSD cmake is version 3.5.2
> My Centos box has 2.8.11
>
> If there any "minimum" requirements here??

You should be fine.

[ceph] (master %)$ head -1 CMakeLists.txt
cmake_minimum_required(VERSION 2.8.11)

HTH,
Brad

>
> --WjW
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
