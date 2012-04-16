From: Joe Buck <jbbuck@gmail.com>
Subject: Re: Intermittent Assert Failure
Date: Mon, 16 Apr 2012 11:33:32 -0700
Message-ID: <C976503C-9FC5-4F62-8C19-4B4B92112912@gmail.com>
References: <4EE0490E.2000205@cs.ucsc.edu> <Pine.LNX.4.64.1112072153430.2448@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33736 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab2DPSdg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Apr 2012 14:33:36 -0400
Received: by pbcun15 with SMTP id un15so6663510pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Apr 2012 11:33:35 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1112072153430.2448@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel@vger.kernel.org, John Ralston <jralston@ucsc.edu>

Sage,

With the 0.45 build of ceph, we're still seeing this. It seems to happen to about 10% of the tasks that spin up when we launch a MapReduce job. 

I can reproduce this pretty reliably. What log files would be useful?

-Joe Buck

On Dec 7, 2011, at 9:54 PM, Sage Weil wrote:

> On Wed, 7 Dec 2011, Noah Watkins wrote:
>> Stack trace from a simple Ceph client that does nothing more than open a file
>> and call ceph_read(...) on it.
> 
> This just looks like a crash we've periodically been seeing in qa, but 
> haven't been able to reproduce with logging (or diagnose from the cores).
> 
> I did some cleanup in Client::unmount() and rearranged some stuff.  Can 
> you see if it still happens with the latest master?
> 
> Thanks!
> sage
> 
> 
> 
>> 
>> - Noah
>> 
>> Hey,
>> I just wanted to note that I got this failure occasionally when I was running
>> ceph_read on issdm-29
>> 
>> @issdm-29:~$ time ./ceph_read /etc/ceph/ceph.conf /john.1gb.bin
>> client/Client.cc: In function 'void Client::put_inode(Inode*, int)', in thread
>> '7fbccb1ea760'
>> client/Client.cc: 1763: FAILED assert(!unclean)
>> ceph version 0.38-259-gd4aef20
>> (commit:d4aef20210d43e25eefe945009e6f77d5b045381)
>> 1: (Client::put_inode(Inode*, int)+0x615) [0x7fbccabe0455]
>> 2: (Client::unlink(Dentry*, bool)+0x27d) [0x7fbccabe1fed]
>> 3: (Client::trim_dentry(Dentry*)+0x73) [0x7fbccabe31a3]
>> 4: (Client::trim_cache()+0x215) [0x7fbccabe3585]
>> 5: (Client::unmount()+0x4d4) [0x7fbccac06474]
>> 6: (ceph_shutdown()+0x79) [0x7fbccabd00e9]
>> 7: ./ceph_read() [0x400e3e]
>> 8: (__libc_start_main()+0xfe) [0x7fbcca7fcd8e]
>> 9: ./ceph_read() [0x400a69]
>> ceph version 0.38-259-gd4aef20
>> (commit:d4aef20210d43e25eefe945009e6f77d5b045381)
>> 1: (Client::put_inode(Inode*, int)+0x615) [0x7fbccabe0455]
>> 2: (Client::unlink(Dentry*, bool)+0x27d) [0x7fbccabe1fed]
>> 3: (Client::trim_dentry(Dentry*)+0x73) [0x7fbccabe31a3]
>> 4: (Client::trim_cache()+0x215) [0x7fbccabe3585]
>> 5: (Client::unmount()+0x4d4) [0x7fbccac06474]
>> 6: (ceph_shutdown()+0x79) [0x7fbccabd00e9]
>> 7: ./ceph_read() [0x400e3e]
>> 8: (__libc_start_main()+0xfe) [0x7fbcca7fcd8e]
>> 9: ./ceph_read() [0x400a69]
>> terminate called after throwing an instance of 'ceph::FailedAssertion'
>> Aborted
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

