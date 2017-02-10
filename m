From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: Breakage in Clang compile....
Date: Fri, 10 Feb 2017 10:46:45 +0800
Message-ID: <CACKY0b_pZXyJO1fQn9hrqJw5JYT_x932YkCYZv3miFZOks9vJw@mail.gmail.com>
References: <a5a35bfc-57b2-bf28-9788-04127654e23a@digiware.nl>
 <E5D4D9AF-0529-424A-9C75-759906A4C65D@quantum.com> <28691041-11fc-bd69-2d0b-1986fa798aca@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36651 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbdBJIsM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2017 03:48:12 -0500
Received: by mail-yw0-f180.google.com with SMTP id v200so17380249ywc.3
        for <ceph-devel@vger.kernel.org>; Fri, 10 Feb 2017 00:48:03 -0800 (PST)
In-Reply-To: <28691041-11fc-bd69-2d0b-1986fa798aca@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Bassam Tabbara <Bassam.Tabbara@quantum.com>, Ceph Development <ceph-devel@vger.kernel.org>

clang's compile warn is clearer than gcc

2017-02-10 2:10 GMT+08:00 Willem Jan Withagen <wjw@digiware.nl>:
> On 9-2-2017 17:18, Bassam Tabbara wrote:
>> Hi,
>>
>> I=E2=80=99m curious are there specific advantages to compiling Ceph with
>> clang vs. gcc? I understand that clang uses less memory, compiles
>> faster, and has better errors/diagnostics, but as it relates to Ceph
>> is there any specific advantages?
>>
>> Is there a plan to switching to clang?
>
> There are a few reasons for also using Clang:
>  - Clang finds other types of issues in the code.
>         I think the speed, mem-footprint advantages you mention are not
>         (yet) the case.
>  - FreeBSD has Clang as native compiler, and I'm preparing a Ceph port
>    to FreeBSD.
>
> Thanx for fixing this, I saw the PR fly by.
>
> --WjW
>
>> Thanks! Bassam
>>
>>> On Feb 9, 2017, at 7:35 AM, Willem Jan Withagen <wjw@digiware.nl>
>>> wrote:
>>>
>>> Hi,
>>>
>>> I think this is a recent addition to the game? And Clang does not
>>> really like it.
>>>
>>> In file included from
>>> /home/jenkins/workspace/ceph-master/src/common/perf_counters.h:21:
>>> /home/jenkins/workspace/ceph-master/src/common/perf_histogram.h:80:9:
>>>
>>>
> error: array initializer must be an initializer list
>>> : m_axes_config(other.m_axes_config) { ^
>>> /home/jenkins/workspace/ceph-master/src/common/perf_counters.h:98:29:
>>>
>>>
> note: in instantiation of member function
>>> 'PerfHistogram<2>::PerfHistogram' requested here
>>> histogram.reset(new PerfHistogram<>(*other.histogram)); ^ 1 error
>>> generated.
>>>
>>> --WjW -- To unsubscribe from this list: send the line "unsubscribe
>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at
>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__vger.kernel.org_m=
ajordomo-2Dinfo.html&d=3DDwICaQ&c=3D8S5idjlO_n28Ko3lg6lskTMwneSC-WqZ5EBTEEv=
Dlkg&r=3DBTMd2ANcDl5P_nTkEam5zzywWdGjHoaoXy4JMG_yHPA&m=3DPzCl2U7BH52mycDw3P=
iC7LaCbGCCTewMNBUqu8gGKIQ&s=3DgR4xXKHg4AFcwEccrIs-KoM7bjGw0aL9CnVF_PQE_fo&e=
=3D
>>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
