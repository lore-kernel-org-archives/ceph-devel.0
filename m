From: Javen Wu <javen.wu@xtaotech.com>
Subject: Is BlueFS an alternative of BlueStore?
Date: Thu, 7 Jan 2016 12:01:55 +0800
Message-ID: <568DE333.7070206@xtaotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr213139.mail.yeah.net ([223.252.213.139]:44906 "EHLO
	mr213139.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbcAGEIj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jan 2016 23:08:39 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@redhat.com
Cc: Peng Xie <peng.hse@xtaotech.com>, ceph-devel@vger.kernel.org

Hi Sage,

Sorry to bother you. I am not sure if it is appropriate to send email to 
you
directly, but I cannot find any useful information to address my confusion
from Internet. Hope you can help me.

Occasionally, I heard that you are going to start BlueFS to eliminate the
redudancy between XFS journal and RocksDB WAL. I am a little confused.
Is the Bluefs only to host RocksDB for BlueStore or it's an
alternative of BlueStore?

I am a new comer to CEPH, I am not sure my understanding is correct about
BlueStore. BlueStore in my mind is as below.

              BlueStore
              =========
    RocksDB
+-----------+          +-----------+
|   onode   |          |           |
|    WAL    |          |           |
|   omap    |          |           |
+-----------+          |   bdev    |
|           |          |           |
|   XFS     |          |           |
|           |          |           |
+-----------+          +-----------+

I am curious if BlueFS is able to host RocksDB, actually it's already a
"filesystem" which have to maintain blockmap kind of metadata by its own
WITHOUT the help of RocksDB. When BlueFS is introduced into the picture,
why RocksDB is needed yet? So I guess BlueFS is an alternative of BlueStore
and it's a new ObjectStore without leveraging RocksDB.

Is my understanding correct?

The reason we care the intention and the design target of BlueFS is that 
I had
discussion with my partner Peng.Hse about an idea to introduce a new
ObjectStore using ZFS library. I know CEPH supports ZFS as FileStore 
backend
already, but we had a different immature idea to use libzpool to 
implement a new
ObjectStore for CEPH totally in userspace without SPL and ZOL kernel 
module.
So that we can align CEPH transaction and zfs transaction in order to  
avoid
double write for CEPH journal.
ZFS core part libzpool (DMU, metaslab etc) offers a dnode object store and
it's platform kernel/user independent. Another benefit for the idea is we
can extend our metadata without bothering any DBStore.

Frankly, we are not sure if our idea is realistic so far, but when I 
heard of
BlueFS, I think we need to know the BlueFS design goal.

Thanks
Javen
