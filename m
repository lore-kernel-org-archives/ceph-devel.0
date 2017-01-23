From: Ming Lin <minggr@gmail.com>
Subject: Re: monitor port closed
Date: Mon, 23 Jan 2017 10:16:16 -0800
Message-ID: <CAF1ivSZtPPVN5g80DfMdedusyQ-NQnB4F2PkbVBvL=wLj7Zo8g@mail.gmail.com>
References: <CAF1ivSbn_bzic_JjOEEUKnp936XOy43s2r=0V0ujzVSpv2okBw@mail.gmail.com>
 <CAJE9aON2E8zAnBxqHhmY9cT3RVr3jGaVtkYcsk-9zfxoqk2+HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:33639 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdAWSQS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 13:16:18 -0500
Received: by mail-io0-f171.google.com with SMTP id v96so53304518ioi.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2017 10:16:18 -0800 (PST)
In-Reply-To: <CAJE9aON2E8zAnBxqHhmY9cT3RVr3jGaVtkYcsk-9zfxoqk2+HQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jan 23, 2017 at 5:12 AM, kefu chai <tchaikov@gmail.com> wrote:
> On Mon, Jan 23, 2017 at 1:32 PM, Ming Lin <minggr@gmail.com> wrote:
>> Hi,
>>
>> [mon]
>> mon initial members =3D a
>>
>> [mon.a]
>> mon addr =3D 192.168.0.1:7000
>>
>> jewel release with 1 monitor and 3 OSDs.
>>
>> After hours of fio rbd test, the monitor binded port(7000) was closed
>> for unknown reason.
>
> is this reproduciable? can you enable ms-debug=3D1 and attach the log?

Will enable it and try to reproduce.

>
>> But monitor is still running,
>>
>> # pidof ceph-mon
>> 21980
>>
>> Another strange thing is there are more than 1000 threads for the
>> ceph-mon process.
>>
>> # ls /proc/21980/task/ |wc -l
>> 1022
>>
>> Any possible reason?
>
> are you using the simple messenger? maybe you can use pstree to check
> the thread names?

Yes, simple messenger.

# ceph daemon ./run/ceph-mon.a.asok config show |grep ms_type
    "ms_type": "simple"

All the thread names are "ceph-mon"

# pstree 21980
ceph-mon=E2=94=80=E2=94=80=E2=94=801021*[{ceph-mon}]
