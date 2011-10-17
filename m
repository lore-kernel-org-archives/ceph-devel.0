From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: how to run ceph on top of other local file system
Date: Mon, 17 Oct 2011 12:20:10 -0500
Message-ID: <CAB7xdim9QmtLWSVTrPoZofrwY=0PQEzsxtcBjA=pgS-GzLgzAw@mail.gmail.com>
References: <CAB7xdikWPdZ4RaLRvqpMhUdkOS6=99ggdx3iBidBkbWy3k5vOg@mail.gmail.com>
	<CAORUGqBnqHOJp_wy3QOi=2LUy3Tbi+6PoaA4sTgUeSPqzDCZyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62155 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab1JQRUL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Oct 2011 13:20:11 -0400
Received: by mail-iy0-f174.google.com with SMTP id k3so6443871iae.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Oct 2011 10:20:11 -0700 (PDT)
In-Reply-To: <CAORUGqBnqHOJp_wy3QOi=2LUy3Tbi+6PoaA4sTgUeSPqzDCZyw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

hi Tommi,

if my local file system does not support extended attributes, can i
use it?  for example, i have mounted my local file system on
/mnt/data/osd.0, when i configure this directory as the osd.0 in the
ceph.conf, it shows error like cannot write osd object into the
directory. how can i fix this?

Thanks,
Sheng

On Mon, Oct 17, 2011 at 12:13 PM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Mon, Oct 17, 2011 at 10:10, sheng qiu <herbert1984106@gmail.com> wrote:
>> Hi all,
>>
>> i am new here. i want to use ceph to build a DFS. while i see, ceph
>> can only use ext3/4 and btreefs to manage the osd. how can i modify it
>> to support other local file system?
>
> Ceph works with any POSIX-compliant filesystem that supports extended
> attributes. It can also use just a subdirectory of an existing
> filesystem.
>



-- 
Sheng Qiu
Texas A & M University
Room 302 Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
