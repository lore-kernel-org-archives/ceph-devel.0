From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: Ceph Package Repo on Ubuntu Precise(12.04) is broken
Date: Mon, 24 Apr 2017 14:41:39 +0800
Message-ID: <CAEYCsVK1YWb-0ihZ_hCz_NRYwPcosCBcL0Gq8y06VNy2gV7h0A@mail.gmail.com>
References: <CAEYCsVL3SAwAr26nVFJcZqwXJM2skj5AztFSj15VRGQXvRrEvQ@mail.gmail.com>
 <CALJWc2vwBSniKR0_-dD8pK2bNmMRvj7xMD-t2qYWNrt1qy_5iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36520 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165491AbdDXGlk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Apr 2017 02:41:40 -0400
Received: by mail-yw0-f176.google.com with SMTP id l18so13632790ywh.3
        for <ceph-devel@vger.kernel.org>; Sun, 23 Apr 2017 23:41:40 -0700 (PDT)
In-Reply-To: <CALJWc2vwBSniKR0_-dD8pK2bNmMRvj7xMD-t2qYWNrt1qy_5iQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xiaoguang fan <fanxiaoguang008@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Well, I can definitely build my own,

1. Precise is NOT EOL on Hammer release, which was confirmed in
previous mail thread. So we still need to maintain point-in-time
hammer package for end users.

2. It is NOT ONLY missing 0.94.10, instead, as how we organize the
repo index(only contains latest package in  index), now all 0.94.x
package on precise are not installable via apt.


2017-04-24 14:02 GMT+08:00 xiaoguang fan <fanxiaoguang008@gmail.com>:
> If you need this deb package 0.94.10 on precise(12.04), I think you can
> build it by yourself, you can use the script make_deps.sh
>
> 2017-04-24 11:35 GMT+08:00 Xiaoxi Chen <superdebuger@gmail.com>:
>>
>> Hi,
>>
>>      The 0.94.10 packages were not build for Ubuntu Precise, till now.
>> What is worse, the dist discription
>>
>> (http://download.ceph.com/debian-hammer/dists/precise/main/binary-amd64/Packages)
>>  doesnt contains any ceph core pacages.
>>
>>      It make Precise user unable provision their ceph cluster/client.
>> Could anyone pls help to fix it?
>>
>> Xiaoxi
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
