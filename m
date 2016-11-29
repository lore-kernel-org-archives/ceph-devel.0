From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: wake up sync waiter when unregistering request
Date: Tue, 29 Nov 2016 15:58:16 +0100
Message-ID: <CAOi1vP-mhjC+jxYcxt+q642Dm7Oc4jyWvR0J3FjxP=DF1ZuL+Q@mail.gmail.com>
References: <20161129114921.62964-1-zyan@redhat.com> <CAOi1vP8ieneOG-UhTysHNoOvoZ3_kcV_x7zqw9p3BSUpMLK_9Q@mail.gmail.com>
 <B93E1ED2-557B-4414-AABC-42A47569D405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:35798 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933389AbcK2O6S (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Nov 2016 09:58:18 -0500
Received: by mail-ua0-f176.google.com with SMTP id 12so180629950uas.2
        for <ceph-devel@vger.kernel.org>; Tue, 29 Nov 2016 06:58:17 -0800 (PST)
In-Reply-To: <B93E1ED2-557B-4414-AABC-42A47569D405@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 29, 2016 at 2:59 PM, Yan, Zheng <zyan@redhat.com> wrote:
>
>> On 29 Nov 2016, at 21:54, Ilya Dryomov <idryomov@gmail.com> wrote:
>>
>> On Tue, Nov 29, 2016 at 12:49 PM, Yan, Zheng <zyan@redhat.com> wrote:
>>> Current code does not wake up sync waiter if osd replies error
>>> or the request does not want ondisk ack.
>>
>> Hi Zheng,
>>
>> Did you mean to write "and" instead of "or" - "if osd replies error
>> *and* the request does not want ondisk ack=E2=80=9D?
>
> I mean =E2=80=98or=E2=80=99.  The code does not wake up sync waiter in ei=
ther of these two cases.

It does wake the sync waiter (r_safe_completion) on error, but only
if ondisk ack was requested.  If ondisk ack wasn't requested, it's not
woken up, success or error.

By not setting CEPH_OSD_FLAG_ONDISK, the submitter is indicating that
*any* reply is fine.  Blocking on the safe reply instead of any reply
in the !CEPH_OSD_FLAG_ONDISK case sounds wrong.

What is the motivation for this patch?

Thanks,

                Ilya
