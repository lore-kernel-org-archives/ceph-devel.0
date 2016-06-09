From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 12/21] block: rbd: Replace non inode CURRENT_TIME
	with current_fs_time()
Date: Wed,  8 Jun 2016 22:04:56 -0700
Message-ID: <1465448705-25055-13-git-send-email-deepa.kernel@gmail.com>
References: <1465448705-25055-1-git-send-email-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <y2038-bounces@lists.linaro.org>
In-Reply-To: <1465448705-25055-1-git-send-email-deepa.kernel@gmail.com>
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
Cc: Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org, ceph-devel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ilya Dryomov <idryomov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

Q1VSUkVOVF9USU1FIG1hY3JvIGlzIG5vdCBhcHByb3ByaWF0ZSBmb3IgZmlsZXN5c3RlbXMgYXMg
aXQKZG9lc24ndCB1c2UgdGhlIHJpZ2h0IGdyYW51bGFyaXR5IGZvciBmaWxlc3lzdGVtIHRpbWVz
dGFtcHMuClVzZSBjdXJyZW50X2ZzX3RpbWUoKSBpbnN0ZWFkLgoKVGhpcyBpcyBhbHNvIGluIHBy
ZXBhcmF0aW9uIGZvciB0aGUgcGF0Y2ggdGhhdCB0cmFuc2l0aW9ucwp2ZnMgdGltZXN0YW1wcyB0
byB1c2UgNjQgYml0IHRpbWUgYW5kIGhlbmNlIG1ha2UgdGhlbQp5MjAzOCBzYWZlLiBBcyBwYXJ0
IG9mIHRoZSBlZmZvcnQgY3VycmVudF9mc190aW1lKCkgd2lsbCBiZQpleHRlbmRlZCB0byBkbyBy
YW5nZSBjaGVja3MuIEhlbmNlLCBpdCBpcyBuZWNlc3NhcnkgZm9yIGFsbApmaWxlIHN5c3RlbSB0
aW1lc3RhbXBzIHRvIHVzZSBjdXJyZW50X2ZzX3RpbWUoKS4KClNpZ25lZC1vZmYtYnk6IERlZXBh
IERpbmFtYW5pIDxkZWVwYS5rZXJuZWxAZ21haWwuY29tPgpDYzogSWx5YSBEcnlvbW92IDxpZHJ5
b21vdkBnbWFpbC5jb20+CkNjOiBTYWdlIFdlaWwgPHNhZ2VAcmVkaGF0LmNvbT4KQ2M6IEFsZXgg
RWxkZXIgPGVsZGVyQGtlcm5lbC5vcmc+CkNjOiBjZXBoLWRldmVsQHZnZXIua2VybmVsLm9yZwot
LS0KIGRyaXZlcnMvYmxvY2svcmJkLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL3JiZC5jIGIv
ZHJpdmVycy9ibG9jay9yYmQuYwppbmRleCA4MTY2NmE1Li40ZGNhZmU0IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2Jsb2NrL3JiZC5jCisrKyBiL2RyaXZlcnMvYmxvY2svcmJkLmMKQEAgLTE4ODgsNyAr
MTg4OCw3IEBAIHN0YXRpYyB2b2lkIHJiZF9vc2RfcmVxX2Zvcm1hdF93cml0ZShzdHJ1Y3QgcmJk
X29ial9yZXF1ZXN0ICpvYmpfcmVxdWVzdCkKIHsKIAlzdHJ1Y3QgY2VwaF9vc2RfcmVxdWVzdCAq
b3NkX3JlcSA9IG9ial9yZXF1ZXN0LT5vc2RfcmVxOwogCi0Jb3NkX3JlcS0+cl9tdGltZSA9IENV
UlJFTlRfVElNRTsKKwlvc2RfcmVxLT5yX210aW1lID0gY3VycmVudF9mc190aW1lKG9zZF9yZXEt
PnJfaW5vZGUtPmlfc2IpOwogCW9zZF9yZXEtPnJfZGF0YV9vZmZzZXQgPSBvYmpfcmVxdWVzdC0+
b2Zmc2V0OwogfQogCi0tIAoxLjkuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KWTIwMzggbWFpbGluZyBsaXN0ClkyMDM4QGxpc3RzLmxpbmFyby5vcmcK
aHR0cHM6Ly9saXN0cy5saW5hcm8ub3JnL21haWxtYW4vbGlzdGluZm8veTIwMzgK
