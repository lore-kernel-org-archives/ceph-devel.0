From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2 3/6] libceph: rados pool namesapce support
Date: Tue, 22 Mar 2016 12:03:18 +0100
Message-ID: <CAOi1vP_3J5G_jDnHBT6WY93zYo5QTRWTJ04k2rBGw8HYODgDJQ@mail.gmail.com>
References: <1454742006-85706-1-git-send-email-zyan@redhat.com>
	<1454742006-85706-4-git-send-email-zyan@redhat.com>
	<CAOi1vP8pFnbLg_h9qFe_ftXb1z6xyEhwYOVkRVQuZ7z0hBemEA@mail.gmail.com>
	<D7ADB539-766B-4E6F-B996-E90C5080D418@redhat.com>
	<CAOi1vP8MnAQSr9HQiOWKML8YED-ADNktqTtcGg6LYy3wEXA8LA@mail.gmail.com>
	<9031B3CD-2132-4A0E-A2C9-0105A61B202E@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36197 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759276AbcCVLDU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2016 07:03:20 -0400
Received: by mail-lb0-f195.google.com with SMTP id sx8so9362528lbb.3
        for <ceph-devel@vger.kernel.org>; Tue, 22 Mar 2016 04:03:19 -0700 (PDT)
In-Reply-To: <9031B3CD-2132-4A0E-A2C9-0105A61B202E@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Mar 22, 2016 at 10:30 AM, Yan, Zheng <zyan@redhat.com> wrote:
>
>> On Mar 22, 2016, at 17:17, Ilya Dryomov <idryomov@gmail.com> wrote:
>>
>> On Tue, Mar 22, 2016 at 8:52 AM, Yan, Zheng <zyan@redhat.com> wrote:
>>>
>>>> On Mar 22, 2016, at 14:11, Ilya Dryomov <idryomov@gmail.com> wrote=
:

[ snip ]

>>>> This ties into my question about how namespaces are going to be us=
ed
>>>> and how long the namespace name is allowed to be.
>>>>
>>>> CEPH_MAX_NAMESPACE_LEN is defined to 100 above, but that definitio=
n is
>>>> removed in patch 5.  That needs fixing, and if the 100 char limit =
is
>>>> real, then buf can just be
>>>>
>>>>   CEPH_MAX_OID_NAME_LEN + CEPH_MAX_NAMESPACE_LEN + 1
>>>>
>>>> with no need for a kmalloc().
>>>
>>> CEPH_MAX_NAMESPACE_LEN is a intermediate variable for splitting pat=
ches (make individual patch be able to compile). As I know there is no =
limitation on namespace length.
>>
>> To me, that's indication of a poorly structured series.
>>
>> I understand that it's just a std::string in userspace and so there
>> isn't a limit as such.  Same goes for OIDs, but we do limit those in
>> the kernel client.  Can we do the same for namespace names?
>
> We can. But it=E2=80=99s irrelevance for this series, I can squash th=
is patch and patch 5.

On the contrary, it's very relevant.  It answers whether embedding
namespace names by value into ceph_osd_request is feasible.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
