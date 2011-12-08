From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Fwd: Intermittent Assert Failure
Date: Wed, 07 Dec 2011 21:20:14 -0800
Message-ID: <4EE0490E.2000205@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:55144 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab1LHFUY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2011 00:20:24 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: John Ralston <jralston@ucsc.edu>

Stack trace from a simple Ceph client that does nothing more than open a 
file and call ceph_read(...) on it.

- Noah

Hey,
I just wanted to note that I got this failure occasionally when I was 
running ceph_read on issdm-29

@issdm-29:~$ time ./ceph_read /etc/ceph/ceph.conf /john.1gb.bin
client/Client.cc: In function 'void Client::put_inode(Inode*, int)', in 
thread '7fbccb1ea760'
client/Client.cc: 1763: FAILED assert(!unclean)
  ceph version 0.38-259-gd4aef20 
(commit:d4aef20210d43e25eefe945009e6f77d5b045381)
  1: (Client::put_inode(Inode*, int)+0x615) [0x7fbccabe0455]
  2: (Client::unlink(Dentry*, bool)+0x27d) [0x7fbccabe1fed]
  3: (Client::trim_dentry(Dentry*)+0x73) [0x7fbccabe31a3]
  4: (Client::trim_cache()+0x215) [0x7fbccabe3585]
  5: (Client::unmount()+0x4d4) [0x7fbccac06474]
  6: (ceph_shutdown()+0x79) [0x7fbccabd00e9]
  7: ./ceph_read() [0x400e3e]
  8: (__libc_start_main()+0xfe) [0x7fbcca7fcd8e]
  9: ./ceph_read() [0x400a69]
  ceph version 0.38-259-gd4aef20 
(commit:d4aef20210d43e25eefe945009e6f77d5b045381)
  1: (Client::put_inode(Inode*, int)+0x615) [0x7fbccabe0455]
  2: (Client::unlink(Dentry*, bool)+0x27d) [0x7fbccabe1fed]
  3: (Client::trim_dentry(Dentry*)+0x73) [0x7fbccabe31a3]
  4: (Client::trim_cache()+0x215) [0x7fbccabe3585]
  5: (Client::unmount()+0x4d4) [0x7fbccac06474]
  6: (ceph_shutdown()+0x79) [0x7fbccabd00e9]
  7: ./ceph_read() [0x400e3e]
  8: (__libc_start_main()+0xfe) [0x7fbcca7fcd8e]
  9: ./ceph_read() [0x400a69]
terminate called after throwing an instance of 'ceph::FailedAssertion'
Aborted

