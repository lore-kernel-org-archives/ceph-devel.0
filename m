From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-disk and /dev/dm-* permissions - race condition?
Date: Wed, 23 Nov 2016 00:33:07 +0100
Message-ID: <04a836d4-480e-9ba2-9691-c5bf48d55219@dachary.org>
References: <CAGbviv+bFfR=oC=XhYKB7zQBce3Ph59GALnhoKS_0e71z649mg@mail.gmail.com>
 <2ef16457-2c08-8b1a-0c44-0a08955c2238@dachary.org>
 <CAGbvivLrrjFp5_LHWQq4Z4DaUfF2OnCVgJK1FKbWL9X+voUHCw@mail.gmail.com>
 <41c84ca4-c14b-511e-fa73-6b846bd6e74c@dachary.org>
 <CAGbvivLbGkwaEGSitOYrna41pqKPucVL6kBYTX5om28A4GkNTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41030 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755650AbcKVXe0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Nov 2016 18:34:26 -0500
In-Reply-To: <CAGbvivLbGkwaEGSitOYrna41pqKPucVL6kBYTX5om28A4GkNTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 22/11/2016 20:13, Wyllys Ingersoll wrote:
> I dont know, but making the change in the 55-dm.rules file seems to do
> the trick well enough for now.

It does. But there does not seem to be a way to package this workaround. This is the reason why I'm trying to find another fix.

Cheers

> 
> On Tue, Nov 22, 2016 at 12:07 PM, Loic Dachary <loic@dachary.org> wrote:
>>
>>
>> On 22/11/2016 16:13, Wyllys Ingersoll wrote:
>>> I think that sounds reasonable, obviously more testing will be needed
>>> to verify.  Our situation occurred on an Ubuntu Trusty (upstart based,
>>> not systemd) server, so I dont think this will help for non-systemd
>>> systems.
>>
>> I don't think there is a way to enforce an order with upstart. But maybe there is ? If you don't know about it I will research.
>>
>>> On Tue, Nov 22, 2016 at 9:48 AM, Loic Dachary <loic@dachary.org> wrote:
>>>> Hi,
>>>>
>>>> It should be enough to add After=local-fs.target to /lib/systemd/system/ceph-disk@.service and have ceph-disk trigger --sync chown ceph:ceph /dev/XXX to fix this issue (and others). Since local-fs.target indirectly depends on dm, this ensures ceph disk activation will only happen after dm is finished. It is entirely possible that the ownership is incorrect when ceph-disk trigger --sync starts running, but it will no longer race with dm and it can safely chown ceph:ceph and proceed with activation.
>>>>
>>>> I'm testing this with https://github.com/ceph/ceph/pull/12136 but I'm not sure yet if I'm missing something or if that's the right thing to do.
>>>>
>>>> What do you think ?
>>>>
>>>> On 04/11/2016 15:51, Wyllys Ingersoll wrote:
>>>>> We are running 10.2.3 with encrypted OSDs and journals using the old
>>>>> (i.e. non-Luks) keys and are seeing issues with the ceph-osd processes
>>>>> after a reboot of a storage server.  Our data and journals are on
>>>>> separate partitions on the same disk.
>>>>>
>>>>> After a reboot, sometimes the OSDs fail to start because of
>>>>> permissions problems.  The /dev/dm-* devices come back with
>>>>> permissions set to "root:disk" sometimes instead of "ceph:ceph".
>>>>> Weirder still is that sometimes the ceph-osd will start and work in
>>>>> spite of the incorrect perrmissions (root:disk) and other times they
>>>>> will fail and the logs show permissions errors when trying to access
>>>>> the journals. Sometimes half of the /dev/dm- devices are "root:disk"
>>>>> and others are "ceph:ceph".  There's no clear pattern, so that's what
>>>>> leads me to think its a race condition in the ceph_disk "dmcrypt_map"
>>>>> function.
>>>>>
>>>>> Is there a known issue with ceph-disk and/or ceph-osd related to
>>>>> timing of the encrypted devices being setup and the permissions
>>>>> getting changed to the ceph processes can access them?
>>>>>
>>>>> Wyllys Ingersoll
>>>>> Keeper Technology, LLC
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>> --
>>>> Loïc Dachary, Artisan Logiciel Libre
>>>
>>
>> --
>> Loïc Dachary, Artisan Logiciel Libre
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
