From: Martin Mailand <martin@tuxadero.com>
Subject: Re: 0.37 crash
Date: Thu, 20 Oct 2011 20:49:14 +0200
Message-ID: <4EA06D2A.6040101@tuxadero.com>
References: <4EA040BC.30708@tuxadero.com> <4EA067A4.5090100@unilogicnetworks.net>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:43230 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab1JTStZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Oct 2011 14:49:25 -0400
In-Reply-To: <4EA067A4.5090100@unilogicnetworks.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Kleijkers <stefan@unilogicnetworks.net>
Cc: ceph-devel@vger.kernel.org

Hi Stefan,
in my case the osd process was just terminated, no IO wait. Could you 
have a look in your dmesg, if there is any btrfs entry?
Because the IO wait sounds like a btrfs problem.

Best Regards,
  martin

Stefan Kleijkers schrieb:
> Hello,
> 
> I got the exact same problem. Upgraded from 0.36 to 0.37 and one of the 
> two osds wouldn't start. In the log of the osd I also found the same 
> error as below. The ceph-osd had status D (with ps, which is 
> uninterruptable sleep) and I see a high IO wait with top. Also I noticed 
> a lot of disk io on the disks.
> 
> Stefan
> 
> On 10/20/2011 05:39 PM, Martin Mailand wrote:
>> Hi,
>> today I tried the version 0.37 and it did not work very well, see below.
>> It was an update from 0.36.
>>
>> Best Regards,
>>  Martin
>>
>>
>> 2011-10-20 17:33:34.350502 7f0ada6f4760 ceph version 0.37 
>> (commit:a6f3bbb744a6faea95ae48317f0b838edb16a896), process ceph-osd, 
>> pid 21707
>> 2011-10-20 17:33:34.353543 7f0ada6f4760 filestore(/data/osd2) mount 
>> FIEMAP ioctl is NOT supported
>> 2011-10-20 17:33:34.353628 7f0ada6f4760 filestore(/data/osd2) mount 
>> detected btrfs
>> 2011-10-20 17:33:34.353656 7f0ada6f4760 filestore(/data/osd2) mount 
>> btrfs CLONE_RANGE ioctl is supported
>> 2011-10-20 17:33:34.425059 7f0ada6f4760 filestore(/data/osd2) mount 
>> btrfs SNAP_CREATE is supported
>> 2011-10-20 17:33:34.544564 7f0ada6f4760 filestore(/data/osd2) mount 
>> btrfs SNAP_DESTROY is supported
>> 2011-10-20 17:33:34.544873 7f0ada6f4760 filestore(/data/osd2) mount 
>> btrfs START_SYNC got 0 Success
>> 2011-10-20 17:33:34.544966 7f0ada6f4760 filestore(/data/osd2) mount 
>> btrfs START_SYNC is supported (transid 149)
>> 2011-10-20 17:33:34.624965 7f0ada6f4760 filestore(/data/osd2) mount 
>> btrfs WAIT_SYNC is supported
>> 2011-10-20 17:33:34.636719 7f0ada6f4760 filestore(/data/osd2) mount 
>> btrfs SNAP_CREATE_V2 got 0 Success
>> 2011-10-20 17:33:34.636754 7f0ada6f4760 filestore(/data/osd2) mount 
>> btrfs SNAP_CREATE_V2 is supported
>> 2011-10-20 17:33:34.644876 7f0ada6f4760 filestore(/data/osd2) mount 
>> found snaps <>
>> 2011-10-20 17:33:34.644983 7f0ada6f4760 filestore(/data/osd2) mount: 
>> enabling WRITEAHEAD journal mode: 'filestore btrfs snap' mode is not 
>> enabled
>> 2011-10-20 17:33:34.678324 7f0ada6f4760 journal  kernel version is 3.1.0
>> 2011-10-20 17:33:34.678737 7f0ada6f4760 journal _open /dev/sda7 fd 14: 
>> 476500201472 bytes, block size 4096 bytes, directio = 1
>> 2011-10-20 17:33:34.688215 7f0ada6f4760 journal read_entry 39366656 : 
>> seq 4653 710 bytes
>> 2011-10-20 17:33:34.688420 7f0ada6f4760 journal read_entry 39374848 : 
>> seq 4654 33 bytes
>> 2011-10-20 17:33:34.695110 7f0ada6f4760 journal  kernel version is 3.1.0
>> 2011-10-20 17:33:34.695496 7f0ada6f4760 journal _open /dev/sda7 fd 14: 
>> 476500201472 bytes, block size 4096 bytes, directio = 1
>> 2011-10-20 17:33:34.696359 7f0ada6f4760 FileStore is up to date.
>> 2011-10-20 17:33:34.696683 7f0ada6f4760 journal close /dev/sda7
>> 2011-10-20 17:33:34.697970 7f0ada6f4760 filestore(/data/osd2) mount 
>> FIEMAP ioctl is NOT supported
>> 2011-10-20 17:33:34.698013 7f0ada6f4760 filestore(/data/osd2) mount 
>> detected btrfs
>> 2011-10-20 17:33:34.698031 7f0ada6f4760 filestore(/data/osd2) mount 
>> btrfs CLONE_RANGE ioctl is supported
>> 2011-10-20 17:33:34.774980 7f0ada6f4760 filestore(/data/osd2) mount 
>> btrfs SNAP_CREATE is supported
>> 2011-10-20 17:33:34.904538 7f0ada6f4760 filestore(/data/osd2) mount 
>> btrfs SNAP_DESTROY is supported
>> 2011-10-20 17:33:34.904945 7f0ada6f4760 filestore(/data/osd2) mount 
>> btrfs START_SYNC got 0 Success
>> 2011-10-20 17:33:34.904995 7f0ada6f4760 filestore(/data/osd2) mount 
>> btrfs START_SYNC is supported (transid 152)
>> 2011-10-20 17:33:34.991585 7f0ada6f4760 filestore(/data/osd2) mount 
>> btrfs WAIT_SYNC is supported
>> 2011-10-20 17:33:34.996636 7f0ada6f4760 filestore(/data/osd2) mount 
>> btrfs SNAP_CREATE_V2 got 0 Success
>> 2011-10-20 17:33:34.996664 7f0ada6f4760 filestore(/data/osd2) mount 
>> btrfs SNAP_CREATE_V2 is supported
>> 2011-10-20 17:33:35.004813 7f0ada6f4760 filestore(/data/osd2) mount 
>> found snaps <>
>> 2011-10-20 17:33:35.004902 7f0ada6f4760 filestore(/data/osd2) mount: 
>> enabling WRITEAHEAD journal mode: 'filestore btrfs snap' mode is not 
>> enabled
>> 2011-10-20 17:33:35.023071 7f0ada6f4760 journal  kernel version is 3.1.0
>> 2011-10-20 17:33:35.023353 7f0ada6f4760 journal _open /dev/sda7 fd 14: 
>> 476500201472 bytes, block size 4096 bytes, directio = 1
>> 2011-10-20 17:33:35.029846 7f0ada6f4760 journal read_entry 39366656 : 
>> seq 4653 710 bytes
>> 2011-10-20 17:33:35.030077 7f0ada6f4760 journal read_entry 39374848 : 
>> seq 4654 33 bytes
>> 2011-10-20 17:33:35.036728 7f0ada6f4760 journal  kernel version is 3.1.0
>> 2011-10-20 17:33:35.037142 7f0ada6f4760 journal _open /dev/sda7 fd 14: 
>> 476500201472 bytes, block size 4096 bytes, directio = 1
>> *** Caught signal (Aborted) **
>>  in thread 0x7f0ace7f9700
>>  ceph version 0.37 (commit:a6f3bbb744a6faea95ae48317f0b838edb16a896)
>>  1: /usr/bin/ceph-osd() [0x5bd012]
>>  2: (()+0xfc60) [0x7f0ada2d4c60]
>>  3: (gsignal()+0x35) [0x7f0ad8a5ad05]
>>  4: (abort()+0x186) [0x7f0ad8a5eab6]
>>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f0ad93116dd]
>>  6: (()+0xb9926) [0x7f0ad930f926]
>>  7: (()+0xb9953) [0x7f0ad930f953]
>>  8: (()+0xb9a5e) [0x7f0ad930fa5e]
>>  9: (ceph::buffer::list::iterator::copy(unsigned int, char*)+0x129) 
>> [0x5a7e99]
>>  10: (OSDMap::decode(ceph::buffer::list&)+0x81) [0x58f9f1]
>>  11: (OSD::get_map(unsigned int)+0x242) [0x53f6d2]
>>  12: (OSD::handle_osd_map(MOSDMap*)+0x1f82) [0x56ae72]
>>  13: (OSD::_dispatch(Message*)+0x36b) [0x56d11b]
>>  14: (OSD::ms_dispatch(Message*)+0xf6) [0x56e1c6]
>>  15: (SimpleMessenger::dispatch_entry()+0x88b) [0x5fff2b]
>>  16: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x4bd55c]
>>  17: (()+0x6d8c) [0x7f0ada2cbd8c]
>>  18: (clone()+0x6d) [0x7f0ad8b0d04d]
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
