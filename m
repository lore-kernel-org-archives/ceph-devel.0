From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: librados2 and librbd1 dependency on libvirt-bin
Date: Wed, 25 Feb 2015 16:45:44 -0800
Message-ID: <CACkq2moMx7oXSi8qSxCyqCLDoQXqJDuOL5feSZuDLBUHtJW7uw@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BAC5F@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1502251516270.25838@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F282BAD3A@SACMBXIP02.sdcorp.global.sandisk.com>
 <CACkq2mqkqqE2wz_gSTeWk71aH6GXHDPH0EzKQ77V3vCFZbpDYw@mail.gmail.com> <755F6B91B3BE364F9BCA11EA3F9E0C6F282BADAC@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34502 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213AbbBZAqG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Feb 2015 19:46:06 -0500
Received: by lbdu14 with SMTP id u14so7622814lbd.1
        for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2015 16:46:04 -0800 (PST)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BADAC@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Somnath,

My first attempt at this showed the expected behavior.  I have to
Trusty vms.  I'm using trusty1 as an admin node for trusty2, which I
am install ceph and libvirt.

root@trusty1:~# ceph-deploy new trusty2
....
root@trusty1:~# ceph-deploy install trusty2  (this successfully installs Giant)
root@trusty1:~# ssh trusty2
root@trusty2:~# apt-get install libvirt-bin
....
root@trusty2:~# dpkg -l | egrep '(ceph|libvirt|rados|rbd)'
ii  ceph                             0.87.1-1trusty
amd64        distributed storage and file system
ii  ceph-common                      0.87.1-1trusty
amd64        common utilities to mount and interact with a ceph
storage cluster
ii  ceph-fs-common                   0.87.1-1trusty
amd64        common utilities to mount and interact with a ceph file
system
ii  ceph-mds                         0.87.1-1trusty
amd64        metadata server for the ceph distributed file system
ii  libcephfs1                       0.87.1-1trusty
amd64        Ceph distributed file system client library
ii  librados2                        0.87.1-1trusty
amd64        RADOS distributed object store client library
ii  librbd1                          0.87.1-1trusty
amd64        RADOS block device client library
ii  libvirt-bin                      1.2.2-0ubuntu13.1.9
amd64        programs for the libvirt library
ii  libvirt0                         1.2.2-0ubuntu13.1.9
amd64        library for interfacing with different virtualization
systems
ii  python-ceph                      0.87.1-1trusty
amd64        Python libraries for the Ceph distributed filesystem
root@trusty2:~# exit


All looks good on trusty2.  Now we do the purge:

root@trusty1:~# ceph-deploy purge trusty2
....  ( I'm happy to fpaste this output if you want to see it)

Go back to trusty2 and see what's left:

root@trusty2:~# dpkg -l | egrep '(ceph|libvirt|rados|rbd)'
ii  libcephfs1                       0.87.1-1trusty
amd64        Ceph distributed file system client library
ii  librados2                        0.87.1-1trusty
amd64        RADOS distributed object store client library
ii  librbd1                          0.87.1-1trusty
amd64        RADOS block device client library
ii  libvirt-bin                      1.2.2-0ubuntu13.1.9
amd64        programs for the libvirt library
ii  libvirt0                         1.2.2-0ubuntu13.1.9
amd64        library for interfacing with different virtualization
systems
ii  python-ceph                      0.87.1-1trusty
amd64        Python libraries for the Ceph distributed filesystem


The ceph libraries and libvirt are all still there.  This is the
expected behavior.

 - Travis

On Wed, Feb 25, 2015 at 4:30 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Thanks Travis..
> Here it is..
>
> Ceph is giant.
> Libvirt is from Ubuntu 14.04 repo only...
>
> ems@emsnode4:~$ sudo dpkg -l | grep libvirt*
> ii  libvirt-bin                                           1.2.2-0ubuntu13.1.9                   amd64        programs for the libvirt library
> ii  libvirt0                                              1.2.2-0ubuntu13.1.9                   amd64        library for interfacing with different virtualization systems
> ems@emsnode4:~$ sudo dpkg -l | grep ceph-deploy
> ii  ceph-deploy                                           1.5.21                                all          Ceph-deploy is an easy to use configuration tool
> ems@emsnode4:~$
> ems@emsnode4:~$ ceph-deploy --version
> 1.5.21
> ems@emsnode4:~$
>
> Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Travis Rhoden
> Sent: Wednesday, February 25, 2015 4:23 PM
> To: Somnath Roy
> Cc: Sage Weil; Ceph Development
> Subject: Re: librados2 and librbd1 dependency on libvirt-bin
>
> Somnath,
>
> Just so I can try to recreate fully, can you also tell me the version of Ceph you are using, the version of ceph-deploy (previously mentioned), and the version of libvirt?  For example, if you have the Juno cloud-archive enabled or anything.
>
>  - Travis
>
> On Wed, Feb 25, 2015 at 3:36 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>> Thanks Sage !
>> But, I think this is a serious issue, every time we will purge the
>> cluster all the node network will be down :-( Basically, it should not delete any component on which non-ceph components are dependent.
>> We need this purge-lite kind of stuff.
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Sage Weil [mailto:sage@newdream.net]
>> Sent: Wednesday, February 25, 2015 3:21 PM
>> To: Somnath Roy
>> Cc: Ceph Development
>> Subject: Re: librados2 and librbd1 dependency on libvirt-bin
>>
>> On Wed, 25 Feb 2015, Somnath Roy wrote:
>>> Hi,
>>> We are facing problem that ceph-deploy purge is uninstalling latest Mellanox ofed driver packages.
>>> Digging down more we found libvirt-bin is dependent on librados2/librbd1.
>>> So, here is what happening.
>>>
>>> 1. Mellanox ofed driver has a dependency on the libvirt-bin*
>>>
>>> 2. purging librados2/librbd1 is removing libvirt-bin and resulting the removal of the Mellanox driver package as well.
>>>
>>> Here is what I found.
>>>
>>> http://packages.ubuntu.com/trusty/devel/libvirt-bin
>>>
>>> ubuntu@ip-10-15-16-211:~$ apt-cache rdepends librados2 [...]
>>
>> The problem is that libvirt (and probably qemu) are built against librbd1.
>> If you remove librbd1, those get removed too.
>>
>>> So, I am curious why libvirt-bin has a depencey on librados2/librbd1 ?
>>
>> qemu needs it for obvious reasons.  libvirt needs it to manage it's
>> (rbd) storage pools.
>>
>>> Also, how come we get rid of this issue ?
>>> Ceph-deploy should not remove any package other than ceph's.
>>
>> Purge could skip the libraries that may have other dependencies, but then it's a purge-lite.  Honestly I thought it skipped them for that reason but we probably changed it at some point because it (also confusingly) wouldn't remove librados etc...
>>
>> sage
>>
>>
>> ________________________________
>>
>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
