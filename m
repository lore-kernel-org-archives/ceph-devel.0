From: Two Spirit <twospirit6905@gmail.com>
Subject: Re: dmcrypt?
Date: Wed, 13 Sep 2017 08:00:41 -0700
Message-ID: <CAKRxpuucZHo5DXK1Ds3Zizbb9HoUZiu5p6gefPE=Mzm8MhvP2w@mail.gmail.com>
References: <CAKRxpuv733NqGs+U5m1TUHK9OyVvCEZDv93bs0Djggop_3vxRA@mail.gmail.com>
 <alpine.DEB.2.11.1709131232040.24068@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:45441 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdIMPAn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Sep 2017 11:00:43 -0400
Received: by mail-it0-f53.google.com with SMTP id v19so3062983ite.0
        for <ceph-devel@vger.kernel.org>; Wed, 13 Sep 2017 08:00:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709131232040.24068@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 13, 2017 at 5:33 AM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 12 Sep 2017, Two Spirit wrote:
>> Hi Sage,
>>
>> I tried to install an encrypted OSD, but I found the documentation to
>> be light and not finding any examples. I was able to prepare
>> (ceph-deploy osd prepare --dmcrypt <host>:<relative_device_name>', but
>> I couldn't activate it. I found a tracker page that listed you as one
>> of the owners http://tracker.ceph.com/projects/ceph/wiki/Osd_-_simple_ceph-mon_dm-crypt_key_management
>> that seemed to imply that it was in the 'planning' phase. I was
>> wondering if this is in planning phase, or if it is fully supported
>> now ready to begin testing.
>
> There are still some issues with dmcrypt + bluestore; can you verify it
> works with --filestore?
>
> I was hoping to get ceph-volume support for bluestore ready so that we
> didn't have to deal with ceph-disk, but we didn't get to it before the
> luminous release.  That's still my preferred path...
>
> sage
>
>
>> I have a requirement to place complete disks in encrypted containers
>> (including partition tables. kpartx accesses the encrypted partitions.
>> some versions of Ubuntu I have to do this manually, but newer versions
>> seem to automatically do this).  I haven't absorbed all the ceph
>> dmcrypt architecture yet, but I did not feel comfortable that the keys
>> were available by querying ceph. Not saying I have any idea how to do
>> it better in a ceph environment. Can you accept a network accessible
>> keyfile?
>>
>> I thought I might be able to get some testing by creating my own
>> encrypted container outside of ceph, which was accessible via
>> /dev/mapper/lukscontainer. I tried 'ceph-deploy osd prepare
>> luksosd:/dev/mapper/lukscontainer' and it didn't like that. I saw docs
>> using absolute references (/dev/sdb) so I thought
>> /dev/mapper/lukscontainer should be usable. ceph-deploy osd prepare
>> --dmcrypt luksosd:sdb seemed to work -- maybe it didn't like the fact
>> the path was an extra level deeper. Where is the encrypted ceph data
>> partition to activate?
>>
>> As a temporary workaround, I was thinking I could create a /dev/mdXXX
>> device using mdadm forcing a single disk raid. This would keep key
>> management outside of ceph for now. and be able to run the relative
>> path format 'ceph-deploy osd prepare luksosd:mdXXX'. In theory, this
>> should work and supported by ceph, right?
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
