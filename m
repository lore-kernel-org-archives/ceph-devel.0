From: Dan Mick <dan.mick@inktank.com>
Subject: Re: CEPHFS mount error !!!
Date: Thu, 07 Feb 2013 12:12:19 -0800
Message-ID: <51140AA3.5010102@inktank.com>
References: <CAPhYxPzgHeuivJZDt7CGPjbxfO8r288pdQMEKnX90_UvPEqbBw@mail.gmail.com> <5111FE64.7050909@inktank.com> <CAPhYxPyBHHhUzNdhZm-vAhny3SZeN-SAC9XFVfzfSh1V5un5JQ@mail.gmail.com> <51120518.7000105@mermaidconsulting.dk> <51124467.10403@conversis.de> <511276DB.3010101@bmrb.wisc.edu> <CAPhYxPwRWk8H5nE9yhWECtRShM0ABZ3WBTcEBfL2sS7ZRNgjUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59018 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896Ab3BGUM3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 15:12:29 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so4034194iea.5
        for <ceph-devel@vger.kernel.org>; Thu, 07 Feb 2013 12:12:29 -0800 (PST)
In-Reply-To: <CAPhYxPwRWk8H5nE9yhWECtRShM0ABZ3WBTcEBfL2sS7ZRNgjUA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: femi anjorin <femi.anjorin@gmail.com>
Cc: ceph-devel@vger.kernel.org



On 02/07/2013 03:05 AM, femi anjorin wrote:
> Hi ... I am now testing cephfs on an ubuntu client before going back to centos.
>
> A quick question about this command:
> mount -t ceph 192.168.0.1:6789:/ /mnt/mycephfs -o
> name=admin,secretfile=/etc/ceph/admin.secret ?
> mount -t ceph 192.168.0.1:6789:/ /mnt/mycephfs -o
> name=ceph,secretfile=/etc/ceph/ceph.keyring ?
>
> Does it need admin.secret  or can i use ceph.keyring to mount with
> cephfs file system?

It needs the unadorned base64 key; it doesn't parse keyring files.
You can either supply the key on the commandline or in the file
(which is a good idea to keep the key string out of your command line
and command history).

> Just a note: At the initial setup of the cluster i used:
> mkcephfs -c /etc/ceph/ceph.conf --mkfs -a -k  /etc/ceph/ceph.keyring.
>
> So i only have ceph.keyring NOT admin.secret ....

Right.  admin.secret is a file containing only the key string.  You
can create that file with your own editing, or you can use
ceph-authtool --name client.admin <keyringfile> --print-key

> if i do:
>
> #mount -t ceph 172.16.0.25:6789:/ /mnt/mycephfs
> mount error 22 = Invalid argument
> #dmesg
> [ 7182.027665] libceph: client0 fsid 31c4d83e-cb0a-4fed-ab6f-581e8d5356f5
> [ 7182.027715] libceph: no secret set (for auth_x protocol)
> [ 7182.027719] libceph: error -22 on auth protocol 2 init
>
>
> #mount -t ceph 172.16.0.25:6789:/ /mnt/mycephfs -o
> name=ceph,secretfile=/etc/ceph/ceph.keyring
> secret is not valid base64: Invalid argument.
> adding ceph secret key to kernel failed: Invalid argument.
> failed to parse ceph_options
> #dmesg
> [ 7639.377337] libceph: client0 fsid 31c4d83e-cb0a-4fed-ab6f-581e8d5356f5
> [ 7639.378047] libceph: auth method 'x' error -1
>
>
> Regards,
> Femi
>
>
>
>
>
>
>
> On Wed, Feb 6, 2013 at 4:29 PM, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu> wrote:
>> On 2/6/2013 5:54 AM, Dennis Jacobfeuerborn wrote:
>> ...
>>
>>>> To mount cephfs like that you need to have kernel support. As the Linux
>>>> kernel on CentOS 6.3 is version 2.6.32 and Ceph support wasn't added
>>>> until
>>>> 2.6.34, you need to compile your own kernel.
>>>>
>>>
>>> The better alternative is probably to install a kernel from
>>> http://elrepo.org/tiki/kernel-lt . "lt" stand for "long term" and should
>>> be
>>> fairly stable and "ml" is "mainline" which is even more current but
>>> because
>>> of that not quite as stable (currently 3.7.6).
>>
>>
>> I had problems booting ml on some/most (dep. on the version) our machines,
>> plus it's a pain to track: there's a new one every day.
>>
>> I do have lt running without problems and mounting cephfs, however, I
>> haven't gotten around to the actual ceph testing on it yet so I can't say
>> anything about ceph client's performance/stability on it. ("lt" is 3.0, as
>> I
>> understand it doesn't have the latest and greatest ceph module(?))
>>
>> Dimitri
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
