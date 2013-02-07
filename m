From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: ceph mkfs failed
Date: Thu, 7 Feb 2013 14:42:55 -0600
Message-ID: <CAB7xdimctzpk8qeRLJqxxeNRJEFpc2EpVHd37qj0E-OCeBP13A@mail.gmail.com>
References: <CAB7xdi=5q-e7FEXjrf524as4FPW-pM4z9wDrCm7boPVTr7sVLg@mail.gmail.com>
	<51140CFF.8000207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:60846 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757578Ab3BGUm4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 15:42:56 -0500
Received: by mail-ie0-f182.google.com with SMTP id k14so4113910iea.13
        for <ceph-devel@vger.kernel.org>; Thu, 07 Feb 2013 12:42:55 -0800 (PST)
In-Reply-To: <51140CFF.8000207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Dan,

thanks for your reply.

after some code tracking, i found it failed at this point :
in file leveldb/db/db_impl.cc  --> NewDB()

log::Writer log(file);
    std::string record;
    new_db.EncodeTo(&record);
    s = log.AddRecord(record);
    if (s.ok()) {
      fprintf(test, "NewDB: 2\n");
      s = file->Close();
    }else
      fprintf(test, "NewDB: 2.5\n");

the log.AddRecord return s which is not ok().

can you provide some hint why it fails?  i am reading the AddRecord()
function now.

Thanks,
Sheng


On Thu, Feb 7, 2013 at 2:22 PM, Dan Mick <dan.mick@inktank.com> wrote:
>
>
> On 02/07/2013 09:59 AM, sheng qiu wrote:
>>
>> Hi,
>>
>> i am trying to port a local file system other than ext3,ext4,btrfs to
>> manage the OSD. There are some reasons for us to do it.
>> the mkcephfs stopped at this point:
>>
>> 2013-02-07 11:39:32.009889 7effe43d17a0 -1 filestore(/mnt/osd.0) mkfs
>> failed to create leveldb: IO error:
>> /mnt/osd.0/current/omap/MANIFEST-000001: Invalid argument
>> 2013-02-07 11:39:32.009907 7effe43d17a0 -1 OSD::mkfs: FileStore::mkfs
>> failed with error -1
>> 2013-02-07 11:39:32.009949 7effe43d17a0 -1  ** ERROR: error creating
>> empty object store in /mnt/osd.0: (1) Operation not permitted
>
>
> Does your ssh user have permission to create dirs in /mnt?
> (I'll grant you it looks like you're doing root, but, still)
>
>
>> failed: 'ssh root@mon-mds /usr/local/sbin/mkcephfs -d
>> /tmp/mkfs.ceph.2686 --init-daemon osd.0'
>
>
> You could certainly try this command on the failing system as root,
> and look with strace to see what system call is actually failing.
>
>
>>
>> look into the code, it failed at os/FileStore.cc -->  leveldb::Status
>> status = leveldb::DB::Open(options, omap_dir, &db);
>>
>> Does anyone have any suggestions?
>>
>> Thanks,
>> Sheng
>>
>



-- 
Sheng Qiu
Texas A & M University
Room 332B Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
