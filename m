From: Yang Joseph <joseph.yang@xtaotech.com>
Subject: rgw: bug#17111 ERROR: got unexpected error when trying to read
 object: -2
Date: Wed, 14 Sep 2016 11:33:52 +0800
Message-ID: <57D8C520.9020102@xtaotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr213138.mail.yeah.net ([223.252.213.138]:11761 "EHLO
        mr213138.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756826AbcINDd4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Sep 2016 23:33:56 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: owasserm@redhat.com
Cc: yehuda@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>

Hello Oritwas,

I am aware of that you are responsible for the issue 17111 
(http://tracker.ceph.com/issues/17111).
Actually, I proposed two fixes already. Could you please take a look at 
them?

1. 
https://github.com/ceph/ceph/pull/10820/commits/2e95e2c824c6cc829c39180b0f6809ff312e5892

In this proposal, I added two items into manifest :

src_instance
copied_object

"copied_object" is used to indicate whether this object is generated 
through COPY operation.
If so, we must overwrite "instance" with "src_instance" in the GET 
operation.
If not, go as before.

We don't need extra tools to fix the old object's manifest that created 
before this patch, because
copied_object's default value is false.

2. 
https://github.com/ceph/ceph/pull/10820/commits/5104f852d255cfc140be33885f696b7f93a6cfad

This is an optimized version.  Only src_instance is added to manifest.
In order to distinguish object generated through COPY operation from 
object generated through
PUT operation, I make the none copied object's src_instance equal to its 
instance value.
So if src_instance not equal to its instance, this is a copied object.

However, this proposal need an extra tool to migrate old objects to new 
version RGW with this patch.

Your comments are highly appreciated!

thx,

Yang Honggang

