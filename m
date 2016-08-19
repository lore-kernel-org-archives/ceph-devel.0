From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Re: wip-enc-dec
Date: Fri, 19 Aug 2016 02:03:15 +0000
Message-ID: <BLUPR0201MB19083A572C596FA095BFAD70E2160@BLUPR0201MB1908.namprd02.prod.outlook.com>
References: <CAN=+7FW+csmLcFGUPNabFMwvHHy0HWKWhX+bMzpa8_cYiCjSxQ@mail.gmail.com>
 <BLUPR0201MB1524E198EBBCB36CAA1DC1FEE8150@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <CAN=+7FWSbP8=Ae6pZnTkNwAtaVxdLEc+gRWsnfsrWvwaY8EeFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam03on0073.outbound.protection.outlook.com ([104.47.42.73]:39692
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753854AbcHSCS7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 18 Aug 2016 22:18:59 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sweil@redhat.com>

Hi Sam,

Here is some wip code on the new approach proposed by Allen.

https://github.com/varadakari/ceph/commits/wip-enc-dec

we are using a raw buffer which has all the encoded data and absorbed
into bufferlist once completed.
It pretty much has all the containers and primitive types support.
Working on some more optimizations on
the bluestore end to reduce the onode size along with blob map, but they
are wrapped in BlueStore.* files.
enc_dec.h and test_enc_dec.cc contains the logic.

Haven't tired with the safe and unsafe appenders yet.

Varada

On Friday 19 August 2016 05:44 AM, Samuel Just wrote:
> Here's a beginning on what that might look like:
> https://github.com/athanatos/ceph/commits/wip-sam-enc-dec-proto
>
> The design mostly comes from Allen/Varada's approach, but it uses
> unsafe_appender (I don't really feel strongly about that, Sage
> indicated that just using a raw pointer would probably be faster).
> The important part is that the top two commits above convert all
> primitive types as well as vector and pair (provided that their
> templated types support the new machinery).  This means that
> vector<int> should be able to preallocate and use unsafe_appender for
> all existing users.  I think it's worth going to some effort to make
> it easy to convert over existing users.
> -Sam
>
> On Thu, Aug 18, 2016 at 10:35 AM, Allen Samuels
> <Allen.Samuels@sandisk.com> wrote:
>> No reason not to merge them.
>>
>>
>> Allen Samuels
>> SanDisk |a Western Digital brand
>> 2880 Junction Avenue, San Jose, CA 95134
>> T: +1 408 801 7030| M: +1 408 780 6416
>> allen.samuels@SanDisk.com
>>
>>
>>> -----Original Message-----
>>> From: Samuel Just [mailto:sjust@redhat.com]
>>> Sent: Thursday, August 18, 2016 9:43 AM
>>> To: Allen Samuels <Allen.Samuels@sandisk.com>; Varada Kari
>>> <Varada.Kari@sandisk.com>; ceph-devel@vger.kernel.org
>>> Subject: wip-enc-dec
>>>
>>> Is there a reason not to put this new machinery directly into encoding.=
h?  The
>>> new machinery seems to be sufficient to implement the existing ::encode
>>> and ::decode types and should be compatible, right?
>>> With the containers, we can use template trickery to also forward the n=
ew
>>> functions when present in the mapped types.  That would let us graduall=
y
>>> adapt the code base.
>>> -Sam

PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
