From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: [ceph-users] Can ceph-deploy be used with 'osd objectstore =
 keyvaluestore-dev' in config file ?
Date: Thu, 25 Sep 2014 17:58:23 +1200
Message-ID: <5423AEFF.6080908@catalyst.net.nz>
References: <541B9EFA.1010408@gmail.com> <541BC6F9.5080401@catalyst.net.nz> <541BE6E7.5010500@gmail.com> <542111BD.8040503@gmail.com> <542120A9.5060203@catalyst.net.nz> <54212E40.3030509@gmail.com> <5422277F.6080405@gmail.com> <54222A4D.5000208@catalyst.net.nz> <54222C7A.9060508@gmail.com> <5422306A.4070503@catalyst.net.nz> <alpine.DEB.2.00.1409240556450.27396@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:37147 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbaIYF62 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Sep 2014 01:58:28 -0400
In-Reply-To: <alpine.DEB.2.00.1409240556450.27396@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Aegeaner <xihuke@gmail.com>, ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org, haomaiwang@gmail.com

On 25/09/14 01:03, Sage Weil wrote:
> On Wed, 24 Sep 2014, Mark Kirkwood wrote:
>> On 24/09/14 14:29, Aegeaner wrote:
>>> I run ceph on Red Hat Enterprise Linux Server 6.4 Santiago, and when I
>>> run "service ceph start" i got:
>>>
>>> # service ceph start
>>>
>>>      ERROR:ceph-disk:Failed to activate
>>>      ceph-disk: Does not look like a Ceph OSD, or incompatible version:
>>>      /var/lib/ceph/tmp/mnt.I71N5T
>>>      mount: /dev/hioa1 already mounted or /var/lib/ceph/tmp/mnt.02sVHj busy
>>>      ceph-disk: Mounting filesystem failed: Command '['/bin/mount', '-t',
>>>      'xfs', '-o', 'noatime', '--',
>>>
>> '/dev/disk/by-parttypeuuid/4fbd7e29-9d25-41b8-afd0-062c0ceff05d.6d726c93-41f9-453d-858e-ab4132b5c8fd',
>>>      '/var/lib/ceph/tmp/mnt.02sVHj']' returned non-zero exit status 32
>>>      ceph-disk: Error: One or more partitions failed to activate
>>>
>>> Someone told me "service ceph start" still tries to call ceph-disk which
>>> will create a filestore type OSD, and create a journal partition, is it
>>> true?
>>>
>>> ls -l /dev/disk/by-parttypeuuid/
>>>
>>>      lrwxrwxrwx. 1 root root 11 9?  23 16:56
>>>
>> 45b0969e-9b03-4f30-b4c6-b4b80ceff106.00dbee5e-fb68-47c4-aa58-924c904c4383
>>>      -> ../../hioa2
>>>      lrwxrwxrwx. 1 root root 10 9?  23 17:02
>>>
>> 45b0969e-9b03-4f30-b4c6-b4b80ceff106.c30e5b97-b914-4eb8-8306-a9649e1c20ba
>>>      -> ../../sdb2
>>>      lrwxrwxrwx. 1 root root 11 9?  23 16:56
>>>
>> 4fbd7e29-9d25-41b8-afd0-062c0ceff05d.6d726c93-41f9-453d-858e-ab4132b5c8fd
>>>      -> ../../hioa1
>>>      lrwxrwxrwx. 1 root root 10 9?  23 17:02
>>>
>> 4fbd7e29-9d25-41b8-afd0-062c0ceff05d.b56ec699-e134-4b90-8f55-4952453e1b7e
>>>      -> ../../sdb1
>>>      lrwxrwxrwx. 1 root root 11 9?  23 16:52
>>>
>> 89c57f98-2fe5-4dc0-89c1-f3ad0ceff2be.6d726c93-41f9-453d-858e-ab4132b5c8fd
>>>      -> ../../hioa1
>>>
>>> There seems to be two hioa1 partitions there, maybe remained from last
>>> time I create the OSD using ceph-deploy osd prepare?
>>>
>>
>> Crap - it is fighting you, yes - looks like the startup script has tried
>> to build an osd for you using ceph-disk (which will make two partitions
>> by default). So that's toasted the setup that your script did.
>>
>> Growl - that's made it more complicated for sure.
>
> Hrm, yeah.  I think ceph-disk needs to have an option (via ceph.conf) that
> will avoid creating a journal [partition], and we need to make sure that
> the journal behavior is all conditional on the journal symlink being
> present.  Do you mind opening a bug for this?  It could condition itself
> off of the osd objectstore option (we'd need to teach ceph-diska bout the
> varoius backends), or we could add a secondary option (awkware to
> configure), or we could call into ceph-osd with something like 'ceph-osd
> -i 0 --does-backend-need-journal' so that a call into the backend
> code itself can control things.  The latter is probably ideal.
>
> Opened http://tracker.ceph.com/issues/9580 and copying ceph-devel
>

Yeah, looks good - the approach to ask ceph-osd if it needs a journal 
seems sound.

Regards

Mark

