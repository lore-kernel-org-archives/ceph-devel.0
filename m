From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: ceph mkfs failed
Date: Thu, 7 Feb 2013 16:11:11 -0600
Message-ID: <CAB7xdin+Ow_KE1EgNSK6PG4EDSKgO=DSjFJBpBVKjL-Rd5wehA@mail.gmail.com>
References: <CAB7xdi=5q-e7FEXjrf524as4FPW-pM4z9wDrCm7boPVTr7sVLg@mail.gmail.com>
	<51140CFF.8000207@inktank.com>
	<CAB7xdimctzpk8qeRLJqxxeNRJEFpc2EpVHd37qj0E-OCeBP13A@mail.gmail.com>
	<CAPYLRzjeNZn+aYwtcij0YddYX=Fpd=xY5+QrveaNNMXCL4bLUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:54375 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422651Ab3BGWLM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 17:11:12 -0500
Received: by mail-ie0-f176.google.com with SMTP id k13so4200212iea.35
        for <ceph-devel@vger.kernel.org>; Thu, 07 Feb 2013 14:11:11 -0800 (PST)
In-Reply-To: <CAPYLRzjeNZn+aYwtcij0YddYX=Fpd=xY5+QrveaNNMXCL4bLUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Is it possible comment the leveldb setup codes during mkfs call path?
i find the problem is because i am trying to use a bunch of memory as
the OSD, when the leveldb mmap() the file on OSD, it failed, as the
file actually located on memory.

Thanks,
Sheng

On Thu, Feb 7, 2013 at 2:53 PM, Gregory Farnum <greg@inktank.com> wrote:
> On Thu, Feb 7, 2013 at 12:42 PM, sheng qiu <herbert1984106@gmail.com> wrote:
>> Hi Dan,
>>
>> thanks for your reply.
>>
>> after some code tracking, i found it failed at this point :
>> in file leveldb/db/db_impl.cc  --> NewDB()
>>
>> log::Writer log(file);
>>     std::string record;
>>     new_db.EncodeTo(&record);
>>     s = log.AddRecord(record);
>>     if (s.ok()) {
>>       fprintf(test, "NewDB: 2\n");
>>       s = file->Close();
>>     }else
>>       fprintf(test, "NewDB: 2.5\n");
>>
>> the log.AddRecord return s which is not ok().
>>
>> can you provide some hint why it fails?  i am reading the AddRecord()
>> function now.
>
> LevelDB is a generic library which we don't develop. My understanding
> is that it's expected to work on any POSIX-compliant filesystem, but
> you can check out the docs
> (http://leveldb.googlecode.com/svn/trunk/doc/index.html) or source
> code for more info.
> -Greg



-- 
Sheng Qiu
Texas A & M University
Room 332B Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
