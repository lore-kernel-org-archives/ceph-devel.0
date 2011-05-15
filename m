From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: Re: Segfault when creating new cluster
Date: Sun, 15 May 2011 08:59:39 -0500
Message-ID: <316e3ce8aebc72567c343c8117bbedc0@pl1.haspere.com>
References: <ec24b6e7f09a0ceec38a82e9e0165c40@pl1.haspere.com>
Reply-To: <YS3fpFE2ykfB@dyweni.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_3e4c42bebbe98b13b2792510e8ecceda"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([208.111.35.220]:40673 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617Ab1EON7j (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 15 May 2011 09:59:39 -0400
In-Reply-To: <ec24b6e7f09a0ceec38a82e9e0165c40@pl1.haspere.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: YS3fpFE2ykfB@dyweni.com
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

--=_3e4c42bebbe98b13b2792510e8ecceda
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8;
 format=flowed

 Hi List!

 I have tracked down the bad commit to 
 de640d85fa3e0e5e5a31704eab5a8714a1ffe867.

 I have also created a patch that fixes this error on my test cluster.  
 I am attaching it here for peer-review.

 ---
 Thanks,
 Dyweni



 On Sat, 14 May 2011 19:17:42 -0500, Dyweni - Ceph-Devel wrote:

> Hi List!
>
> When creating a brand new cluster, I get the following segmentation
> fault:
>
> === osd.2 ===
> pushing conf and monmap to ceph2
> Warning: Permanently added 'ceph2' (ECDSA) to the list of known 
> hosts.
> umount: /data/osd2: not mounted
> umount: /dev/sda: not mounted
>
> WARNING! - Btrfs Btrfs v0.19 IS EXPERIMENTAL
> WARNING! - see http://btrfs.wiki.kernel.org [1] before using
>
> fs created label (null) on /dev/sda
> nodesize 4096 leafsize 4096 sectorsize 4096 size 74.53GB
> Btrfs Btrfs v0.19
> Scanning for Btrfs filesystems
> ** WARNING: Ceph is still under development. Any feedback can be
> directed **
> ** at ceph-devel@vger.kernel.org [2] or
> http://ceph.newdream.net/ [3]. **
> *** Caught signal (Segmentation fault) **
> in thread 0xb70f2b30
> ceph version 0.27.1-401-g6af0379
> (commit:6af0379e27ac71a7abd8c9ebb0145ae8b9f66cc4)
> 1: (ceph::BackTrace::BackTrace(int)+0x1f) [0x8465fcf]
> 2: /usr/bin/cosd() [0x84d8844]
> 3: [0xb77f1400]
> 4: (pthread_spin_lock()+0x6) [0xb77c38d6]
> 5: (ceph::Spinlock::lock()+0x20) [0x82e42e8]
> 6: (ceph::atomic_t::dec()+0x12) [0x82e4418]
> 7: (RefCountedObject::put()+0x15) [0x82e48d9]
> 8: (MonClient::get_monmap_privately()+0x5f2) [0x84c81ec]
> 9: (main()+0x976) [0x82e0cce]
> 10: (__libc_start_main()+0xd9) [0xb7109ba9]
> 11: /usr/bin/cosd() [0x82e0101]
> /usr/sbin/mkcephfs: line 239: 859 Segmentation fault (core
> dumped) $BINDIR/cosd -c $conf --monmap $dir/monmap -i $id --mkfs
> failed: 'ssh ceph2 /usr/sbin/mkcephfs -d /tmp/mkcephfs.6ySmaVjdFm
> --init-daemon osd.2'
>
> Here is the GDB backtrace:
>
> (gdb) bt
> #0 0xb77c6d6f in raise () from /lib/libpthread.so.0
> #1 0x084d870f in reraise_fatal (signum=11) at common/signal.cc:63
> #2 0x084d88ce in handle_fatal_signal (signum=11) at
> common/signal.cc:110
> #3
> #4 0xb77c38d6 in pthread_spin_lock () from /lib/libpthread.so.0
> #5 0x082e42e8 in ceph::Spinlock::lock (this=0x4) at
> include/Spinlock.h:97
> #6 0x082e4418 in ceph::atomic_t::dec (this=0x4) at 
> include/atomic.h:75
> #7 0x082e48d9 in RefCountedObject::put (this=0x0) at 
> msg/Message.h:160
> #8 0x084c81ec in MonClient::get_monmap_privately (this=0xbf81baf4) at
> mon/MonClient.cc:230
> #9 0x082e0cce in main (argc=8, argv=0xbf81c1f4) at cosd.cc:130
>
> My kernel is:
> Linux version 2.6.39-rc7-git5-20110514-0905 (root@phenom) (gcc 
> version
> 4.4.5 (Gentoo 4.4.5 p1.2, pie-0.4.5) ) #1 SMP Sat May 14 09:07:07 CDT
> 2011
>
> --
> Thanks,
> Dyweni
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in
> the body of a message to majordomo@vger.kernel.org [4]
> More majordomo info at http://vger.kernel.org/majordomo-info.html [5]


