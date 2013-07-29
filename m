From: Patrick McGarry <patrick@inktank.com>
Subject: Fwd: [ceph-users] Small fix for ceph.spec
Date: Mon, 29 Jul 2013 19:33:18 -0400
Message-ID: <CAP8Oy=KD4au7aaOqo1t6zvWP1JFnTtQELd8YunxXqyBaE4+wpg@mail.gmail.com>
References: <51F6F595.605@logtenberg.eu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec53050e1cf3f7804e2aeea41
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:47634 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab3G2XdT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jul 2013 19:33:19 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so5948921pad.37
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jul 2013 16:33:18 -0700 (PDT)
In-Reply-To: <51F6F595.605@logtenberg.eu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>

--bcaec53050e1cf3f7804e2aeea41
Content-Type: text/plain; charset=ISO-8859-1

---------- Forwarded message ----------
From: Erik Logtenberg <erik@logtenberg.eu>
Date: Mon, Jul 29, 2013 at 7:07 PM
Subject: [ceph-users] Small fix for ceph.spec
To: ceph-users@lists.ceph.com


Hi,

The spec file used for building rpm's misses a build time dependency on
snappy-devel. Please see attached patch to fix.

Kind regards,

Erik.

_______________________________________________
ceph-users mailing list
ceph-users@lists.ceph.com
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--bcaec53050e1cf3f7804e2aeea41
Content-Type: text/x-patch; charset=US-ASCII; name="require-snappy-devel.patch"
Content-Disposition: attachment; filename="require-snappy-devel.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: abe371e6e77e1bc7_0.1

LS0tIGNlcGguc3BlYy1vcmlnCTIwMTMtMDctMzAgMDA6MjQ6NTQuNzA1MDAwMDAwICswMjAwDQor
KysgY2VwaC5zcGVjCTIwMTMtMDctMzAgMDA6MjU6MzQuMTk5MDAwMDAwICswMjAwDQpAQCAtNDIs
NiArNDIsNyBAQA0KIEJ1aWxkUmVxdWlyZXM6ICBsaWJ4bWwyLWRldmVsDQogQnVpbGRSZXF1aXJl
czogIGxpYnV1aWQtZGV2ZWwNCiBCdWlsZFJlcXVpcmVzOiAgbGV2ZWxkYi1kZXZlbCA+IDEuMg0K
K0J1aWxkUmVxdWlyZXM6ICBzbmFwcHktZGV2ZWwNCiANCiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMNCiAjIHNwZWNpZmljDQo=
--bcaec53050e1cf3f7804e2aeea41--
