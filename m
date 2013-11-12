From: Li Wang <liwang@ubuntukylin.com>
Subject: [RFC] Ceph encryption support
Date: Tue, 12 Nov 2013 22:10:31 +0800
Message-ID: <528236D7.6020106@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:58563 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361Ab3KLOKe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Nov 2013 09:10:34 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Hi,
   We want to implement encryption support for Ceph.
   Currently, we have the draft design,

1 When user mount a ceph directory for the first time, he can specify a 
passphrase and the encryption algorithm and length of key etc. These 
will be stored as extend attribute of the current root directory, of 
course, with the passphrase being hashed several times, call it TOKEN.
2 When user try to mount an encrypted directory, a passphrase is 
required to given, then hash and compare with the stored TOKEN, if 
equal, accept to mount, otherwise reject to mount.
3 When a file is created, a random key (FEK, file encryption key) is 
generated, and this key is encrypted by TOKEN, we get EFEK (encrypted 
FEK), the EFEK and other encryption related information inherited from 
the root directory are stored in the extend attribute of file.
4 When a file is opened, retrieve the extend attribute, we get EFEK,
use TOKEN to decrypt EFEK, get FEK, buffered in the inode
5 When a file is read in readpage()/readpages(), the encrypted pages are 
decrypted transparently by using FEK, and the plain data are sent to 
application
6 When a file is written in writepage()/writepages(), the pages are 
encrypted transparently by using FEK, and then written to OSDs.

Some points,
1 We do client side encryption, the advantages are,
   (1) The data over network are encrypted;
   (2) OSDs are intended to do io intensive job, we donot wanna bother 
them to do cpu intensive job, thus we can use cheap and low power machines
   (3) The implementation is OSD transparent, and mostly MDS 
transparent, enjoys the simplification.
2 What about if no page cache?
   Block cipher algorithm is more secure than stream cipher algorithm, 
so we prefer the former. If no page cache, we have two choices, with 
encryption enabled, the same file is not allowed by opened by the second 
writer, alternatively, we enforce O_LAZYIO on the file, but application 
is supposed to be aware of this.

We plan to submit it as a blueprint for the incoming CDS, comments are 
welcome.

Cheers,
Li Wang
