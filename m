From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Message decode issue
Date: Tue, 23 Jan 2018 09:30:28 +0100
Message-ID: <CAJ4mKGYin9Z9zmmfvFAdrT_eL2+FB6Rw0bhHSQ_885gAg+FyvQ@mail.gmail.com>
References: <1240D552-284C-4C9C-A114-BFAE7F537D95@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:42489 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeAWIaa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jan 2018 03:30:30 -0500
Received: by mail-io0-f180.google.com with SMTP id 25so55527ioj.9
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jan 2018 00:30:30 -0800 (PST)
In-Reply-To: <1240D552-284C-4C9C-A114-BFAE7F537D95@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6Zm25Yas5Yas?= <tdd21151186@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jan 23, 2018 at 9:25 AM, 陶冬冬 <tdd21151186@gmail.com> wrote:
> Dear Cephers,
>
> below is a piece of code in Message::decode_message:
> ```
> // m->header.version, if non-zero, should be populated with the
>   // newest version of the encoding the code supports.  If set, check
>   // it against compat_version.
>   if (m->get_header().version &&
>       m->get_header().version < header.compat_version) {
>     if (cct) {
>       ldout(cct, 0) << "will not decode message of type " << type
>                     << " version " << header.version
>                     << " because compat_version " << header.compat_version
>                     << " > supported version " << m->get_header().version << dendl;
>       if (cct->_conf->ms_die_on_bad_msg)
>         ceph_abort();
>     }
>     m->put();
>     return 0;
>   }
> ```
> I know it’s checking the compatibility of the incoming message.
> but, i think it’s not sufficient, it only checked if the coming message’s compat_version is bigger than our version (if it’s true, the message is not supported)
> it should also check if the comming message’s version  is smaller than our compat_version, right ?

No. A message older than us may still be understandable by us. Many of
the message decode functions branch to deal with older messages, and
we have a lot of code to communicate with older message types to older
daemons.
-Greg

> please correct me if i’m wrong.
>
> Regards,
> Dongdong--
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
