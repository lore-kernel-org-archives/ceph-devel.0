From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Re: client isn't responding to mclientcaps
Date: Wed, 17 Jan 2018 11:24:19 +0800
Message-ID: <CAJACTud1L8nitFCXCr8KLFZnkiZui_gWGO3Crd3-LpRY1NmsVA@mail.gmail.com>
References: <CAJACTucim=9i_xOaVo-sJ7VuFEeTaK-hZvrqqrsKH7TpL0WK8g@mail.gmail.com>
 <CAAM7YA=zLKAS+CSSsCAHUZiQbNauSrBdJxKYoMATrukZhOQ5uA@mail.gmail.com> <CAJACTud8S++SJ4RdyzBiNHN1jQvzaD8pUAE-qz6CRMyBCzS=uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f170.google.com ([74.125.82.170]:44125 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbeAQDYU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jan 2018 22:24:20 -0500
Received: by mail-ot0-f170.google.com with SMTP id t20so6240972ote.11
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jan 2018 19:24:20 -0800 (PST)
In-Reply-To: <CAJACTud8S++SJ4RdyzBiNHN1jQvzaD8pUAE-qz6CRMyBCzS=uQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 17 January 2018 at 10:58, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
> On 17 January 2018 at 10:06, Yan, Zheng <ukernel@gmail.com> wrote:
>> On Tue, Jan 16, 2018 at 5:06 PM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>>> Hi, everyone.
>>>
>>> In our online cephfs, we occasionally encounter the error "Client.
>>> isn't responding to mclientcaps", the client kernel we are using is
>>> centos's "3.10.0-514".
>>
>> Is the error persistent and just temporary ?
>>
>
> It's temporary, but lasts for about 1.5 minutes, and the cephfs
> cluster is under no heavy load.
> Thanks:-)

By the way, in our logs, there is such statements: "client.4607906
isn't responding to mclientcaps(revoke), ino 0x10000001d30 pending
pAsLsXsFr issued pAsLsXsFscr, sent 62.743469 seconds ago"

It seems that "Fscr" is all read capabilities, and "Fr" is all read
capabilities, so it seems that the "issued" caps doesn't need to be
revoked. Is this right?
