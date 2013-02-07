From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph mkfs failed
Date: Thu, 7 Feb 2013 12:53:19 -0800
Message-ID: <CAPYLRzjeNZn+aYwtcij0YddYX=Fpd=xY5+QrveaNNMXCL4bLUw@mail.gmail.com>
References: <CAB7xdi=5q-e7FEXjrf524as4FPW-pM4z9wDrCm7boPVTr7sVLg@mail.gmail.com>
	<51140CFF.8000207@inktank.com>
	<CAB7xdimctzpk8qeRLJqxxeNRJEFpc2EpVHd37qj0E-OCeBP13A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:52155 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab3BGUxU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 15:53:20 -0500
Received: by mail-qa0-f50.google.com with SMTP id dx4so30706qab.16
        for <ceph-devel@vger.kernel.org>; Thu, 07 Feb 2013 12:53:19 -0800 (PST)
In-Reply-To: <CAB7xdimctzpk8qeRLJqxxeNRJEFpc2EpVHd37qj0E-OCeBP13A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: Dan Mick <dan.mick@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Feb 7, 2013 at 12:42 PM, sheng qiu <herbert1984106@gmail.com> wrote:
> Hi Dan,
>
> thanks for your reply.
>
> after some code tracking, i found it failed at this point :
> in file leveldb/db/db_impl.cc  --> NewDB()
>
> log::Writer log(file);
>     std::string record;
>     new_db.EncodeTo(&record);
>     s = log.AddRecord(record);
>     if (s.ok()) {
>       fprintf(test, "NewDB: 2\n");
>       s = file->Close();
>     }else
>       fprintf(test, "NewDB: 2.5\n");
>
> the log.AddRecord return s which is not ok().
>
> can you provide some hint why it fails?  i am reading the AddRecord()
> function now.

LevelDB is a generic library which we don't develop. My understanding
is that it's expected to work on any POSIX-compliant filesystem, but
you can check out the docs
(http://leveldb.googlecode.com/svn/trunk/doc/index.html) or source
code for more info.
-Greg
