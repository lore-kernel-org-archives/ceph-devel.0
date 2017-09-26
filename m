From: Jeff Layton <jlayton@redhat.com>
Subject: lingering caps outstanding after client shutdown?
Date: Tue, 26 Sep 2017 09:24:49 -0400
Message-ID: <1506432289.3182.16.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-zPTl2u9wO7gFM6X2mKhQ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:47400 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934627AbdIZNYx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Sep 2017 09:24:53 -0400
Received: by mail-qk0-f174.google.com with SMTP id b82so9993850qkc.4
        for <ceph-devel@vger.kernel.org>; Tue, 26 Sep 2017 06:24:52 -0700 (PDT)
Received: from redhat-78.nfsv4bat.org ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id s16sm6708195qks.63.2017.09.26.06.24.50
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Sep 2017 06:24:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "open list:CEPH DISTRIBUTED..." <ceph-devel@vger.kernel.org>


--=-zPTl2u9wO7gFM6X2mKhQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

In order to get the correct semantics for a delegation or oplock, we
need to be able to break delegations on open. Cephfs' open routine is
pretty light with the caps though.

One way to fix that is to request a enough caps to cause a delegation
break if any are outstanding. So, I've been playing with the attached
patch. It may be wrong and not what we want, but it seems like it ought
to work.

This patch however causes the LibCephFS.Fchmod test to hang, waiting on
caps, iff the DoubleChmod test is run before it. If you run just Fchmod
test, it works fine. They both use the same filename and hence the same
inode.

The test hangs at the first Fchmod test ceph_open call, waiting for the
caps. At that point though, there should be no other clients accessing
the mount. Is it possible that outstanding caps granted to the client
from the earlier test could be surviving a ceph_shutdown, such that it
blocks the next client from getting them?

To reproduce I've been running this on a build with the attached patch
vs. a vstart cluster:

    $ ./bin/ceph_test_libcephfs --gtest_filter=LibCephFS.DoubleChmod:LibCephFS.Fchmod

I'll continue to dig into this, but I'm starting to wonder if this is
exposing a bug in the mds. Should I open a tracker bug on this?
-- 
Jeff Layton <jlayton@redhat.com>
--=-zPTl2u9wO7gFM6X2mKhQ
Content-Disposition: attachment; filename="0001-client-request-caps-on-open.patch"
Content-Type: text/x-patch; name="0001-client-request-caps-on-open.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA2ZjJkNTYyZjA2NTI5NjMxMjM1YmVhMDJiODIxZjgzYTFhM2QwZTczIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKZWZmcmV5IExheXRvbiA8amxheXRvbkBjZXJlcy5wb29jaGll
cmVkcy5uZXQ+CkRhdGU6IE1vbiwgMjUgU2VwIDIwMTcgMTU6MDk6NDggLTA0MDAKU3ViamVjdDog
W1BBVENIXSBjbGllbnQ6IHJlcXVlc3QgY2FwcyBvbiBvcGVuCgpTaWduZWQtb2ZmLWJ5OiBKZWZm
IExheXRvbiA8amxheXRvbkByZWRoYXQuY29tPgotLS0KIHNyYy9jbGllbnQvQ2xpZW50LmNjIHwg
MTYgKysrKysrKysrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc3JjL2NsaWVudC9DbGllbnQuY2MgYi9zcmMvY2xp
ZW50L0NsaWVudC5jYwppbmRleCA3ODUxN2M4MDhhLi5mZmU4NzdmZGY4IDEwMDY0NAotLS0gYS9z
cmMvY2xpZW50L0NsaWVudC5jYworKysgYi9zcmMvY2xpZW50L0NsaWVudC5jYwpAQCAtODQyNSwx
MSArODQyNSwyMiBAQCBpbnQgQ2xpZW50Ojpfb3BlbihJbm9kZSAqaW4sIGludCBmbGFncywgbW9k
ZV90IG1vZGUsIEZoICoqZmhwLAogCiAgIGluLT5nZXRfb3Blbl9yZWYoY21vZGUpOyAgLy8gbWFr
ZSBub3RlIG9mIHBlbmRpbmcgb3Blbiwgc2luY2UgaXQgZWZmZWN0cyBfd2FudGVkXyBjYXBzLgog
Ci0gIGlmICgoZmxhZ3MgJiBPX1RSVU5DKSA9PSAwICYmCi0gICAgICBpbi0+Y2Fwc19pc3N1ZWRf
bWFzayh3YW50KSkgeworICBpZiAoKGZsYWdzICYgT19UUlVOQykgPT0gMCAmJiBpbi0+Y2Fwc19p
c3N1ZWRfbWFzayh3YW50KSkgewogICAgIC8vIHVwZGF0ZSB3YW50ZWQ/CiAgICAgY2hlY2tfY2Fw
cyhpbiwgQ0hFQ0tfQ0FQU19OT0RFTEFZKTsKICAgfSBlbHNlIHsKKyAgICBpbnQgbmVlZCA9IDAs
IGhhdmU7CisKKyAgICAvKiBXYWl0IG9uIG1pbmltYWwgY2FwcywganVzdCB0byBicmVhayBkZWxl
Z2F0aW9ucyAqLworICAgIGlmIChjbW9kZSAmIENFUEhfRklMRV9NT0RFX1dSKQorICAgICAgbmVl
ZCB8PSBDRVBIX0NBUF9GSUxFX1dSOworICAgIGlmIChjbW9kZSAmIENFUEhfRklMRV9NT0RFX1JE
KQorICAgICAgbmVlZCB8PSBDRVBIX0NBUF9GSUxFX1JEOworCisgICAgcmVzdWx0ID0gZ2V0X2Nh
cHMoaW4sIG5lZWQsIHdhbnQsICZoYXZlLCAtMSk7CisgICAgaWYgKHJlc3VsdCA8IDApCisgICAg
ICByZXR1cm4gcmVzdWx0OworCiAgICAgTWV0YVJlcXVlc3QgKnJlcSA9IG5ldyBNZXRhUmVxdWVz
dChDRVBIX01EU19PUF9PUEVOKTsKICAgICBmaWxlcGF0aCBwYXRoOwogICAgIGluLT5tYWtlX25v
c25hcF9yZWxhdGl2ZV9wYXRoKHBhdGgpOwpAQCAtODQ0NCw2ICs4NDU1LDcgQEAgaW50IENsaWVu
dDo6X29wZW4oSW5vZGUgKmluLCBpbnQgZmxhZ3MsIG1vZGVfdCBtb2RlLCBGaCAqKmZocCwKICAg
ICByZXEtPmhlYWQuYXJncy5vcGVuLm9sZF9zaXplID0gaW4tPnNpemU7ICAgLy8gZm9yIE9fVFJV
TkMKICAgICByZXEtPnNldF9pbm9kZShpbik7CiAgICAgcmVzdWx0ID0gbWFrZV9yZXF1ZXN0KHJl
cSwgcGVybXMpOworICAgIHB1dF9jYXBfcmVmKGluLCBuZWVkKTsKICAgfQogCiAgIC8vIHN1Y2Nl
c3M/Ci0tIAoyLjEzLjUKCg==


--=-zPTl2u9wO7gFM6X2mKhQ--

