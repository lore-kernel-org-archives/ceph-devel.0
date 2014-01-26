From: Dominik Mostowiec <dominikmostowiec@gmail.com>
Subject: Re: many meta files in osd
Date: Sun, 26 Jan 2014 21:59:45 +0100
Message-ID: <CAMNMNTzXETisGUHmEGd5z9NCjU-k_fmFU7Dctgn32b33vHbTyQ@mail.gmail.com>
References: <CAMNMNTw3OM-aoUAOAEJcN5BqsrL+4S79Ha20=xt5wE_56Jd5_w@mail.gmail.com>
	<CAMNMNTzUA-xbGrQnw_aq2XtUhpQcvo4qf1YBJrqk=sP1zKzMDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:51044 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbaAZU7q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Jan 2014 15:59:46 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp4so5709709obc.11
        for <ceph-devel@vger.kernel.org>; Sun, 26 Jan 2014 12:59:46 -0800 (PST)
In-Reply-To: <CAMNMNTzUA-xbGrQnw_aq2XtUhpQcvo4qf1YBJrqk=sP1zKzMDw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,
It is safe to remove this files
> rados -p .rgw ls | grep '.bucket.meta.my_deleted_bucket:'
for deleted bucket via
rados -p .rgw rm .bucket.meta.my_deleted_bucket:default.4576.1

I have a problem with eaten inodes on disks where is many of such files.

--
Regards
Dominik

2013-12-10 Dominik Mostowiec <dominikmostowiec@gmail.com>:
> Is there any posibility to remove this meta files? (whithout recreate cluster)
> Files names:
> {path}.bucket.meta.test1:default.4110.{sequence number}__head_...
>
> --
> Regards
> Dominik
>
> 2013/12/8 Dominik Mostowiec <dominikmostowiec@gmail.com>:
>> Hi,
>> My api app to put files to s3/ceph checks if bucket exists by create
>> this bucket.
>> Each bucket create command adds 2 meta files.
>>
>> -----
>> root@vm-1:/vol0/ceph/osd# find | grep meta | grep test1 | wc -l
>> 44
>> root@vm-1:/vol0/ceph/osd# s3 -u create test1
>> Bucket successfully created.
>> root@vm-1:/vol0/ceph/osd# find | grep meta | grep test1 | wc -l
>> 46
>> -----
>>
>> Unfortunately:
>> -----
>> root@vm-1:/vol0/ceph/osd# s3 -u delete test1
>> root@vm-1:/vol0/ceph/osd# find | grep meta | grep test1 | wc -l
>> 46
>> -----
>>
>> Is there some way to remove this meta files from ceph?
>>
>> --
>> Regards
>> Dominik
>
>
>
> --
> Pozdrawiam
> Dominik



-- 
Pozdrawiam
Dominik
