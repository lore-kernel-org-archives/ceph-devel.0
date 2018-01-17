From: Xuehan Xu <xxhdx1985126@gmail.com>
Subject: Re: client isn't responding to mclientcaps
Date: Wed, 17 Jan 2018 10:58:04 +0800
Message-ID: <CAJACTud8S++SJ4RdyzBiNHN1jQvzaD8pUAE-qz6CRMyBCzS=uQ@mail.gmail.com>
References: <CAJACTucim=9i_xOaVo-sJ7VuFEeTaK-hZvrqqrsKH7TpL0WK8g@mail.gmail.com>
 <CAAM7YA=zLKAS+CSSsCAHUZiQbNauSrBdJxKYoMATrukZhOQ5uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33354 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbeAQC6F (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jan 2018 21:58:05 -0500
Received: by mail-oi0-f67.google.com with SMTP id y141so12140763oia.0
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jan 2018 18:58:05 -0800 (PST)
In-Reply-To: <CAAM7YA=zLKAS+CSSsCAHUZiQbNauSrBdJxKYoMATrukZhOQ5uA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 17 January 2018 at 10:06, Yan, Zheng <ukernel@gmail.com> wrote:
> On Tue, Jan 16, 2018 at 5:06 PM, Xuehan Xu <xxhdx1985126@gmail.com> wrote:
>> Hi, everyone.
>>
>> In our online cephfs, we occasionally encounter the error "Client.
>> isn't responding to mclientcaps", the client kernel we are using is
>> centos's "3.10.0-514".
>
> Is the error persistent and just temporary ?
>

It's temporary, but lasts for about 1.5 minutes, and the cephfs
cluster is under no heavy load.
Thanks:-)
