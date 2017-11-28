From: kefu chai <tchaikov@gmail.com>
Subject: Re: 12.2.2 Luminous validation status
Date: Tue, 28 Nov 2017 23:56:25 +0800
Message-ID: <CAJE9aOMOm8mtSQ8VPb974NRCTvS989_Sxxs48uvw3n_uDDygBA@mail.gmail.com>
References: <CAMMFjmH0-XbJ1P431bErnMS1BEaU3Ln9XhVMPbEte3ixm+YSzQ@mail.gmail.com>
 <9162c114-44ea-3153-fc3f-76fbd20e06b4@redhat.com> <CAMMFjmG_6UrMOEWmanz76GyGsJioFLt-ZAYRaYzQJ72LH2pRqA@mail.gmail.com>
 <87vai1ugkh.fsf@suse.com> <CAMMFjmGke9G7i2OLgBxQAdO+irkO7CXrT2zgKF1_KJnGPkE4yw@mail.gmail.com>
 <CAMMFjmGv13B5qLqZj+ZwhDY9H=XgqTJ+hqTFdDeE4vK04iBFTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:39496 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbdK1P40 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Nov 2017 10:56:26 -0500
Received: by mail-qk0-f174.google.com with SMTP id u184so391797qkd.6
        for <ceph-devel@vger.kernel.org>; Tue, 28 Nov 2017 07:56:26 -0800 (PST)
In-Reply-To: <CAMMFjmGv13B5qLqZj+ZwhDY9H=XgqTJ+hqTFdDeE4vK04iBFTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Abhishek Lekshmanan <abhishek@suse.com>, Josh Durgin <jdurgin@redhat.com>, Ilya Dryomov <idryomov@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Nov 24, 2017 at 12:31 AM, Yuri Weinstein <yweinste@redhat.com> wrot=
e:
> and ceph-disk unresolved

Yuri, https://github.com/ceph/ceph/pull/19205 should address the
ceph-disk test failure.

>
> On Thu, Nov 23, 2017 at 8:30 AM, Yuri Weinstein <yweinste@redhat.com> wro=
te:
>> I need to review latest results next week.
>> But AFAIR Ilya approved krbd
>>
>> rest is unresolved and jewel-x maybe not be resolved yet.
>>
>> On Thu, Nov 23, 2017 at 8:04 AM, Abhishek Lekshmanan <abhishek@suse.com>=
 wrote:
>>> Yuri Weinstein <yweinste@redhat.com> writes:
>>>
>>>> Josh's fixed merged and tested, so rados is good.
>>>>
>>>> Ilya's kernel fix helped sort out knfs and kcepfs failures, however
>>>> some jobs still failed (see details/bugs in the ticket) and need
>>>> Patrick, Ilya review.
>>>
>>> I saw patrick's approval on cephfs, though k{RBD/cephfs} suites need
>>> Ilya's approval I belive.
>>>>
>>>> Please review the tests results and either approve or comment.
>>>>
>>>> Thx
>>>> YuriW
>>>>
>>>> On Wed, Nov 15, 2017 at 6:07 PM, Josh Durgin <jdurgin@redhat.com> wrot=
e:
>>>>> On 11/15/2017 02:00 PM, Yuri Weinstein wrote:
>>>>>>
>>>>>> Details of this release summarized here
>>>>>> http://tracker.ceph.com/issues/21830#note-26
>>>>>
>>>>>
>>>>> The rados failures are due to a bug in the test fixed by:
>>>>>
>>>>> https://github.com/ceph/ceph/pull/18808
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> --
>>> Abhishek Lekshmanan
>>> SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Nort=
on,
>>> HRB 21284 (AG N=C3=BCrnberg)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Regards
Kefu Chai
