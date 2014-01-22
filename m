From: Haomai Wang <haomai@unitedstack.com>
Subject: [RFC]About GenericObjectMap in KeyValueStore
Date: Wed, 22 Jan 2014 10:39:53 +0800
Message-ID: <DBFF7C56-99B9-4648-BE3C-09EE7D7A1FDC@unitedstack.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:61126 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619AbaAVCkk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jan 2014 21:40:40 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so9194831pbb.17
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jan 2014 18:40:39 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

KeyValueStore is a implementation of ObjectStore which use KeyValueDB as main
data access interface. It discard FileJournal and reply to the backend of
KeyValueDB to get the atomic of transaction.

KeyValueStore make a object composed of multi key/value pair in the side of
KeyValueDB. Much like DBObjectMap, each object has a header to manage the
metadata such as size, bitmap.

As I mentioned in previous mail, DBObjectMap has some defect in KeyValueStore.
GenericObjectMap is aimed to provide more generic KeyValueDB wrapper. The main
differences between GenericObjectMap and DBObjectMap contains:
1. add "coll_t" field to the key of header
2. expose Header to successor and all write operations are accessed via header
3. expose key prefix to caller

I think point 2 is the primary change may confuse. KeyValueStore use
GenericObjectMap to implement ObjectStore interfaces. it will combine all
operations in the same transaction and apply in to the time. Like
OSDMap::Incremental, here we need to make the former operation visible to the
following operations in the same transaction. The header and data
created/modified should be know by the following operations. So
GenericObjectMap will expose "header" to caller among write operations.

StripObjectMap is the successor of GenericObjectMap and used by KeyValueStore
directly. It encapsulate the interface of GenericObjectMap and make more
suitable for KeyValueStore.

Best regards,
Haomai Wang, UnitedStack Inc.

