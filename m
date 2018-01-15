From: kefu chai <tchaikov@gmail.com>
Subject: Re: seastar temporary_buffer/packet and ceph::buffer
Date: Tue, 16 Jan 2018 01:09:57 +0800
Message-ID: <CAJE9aOMh5PUphVUrXc7YpHCjym2aBM9pJ7_5pAg4N4g7eggJWQ@mail.gmail.com>
References: <CAJE9aOPqAWTatC6sp-_00+w_MPVW52b+1TGL9LS0vc0y+iJq8Q@mail.gmail.com>
 <CAJE9aOPs8KPYQRprJ_iFcTGnkafnSkY_yswc5YennZox7-P1BA@mail.gmail.com> <20180115170427.GA10256@mailware>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:41562 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeAORJ6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jan 2018 12:09:58 -0500
Received: by mail-qt0-f177.google.com with SMTP id i40so14982750qti.8
        for <ceph-devel@vger.kernel.org>; Mon, 15 Jan 2018 09:09:58 -0800 (PST)
In-Reply-To: <20180115170427.GA10256@mailware>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <branch@predictor.org.pl>
Cc: The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>, Casey Bodley <cbodley@redhat.com>

On Tue, Jan 16, 2018 at 1:04 AM, Piotr Da=C5=82ek <branch@predictor.org.pl>=
 wrote:
> On Tue, Jan 16, 2018 at 12:53:22AM +0800, kefu chai wrote:
>> On Mon, Jan 15, 2018 at 11:49 PM, kefu chai <tchaikov@gmail.com> wrote:
>> > [..]
>> > i am preparing a change to prototype this approach. the downside of it=
 is:
>> >
>> > - we need to include a placeholder structure in buffer.h for
>> > seastar::tempoary_buffer<char>. and cast it to
>> > seastar::tempoary_buffer<char> in buffer.cc . otherwise we need to
>> > include seastar headers in librados.
>>
>> - we cannot store the crc map along with the raw class anymore. this
>> might be a show stopper.
>
> https://github.com/ceph/ceph/pull/18906
> There, already fixed it.


Piotr, thanks for point me to this PR. but i am evaluating the pros
and cons of the change, which tries to replace buffer::raw with
seastar::temporary_buffer, and use the latter in buffer::ptr as a
member variable.

>
> --
> Piotr Da=C5=82ek
> branch@predictor.org.pl
> http://blog.predictor.org.pl



--=20
Regards
Kefu Chai
