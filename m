From: Vasu Kulkarni <vakulkar@redhat.com>
Subject: Re: install task and ceph-mgr
Date: Wed, 2 Nov 2016 15:12:52 -0700
Message-ID: <CAKPXa=ZXSDpH4Yx3ueA65x95_kuJ62s1QmXS2Dun=ifZ49UGWA@mail.gmail.com>
References: <alpine.DEB.2.11.1611021754240.20331@piezo.us.to> <CAN=+7FUZ+jL_E3RyupkGD2Gd-WGuQ8CxBqg1Qif+bZGYHK4fBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33582 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932868AbcKBWMy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Nov 2016 18:12:54 -0400
Received: by mail-oi0-f53.google.com with SMTP id 128so42027047oih.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Nov 2016 15:12:53 -0700 (PDT)
In-Reply-To: <CAN=+7FUZ+jL_E3RyupkGD2Gd-WGuQ8CxBqg1Qif+bZGYHK4fBQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Kefu Chai <kchai@redhat.com>, "zcerza@redhat.com" <zcerza@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

other option is to make ceph-mgr dependent on one of the existing
packages and remove ceph-mgr from packages.yaml and the
install/upgrade will automatically install that package for kraken.

Regards
Vasu

On Wed, Nov 2, 2016 at 11:07 AM, Samuel Just <sjust@redhat.com> wrote:
> Having install.py skip it seems simpler to me?
> -Sam
>
> On Wed, Nov 2, 2016 at 10:56 AM, Sage Weil <sweil@redhat.com> wrote:
>> The recent ceph-qa-suite change to install ceph-mgr breaks the upgrade
>> tests because ceph-mgr doesn't exist in jewel and earlier.  How should we
>> fix that?
>>
>> - add exclude packages option to install.py, and update all the install
>> tests?
>>
>> - make install.py try to sort out on its own if the version is pre-kraken
>> and exclude it itself?
>>
>> http://pulpito.ceph.com/sage-2016-11-02_13:49:58-rados-wip-sage-testing---basic-smithi/
>>
>> sage
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
