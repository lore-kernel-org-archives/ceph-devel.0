From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: ceph-disk and /dev/dm-* permissions - race condition?
Date: Sat, 5 Nov 2016 08:36:22 -0400
Message-ID: <CAGbvivKV1RNfUETQuKaAhGcRz98dNrCO-X8ha_a9CveFhXbNNw@mail.gmail.com>
References: <CAGbviv+bFfR=oC=XhYKB7zQBce3Ph59GALnhoKS_0e71z649mg@mail.gmail.com>
 <CADEhWsOYJeq3kVUL31fzsCmi6E2jueYQsy08OV+jXx-waqZe5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:38532 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754112AbcKEMgY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Nov 2016 08:36:24 -0400
Received: by mail-it0-f45.google.com with SMTP id q124so33657093itd.1
        for <ceph-devel@vger.kernel.org>; Sat, 05 Nov 2016 05:36:23 -0700 (PDT)
In-Reply-To: <CADEhWsOYJeq3kVUL31fzsCmi6E2jueYQsy08OV+jXx-waqZe5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rajib Hossen <rajib.hossen.ipvision@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

Thats an interesting workaround, I may end up using it if all else fails.

I watch the permissions on /dev/dm-* devices during the boot
processes, they start out correctly as "ceph:ceph", but at the end of
the ceph disk preparation, a "ceph-disk trigger" is executed which
seems to cause the permissions to get reset back to "root:disk".  This
leaves the ceph-osd processes that are running able to continue, but
if they have to restart for any reason, they will fail to restart.

It could be a problem with the udev rules for the encrypted data and
journal partitions.  Debugging udev is a nightmare.  Im hoping someone
else has already solved this one.



On Sat, Nov 5, 2016 at 1:13 AM, Rajib Hossen
<rajib.hossen.ipvision@gmail.com> wrote:
> Hello,
> I had the similar issue. I solved it via a cronjob. In crontab -e
> "@reboot chown -R ceph:ceph /dev/vdb1". say my journal is in disk vdb and
> first partition(vdb1). vdb2 is my data disk.
>
> On Fri, Nov 4, 2016 at 8:51 PM, Wyllys Ingersoll
> <wyllys.ingersoll@keepertech.com> wrote:
>>
>> We are running 10.2.3 with encrypted OSDs and journals using the old
>> (i.e. non-Luks) keys and are seeing issues with the ceph-osd processes
>> after a reboot of a storage server.  Our data and journals are on
>> separate partitions on the same disk.
>>
>> After a reboot, sometimes the OSDs fail to start because of
>> permissions problems.  The /dev/dm-* devices come back with
>> permissions set to "root:disk" sometimes instead of "ceph:ceph".
>> Weirder still is that sometimes the ceph-osd will start and work in
>> spite of the incorrect perrmissions (root:disk) and other times they
>> will fail and the logs show permissions errors when trying to access
>> the journals. Sometimes half of the /dev/dm- devices are "root:disk"
>> and others are "ceph:ceph".  There's no clear pattern, so that's what
>> leads me to think its a race condition in the ceph_disk "dmcrypt_map"
>> function.
>>
>> Is there a known issue with ceph-disk and/or ceph-osd related to
>> timing of the encrypted devices being setup and the permissions
>> getting changed to the ceph processes can access them?
>>
>> Wyllys Ingersoll
>> Keeper Technology, LLC
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
