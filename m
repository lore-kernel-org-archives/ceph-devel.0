From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Re: client isn't responding to mclientcaps
Date: Wed, 24 Jan 2018 13:24:22 +0800
Message-ID: <CAJACTue5VBCf8d6J0OQVtq-dMqeksYtN_eA_O_9jTnG8S0qhOQ@mail.gmail.com>
References: <CAJACTucim=9i_xOaVo-sJ7VuFEeTaK-hZvrqqrsKH7TpL0WK8g@mail.gmail.com>
 <CAAM7YA=zLKAS+CSSsCAHUZiQbNauSrBdJxKYoMATrukZhOQ5uA@mail.gmail.com>
 <CAJACTud8S++SJ4RdyzBiNHN1jQvzaD8pUAE-qz6CRMyBCzS=uQ@mail.gmail.com>
 <CAJACTud1L8nitFCXCr8KLFZnkiZui_gWGO3Crd3-LpRY1NmsVA@mail.gmail.com>
 <04E3D376-C095-44C1-9F61-1B0780138221@gmail.com> <CAJACTudqg6+pb7A4-p2npEFD=JAFas0=Qrh_9jBbgHSw-u18qw@mail.gmail.com>
 <A5875655-F788-425A-9C75-BACB9C1F99E3@gmail.com> <CAJACTudSPdx8jXkLFd=AiX6DmkVCt64BEeZ3WFjVPFdnhk8Rxw@mail.gmail.com>
 <CAAM7YAmcOabyjiJwsdJmD4XSGx0JLmPAqaktZNU21Bzrck2aBQ@mail.gmail.com>
 <CAJACTucu9cJ+ohrmDP1pRWOaHpTBXs4_PQ_Cwgfs=_NKgrq=wA@mail.gmail.com> <CAJACTucn7hqZxd4bNhe62tH5-K2bkjHauYFHoH5Tv98QHazBLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:46934 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbeAXFYX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jan 2018 00:24:23 -0500
Received: by mail-oi0-f48.google.com with SMTP id d124so2042103oib.13
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jan 2018 21:24:22 -0800 (PST)
In-Reply-To: <CAJACTucn7hqZxd4bNhe62tH5-K2bkjHauYFHoH5Tv98QHazBLg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: =?UTF-8?B?6Zm25Yas5Yas?= <tdd21151186@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi, I manually backported the patch into centos' 3.10.0-693 kernel. Is
there any way that I can fully test and validate my new kernel?
Thanks:-)

On 17 January 2018 at 15:16, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>>> The revoking caps is Fsc. This issue seems like
>>> http://tracker.ceph.com/issues/18798
>>
>> Is there any way that I can confirm these are the same issue, except
>> for upgrading my kernel?
>
> Is there any way that I can steadily reproduce this issue? Thanks
