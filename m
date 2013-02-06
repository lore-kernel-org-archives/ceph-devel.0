From: femi anjorin <femi.anjorin@gmail.com>
Subject: Re: CEPHFS mount error !!!
Date: Wed, 6 Feb 2013 08:20:04 +0100
Message-ID: <CAPhYxPyBHHhUzNdhZm-vAhny3SZeN-SAC9XFVfzfSh1V5un5JQ@mail.gmail.com>
References: <CAPhYxPzgHeuivJZDt7CGPjbxfO8r288pdQMEKnX90_UvPEqbBw@mail.gmail.com>
	<5111FE64.7050909@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54]:55564 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab3BFHUF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 02:20:05 -0500
Received: by mail-qe0-f54.google.com with SMTP id 1so504275qeb.13
        for <ceph-devel@vger.kernel.org>; Tue, 05 Feb 2013 23:20:04 -0800 (PST)
In-Reply-To: <5111FE64.7050909@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Joao Eduardo Luis <joao.luis@inktank.com>, Martin B Nielsen <martin@unity3d.com>, Dan Mick <dan.mick@inktank.com>

No I didnt build my kernel.

CentOS was working fine on the system and yum install was used to
install ceph. i followed the instruction on this link
http://ceph.com/docs/master/install/rpm/. and it installed fine but i
dont why the cephfs isnt working.

The storage cluster is working fine with all the daemon running
(osd,mon and mds)  and 'ceph health' is responding 'health ok'... and
the storage cluster are also centos 6.3 machines.

But the client machine which i want to use to access the storage
'using CEPHFS' is the one giving this error... this client machine
also have the ceph.conf file in /etc/ceph/ceph.conf. and ceph is
installed on it. if i do ceph -s it respond with health ok ...meaning
it syncs with the cluster.but when i do mount -t ceph
172.16.0.25:6789:/ /mnt/mycephfs -o
name=admin,secret=AQCqnw9RmBPpOBAAeJjkIgKGYvyRGlekTpUPog==

i get:::

FATAL: Module ceph not found.
mount.ceph: modprobe failed, exit status 1
mount error: ceph filesystem not supported by the system

what do u recommend???

Regards

Femi




On Wed, Feb 6, 2013 at 7:55 AM, Dan Mick <dan.mick@inktank.com> wrote:
> Yes; as Martin said last night, you don't have the ceph module.
> Did you build your own kernel?
>
> See
> http://ceph.com/docs/master/install/os-recommendations/#linux-kernel
>
>
> On 02/05/2013 09:37 PM, femi anjorin wrote:
>>
>> Linux 2.6.32-279.19.1.el6.x86_64 x86_64 CentOS 6.3
>>
>> Pls can somebody help ... This command not working on CentOS 6.3 !!!!
>>
>> mount -t ceph 172.16.0.25:6789:/ /mnt/mycephfs -o
>> name=admin,secret=AQCqnw9RmBPpOBAAeJjkIgKGYvyRGlekTpUPog==
>>
>>   FATAL: Module ceph not found.
>>   mount.ceph: modprobe failed, exit status 1
>>   mount error: ceph filesystem not supported by the system
>>
>>
>> Regards,
>> Femi
>>
>>
>>
>>
>>
>> On Tue, Feb 5, 2013 at 1:49 PM, femi anjorin <femi.anjorin@gmail.com>
>> wrote:
>>>
>>>
>>> Hi ...
>>>
>>> Thanks. i set --debug ms = 0. The result is HEALTH_OK ...but i get an
>>> error when trying to setup an client access to the cluster CEPHFS!!!
>>>
>>> ----------------------------------------------------------------------------------------
>>> I tried setting up another server which should act as client..
>>> - i install ceph on it.
>>> - got the configuration file from the cluster servers to the new
>>> server ...  /etc/ceph/ceph.conf
>>> -i did ...  mkdir /mnt/mycephfs
>>> -i copied the key from ceph.keyring and used it in the command below
>>> -i try to run this command: mount -t ceph 172.16.0.25:6789:/
>>> /mnt/mycephfs -o
>>> name=admin,secret=AQCqnw9RmBPpOBAAeJjkIgKGYvyRGlekTpUPog==
>>> Here is the result i got:::
>>>
>>> [root@testclient]# mount -t ceph 172.16.0.25:6789:/ /mnt/mycephfs -o
>>> name=admin,secret=AQCqnw9RmBPpOBAAeJjkIgKGYvyRGlekTpUPog==
>>> FATAL: Module ceph not found.
>>> mount.ceph: modprobe failed, exit status 1
>>> mount error: ceph filesystem not supported by the system
>>>
>>> Regards,
>>> Femi.
>>>
>>> On Mon, Feb 4, 2013 at 3:27 PM, Joao Eduardo Luis <joao.luis@inktank.com>
>>> wrote:
>>>>
>>>> This wasn't obvious due to all the debug being outputted, but here's why
>>>> 'ceph health' wasn't replying with HEALTH_OK:
>>>>
>>>>
>>>> On 02/04/2013 12:21 PM, femi anjorin wrote:
>>>>>
>>>>>
>>>>> 2013-02-04 12:56:15.818985 7f149bfff700  1 HEALTH_WARN 4987 pgs
>>>>> peering; 4987 pgs stuck inactive; 5109 pgs stuck unclean
>>>>
>>>>
>>>>
>>>> Furthermore, on your other email in which you ran 'ceph health detail',
>>>> this
>>>> appear to have gone away, as it is replying with HEALTH_OK again.
>>>>
>>>> You might want to set '--debug-ms 0' when you run 'ceph', or set it in
>>>> your
>>>> ceph.conf, leaving it at a higher level only for daemons (i.e., under
>>>> [mds],
>>>> [mon], [osd]...).  The resulting output will be clearer and more easily
>>>> understandable.
>>>>
>>>>    -Joao
>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
