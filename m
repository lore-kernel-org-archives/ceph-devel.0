From: Alfredo Deza <adeza@redhat.com>
Subject: Re: LUKS encryption in OSDs (ceph-volume)
Date: Tue, 12 Dec 2017 14:51:00 -0500
Message-ID: <CAC-Np1xymbq6taouoMZB7F_LKv5ZUq04zpeKgda3DtoZ+RVJ1A@mail.gmail.com>
References: <CAC-Np1z_Kv1sSBzPXvsiQ7GubioSwQZnMMtuJL4Z3SUXR2L1fg@mail.gmail.com>
 <CAGbvivL=5WdKJbKtt=KO98v86EQZb3Nz+p=zLKusxbMv+_u0ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:43906 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdLLTvB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Dec 2017 14:51:01 -0500
Received: by mail-qt0-f182.google.com with SMTP id w10so41951qtb.10
        for <ceph-devel@vger.kernel.org>; Tue, 12 Dec 2017 11:51:01 -0800 (PST)
In-Reply-To: <CAGbvivL=5WdKJbKtt=KO98v86EQZb3Nz+p=zLKusxbMv+_u0ig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Dec 12, 2017 at 2:38 PM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> Its useful for legacy systems that installed with "plain" back when
> that was the only option. Since there is no easy migration path for
> re-keying an encrypted OSD to use a new encryption scheme, keeping
> support for legacy "plain" is still very useful and desirable.

Yes, for sure we are going to support that legacy option. But for
*newly* created OSDs, I was looking forward to follow
the preferred way with LUKS only.

>
> On Tue, Dec 12, 2017 at 2:27 PM, Alfredo Deza <adeza@redhat.com> wrote:
>> We have started looking into encryption support in ceph-volume, and
>> one of the unclear paths is if we really want to support both "plain"
>> and "LUKS".
>>
>> According to the cryptsetup docs [0] :
>>
>>     (LUKS) is now the preferred way to set up disk encryption with
>> dm-crypt using the cryptsetup utility
>>
>>
>> ceph-disk supports both plain and LUKS, but moving forward, I was
>> interested in understanding if anyone is really expecting the "plain"
>> type to be a choice?
>>
>> The legacy support will mean that ceph-volume will have to deal with
>> "plain", but moving forward it might be easier if we are supporting a
>> single type of encryption with LUKS.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
