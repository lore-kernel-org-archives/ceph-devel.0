From: Alfredo Deza <adeza@redhat.com>
Subject: Re: Hammer 0.94.10 release - last call
Date: Tue, 10 Jan 2017 10:09:44 -0500
Message-ID: <CAC-Np1xbc21KZgPnDyY3uU6vJPEyiU3tOhTdbtbSK93MY7nZ8A@mail.gmail.com>
References: <8c0ffdf7-a8db-5a3d-6e4b-afe31f52319f@suse.cz> <CAC-Np1yQrOBeeWzxAgy4aebXwGOi3d4i2VK7Yscn4O802-7uCA@mail.gmail.com>
 <9b4076a3-3e4a-8cd7-4db5-549d277fc4f8@suse.cz> <CAMMFjmFVYCKv=OgOjibn_tKEzQdpFGV+yhLP11VRzhxjhfNoOg@mail.gmail.com>
 <243fa727-c055-d1a0-6f51-5f5db87ed953@dachary.org> <CAC-Np1yn6i=FDM16rxOX8ZjXVj=u6GatC0u2tg8w9YHRvKZ9dw@mail.gmail.com>
 <ecd937e4-98df-b42e-8a57-5c8bb963fd54@suse.cz> <CAC-Np1yHUzoMCh72g6i1Ak75OPM-n=NgyE=-8HBCEvJYQAcG8Q@mail.gmail.com>
 <88567e66-9404-24dc-01b2-6bcd28899864@suse.cz> <CAC-Np1zqjJk5GvUEbxkVGoh36dnwcqSkcbRWzz4zew30ciTg5A@mail.gmail.com>
 <6e55e688-49df-72d2-58c4-ce86c67eeac8@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36124 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935227AbdAJPJp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jan 2017 10:09:45 -0500
Received: by mail-qk0-f173.google.com with SMTP id 11so78550711qkl.3
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jan 2017 07:09:45 -0800 (PST)
In-Reply-To: <6e55e688-49df-72d2-58c4-ce86c67eeac8@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Loic Dachary <loic@dachary.org>, Yuri Weinstein <yweinste@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jan 10, 2017 at 8:52 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>>> Sorry, I shouldn't have been so cryptic. I meant: if I prepare an
>>> integration branch in ceph-ci and Shaman builds it, can you do a manual
>>> test?
>>
>>
>> Sure thing!
>
>
> wip-hammer-backports now includes your PR and is ready for testing:
>
> http://tracker.ceph.com/issues/17151#note-45
> https://shaman.ceph.com/builds/ceph/wip-hammer-backports/

To replicate, I install the latest from the backports branch onto a
single CentOS 7 machine:

$ ceph-deploy install --dev=wip-hammer-backports 1.node.a
...
[1.node.a][DEBUG ] Complete!
[1.node.a][INFO  ] Running command: sudo ceph --version
[1.node.a][DEBUG ] ceph version 0.94.9-4522-g953992f
(953992f4b8d3c1de632cc7182412f8997052d18c)

I edit the ceph.conf to have a different hostname (but still
resolvable) than the machine:

$ cat ceph.conf
[global]
fsid = 99070b44-f70f-4379-9a6e-1be066a37bb5
mon_initial_members = node1
mon_host = 192.168.111.100
auth_cluster_required = cephx
auth_service_required = cephx
auth_client_required = cephx

I call create-initial that will fail:

$ ceph-deploy mon create-initial
...
[node1][WARNIN]
********************************************************************************
[node1][WARNIN] provided hostname must match remote hostname
[node1][WARNIN] provided hostname: node1
[node1][WARNIN] remote hostname: 1
[node1][WARNIN] monitors may not reach quorum and create-keys will not complete
[node1][WARNIN]
********************************************************************************
...
[ceph_deploy.mon][ERROR ] Some monitors have still not reached quorum:
[ceph_deploy.mon][ERROR ] node1

Now I log in and check the ceph-create-keys process which is still around:


[vagrant@1 ~] ps aux | grep create-keys
root     12491  0.1  1.4  53292  7352 ?        S    14:41   0:00
python /usr/sbin/ceph-create-keys --cluster ceph -i 1
vagrant  13343  0.0  0.1 112648   956 pts/0    S+   14:44   0:00 grep
--color=auto create

I call date to check how long it will be until it dies:

[vagrant@1 ~]$ date
Tue Jan 10 14:47:53 UTC 2017

Then check again after 10 minutes (the maximum the code waits before exiting):
[vagrant@1 ~]$ date
Tue Jan 10 14:55:28 UTC 2017
[vagrant@1 ~]$ ps aux | grep create
vagrant  15690  0.0  0.1 112648   956 pts/0    S+   14:55   0:00 grep
--color=auto create

And ceph-create-keys is no more.

To double check this, I call ceph-create-keys manually with increased verbosity:

[vagrant@1 ~]$ sudo python /usr/sbin/ceph-create-keys -v --cluster ceph -i 1
INFO:ceph-create-keys:ceph-mon is not in quorum: u'probing'
INFO:ceph-create-keys:ceph-mon is not in quorum: u'probing'
INFO:ceph-create-keys:ceph-mon is not in quorum: u'probing'
INFO:ceph-create-keys:ceph-mon is not in quorum: u'probing'
...
ceph-mon was not able to join quorum within 10 minutes
[vagrant@1 ~]$ ceph --version
ceph version 0.94.9-4522-g953992f (953992f4b8d3c1de632cc7182412f8997052d18c)

>
> Thanks,
> Nathan
