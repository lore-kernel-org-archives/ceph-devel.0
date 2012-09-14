From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: safe to defrag XFS on live system?
Date: Fri, 14 Sep 2012 10:15:00 -0700
Message-ID: <50536614.8030707@inktank.com>
References: <CACkq2moNPAopPQ1KRSd_v0Dm6wrkV3xS-2X-qWgu=BP98rSKCg@mail.gmail.com> <CADvuQREvqUG0Xe7gf_LMtXsvZMxX88TT7imi8Cfj2ihA0s+VeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56434 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759076Ab2INRPF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Sep 2012 13:15:05 -0400
Received: by dady13 with SMTP id y13so2540063dad.19
        for <ceph-devel@vger.kernel.org>; Fri, 14 Sep 2012 10:15:03 -0700 (PDT)
In-Reply-To: <CADvuQREvqUG0Xe7gf_LMtXsvZMxX88TT7imi8Cfj2ihA0s+VeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Travis Rhoden <trhoden@gmail.com>, ceph-devel@vger.kernel.org

On 09/14/2012 10:06 AM, Tommi Virtanen wrote:
> On Fri, Sep 14, 2012 at 8:51 AM, Travis Rhoden <trhoden@gmail.com> wrote:
>> On a running Ceph cluster using XFS for the OSD's, is it safe to
>> defrag the OSD devices while the system is live?
>>
>> I did a quick check of one device:
>>
>> xfs_db -c frag -r /dev/sdd
>> actual 637596, ideal 144935, fragmentation factor 77.27%
>
> If it's safe to defrag xfs while it's mounted in general, it's safe to
> do it when an OSD is running. Xfs either keeps its promises as a
> filesystem, or doesn't.
>
> How that affects performance is another question..
>
>> While I'm talking about XFS...  I know that RBD's use a default object
>> size of 4MB.  I've stuck with that so far..  Would it be beneficial to
>> mount XFS with -o allocsize=4M ?  What is the object size that gets
>> used for non-RBD cases -- i.e. just dumping objects into data pool?
>
> Don't know about -o allocsize -- benchmark it!
>
> Objects are the size they are; Ceph does not dictate any size. RBD and
> CephFS both stripe a thing (image/file) over multiple objects, at a
> constant size; you already know that, RBD defaults to 4MB. Other users
> of RADOS create objects of any size they please, and an OSD stores
> those as files in the underlying filesystem.

Also keep in mind that objects can be sparse - the 4MB stripe size
doesn't mean the full 4MB are used by an object in CephFS or RBD.

