From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v2 20/24] block: Replace CURRENT_TIME with
	ktime_get_real_ts
Date: Sun, 19 Jun 2016 17:27:19 -0700
Message-ID: <1466382443-11063-21-git-send-email-deepa.kernel@gmail.com>
References: <1466382443-11063-1-git-send-email-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <1466382443-11063-1-git-send-email-deepa.kernel@gmail.com>
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
b2ZmLWJ5OiBEZWVwYSBEaW5hbWFuaSA8ZGVlcGEua2VybmVsQGdtYWlsLmNvbT4KQ2M6IElseWEg
RHJ5b21vdiA8aWRyeW9tb3ZAZ21haWwuY29tPgpDYzogU2FnZSBXZWlsIDxzYWdlQHJlZGhhdC5j
b20+CkNjOiBBbGV4IEVsZGVyIDxlbGRlckBrZXJuZWwub3JnPgpDYzogY2VwaC1kZXZlbEB2Z2Vy
Lmtlcm5lbC5vcmcKLS0tCiBkcml2ZXJzL2Jsb2NrL3JiZC5jIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9i
bG9jay9yYmQuYyBiL2RyaXZlcnMvYmxvY2svcmJkLmMKaW5kZXggNDUwNjYyMC4uMTQ4NjdhYiAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ibG9jay9yYmQuYworKysgYi9kcml2ZXJzL2Jsb2NrL3JiZC5j
CkBAIC0xODg4LDcgKzE4ODgsNyBAQCBzdGF0aWMgdm9pZCByYmRfb3NkX3JlcV9mb3JtYXRfd3Jp
dGUoc3RydWN0IHJiZF9vYmpfcmVxdWVzdCAqb2JqX3JlcXVlc3QpCiB7CiAJc3RydWN0IGNlcGhf
b3NkX3JlcXVlc3QgKm9zZF9yZXEgPSBvYmpfcmVxdWVzdC0+b3NkX3JlcTsKIAotCW9zZF9yZXEt
PnJfbXRpbWUgPSBDVVJSRU5UX1RJTUU7CisJa3RpbWVfZ2V0X3JlYWxfdHMoJm9zZF9yZXEtPnJf
bXRpbWUpOwogCW9zZF9yZXEtPnJfZGF0YV9vZmZzZXQgPSBvYmpfcmVxdWVzdC0+b2Zmc2V0Owog
fQogCi0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KWTIwMzggbWFpbGluZyBsaXN0ClkyMDM4QGxpc3RzLmxpbmFyby5vcmcKaHR0cHM6Ly9s
aXN0cy5saW5hcm8ub3JnL21haWxtYW4vbGlzdGluZm8veTIwMzgK