--=_3e4c42bebbe98b13b2792510e8ecceda
Content-Transfer-Encoding: base64
Content-Type: text/plain;
 name=0001-fix-segfault-introduced-by-commit-de640d85fa3e0e5e5a.patch
Content-Disposition: attachment;
 filename=0001-fix-segfault-introduced-by-commit-de640d85fa3e0e5e5a.patch

RnJvbSBhY2Y4NmYyMWQzYzExZThlZGQ4MjY5MmE0ZmEyN2E1Yjg4YzUzOGIwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiByb290IDxyb290QHBoZW5vbS5keXdlbmkuY29tPgpEYXRlOiBT
dW4sIDE1IE1heSAyMDExIDA4OjU0OjEzIC0wNTAwClN1YmplY3Q6IFtQQVRDSF0gZml4IHNlZ2Zh
dWx0IGludHJvZHVjZWQgYnkgY29tbWl0IGRlNjQwZDg1ZmEzZTBlNWU1YTMxNzA0ZWFiNWE4NzE0
YTFmZmU4NjcKClRoYXQgY29tbWl0IGludHJvZHVjZXMgdGhlIGxpbmUgJ2N1cl9jb24tPnB1dCgp
JyB3aGljaCBoYXMgdGhlIHBvc3NpYmlsaXR5Cm9mIGJlaW5nIGNhbGxlZCB3aGlsZSBjdXJfY29u
IGlzIG5vdCBpbml0aWFsaXplZC4KLS0tCiBzcmMvbW9uL01vbkNsaWVudC5jYyB8ICAgIDYgKysr
Ky0tCiAxIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9zcmMvbW9uL01vbkNsaWVudC5jYyBiL3NyYy9tb24vTW9uQ2xpZW50LmNjCmlu
ZGV4IDcwZTE0ZTkuLjk3MDdkZmUgMTAwNjQ0Ci0tLSBhL3NyYy9tb24vTW9uQ2xpZW50LmNjCisr
KyBiL3NyYy9tb24vTW9uQ2xpZW50LmNjCkBAIC0yMjcsOCArMjI3LDEwIEBAIGludCBNb25DbGll
bnQ6OmdldF9tb25tYXBfcHJpdmF0ZWx5KCkKICAgaHVudGluZyA9IHRydWU7ICAvLyByZXNldCB0
aGlzIHRvIHRydWUhCiAgIGN1cl9tb24uY2xlYXIoKTsKIAotICBjdXJfY29uLT5wdXQoKTsKLSAg
Y3VyX2NvbiA9IE5VTEw7CisgIGlmIChjdXJfY29uKSB7CisgICAgY3VyX2Nvbi0+cHV0KCk7Cisg
ICAgY3VyX2NvbiA9IE5VTEw7CisgIH0KIAogICBpZiAobW9ubWFwLmVwb2NoKQogICAgIHJldHVy
biAwOwotLSAKMS43LjMuNAoK
--=_3e4c42bebbe98b13b2792510e8ecceda--

