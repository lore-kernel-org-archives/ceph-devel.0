From: David Zafman <dzafman@gmail.com>
Subject: xattr limits
Date: Thu, 3 Oct 2013 16:21:49 -0700
Message-ID: <C1F9D079-3D19-4A39-872A-0CAF8EA3866F@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:51391 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab3JCXVy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Oct 2013 19:21:54 -0400
Received: by mail-oa0-f51.google.com with SMTP id h16so3080386oag.24
        for <ceph-devel@vger.kernel.org>; Thu, 03 Oct 2013 16:21:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


I want to record with the ceph-devel archive results from testing limit=
s of xattrs for Linux filesystems used with Ceph.

Script that creates xattrs with name user.test1, user.test2, =85. on a =
single file
3.10 linux kernel

ext4 =20
value bytes       number of entries
    1               148
   16             103
  256          14
  512            7
  1024         3
4036          1=20
Beyond this immediately get ENOSPC

btrfs   =20
value bytes       number of entries
 8       		 10k
16       		10k
32        		 10k
64        		 10k
128     		 10k
256       		 10k
512        		10k  slow but worked 1,000,000 got completely hung for min=
utes at a time during removal strace showed no forward progress
1024        	 10k
2048        	 10k
 3096          	 10k
Beyond this you start getting ENOSPC after fewer entries

xfs (limit entries due to xfs crash with 10k entries)
value bytes       number of entries
1   			1k
8   			 1k
16   			 1k
32  			 1k
64   		        1k
128   		 1k
256 			1k
512  		 1k
1024 		1k
2048  		 1k
4096   		 1k
8192   		 1k
16384   		 1k
32768   		 1k
65536   		 1k

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
