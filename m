From: femi anjorin <femi.anjorin@gmail.com>
Subject: Re: CEPH HEALTH NOT OK ...CEPHFS mount error !!!
Date: Tue, 5 Feb 2013 13:49:58 +0100
Message-ID: <CAPhYxPz19P-2h1J_5UXixvwyLOn+-va1j2RuYo9z0+Jpi7V0ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f42.google.com ([209.85.128.42]:40333 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab3BEMt7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Feb 2013 07:49:59 -0500
Received: by mail-qe0-f42.google.com with SMTP id 2so44217qeb.29
        for <ceph-devel@vger.kernel.org>; Tue, 05 Feb 2013 04:49:58 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi ...

Thanks. i set --debug ms = 0. The result is HEALTH_OK ...but i get an
error when trying to setup an client access to the cluster CEPHFS!!!
----------------------------------------------------------------------------------------
I tried setting up another server which should act as client..
- i install ceph on it.
- got the configuration file from the cluster servers to the new
server ...  /etc/ceph/ceph.conf
-i did ...  mkdir /mnt/mycephfs
-i copied the key from ceph.keyring and used it in the command below
-i try to run this command: mount -t ceph 172.16.0.25:6789:/
/mnt/mycephfs -o
name=admin,secret=AQCqnw9RmBPpOBAAeJjkIgKGYvyRGlekTpUPog==
Here is the result i got:::

[root@testclient]# mount -t ceph 172.16.0.25:6789:/ /mnt/mycephfs -o
name=admin,secret=AQCqnw9RmBPpOBAAeJjkIgKGYvyRGlekTpUPog==
FATAL: Module ceph not found.
mount.ceph: modprobe failed, exit status 1
mount error: ceph filesystem not supported by the system

Regards,
Femi.

On Mon, Feb 4, 2013 at 3:27 PM, Joao Eduardo Luis <joao.luis@inktank.com> wrote:
> This wasn't obvious due to all the debug being outputted, but here's why
> 'ceph health' wasn't replying with HEALTH_OK:
>
>
> On 02/04/2013 12:21 PM, femi anjorin wrote:
>>
>> 2013-02-04 12:56:15.818985 7f149bfff700  1 HEALTH_WARN 4987 pgs
>> peering; 4987 pgs stuck inactive; 5109 pgs stuck unclean
>
>
> Furthermore, on your other email in which you ran 'ceph health detail', this
> appear to have gone away, as it is replying with HEALTH_OK again.
>
> You might want to set '--debug-ms 0' when you run 'ceph', or set it in your
> ceph.conf, leaving it at a higher level only for daemons (i.e., under [mds],
> [mon], [osd]...).  The resulting output will be clearer and more easily
> understandable.
>
>   -Joao
>
