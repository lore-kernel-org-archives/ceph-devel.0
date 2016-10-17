From: Loic Dachary <loic@dachary.org>
Subject: Re: jewel: rbd: FAILED assert(m_in_flight_object_closes > 0)
Date: Mon, 17 Oct 2016 15:53:36 +0200
Message-ID: <5804D7E0.6060607@dachary.org>
References: <5804970A.6080902@dachary.org>
 <CA+aFP1BDLPsB=e7Y+8xx9zkPrqyAU0H26ntgbmEYUq5AMrg68Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37067 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754734AbcJQNxl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Oct 2016 09:53:41 -0400
In-Reply-To: <CA+aFP1BDLPsB=e7Y+8xx9zkPrqyAU0H26ntgbmEYUq5AMrg68Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 17/10/2016 15:22, Jason Dillaman wrote:
> I don't see any missing commits related to that area of code. I ran
> unittest_librbd in a continuous loop and was able to recreate on the
> master branch, so this is a real issue that needs to be addressed.

Did you create an issue for that ? If not I will, to get a reference and remember this discussion.

Thanks for the quick reply :-)

> 
> Thanks,
> Jason
> 
> On Mon, Oct 17, 2016 at 5:16 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Jason,
>>
>> The
>>
>> rbd/qemu/{cache/writeback.yaml cachepool/ec-cache.yaml clusters/{fixed-3.yaml openstack.yaml} features/journaling.yaml fs/xfs.yaml msgr-failures/few.yaml workloads/qemu_xfstests.yaml}
>>
>> job failed twice in a row
>>
>> http://pulpito.ceph.com/loic-2016-10-14_06:48:18-rbd-jewel-backports---basic-smithi/473422
>> http://pulpito.ceph.com/loic-2016-10-13_09:17:31-rbd-jewel-backports---basic-smithi/470997
>>
>> with
>>
>> 2016-10-14T06:57:57.700 INFO:tasks.qemu.client.0.smithi087.stdout:mount: block device /dev/sr0 is write-protected, mounting read-only
>> 2016-10-14T06:59:18.374 INFO:tasks.ceph.osd.5.smithi096.stderr:2016-10-14 06:59:18.373238 7f89520fb700 -1 reset not still connected to 0x7f89737050c0
>> 2016-10-14T06:59:58.946 INFO:tasks.ceph.osd.5.smithi096.stderr:2016-10-14 06:59:58.946646 7f89520fb700 -1 reset not still connected to 0x7f8973913180
>> 2016-10-14T07:07:59.122 INFO:tasks.qemu.client.0.smithi087.stderr:main-loop: WARNING: I/O thread spun for 1000 iterations
>> 2016-10-14T07:09:11.712 INFO:tasks.ceph.osd.5.smithi096.stderr:2016-10-14 07:09:11.711124 7f89520fb700 -1 reset not still connected to 0x7f8973913180
>> 2016-10-14T07:10:28.034 INFO:tasks.ceph.osd.5.smithi096.stderr:2016-10-14 07:10:28.034047 7f89520fb700 -1 reset not still connected to 0x7f8973913180
>> 2016-10-14T07:14:20.062 INFO:tasks.qemu.client.0.smithi087.stderr:journal/JournalRecorder.cc: In function 'void journal::JournalRecorder::handle_closed(journal::ObjectRecorder*)' thread 7fe0b3066700 time 2016-10-14 07:14:20.069199
>> 2016-10-14T07:14:20.063 INFO:tasks.qemu.client.0.smithi087.stderr:journal/JournalRecorder.cc: 321: FAILED assert(m_in_flight_object_closes > 0)
>> 2016-10-14T07:14:20.091 INFO:tasks.qemu.client.0.smithi087.stderr: ceph version 10.2.3-266-g94a5296 (94a52962cdb0eb3d2f2eba11daa0e14ae349734e)
>> 2016-10-14T07:14:20.092 INFO:tasks.qemu.client.0.smithi087.stderr: 1: (()+0x29e865) [0x7fe0cf2c1865]
>> 2016-10-14T07:14:20.092 INFO:tasks.qemu.client.0.smithi087.stderr: 2: (()+0x1a7589) [0x7fe0cf1ca589]
>> 2016-10-14T07:14:20.092 INFO:tasks.qemu.client.0.smithi087.stderr: 3: (()+0x1b2c46) [0x7fe0cf1d5c46]
>> 2016-10-14T07:14:20.092 INFO:tasks.qemu.client.0.smithi087.stderr: 4: (()+0x1b5b23) [0x7fe0cf1d8b23]
>> 2016-10-14T07:14:20.092 INFO:tasks.qemu.client.0.smithi087.stderr: 5: (()+0x75ef9) [0x7fe0cf098ef9]
>> 2016-10-14T07:14:20.092 INFO:tasks.qemu.client.0.smithi087.stderr: 6: (()+0xc1487) [0x7fe0cf0e4487]
>> 2016-10-14T07:14:20.092 INFO:tasks.qemu.client.0.smithi087.stderr: 7: (()+0xc15a2) [0x7fe0cf0e45a2]
>> 2016-10-14T07:14:20.092 INFO:tasks.qemu.client.0.smithi087.stderr: 8: (()+0xb1c39) [0x7fe0cf0d4c39]
>> 2016-10-14T07:14:20.092 INFO:tasks.qemu.client.0.smithi087.stderr: 9: (()+0x9ebad) [0x7fe0c5941bad]
>> 2016-10-14T07:14:20.093 INFO:tasks.qemu.client.0.smithi087.stderr: 10: (()+0x87099) [0x7fe0c592a099]
>> 2016-10-14T07:14:20.093 INFO:tasks.qemu.client.0.smithi087.stderr: 11: (()+0x173d06) [0x7fe0c5a16d06]
>> 2016-10-14T07:14:20.093 INFO:tasks.qemu.client.0.smithi087.stderr: 12: (()+0x7dc5) [0x7fe0d8d8cdc5]
>> 2016-10-14T07:14:20.093 INFO:tasks.qemu.client.0.smithi087.stderr: 13: (clone()+0x6d) [0x7fe0c2fb5ced]
>> 2016-10-14T07:14:20.093 INFO:tasks.qemu.client.0.smithi087.stderr: NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>> 2016-10-14T07:14:23.511 INFO:tasks.qemu.client.0.smithi087.stderr:daemon-helper: command crashed with signal 6
>> 2016-10-14T07:14:23.518 INFO:tasks.rbd:Deleting rbd clones...
>>
>> It used the jewel-backports branch ( http://tracker.ceph.com/issues/17487#note-9 ).
>>
>> I looked in the tracker for m_in_flight_object_closes and did not find any match. Since https://github.com/ceph/ceph/pull/11433 has many journal related commits, I wonder if maybe something is missing ?
>>
>> Cheers
>>
>> --
>> Loïc Dachary, Artisan Logiciel Libre
> 
> 
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
