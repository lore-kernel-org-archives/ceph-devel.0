From: Haomai Wang <haomai@xsky.com>
Subject: Re: msgr2 protocol
Date: Sat, 4 Jun 2016 00:47:43 +0800
Message-ID: <CACJqLyZs9EdbnjSiazPzxD_R+yuwPT9BzDq-GmEyS55f_pYFdw@mail.gmail.com>
References: <alpine.DEB.2.11.1605261358330.6221@cpach.fuggernut.com>
 <CAJ4mKGYxu1CKbusKp5Sn5269Q3PNuUWWRMQt1qUNR2SQQPjuFQ@mail.gmail.com>
 <alpine.DEB.2.11.1606021416510.6221@cpach.fuggernut.com> <CAJ4mKGaWx8m4Zh_f6tQWe9ows77HHyMmv5y52Rr-5Q-ob_N1Yg@mail.gmail.com>
 <alpine.DEB.2.11.1606030912000.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0113.outbound.protection.outlook.com ([104.47.125.113]:39807
	"EHLO APC01-SG2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932291AbcFCQry convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jun 2016 12:47:54 -0400
Received: by mail-vk0-f52.google.com with SMTP id d127so122237285vkh.2
        for <ceph-devel@vger.kernel.org>; Fri, 03 Jun 2016 09:47:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606030912000.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Marcus Watts <mwatts@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jun 3, 2016 at 9:24 PM, Sage Weil <sweil@redhat.com> wrote:
> I updated the PR with an additional commit that simplifies the
> confounder.  It seems like we only need the confoudner at teh beginni=
ng of
> the session, not for every message, since the signature and encryptio=
n
> state is chained from the previous frame.  Is that right?
>
>         https://github.com/ceph/ceph/pull/9461/commits/45766fed186473=
3c5216a7b50f11cce256338170
>
> Full PR:
>
>         https://github.com/ceph/ceph/pull/9461
>
> --
>
> Also, I just realized that now might be a good time to address the ab=
ility
> to multiplex different endpoints (sessions) into the same connection.=
  We
> could add it later with the msgr feature bits, but it'll probably be
> simpler not to have to support two variants of the protocol.  On the =
other
> hand, it's a lot more complicated.  :(

What's the use case? different session shares the same connection? Do
you mean different messenger instance will share the same connection
pool?

>
> Initial thoughts:
>
>  - make a clearer distinction between connection (as in tcp) and a
> session (as in an exchange between two entities, one that may or may =
not
> have a lifecycle independent of the connection.
>  - the auth exchange is no longer always at the beginning of the
> connection.  new entities might appear in the same endpoint=E3=80=82
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
