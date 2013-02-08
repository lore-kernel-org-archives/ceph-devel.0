From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: ceph mkfs failed
Date: Fri, 8 Feb 2013 10:36:31 -0600
Message-ID: <CAB7xdi=tnmU3jWVfmLjxSFa_kdNrPbcd=3uePUaJ0k-S5gyMfQ@mail.gmail.com>
References: <CAB7xdi=5q-e7FEXjrf524as4FPW-pM4z9wDrCm7boPVTr7sVLg@mail.gmail.com>
	<51140CFF.8000207@inktank.com>
	<CAB7xdimctzpk8qeRLJqxxeNRJEFpc2EpVHd37qj0E-OCeBP13A@mail.gmail.com>
	<CAPYLRzjeNZn+aYwtcij0YddYX=Fpd=xY5+QrveaNNMXCL4bLUw@mail.gmail.com>
	<CAB7xdin+Ow_KE1EgNSK6PG4EDSKgO=DSjFJBpBVKjL-Rd5wehA@mail.gmail.com>
	<511428FA.3040209@inktank.com>
	<CAB7xdikEyH0_4TsFiabRmQXRkTs=vtJe1njtc4QpWq1sMANAHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:56567 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760098Ab3BHQgc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 11:36:32 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so5175953ieb.6
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 08:36:31 -0800 (PST)
In-Reply-To: <CAB7xdikEyH0_4TsFiabRmQXRkTs=vtJe1njtc4QpWq1sMANAHQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

i want to update a little bit on my problem.
after some work, right now my local fs on OSD can works with ceph (at
least pass through the init-ceph script). i made a minor change on
ceph code, i changed the link_object() in LFNIndex.cc, basically i
changed the hard link call ::link() to symlink(), as my local fs does
not support hard link (the directory entry stores together with the
related inodes).

when i mount the client on ceph, it is fine. and the ceph -s shows at
least 50% degraded, although in HEALTH_WARN state, some pgs still
work.
i can manually create files and write them on the mount path (by vim
and edit them).
when i try to run some benchmarks, such as iozone and fio. it fails
with the following information:

2013-02-08 10:16:44.433532 7f692c55a700  0 -- 165.91.215.237:6801/7231
>> 165.91.215.237:0/1395168951 pipe(0x2b9c240 sd=57 :6801 pgs=0 cs=0
l=0).accept peer addr is really 165.91.215.237:0/1395168951 (socket is
165.91.215.237:60388/0)
2013-02-08 10:20:22.488334 7f692c55a700  0 -- 165.91.215.237:6801/7231
>> 165.91.215.237:0/1395168951 pipe(0x2b9c000 sd=57 :6801 pgs=0 cs=0
l=0).accept peer addr is really 165.91.215.237:0/1395168951 (socket is
165.91.215.237:60413/0)
2013-02-08 10:20:22.564453 7f6937873700 -1 *** Caught signal
(Segmentation fault) **
 in thread 7f6937873700

is there any suggestions?

Thanks,
Sheng

On Thu, Feb 7, 2013 at 4:40 PM, sheng qiu <herbert1984106@gmail.com> wrote:
> i see. it only support readonly mmap. i will figure it out.
>
> Thanks a lot.
>
> Sheng
>
> On Thu, Feb 7, 2013 at 4:21 PM, Dan Mick <dan.mick@inktank.com> wrote:
>> leveldb is required.  What filesystem are you using that doesn't support
>> mmap?
>>
>>
>> On 02/07/2013 02:11 PM, sheng qiu wrote:
>>>
>>> Is it possible comment the leveldb setup codes during mkfs call path?
>>> i find the problem is because i am trying to use a bunch of memory as
>>> the OSD, when the leveldb mmap() the file on OSD, it failed, as the
>>> file actually located on memory.
>>>
>>> Thanks,
>>> Sheng
>>>
>>> On Thu, Feb 7, 2013 at 2:53 PM, Gregory Farnum <greg@inktank.com> wrote:
>>>>
>>>> On Thu, Feb 7, 2013 at 12:42 PM, sheng qiu <herbert1984106@gmail.com>
>>>> wrote:
>>>>>
>>>>> Hi Dan,
>>>>>
>>>>> thanks for your reply.
>>>>>
>>>>> after some code tracking, i found it failed at this point :
>>>>> in file leveldb/db/db_impl.cc  --> NewDB()
>>>>>
>>>>> log::Writer log(file);
>>>>>      std::string record;
>>>>>      new_db.EncodeTo(&record);
>>>>>      s = log.AddRecord(record);
>>>>>      if (s.ok()) {
>>>>>        fprintf(test, "NewDB: 2\n");
>>>>>        s = file->Close();
>>>>>      }else
>>>>>        fprintf(test, "NewDB: 2.5\n");
>>>>>
>>>>> the log.AddRecord return s which is not ok().
>>>>>
>>>>> can you provide some hint why it fails?  i am reading the AddRecord()
>>>>> function now.
>>>>
>>>>
>>>> LevelDB is a generic library which we don't develop. My understanding
>>>> is that it's expected to work on any POSIX-compliant filesystem, but
>>>> you can check out the docs
>>>> (http://leveldb.googlecode.com/svn/trunk/doc/index.html) or source
>>>> code for more info.
>>>> -Greg
>>>
>>>
>>>
>>>
>>
>
>
>
> --
> Sheng Qiu
> Texas A & M University
> Room 332B Wisenbaker
> email: herbert1984106@gmail.com
> College Station, TX 77843-3259



-- 
Sheng Qiu
Texas A & M University
Room 332B Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
