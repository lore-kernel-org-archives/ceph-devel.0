From: Jojy Varghese <jojy.varghese@gmail.com>
Subject: [PATCH 3/3] mds:Interval tree
Date: Tue, 11 Oct 2011 23:50:40 -0700
Message-ID: <CAJD3hpVD0JEtZhFzB+4qQWcbBSkMzZCGTAocdt4YAUDvKLukVw@mail.gmail.com>
References: <CAJD3hpWY0F-qg05Tgzy5twpcqJSQXAcAEs_yv7qTzFTxAWW33w@mail.gmail.com>
	<CAJD3hpU=n3E7TU07L4JWUXajaDoZ5bKdo37Q3jNebsomJQd82g@mail.gmail.com>
	<Pine.LNX.4.64.1110081700050.26432@cobra.newdream.net>
	<CAJD3hpU5XSjiOVmXnt31KYuQhU12yBJfSaMHLhKu+rTGTGJfUg@mail.gmail.com>
	<Pine.LNX.4.64.1110110842430.20977@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504501466737d4e104af14714e
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52496 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681Ab1JLGul (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Oct 2011 02:50:41 -0400
Received: by gyb13 with SMTP id 13so382227gyb.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Oct 2011 23:50:40 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1110110842430.20977@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

--00504501466737d4e104af14714e
Content-Type: text/plain; charset=UTF-8

Hi
  This patch part is the change to Makefile for unit test integration.

     Signed-off-by: Jojy George Varghese <jvarghese@scalecomputing.com>

thanks,
-Jojy

--00504501466737d4e104af14714e
Content-Type: text/x-patch; charset=US-ASCII;
	name="0003-makefile-changes-for-interval-tree.patch"
Content-Disposition: attachment;
	filename="0003-makefile-changes-for-interval-tree.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gtnyle3n1

RnJvbSA0NzZiYWIzOTJkZGU0ODk5MDk4YjA3ZDVkYzA2OTJkOTY2OTY0ZmYxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2p5IEdlb3JnZSBWYXJnaGVzZSA8anZhcmdoZXNlQHNjYWxl
Y29tcHV0aW5nLmNvbT4KRGF0ZTogVHVlLCAxMSBPY3QgMjAxMSAyMzo0NzoxMCAtMDcwMApTdWJq
ZWN0OiBbUEFUQ0hdWyAzLzNdIG1ha2VmaWxlIGNoYW5nZXMgZm9yIGludGVydmFsIHRyZWUKIAlB
ZGRlZCB1bml0IHRlc3QgY2FzZSBmb3IgaW50ZXJ2YWwgdHJlZSB0byB0aGUKIG1ha2VmaWxlIHRl
bXBsYXRlLgoKU2lnbmVkLW9mZi1ieTogSm9qeSBHZW9yZ2UgVmFyZ2hlc2UgPGp2YXJnaGVzZUBz
Y2FsZWNvbXB1dGluZy5jb20+Ci0tLQogc3JjL01ha2VmaWxlLmFtIHwgICAgNSArKysrKwogMSBm
aWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvc3JjL01ha2VmaWxlLmFtIGIvc3JjL01ha2VmaWxlLmFtCmluZGV4IGUxYTc0MDAuLjNiMDBj
NDkgMTAwNjQ0Ci0tLSBhL3NyYy9NYWtlZmlsZS5hbQorKysgYi9zcmMvTWFrZWZpbGUuYW0KQEAg
LTU3MSw2ICs1NzEsMTEgQEAgdW5pdHRlc3RfbGlicmd3X0NYWEZMQUdTID0gJHtDUllQVE9fQ0ZM
QUdTfSAke0FNX0NYWEZMQUdTfSAke1VOSVRURVNUX0NYWEZMQUdTfQogY2hlY2tfUFJPR1JBTVMg
Kz0gdW5pdHRlc3RfbGlicmd3CiBlbmRpZgogCit1bml0dGVzdF9pbnRlcnZhbF90cmVlX1NPVVJD
RVMgPSB0ZXN0L1Rlc3RJbnRlcnZhbFRyZWUuY2MKK3VuaXR0ZXN0X2ludGVydmFsX3RyZWVfTERB
REQgPSAke1VOSVRURVNUX0xEQUREfSAkKExJQkdMT0JBTF9MREEpCit1bml0dGVzdF9pbnRlcnZh
bF90cmVlX0NYWEZMQUdTID0gJHtBTV9DWFhGTEFHU30gJHtVTklUVEVTVF9DWFhGTEFHU30KK2No
ZWNrX1BST0dSQU1TICs9IHVuaXR0ZXN0X2ludGVydmFsX3RyZWUKKwogdGVzdF9saWJyYmRfU09V
UkNFUyA9IHRlc3QvdGVzdF9saWJyYmQuY2MKIHRlc3RfbGlicmJkX0xEQUREID0gIGxpYnJiZC5s
YSBsaWJyYWRvcy5sYSAke1VOSVRURVNUX1NUQVRJQ19MREFERH0KIHRlc3RfbGlicmJkX0NYWEZM
QUdTID0gJHtBTV9DWFhGTEFHU30gJHtVTklUVEVTVF9DWFhGTEFHU30KLS0gCjEuNy4wLjQKCg==
--00504501466737d4e104af14714e--
