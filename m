From: Jojy Varghese <jojy.varghese@gmail.com>
Subject: [PATCH] build: Fixed install-deps
Date: Tue, 27 Jan 2015 17:42:59 -0800
Message-ID: <CAJD3hpWT4mvEAkYm5byJ8sf0XDv=rM-ULYGnetwQQ8fq-LjOwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a113ffd40cc1da7050dac7d96
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:43694 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933642AbbA1BnA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jan 2015 20:43:00 -0500
Received: by mail-ie0-f171.google.com with SMTP id tr6so18957784ieb.2
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jan 2015 17:42:59 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

--001a113ffd40cc1da7050dac7d96
Content-Type: text/plain; charset=ISO-8859-1

    Running install-deps causes LC_ALL to be set to C#. This is unintentional
    behaviour due to the comment being joined with the bash statement.

    Change:
    Added the missing newline before comment.


Jojy G Varghese

--001a113ffd40cc1da7050dac7d96
Content-Type: text/x-patch; charset=US-ASCII; name="0001-build-Fixed-install-deps.patch"
Content-Disposition: attachment;
	filename="0001-build-Fixed-install-deps.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i5g1te4p0

RnJvbSBiODg5ZDhlY2FjNDNjNzBkNDMxNDcxMDhmYjlkOGVhODRiZDYyYzExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2p5IEcgVmFyZ2hlc2UgPGpvankudmFyZ2hlc2VAZ21haWwu
Y29tPgpEYXRlOiBUdWUsIDI3IEphbiAyMDE1IDE3OjA3OjM2IC0wODAwClN1YmplY3Q6IFtQQVRD
SF0gYnVpbGQ6IEZpeGVkIGluc3RhbGwtZGVwcwoKCVJ1bm5pbmcgaW5zdGFsbC1kZXBzIGNhdXNl
cyBMQ19BTEwgdG8gYmUgc2V0IHRvIEMjLiBUaGlzIGlzIHVuaW50ZW50aW9uYWwKICAgIGJlaGF2
aW91ciBkdWUgdG8gdGhlIGNvbW1lbnQgYmVpbmcgam9pbmVkIHdpdGggdGhlIGJhc2ggc3RhdGVt
ZW50LgoKICAgIENoYW5nZToKICAgIEFkZGVkIHRoZSBtaXNzaW5nIG5ld2xpbmUgYmVmb3JlIGNv
bW1lbnQuCgpTaWduZWQtb2ZmLWJ5OiBKb2p5IEcgVmFyZ2hlc2UgPGpvankudmFyZ2hlc2VAZ21h
aWwuY29tPgotLS0KIGluc3RhbGwtZGVwcy5zaCB8ICAgIDMgKystCiAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW5zdGFsbC1kZXBz
LnNoIGIvaW5zdGFsbC1kZXBzLnNoCmluZGV4IDdlYWIwMjkuLjA2ZTkyZmYgMTAwNzU1Ci0tLSBh
L2luc3RhbGwtZGVwcy5zaAorKysgYi9pbnN0YWxsLWRlcHMuc2gKQEAgLTE3LDcgKzE3LDggQEAg
bWtkaXIgLXAgJERJUgogaWYgdGVzdCAkKGlkIC11KSAhPSAwIDsgdGhlbgogICAgIFNVRE89c3Vk
bwogZmkKLWV4cG9ydCBMQ19BTEw9QyMgdGhlIGZvbGxvd2luZyBpcyB2dWxuZXJhYmxlIHRvIGkx
OG4KK2V4cG9ydCBMQ19BTEw9QworIyB0aGUgZm9sbG93aW5nIGlzIHZ1bG5lcmFibGUgdG8gaTE4
bgogY2FzZSAkKGxzYl9yZWxlYXNlIC1zaSkgaW4KIFVidW50dXxEZWJpYW58RGV2dWFuKQogICAg
ICAgICAkU1VETyBhcHQtZ2V0IGluc3RhbGwgLXkgZHBrZy1kZXYKLS0gCjEuNy45LjUKCg==
--001a113ffd40cc1da7050dac7d96--
