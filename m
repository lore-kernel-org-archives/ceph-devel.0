From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: Intermittent Assert Failure
Date: Wed, 7 Dec 2011 21:54:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112072153430.2448@cobra.newdream.net>
References: <4EE0490E.2000205@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44281 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab1LHFyo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2011 00:54:44 -0500
In-Reply-To: <4EE0490E.2000205@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org, John Ralston <jralston@ucsc.edu>

On Wed, 7 Dec 2011, Noah Watkins wrote:
> Stack trace from a simple Ceph client that does nothing more than open a file
> and call ceph_read(...) on it.

This just looks like a crash we've periodically been seeing in qa, but 
haven't been able to reproduce with logging (or diagnose from the cores).

I did some cleanup in Client::unmount() and rearranged some stuff.  Can 
you see if it still happens with the latest master?

Thanks!
sage



> 
> - Noah
> 
> Hey,
> I just wanted to note that I got this failure occasionally when I was running
> ceph_read on issdm-29
> 
> @issdm-29:~$ time ./ceph_read /etc/ceph/ceph.conf /john.1gb.bin
> client/Client.cc: In function 'void Client::put_inode(Inode*, int)', in thread
> '7fbccb1ea760'
> client/Client.cc: 1763: FAILED assert(!unclean)
>  ceph version 0.38-259-gd4aef20
> (commit:d4aef20210d43e25eefe945009e6f77d5b045381)
>  1: (Client::put_inode(Inode*, int)+0x615) [0x7fbccabe0455]
>  2: (Client::unlink(Dentry*, bool)+0x27d) [0x7fbccabe1fed]
>  3: (Client::trim_dentry(Dentry*)+0x73) [0x7fbccabe31a3]
>  4: (Client::trim_cache()+0x215) [0x7fbccabe3585]
>  5: (Client::unmount()+0x4d4) [0x7fbccac06474]
>  6: (ceph_shutdown()+0x79) [0x7fbccabd00e9]
>  7: ./ceph_read() [0x400e3e]
>  8: (__libc_start_main()+0xfe) [0x7fbcca7fcd8e]
>  9: ./ceph_read() [0x400a69]
>  ceph version 0.38-259-gd4aef20
> (commit:d4aef20210d43e25eefe945009e6f77d5b045381)
>  1: (Client::put_inode(Inode*, int)+0x615) [0x7fbccabe0455]
>  2: (Client::unlink(Dentry*, bool)+0x27d) [0x7fbccabe1fed]
>  3: (Client::trim_dentry(Dentry*)+0x73) [0x7fbccabe31a3]
>  4: (Client::trim_cache()+0x215) [0x7fbccabe3585]
>  5: (Client::unmount()+0x4d4) [0x7fbccac06474]
>  6: (ceph_shutdown()+0x79) [0x7fbccabd00e9]
>  7: ./ceph_read() [0x400e3e]
>  8: (__libc_start_main()+0xfe) [0x7fbcca7fcd8e]
>  9: ./ceph_read() [0x400a69]
> terminate called after throwing an instance of 'ceph::FailedAssertion'
> Aborted
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
