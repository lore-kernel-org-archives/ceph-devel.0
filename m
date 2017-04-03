From: Myna V <mynaramana@gmail.com>
Subject: Re: Coupled Layer MSR: PR 14300, ECSubRead decode fail.
Date: Mon, 3 Apr 2017 23:43:48 +0530
Message-ID: <CAGvpcHZQEsWWHFg57eafM7HCMOArHbMWuK9ajrhn0TE-Tgpu8A@mail.gmail.com>
References: <CAGvpcHbbY2wU+vMxooxg=JC41c1DRaAKj86fw3ybGvFcNfWhLw@mail.gmail.com>
 <CAJ4mKGY79sgNSuEHWdje=6vm+p=omsJGNbKBzaj+o-sHYrP=8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36718 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753423AbdDCSO3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Apr 2017 14:14:29 -0400
Received: by mail-pg0-f51.google.com with SMTP id g2so126325952pge.3
        for <ceph-devel@vger.kernel.org>; Mon, 03 Apr 2017 11:14:29 -0700 (PDT)
In-Reply-To: <CAJ4mKGY79sgNSuEHWdje=6vm+p=omsJGNbKBzaj+o-sHYrP=8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Elita Lobo <loboelita@gmail.com>, Bhagyashree Puranik <bhagya.puranik@gmail.com>, Birenjith Sasidharan <birenjith@gmail.com>, Ganesh Kini <kiniganesh94@gmail.com>, Vinayak Ramkumar <vinram93@gmail.com>

Thanks Greg. We will do that!

On Mon, Apr 3, 2017 at 11:37 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Mon, Apr 3, 2017 at 11:02 AM, Myna V <mynaramana@gmail.com> wrote:
>> Hello All,
>>
>> This is regarding the make check error in readable.sh
>>
>> https://jenkins.ceph.com/job/ceph-pull-requests/21319/
>>
>> We have added additional fields to the ECSubRead message type and
>> updated the encode, decode of ECSubRead message to incorporate the
>> newly added fields. The failure seems to happen when the object (older
>> ECSubRead) is being decoded with the new decode function as it is
>> expecting a larger buffer length.
>>
>> How do we update the test objects in ceph-object-corpus with these
>> added fields ?
>
> You don't! ceph-object-corpus exists to make sure that newer code can
> read older objects. You need to update the versions used in
> ENCODE_START/DECODE_START and branch internally based on the encoded
> object's struct_v member. I'm not sure if there are good examples of
> this in the EC utility functions yet, but if not you can check out
> osd_types.[h|cc] and the encoding.h macros being invoked. :)
> -Greg
