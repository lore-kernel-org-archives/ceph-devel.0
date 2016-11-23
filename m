From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: ceph-disk and /dev/dm-* permissions - race condition?
Date: Wed, 23 Nov 2016 10:49:13 -0500
Message-ID: <CAGbviv+ET66uOrx-vTPOiLDZRb5DzAgsvX3c8bB7D8Jgtd5oTQ@mail.gmail.com>
References: <CAGbviv+bFfR=oC=XhYKB7zQBce3Ph59GALnhoKS_0e71z649mg@mail.gmail.com>
 <2ef16457-2c08-8b1a-0c44-0a08955c2238@dachary.org> <CAGbvivLrrjFp5_LHWQq4Z4DaUfF2OnCVgJK1FKbWL9X+voUHCw@mail.gmail.com>
 <41c84ca4-c14b-511e-fa73-6b846bd6e74c@dachary.org> <CAGbvivLbGkwaEGSitOYrna41pqKPucVL6kBYTX5om28A4GkNTA@mail.gmail.com>
 <85c2dcf0-ad1e-ecba-fba5-02a388c21b23@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:32777 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbcKWPuM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2016 10:50:12 -0500
Received: by mail-io0-f174.google.com with SMTP id j65so30747905iof.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Nov 2016 07:49:15 -0800 (PST)
In-Reply-To: <85c2dcf0-ad1e-ecba-fba5-02a388c21b23@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

That doesn't appear to work on 10.2.3 (with modified ceph-disk/main.py
from your fix above).  I think it ends up trying to access the
/dev/mapper/UUID files before they have been established so the
ceph-osd starter process fails since there are no mapped dm partitions
yet.  Adding 'local-filesystems' to the "start on" line is forcing it
to start too soon,I think.   I see these errors in the upstart logs
for ceph-osd-all-starter.log.

ceph-disk: Cannot discover filesystem type: device
/dev/mapper/00457719-b9b0-4cd0-a912-8e6e5efff7cd: Command
'/sbin/blkid' returned non-zero exit status 2
ceph-disk: Cannot discover filesystem type: device
/dev/mapper/eb056779-7bd0-4768-86cb-d757174a2046: Command
'/sbin/blkid' returned non-zero exit status 2
ceph-disk: Cannot discover filesystem type: device
/dev/mapper/f1300502-1143-4c91-b43c-051342b36933: Command
'/sbin/blkid' returned non-zero exit status 2
ceph-disk: Error: One or more partitions failed to activate



On Wed, Nov 23, 2016 at 6:42 AM, Loic Dachary <loic@dachary.org> wrote:
> I think that could work as well:
>
> in ceph-disk.conf
>
> description "ceph-disk async worker"
>
> start on (ceph-disk and local-filesystems)
>
> instance $dev/$pid
> export dev
> export pid
>
> exec flock /var/lock/ceph-disk -c 'ceph-disk --verbose --log-stdout trigg=
er --sync $dev'
>
> with https://github.com/ceph/ceph/pull/12136/commits/72f0b2aa1eb4b7b2a222=
2c2847d26f99400a8374
>
> What do you say ?
>
> On 22/11/2016 20:13, Wyllys Ingersoll wrote:
>> I dont know, but making the change in the 55-dm.rules file seems to do
>> the trick well enough for now.
>>
>> On Tue, Nov 22, 2016 at 12:07 PM, Loic Dachary <loic@dachary.org> wrote:
>>>
>>>
>>> On 22/11/2016 16:13, Wyllys Ingersoll wrote:
>>>> I think that sounds reasonable, obviously more testing will be needed
>>>> to verify.  Our situation occurred on an Ubuntu Trusty (upstart based,
>>>> not systemd) server, so I dont think this will help for non-systemd
>>>> systems.
>>>
>>> I don't think there is a way to enforce an order with upstart. But mayb=
e there is ? If you don't know about it I will research.
>>>
>>>> On Tue, Nov 22, 2016 at 9:48 AM, Loic Dachary <loic@dachary.org> wrote=
:
>>>>> Hi,
>>>>>
>>>>> It should be enough to add After=3Dlocal-fs.target to /lib/systemd/sy=
stem/ceph-disk@.service and have ceph-disk trigger --sync chown ceph:ceph /=
dev/XXX to fix this issue (and others). Since local-fs.target indirectly de=
pends on dm, this ensures ceph disk activation will only happen after dm is=
 finished. It is entirely possible that the ownership is incorrect when cep=
h-disk trigger --sync starts running, but it will no longer race with dm an=
d it can safely chown ceph:ceph and proceed with activation.
>>>>>
>>>>> I'm testing this with https://github.com/ceph/ceph/pull/12136 but I'm=
 not sure yet if I'm missing something or if that's the right thing to do.
>>>>>
>>>>> What do you think ?
>>>>>
>>>>> On 04/11/2016 15:51, Wyllys Ingersoll wrote:
>>>>>> We are running 10.2.3 with encrypted OSDs and journals using the old
>>>>>> (i.e. non-Luks) keys and are seeing issues with the ceph-osd process=
es
>>>>>> after a reboot of a storage server.  Our data and journals are on
>>>>>> separate partitions on the same disk.
>>>>>>
>>>>>> After a reboot, sometimes the OSDs fail to start because of
>>>>>> permissions problems.  The /dev/dm-* devices come back with
>>>>>> permissions set to "root:disk" sometimes instead of "ceph:ceph".
>>>>>> Weirder still is that sometimes the ceph-osd will start and work in
>>>>>> spite of the incorrect perrmissions (root:disk) and other times they
>>>>>> will fail and the logs show permissions errors when trying to access
>>>>>> the journals. Sometimes half of the /dev/dm- devices are "root:disk"
>>>>>> and others are "ceph:ceph".  There's no clear pattern, so that's wha=
t
>>>>>> leads me to think its a race condition in the ceph_disk "dmcrypt_map=
"
>>>>>> function.
>>>>>>
>>>>>> Is there a known issue with ceph-disk and/or ceph-osd related to
>>>>>> timing of the encrypted devices being setup and the permissions
>>>>>> getting changed to the ceph processes can access them?
>>>>>>
>>>>>> Wyllys Ingersoll
>>>>>> Keeper Technology, LLC
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>
>>>>> --
>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
