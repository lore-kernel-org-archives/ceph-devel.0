From: Muminul Islam Russell <misla011@fiu.edu>
Subject: Re: Syslog error during disk preparation
Date: Tue, 2 Aug 2016 11:29:08 -0700
Message-ID: <CAK=B8yZ1fW-nCYhzR+WAgMqi=47ddVg-1wMSKz-NuBd64t5i1Q@mail.gmail.com>
References: <CAK=B8yZmeAKVxVoZVH2wDAS+xW8Hg6xygtB8W0SdqyOqfkK7gg@mail.gmail.com>
 <57A0D531.20202@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35904 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352AbcHBS3K convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Aug 2016 14:29:10 -0400
Received: by mail-qk0-f178.google.com with SMTP id v123so50057782qkh.3
        for <ceph-devel@vger.kernel.org>; Tue, 02 Aug 2016 11:29:10 -0700 (PDT)
In-Reply-To: <57A0D531.20202@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

OSDs are up though.

Thanks,
Muminul

On Tue, Aug 2, 2016 at 10:15 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> It may not be a fatal error, just a transient problem while the disk is being prepared. Is the OSD up or down ?
>
> Cheers
>
> On 02/08/2016 19:05, Muminul Islam Russell wrote:
>> Hi Loic,
>>
>> I am getting a lot of error messages in system log file while
>> preparing the device. Can you please tell me what is wrong here?
>>
>> Ceph version: 10.2.2
>>
>> The command I am using:
>>
>> ceph-deploy  purge ca-ostest433
>> ceph-deploy  purgedata ca-ostest433
>> ceph-deploy new ca-ostest433
>> echo "osd pool default size = 1" >> ceph.conf
>> ceph-deploy install  ca-ostest433
>> ceph-deploy mon create-initial
>> ceph-deploy mon create ca-ostest433
>> ceph-deploy gatherkeys ca-ostest433
>>
>> ceph-deploy disk zap ca-ostest433:sdb
>> ceph-deploy osd prepare ca-ostest433:sdb
>> ceph status
>>
>> Error message that I got in the system log : cat /var/log/messages:
>>
>> Aug  1 05:59:39 ca-ostest432 sh: File
>> "/usr/lib/python2.7/site-packages/ceph_disk/main.py", line 4994, in
>> run
>> Aug  1 05:59:39 ca-ostest432 sh: main(sys.argv[1:])
>> Aug  1 05:59:39 ca-ostest432 sh: File
>> "/usr/lib/python2.7/site-packages/ceph_disk/main.py", line 4945, in
>> main
>> Aug  1 05:59:39 ca-ostest432 sh: args.func(args)
>> Aug  1 05:59:39 ca-ostest432 sh: File
>> "/usr/lib/python2.7/site-packages/ceph_disk/main.py", line 4703, in
>> <lambda>
>> Aug  1 05:59:39 ca-ostest432 sh: func=lambda args:
>> main_activate_space(name,args),
>> Aug  1 05:59:39 ca-ostest432 sh: File
>> "/usr/lib/python2.7/site-packages/ceph_disk/main.py", line 3722, in
>> main_activate_space
>> Aug  1 05:59:39 ca-ostest432 sh: reactivate=args.reactivate,
>> Aug  1 05:59:39 ca-ostest432 sh: File
>> "/usr/lib/python2.7/site-packages/ceph_disk/main.py", line 3009, in
>> mount_activate
>>   Aug  1 05:59:39 ca-ostest432 sh: e,
>> Aug  1 05:59:39 ca-ostest432 sh: ceph_disk.main.FilesystemTypeError:
>> Cannot discover filesystem type: device
>> /dev/disk/by-partuuid/00000000-0000-0000-0000-00000
>> 0000000: Command '/sbin/blkid' returned non-zero exit status 2
>> Aug  1 05:59:39 ca-ostest432 python: detected unhandled Python
>> exception in'/usr/sbin/ceph-disk'
>> Aug  1 05:59:39 ca-ostest432 abrt-server: Not saving repeating crash
>> in '/usr/sbin/ceph-disk'
>> Aug  1 05:59:39 ca-ostest432 sh: Traceback (most recent call last):
>> Aug  1 05:59:39 ca-ostest432 sh: File "/usr/sbin/ceph-disk", line 9, in <module>
>> Aug  1 05:59:39 ca-ostest432 sh: load_entry_point('ceph-disk==1.0.0',
>> 'console_scripts', 'ceph-disk')()
>> Aug  1 05:59:39 ca-ostest432 sh: File
>> "/usr/lib/python2.7/site-packages/ceph_disk/main.py", line 4994, in
>> run
>> Aug  1 05:59:39 ca-ostest432 sh: main(sys.argv[1:])
>> Aug  1 05:59:39 ca-ostest432 sh: File
>> "/usr/lib/python2.7/site-packages/ceph_disk/main.py", line 4945, in
>> main
>> Aug  1 05:59:39 ca-ostest432 sh: args.func(args)
>> Aug  1 05:59:39 ca-ostest432 sh: File
>> "/usr/lib/python2.7/site-packages/ceph_disk/main.py", line 4382, in
>> main_trigger
>> Aug  1 05:59:39 ca-ostest432 sh: raise Error('return code ' + str(ret))
>> Aug  1 05:59:39 ca-ostest432 sh: ceph_disk.main.Error: Error: return code 1
>>
>>
>> Thanks,
>> Muminul
>>
>
> --
> Loïc Dachary, Artisan Logiciel Libre
