From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Ceph Package Repo on Ubuntu Precise(12.04) is broken
Date: Mon, 24 Apr 2017 08:53:44 -0400
Message-ID: <CAC-Np1y2ohw7NCWjthpwpZp0JL8Yn14UAxsbh6fVWtcZ1GgNkg@mail.gmail.com>
References: <CAEYCsVL3SAwAr26nVFJcZqwXJM2skj5AztFSj15VRGQXvRrEvQ@mail.gmail.com>
 <CALJWc2vwBSniKR0_-dD8pK2bNmMRvj7xMD-t2qYWNrt1qy_5iQ@mail.gmail.com> <CAEYCsVK1YWb-0ihZ_hCz_NRYwPcosCBcL0Gq8y06VNy2gV7h0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37900 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1170117AbdDXMxq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Apr 2017 08:53:46 -0400
Received: by mail-wm0-f47.google.com with SMTP id r190so66808060wme.1
        for <ceph-devel@vger.kernel.org>; Mon, 24 Apr 2017 05:53:46 -0700 (PDT)
In-Reply-To: <CAEYCsVK1YWb-0ihZ_hCz_NRYwPcosCBcL0Gq8y06VNy2gV7h0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: xiaoguang fan <fanxiaoguang008@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

On Mon, Apr 24, 2017 at 2:41 AM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
> Well, I can definitely build my own,
>
> 1. Precise is NOT EOL on Hammer release, which was confirmed in
> previous mail thread. So we still need to maintain point-in-time
> hammer package for end users.

Ceph Hammer is EOL

>
> 2. It is NOT ONLY missing 0.94.10, instead, as how we organize the
> repo index(only contains latest package in  index), now all 0.94.x
> package on precise are not installable via apt.
>

I think this may be because we didn't built precise for 0.94.10 and
Debian repositories do not support multi-version packages. So although
other versions are there, but the latest one isn't, the repository
acts as there is nothing for Precise.

I would suggest an upgrade to a newer Ceph version at this point,
although Precise isn't built for any newer Ceph versions, so
effectively you are looking at
upgrading to a newer OS as well.

>
> 2017-04-24 14:02 GMT+08:00 xiaoguang fan <fanxiaoguang008@gmail.com>:
>> If you need this deb package 0.94.10 on precise(12.04), I think you can
>> build it by yourself, you can use the script make_deps.sh
>>
>> 2017-04-24 11:35 GMT+08:00 Xiaoxi Chen <superdebuger@gmail.com>:
>>>
>>> Hi,
>>>
>>>      The 0.94.10 packages were not build for Ubuntu Precise, till now.
>>> What is worse, the dist discription
>>>
>>> (http://download.ceph.com/debian-hammer/dists/precise/main/binary-amd64/Packages)
>>>  doesnt contains any ceph core pacages.
>>>
>>>      It make Precise user unable provision their ceph cluster/client.
>>> Could anyone pls help to fix it?
>>>
>>> Xiaoxi
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
