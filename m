From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: ceph-post-file : Permission denied (publickey).
Date: Thu, 3 Nov 2016 09:29:30 +1000
Message-ID: <CAF-wwdGaj4rz_gBWp8eFfrg4-GEjv6QRMPSPr6rRpj8CDLccWQ@mail.gmail.com>
References: <89b95e99-73e5-474e-df5f-cbd7927924ed@epfl.ch> <20161028021506.GE6026@rskikr.localdomain>
 <7f4235ea-9a4b-66db-3e49-7be4b526513d@epfl.ch> <alpine.DEB.2.11.1611021325480.20331@piezo.us.to>
 <ef07c150-34a0-8fe1-f0ed-8ee6b9c74852@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37694 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757684AbcKBX3d (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Nov 2016 19:29:33 -0400
Received: by mail-wm0-f45.google.com with SMTP id t79so67811591wmt.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Nov 2016 16:29:33 -0700 (PDT)
In-Reply-To: <ef07c150-34a0-8fe1-f0ed-8ee6b9c74852@epfl.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yoann Moulin <yoann.moulin@epfl.ch>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

http://tracker.ceph.com/issues/17787

On Wed, Nov 2, 2016 at 11:33 PM, Yoann Moulin <yoann.moulin@epfl.ch> wrote:
>
>>>>> I tried to upload files with ceph-post-file but got "Permission denied (publickey)."
>>>>>
>>>>>> $ ceph-post-file 17180.tgz
>>>>>> args: -- 17180.tgz
>>>>>> /usr/bin/ceph-post-file: upload tag 60a84fdd-b9e9-42cb-817e-5a90e0f9bcf0
>>>>>> /usr/bin/ceph-post-file: user: yoann@kveikur
>>>>>> /usr/bin/ceph-post-file: will upload file 17180.tgz
>>>>>> Permission denied (publickey).
>>>>>> Couldn't read packet: Connection reset by peer
>>>>>
>>>>> do I need to set anything on my side to be able to upload file with this command ?
>>>>
>>>> $ ./bin/ceph-post-file test_file
>>>> args: -- test_file
>>>> ./bin/ceph-post-file: upload tag eedc0ac6-a2fa-45d5-8fe1-8f7548da3bb2
>>>> ./bin/ceph-post-file: user: brad@localhost
>>>> ./bin/ceph-post-file: will upload file test_file
>>>> sftp> mkdir post/eedc0ac6-a2fa-45d5-8fe1-8f7548da3bb2_brad@localhost_38cc969c-04af-4d5b-b862-ec9d594d3a3c
>>>> sftp> cd post/eedc0ac6-a2fa-45d5-8fe1-8f7548da3bb2_brad@localhost_38cc969c-04af-4d5b-b862-ec9d594d3a3c
>>>> sftp> put /tmp/tmp.1biVN9avrx user
>>>> sftp> put test_file
>>>> ./bin/ceph-post-file: copy the upload id below to share with a dev:
>>>>
>>>> ceph-post-file: eedc0ac6-a2fa-45d5-8fe1-8f7548da3bb2
>>>>
>>>> You can test connectivity with something like the following.
>>>>
>>>> $ sftp -o "IdentityFile=../share/id_rsa_drop.ceph.com" -C -oCheckHostIP=no -oGlobalKnownHostsFile=../share/known_hosts_drop.ceph.com -oBatchMode=no -oIdentitiesOnly=yes -- postfile@drop.ceph.com
>>>> Connected to drop.ceph.com.
>>>> sftp>
>>>
>>> Finally I found time to look on why it wasn't working, I only had the dsa key, I grab the rsa key from git and change the path in the
>>> ceph-post-file from dsa to rsa and it works
>>
>> Ah.  Is this hammer or jewel?  We should backport the new key.
>
> This is Jewel :
>
>> $ dpkg -S  usr/bin/ceph-post-file
>> ceph-common: /usr/bin/ceph-post-file
>
>> $ grep dsa /usr/bin/ceph-post-file
>> if [[ -f ../share/known_hosts_drop.ceph.com && -f ../share/id_dsa_drop.ceph.com ]]
>>        ssh_key=../share/id_dsa_drop.ceph.com
>>        ssh_key=/usr/share/ceph/id_dsa_drop.ceph.com
>>                       [Default: /usr/share/ceph/id_dsa_drop.ceph.com]
>
>> $ dpkg -l | grep ceph-common
>> ii  ceph-common                          10.2.2-1xenial                  amd64        common utilities to mount and interact with a ceph storage cluster
>
>
> --
> Yoann Moulin
> EPFL IC-IT



-- 
Cheers,
Brad
