From: Haomai Wang <haomai@xsky.com>
Subject: Re: Cache Layer on NVME driver
Date: Wed, 18 May 2016 21:32:31 +0800
Message-ID: <CACJqLyab+rX4e2eu3oaC-DdX-OCaBCWiM_tt79KV8Dr6ZRfL4w@mail.gmail.com>
References: <CAFjGuFRBqX8CibKVA=Uu7J0cO3DXsLrA1_FVP_LBriKTLgQr3g@mail.gmail.com>
	<CACJqLyYGwhymjaVSoAGArPmPzFBmUHRrjGAtiQXKr6gEv_ZsSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-hk2apc01on0108.outbound.protection.outlook.com ([104.47.124.108]:30259
	"EHLO APC01-HK2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751062AbcERNcm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 18 May 2016 09:32:42 -0400
Received: by mail-vk0-f41.google.com with SMTP id s184so60920830vkb.3
        for <ceph-devel@vger.kernel.org>; Wed, 18 May 2016 06:32:37 -0700 (PDT)
In-Reply-To: <CACJqLyYGwhymjaVSoAGArPmPzFBmUHRrjGAtiQXKr6gEv_ZsSw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rajath Shashidhara <rajath.shashidhara@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Rajath,

We are glad to see your passion, from my view, sage is planning to
implement a userspace cache in bluestore itself. Like
(https://github.com/ceph/ceph/commit/b9ac31afe5a162176f019baa25348014a77f6ab8#commitcomment-17488250).

I guess the cache won't be a generic cache interface. Instead it will
be bound to specified needed object. So sage may give a brief?

On Wed, May 18, 2016 at 9:32 PM, Haomai Wang <haomai@xsky.com> wrote:
>
>
> On Wed, May 18, 2016 at 2:44 PM, Rajath Shashidhara
> <rajath.shashidhara@gmail.com> wrote:
>>
>> Hello,
>>
>> I was a GSoC'16 applicant for the project "Implementing Cache layer on
>> top of NVME Driver". Unfortunately, I was not selected for the
>> internship.
>
>
> Hi Rajath,
>
> We are glad to see your passion, from my view, sage is planning to implement
> a userspace cache in bluestore itself. Like
> (https://github.com/ceph/ceph/commit/b9ac31afe5a162176f019baa25348014a77f6ab8#commitcomment-17488250).
>
> I guess the cache won't be a generic cache interface. Instead it will be
> bound to specified needed object. So sage may give a brief?
>
>>
>>
>> However, I would be interested in working on the project as an
>> independent contributor to Ceph.
>> I am expecting to receive the necessary support from Ceph developer
>> community.
>>
>> In case I missed out any important details in my project proposal or I
>> have the wrong understanding of the project, please help me figure out
>> the details.
>>
>> Looking forward to contribute!
>>
>> Thank you,
>> Rajath Shashidhara
>
>
