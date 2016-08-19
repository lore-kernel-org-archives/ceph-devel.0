From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Re: wip-enc-dec
Date: Fri, 19 Aug 2016 15:23:13 +0000
Message-ID: <BLUPR0201MB190863C230AE671EB96EC1FDE2160@BLUPR0201MB1908.namprd02.prod.outlook.com>
References: <CAN=+7FW+csmLcFGUPNabFMwvHHy0HWKWhX+bMzpa8_cYiCjSxQ@mail.gmail.com>
 <BLUPR0201MB1524E198EBBCB36CAA1DC1FEE8150@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <CAN=+7FWSbP8=Ae6pZnTkNwAtaVxdLEc+gRWsnfsrWvwaY8EeFw@mail.gmail.com>
 <BLUPR0201MB19083A572C596FA095BFAD70E2160@BLUPR0201MB1908.namprd02.prod.outlook.com>
 <CAN=+7FWqvbXJ8k1srv8QSMocAUUfTf0GOtOBscLww7vVnEHeEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0050.outbound.protection.outlook.com ([104.47.40.50]:64032
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754931AbcHSPXR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 19 Aug 2016 11:23:17 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Weil, Sage" <sweil@redhat.com>

Sure Sam. Working on couple of optimizations with the current branch,=0A=
will work on this integration once that is completed.=0A=
Haven't completely gone through the hooks what you have written yet, but=0A=
will rebase my branch on that once i am done with current changes.=0A=
=0A=
Thanks,=0A=
Varada=0A=
=0A=
On Friday 19 August 2016 08:44 PM, Samuel Just wrote:=0A=
> Yeah, that's what my branch is based on.  My goal wasn't to replace=0A=
> what you've been working on, but rather to suggest a way to hook it=0A=
> into the existing encode/decode machinery so that everything would=0A=
> benefit.=0A=
> -Sam=0A=
>=0A=
> On Thu, Aug 18, 2016 at 7:03 PM, Varada Kari <Varada.Kari@sandisk.com> wr=
ote:=0A=
>> Hi Sam,=0A=
>>=0A=
>> Here is some wip code on the new approach proposed by Allen.=0A=
>>=0A=
>> https://github.com/varadakari/ceph/commits/wip-enc-dec=0A=
>>=0A=
>> we are using a raw buffer which has all the encoded data and absorbed=0A=
>> into bufferlist once completed.=0A=
>> It pretty much has all the containers and primitive types support.=0A=
>> Working on some more optimizations on=0A=
>> the bluestore end to reduce the onode size along with blob map, but they=
=0A=
>> are wrapped in BlueStore.* files.=0A=
>> enc_dec.h and test_enc_dec.cc contains the logic.=0A=
>>=0A=
>> Haven't tired with the safe and unsafe appenders yet.=0A=
>>=0A=
>> Varada=0A=
>>=0A=
>> On Friday 19 August 2016 05:44 AM, Samuel Just wrote:=0A=
>>> Here's a beginning on what that might look like:=0A=
>>> https://github.com/athanatos/ceph/commits/wip-sam-enc-dec-proto=0A=
>>>=0A=
>>> The design mostly comes from Allen/Varada's approach, but it uses=0A=
>>> unsafe_appender (I don't really feel strongly about that, Sage=0A=
>>> indicated that just using a raw pointer would probably be faster).=0A=
>>> The important part is that the top two commits above convert all=0A=
>>> primitive types as well as vector and pair (provided that their=0A=
>>> templated types support the new machinery).  This means that=0A=
>>> vector<int> should be able to preallocate and use unsafe_appender for=
=0A=
>>> all existing users.  I think it's worth going to some effort to make=0A=
>>> it easy to convert over existing users.=0A=
>>> -Sam=0A=
>>>=0A=
>>> On Thu, Aug 18, 2016 at 10:35 AM, Allen Samuels=0A=
>>> <Allen.Samuels@sandisk.com> wrote:=0A=
>>>> No reason not to merge them.=0A=
>>>>=0A=
>>>>=0A=
>>>> Allen Samuels=0A=
>>>> SanDisk |a Western Digital brand=0A=
>>>> 2880 Junction Avenue, San Jose, CA 95134=0A=
>>>> T: +1 408 801 7030| M: +1 408 780 6416=0A=
>>>> allen.samuels@SanDisk.com=0A=
>>>>=0A=
>>>>=0A=
>>>>> -----Original Message-----=0A=
>>>>> From: Samuel Just [mailto:sjust@redhat.com]=0A=
>>>>> Sent: Thursday, August 18, 2016 9:43 AM=0A=
>>>>> To: Allen Samuels <Allen.Samuels@sandisk.com>; Varada Kari=0A=
>>>>> <Varada.Kari@sandisk.com>; ceph-devel@vger.kernel.org=0A=
>>>>> Subject: wip-enc-dec=0A=
>>>>>=0A=
>>>>> Is there a reason not to put this new machinery directly into encodin=
g.h?  The=0A=
>>>>> new machinery seems to be sufficient to implement the existing ::enco=
de=0A=
>>>>> and ::decode types and should be compatible, right?=0A=
>>>>> With the containers, we can use template trickery to also forward the=
 new=0A=
>>>>> functions when present in the mapped types.  That would let us gradua=
lly=0A=
>>>>> adapt the code base.=0A=
>>>>> -Sam=0A=
>> PLEASE NOTE: The information contained in this electronic mail message i=
s intended only for the use of the designated recipient(s) named above. If =
the reader of this message is not the intended recipient, you are hereby no=
tified that you have received this message in error and that any review, di=
ssemination, distribution, or copying of this message is strictly prohibite=
d. If you have received this communication in error, please notify the send=
er by telephone or e-mail (as shown above) immediately and destroy any and =
all copies of this message in your possession (whether hard copies or elect=
ronically stored copies).=0A=
=0A=
