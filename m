From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: XmlFormatter: space isn't allowed in xml tag
Date: Fri, 13 Jan 2017 16:04:29 +0800
Message-ID: <CACKY0b9PXB-tOii+3K_yGT9OUQiznu5e_==rkVcuRxCZmfK2Vw@mail.gmail.com>
References: <CACKY0b9_gPAoB3uWAiom1UiPHvDtbXAFJiCtQZN1PV+ps6P5Yw@mail.gmail.com>
 <robbat2-20170112T091829-255678655Z@orbis-terrarum.net> <CACKY0b9=9wmNKFa1NEh=qatVHvwRTg0Xh50Xt41QPBsDyA-TWw@mail.gmail.com>
 <alpine.DEB.2.11.1701121334460.5745@piezo.novalocal> <CACKY0b_wChMcJYvFp+ZCCy4wCs0_TuB2sBjZb09oRoFLsYduSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f179.google.com ([209.85.213.179]:35720 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbdAMIEs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jan 2017 03:04:48 -0500
Received: by mail-yb0-f179.google.com with SMTP id l23so12970133ybj.2
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2017 00:04:30 -0800 (PST)
In-Reply-To: <CACKY0b_wChMcJYvFp+ZCCy4wCs0_TuB2sBjZb09oRoFLsYduSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi, all

https://github.com/ceph/ceph/pull/12916

Please take a look

2017-01-12 21:56 GMT+08:00 liuchang0812 <liuchang0812@gmail.com>:
> I'm working on it, Thanks for all comments
>
> 2017-01-12 21:35 GMT+08:00 Sage Weil <sage@newdream.net>:
>> On Thu, 12 Jan 2017, liuchang0812 wrote:
>>> ./bin/ceph daemon out/osd.0.asok dump_historic_ops -f xml
>>> <OpHistory><num to keep>20</num to keep><duration to
>>> keep>600</duration to keep><Ops></Ops></OpHistory>
>>
>> Any instance where a Formatter element name has a space in it (and
>> probably uppercase, for that matter) should be considered a bug and fixed
>> (for this very reason).  Please just submit a PR that adds _'s for this
>> one.
>>
>> Thanks!
>> sage
>>
>>
>>>
>>> I'm not sure whether XML library could decode it, I will have a try
>>>
>>> 2017-01-12 17:20 GMT+08:00 Robin H. Johnson <robbat2@gentoo.org>:
>>> > On Thu, Jan 12, 2017 at 01:27:33PM +0800, liuchang0812 wrote:
>>> >> hi, all
>>> >>
>>> >> an XML tag cannot contains space in it. see
>>> >> https://www.w3.org/TR/2008/REC-xml-20081126/#NT-NameChar.
>>> > Where are spaces leaking into the element names?
>>> >
>>> > I did a refactor of Formatter parters when I was introducing the
>>> > HTMLFormatter used by s3website mode, and I don't recall seeing any
>>> > cases of accidental space in XML element names, at least in the RGW
>>> > side.
>>> >
>>> > --
>>> > Robin Hugh Johnson
>>> > Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
>>> > E-Mail   : robbat2@gentoo.org
>>> > GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
>>> > GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
