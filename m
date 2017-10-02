From: Mauricio Garavaglia <mauricio@medallia.com>
Subject: Re: break_lock in librbd API without blacklisting client
Date: Mon, 2 Oct 2017 18:23:08 -0300
Message-ID: <CAAVaRiwd+CFBYJpQfMEv7BoW4BRS-fhJ-V7S11Dd-tBcbJGKpQ@mail.gmail.com>
References: <CAAVaRixW--NfN6a65xj7ekNGhbc+ZT7VMBdXVGtOgCaFxnesgQ@mail.gmail.com>
 <CA+aFP1B+oUOXH0zpAyNf5U+QmfbEdV1DNcUFM1Jv9JtWUwq67A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:51212 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbdJBVXk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Oct 2017 17:23:40 -0400
Received: by mail-wr0-f178.google.com with SMTP id j14so5021471wre.8
        for <ceph-devel@vger.kernel.org>; Mon, 02 Oct 2017 14:23:39 -0700 (PDT)
In-Reply-To: <CA+aFP1B+oUOXH0zpAyNf5U+QmfbEdV1DNcUFM1Jv9JtWUwq67A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks, in this scenario I want a host to cleanup any locks it had
during boot time, for the cases when it crashes and reboots.



On Mon, Oct 2, 2017 at 3:59 PM, Jason Dillaman <jdillama@redhat.com> wrote:
> First, I would like to advise that disabling blacklist on lock break
> can result in data corruption if the old lock owner continues to write
> after the lock has been broken. If that doesn't deter you, you can
> just set the configuration value programmatically [1] just like the
> rbd CLI allows you to override configuration values via optionals.
>
> [1] http://docs.ceph.com/docs/master/rados/api/python/#rados.Rados.conf_set
>
> On Mon, Oct 2, 2017 at 1:28 PM, Mauricio Garavaglia
> <mauricio@medallia.com> wrote:
>> Hello,
>> What's the correct way to use break_lock in the python/golang bindings
>> without blacklisting the client?
>> This can be done in the rbd cli using
>> --rbd_blacklist_on_break_lock=false but I can't find a way to do it
>> with the api.
>> Thanks
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Jason
