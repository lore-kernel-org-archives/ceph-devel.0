From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 09/10] fs: ceph: Replace CURRENT_TIME by
	ktime_get_real_ts()
Date: Tue,  2 Feb 2016 22:07:49 -0800
Message-ID: <1454479670-8204-10-git-send-email-deepa.kernel@gmail.com>
References: <1454479670-8204-1-git-send-email-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <1454479670-8204-1-git-send-email-deepa.kernel@gmail.com>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org
Cc: Theodore Ts'o <tytso@mit.edu>, Sage Weil <sage@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

VGhpcyBpcyBpbiBwcmVwYXJhdGlvbiBmb3IgdGhlIHNlcmllcyB0aGF0IHRyYW5zaXRpb25zCmZp
bGVzeXN0ZW0gdGltZXN0YW1wcyB0byB1c2UgNjQgYml0IHRpbWUgYW5kIGhlbmNlIG1ha2UKdGhl
bSB5MjAzOCBzYWZlLgoKQ1VSUkVOVF9USU1FIG1hY3JvIHdpbGwgYmUgZGVsZXRlZCBiZWZvcmUg
bWVyZ2luZyB0aGUKYWZvcmVtZW50aW9uZWQgc2VyaWVzLgoKRmlsZXN5c3RlbXMgd2lsbCB1c2Ug
Y3VycmVudF9mc190aW1lKCkgaW5zdGVhZCBvZgpDVVJSRU5UX1RJTUUuClVzZSBrdGltZV9nZXRf
cmVhbF90cygpIGhlcmUgYXMgdGhpcyBpcyBub3QgZmlsZXN5c3RlbSB0aW1lLgprdGltZV9nZXRf
cmVhbF90cygpIHJldHVybnMgdGhlIHRpbWVzdGFtcCBpbiBucyB3aGljaCBjYW4KYmUgdXNlZCB0
byBjYWxjdWxhdGUgTURTIHJlcXVlc3QgdGltZXN0YW1wLgoKU2lnbmVkLW9mZi1ieTogRGVlcGEg
RGluYW1hbmkgPGRlZXBhLmtlcm5lbEBnbWFpbC5jb20+CkNjOiAiWWFuLCBaaGVuZyIgPHp5YW5A
cmVkaGF0LmNvbT4KQ2M6IFNhZ2UgV2VpbCA8c2FnZUByZWRoYXQuY29tPgpDYzogSWx5YSBEcnlv
bW92IDxpZHJ5b21vdkBnbWFpbC5jb20+CkNjOiBjZXBoLWRldmVsQHZnZXIua2VybmVsLm9yZwot
LS0KIGZzL2NlcGgvbWRzX2NsaWVudC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMvY2VwaC9tZHNfY2xpZW50LmMg
Yi9mcy9jZXBoL21kc19jbGllbnQuYwppbmRleCBlN2IxMzBhLi4zNDhiMjJlIDEwMDY0NAotLS0g
YS9mcy9jZXBoL21kc19jbGllbnQuYworKysgYi9mcy9jZXBoL21kc19jbGllbnQuYwpAQCAtMTcy
MSw3ICsxNzIxLDcgQEAgY2VwaF9tZHNjX2NyZWF0ZV9yZXF1ZXN0KHN0cnVjdCBjZXBoX21kc19j
bGllbnQgKm1kc2MsIGludCBvcCwgaW50IG1vZGUpCiAJaW5pdF9jb21wbGV0aW9uKCZyZXEtPnJf
c2FmZV9jb21wbGV0aW9uKTsKIAlJTklUX0xJU1RfSEVBRCgmcmVxLT5yX3Vuc2FmZV9pdGVtKTsK
IAotCXJlcS0+cl9zdGFtcCA9IENVUlJFTlRfVElNRTsKKwlrdGltZV9nZXRfcmVhbF90cygmcmVx
LT5yX3N0YW1wKTsKIAogCXJlcS0+cl9vcCA9IG9wOwogCXJlcS0+cl9kaXJlY3RfbW9kZSA9IG1v
ZGU7Ci0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KWTIwMzggbWFpbGluZyBsaXN0ClkyMDM4QGxpc3RzLmxpbmFyby5vcmcKaHR0cHM6Ly9s
aXN0cy5saW5hcm8ub3JnL21haWxtYW4vbGlzdGluZm8veTIwMzgK
