From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v4 21/26] block: Replace CURRENT_TIME with
	ktime_get_real_ts
Date: Sat, 13 Aug 2016 15:48:33 -0700
Message-ID: <1471128518-24075-22-git-send-email-deepa.kernel@gmail.com>
References: <1471128518-24075-1-git-send-email-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <1471128518-24075-1-git-send-email-deepa.kernel@gmail.com>
List-Unsubscribe: <https://lists.linaro.org/mailman/options/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/y2038/>
List-Post: <mailto:y2038@lists.linaro.org>
List-Help: <mailto:y2038-request@lists.linaro.org?subject=help>
List-Subscribe: <https://lists.linaro.org/mailman/listinfo/y2038>,
 <mailto:y2038-request@lists.linaro.org?subject=subscribe>
Errors-To: y2038-bounces@lists.linaro.org
Sender: "Y2038" <y2038-bounces@lists.linaro.org>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Elder <elder@kernel.org>, tytso@mit.edu, Sage Weil <sage@redhat.com>, arnd@arndb.de, y2038@lists.linaro.org, ceph-devel@vger.kernel.org, viro@zeniv.linux.org.uk, tglx@linutronix.de, torvalds@linux-foundation.org, Ilya Dryomov <idryomov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

Q1VSUkVOVF9USU1FIGlzIG5vdCB5MjAzOCBzYWZlLgpUaGUgbWFjcm8gd2lsbCBiZSBkZWxldGVk
IGFuZCBhbGwgdGhlIHJlZmVyZW5jZXMgdG8gaXQKd2lsbCBiZSByZXBsYWNlZCBieSBrdGltZV9n
ZXRfKiBhcGlzLgoKc3RydWN0IHRpbWVzcGVjIGlzIGFsc28gbm90IHkyMDM4IHNhZmUuClJldGFp
biB0aW1lc3BlYyBmb3IgdGltZXN0YW1wIHJlcHJlc2VudGF0aW9uIGhlcmUgYXMgY2VwaAp1c2Vz
IGl0IGludGVybmFsbHkgZXZlcnl3aGVyZS4KVGhlc2UgcmVmZXJlbmNlcyB3aWxsIGJlIGNoYW5n
ZWQgdG8gdXNlIHN0cnVjdCB0aW1lc3BlYzY0CmluIGEgc2VwYXJhdGUgcGF0Y2guCgpTaWduZWQt
b2ZmLWJ5OiBEZWVwYSBEaW5hbWFuaSA8ZGVlcGEua2VybmVsQGdtYWlsLmNvbT4KUmV2aWV3ZWQt
Ynk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+CkNjOiBJbHlhIERyeW9tb3YgPGlkcnlv
bW92QGdtYWlsLmNvbT4KQ2M6IFNhZ2UgV2VpbCA8c2FnZUByZWRoYXQuY29tPgpDYzogQWxleCBF
bGRlciA8ZWxkZXJAa2VybmVsLm9yZz4KQ2M6IGNlcGgtZGV2ZWxAdmdlci5rZXJuZWwub3JnCi0t
LQogZHJpdmVycy9ibG9jay9yYmQuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svcmJkLmMgYi9k
cml2ZXJzL2Jsb2NrL3JiZC5jCmluZGV4IDZjNjUxOWYuLmU1YjEyMGUgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvYmxvY2svcmJkLmMKKysrIGIvZHJpdmVycy9ibG9jay9yYmQuYwpAQCAtMTg4OCw3ICsx
ODg4LDcgQEAgc3RhdGljIHZvaWQgcmJkX29zZF9yZXFfZm9ybWF0X3dyaXRlKHN0cnVjdCByYmRf
b2JqX3JlcXVlc3QgKm9ial9yZXF1ZXN0KQogewogCXN0cnVjdCBjZXBoX29zZF9yZXF1ZXN0ICpv
c2RfcmVxID0gb2JqX3JlcXVlc3QtPm9zZF9yZXE7CiAKLQlvc2RfcmVxLT5yX210aW1lID0gQ1VS
UkVOVF9USU1FOworCWt0aW1lX2dldF9yZWFsX3RzKCZvc2RfcmVxLT5yX210aW1lKTsKIAlvc2Rf
cmVxLT5yX2RhdGFfb2Zmc2V0ID0gb2JqX3JlcXVlc3QtPm9mZnNldDsKIH0KIAotLSAKMS45LjEK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClkyMDM4IG1h
aWxpbmcgbGlzdApZMjAzOEBsaXN0cy5saW5hcm8ub3JnCmh0dHBzOi8vbGlzdHMubGluYXJvLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3kyMDM4Cg==
