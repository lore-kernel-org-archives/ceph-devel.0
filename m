From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ceph: fix message length computation
Date: Wed, 30 Sep 2015 15:04:42 +0200
Message-ID: <9959810.KasB66Ks40@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: ceph-devel@vger.kernel.org
Cc: y2038@lists.linaro.org, "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, linux-kernel@vger.kernel.org, Sage Weil <sage@redhat.com>
List-Id: ceph-devel.vger.kernel.org

Y3JlYXRlX3JlcXVlc3RfbWVzc2FnZSgpIGNvbXB1dGVzIHRoZSBtYXhpbXVtIGxlbmd0aCBvZiBh
IG1lc3NhZ2UsCmJ1dCB1c2VzIHRoZSB3cm9uZyB0eXBlIGZvciB0aGUgdGltZSBzdGFtcDogc2l6
ZW9mKHN0cnVjdCB0aW1lc3BlYykKbWF5IGJlIDggb3IgMTYgZGVwZW5kaW5nIG9uIHRoZSBhcmNo
aXRlY3R1cmUsIHdoaWxlIHNpemVvZihzdHJ1Y3QKY2VwaF90aW1lc3BlYykgaXMgYWx3YXlzIDgs
IGFuZCB0aGF0IGlzIHdoYXQgZ2V0cyBwdXQgaW50byB0aGUKbWVzc2FnZS4KCkZvdW5kIHdoaWxl
IGF1ZGl0aW5nIHRoZSB1c2VzIG9mIHRpbWVzcGVjIGZvciB5MjAzOCBwcm9ibGVtcy4KClNpZ25l
ZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+CkZpeGVzOiBiOGU2OTA2NmQ4
YWYgKCJjZXBoOiBpbmNsdWRlIHRpbWUgc3RhbXAgaW4gZXZlcnkgTURTIHJlcXVlc3QiKQotLS0K
ZGlmZiAtLWdpdCBhL2ZzL2NlcGgvbWRzX2NsaWVudC5jIGIvZnMvY2VwaC9tZHNfY2xpZW50LmMK
aW5kZXggNTFjYjAyZGE3NWQ5Li5mZTJjOTgyNzY0ZTcgMTAwNjQ0Ci0tLSBhL2ZzL2NlcGgvbWRz
X2NsaWVudC5jCisrKyBiL2ZzL2NlcGgvbWRzX2NsaWVudC5jCkBAIC0xOTM1LDcgKzE5MzUsNyBA
QCBzdGF0aWMgc3RydWN0IGNlcGhfbXNnICpjcmVhdGVfcmVxdWVzdF9tZXNzYWdlKHN0cnVjdCBj
ZXBoX21kc19jbGllbnQgKm1kc2MsCiAKIAlsZW4gPSBzaXplb2YoKmhlYWQpICsKIAkJcGF0aGxl
bjEgKyBwYXRobGVuMiArIDIqKDEgKyBzaXplb2YodTMyKSArIHNpemVvZih1NjQpKSArCi0JCXNp
emVvZihzdHJ1Y3QgdGltZXNwZWMpOworCQlzaXplb2Yoc3RydWN0IGNlcGhfdGltZXNwZWMpOwog
CiAJLyogY2FsY3VsYXRlIChtYXgpIGxlbmd0aCBmb3IgY2FwIHJlbGVhc2VzICovCiAJbGVuICs9
IHNpemVvZihzdHJ1Y3QgY2VwaF9tZHNfcmVxdWVzdF9yZWxlYXNlKSAqCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpZMjAzOCBtYWlsaW5nIGxpc3QKWTIw
MzhAbGlzdHMubGluYXJvLm9yZwpodHRwczovL2xpc3RzLmxpbmFyby5vcmcvbWFpbG1hbi9saXN0
aW5mby95MjAzOAo=
