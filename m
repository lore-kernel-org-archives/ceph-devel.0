From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: jewel backports: cephfs.InvalidValue: error in setxattr
Date: Mon, 22 Aug 2016 11:16:08 -0700
Message-ID: <CAJ4mKGZ1kSayB6cjZK32GLTBCOt1rE609T8wE4RAaSKgSSVwCA@mail.gmail.com>
References: <57B1F22E.7050508@dachary.org> <CAAM7YAkFFPJrJGjeaWdNu8zQqRMAYovbe+dJaLYuscNcKKvwVg@mail.gmail.com>
 <57B2D26A.3080904@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:33528 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753181AbcHVSQK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Aug 2016 14:16:10 -0400
Received: by mail-ua0-f182.google.com with SMTP id 74so203910007uau.0
        for <ceph-devel@vger.kernel.org>; Mon, 22 Aug 2016 11:16:10 -0700 (PDT)
In-Reply-To: <57B2D26A.3080904@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "Yan, Zheng" <ukernel@gmail.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Aug 16, 2016 at 1:44 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Yan,
>
> On 16/08/2016 04:16, Yan, Zheng wrote:
>> On Tue, Aug 16, 2016 at 12:47 AM, Loic Dachary <loic@dachary.org> wrote:
>>> Hi John,
>>>
>>> http://pulpito.ceph.com/loic-2016-08-15_07:35:11-fs-jewel-backports-distro-basic-smithi/364579/ has the following error:
>>>
>>> 2016-08-15T08:13:22.919 INFO:teuthology.orchestra.run.smithi052.stderr:create_volume: /volumes/grpid/volid
>>> 2016-08-15T08:13:22.919 INFO:teuthology.orchestra.run.smithi052.stderr:create_volume: grpid/volid, create pool fsvolume_volid as data_isolated =True.
>>> 2016-08-15T08:13:22.919 INFO:teuthology.orchestra.run.smithi052.stderr:Traceback (most recent call last):
>>> 2016-08-15T08:13:22.920 INFO:teuthology.orchestra.run.smithi052.stderr:  File "<string>", line 11, in <module>
>>> 2016-08-15T08:13:22.920 INFO:teuthology.orchestra.run.smithi052.stderr:  File "/usr/lib/python2.7/dist-packages/ceph_volume_client.py", line 632, in create_volume
>>> 2016-08-15T08:13:22.920 INFO:teuthology.orchestra.run.smithi052.stderr:    self.fs.setxattr(path, 'ceph.dir.layout.pool', pool_name, 0)
>>> 2016-08-15T08:13:22.920 INFO:teuthology.orchestra.run.smithi052.stderr:  File "cephfs.pyx", line 779, in cephfs.LibCephFS.setxattr (/srv/autobuild-ceph/gitbuilder.git/build/out~/ceph-10.2.2-351-g431d02a/src/build/cephfs.c:10542)
>>> 2016-08-15T08:13:22.920 INFO:teuthology.orchestra.run.smithi052.stderr:cephfs.InvalidValue: error in setxattr
>>>
>>
>> The error is because MDS had outdated osdmap and thought the newly
>> creately pool does not exist. (MDS has code that makes sure its osdmap
>> is the same as or newer than fs client's osdmap)  For this case, It
>> seems both mds and fs client had outdated osdmap.  Pool creation was
>> through self.rados. self.rados had the newest olsdmap, but self.fs
>> might have outdated osdmap.
>
> Interesting. Do you know why this happens ? Is there a specific pull request that causes this ?
>
> Thanks a lot for your help !

Not sure about the specific PR, but in general when running commands
referencing pools, you need a new enough OSDMap to see the pool
everywhere it's used. We have a lot of logic and extra data passing in
the FS layers to make sure those OSDMaps appear transparently, but if
you create the pool through RADOS the FS clients have no idea of its
existence and the caller needs to wait themselves.
-Greg
