From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: XmlFormatter: space isn't allowed in xml tag
Date: Thu, 12 Jan 2017 18:03:14 +0800
Message-ID: <CACKY0b9=9wmNKFa1NEh=qatVHvwRTg0Xh50Xt41QPBsDyA-TWw@mail.gmail.com>
References: <CACKY0b9_gPAoB3uWAiom1UiPHvDtbXAFJiCtQZN1PV+ps6P5Yw@mail.gmail.com>
 <robbat2-20170112T091829-255678655Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f169.google.com ([209.85.213.169]:33436 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbdALKDw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jan 2017 05:03:52 -0500
Received: by mail-yb0-f169.google.com with SMTP id w194so473612ybe.0
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2017 02:03:15 -0800 (PST)
In-Reply-To: <robbat2-20170112T091829-255678655Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

./bin/ceph daemon out/osd.0.asok dump_historic_ops -f xml
<OpHistory><num to keep>20</num to keep><duration to
keep>600</duration to keep><Ops></Ops></OpHistory>

I'm not sure whether XML library could decode it, I will have a try

2017-01-12 17:20 GMT+08:00 Robin H. Johnson <robbat2@gentoo.org>:
> On Thu, Jan 12, 2017 at 01:27:33PM +0800, liuchang0812 wrote:
>> hi, all
>>
>> an XML tag cannot contains space in it. see
>> https://www.w3.org/TR/2008/REC-xml-20081126/#NT-NameChar.
> Where are spaces leaking into the element names?
>
> I did a refactor of Formatter parters when I was introducing the
> HTMLFormatter used by s3website mode, and I don't recall seeing any
> cases of accidental space in XML element names, at least in the RGW
> side.
>
> --
> Robin Hugh Johnson
> Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
> E-Mail   : robbat2@gentoo.org
> GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
