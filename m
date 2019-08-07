From: john.hubbard@gmail.com
Subject: [PATCH v3 07/41] drm/etnaviv: convert release_pages() to
 put_user_pages()
Date: Tue,  6 Aug 2019 18:33:06 -0700
Message-ID: <20190807013340.9706-8-jhubbard@nvidia.com>
References: <20190807013340.9706-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20190807013340.9706-1-jhubbard@nvidia.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, "H . Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Borislav
List-Id: ceph-devel.vger.kernel.org

RnJvbTogSm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlkaWEuY29tPgoKRm9yIHBhZ2VzIHRoYXQg
d2VyZSByZXRhaW5lZCB2aWEgZ2V0X3VzZXJfcGFnZXMqKCksIHJlbGVhc2UgdGhvc2UgcGFnZXMK
dmlhIHRoZSBuZXcgcHV0X3VzZXJfcGFnZSooKSByb3V0aW5lcywgaW5zdGVhZCBvZiB2aWEgcHV0
X3BhZ2UoKSBvcgpyZWxlYXNlX3BhZ2VzKCkuCgpUaGlzIGlzIHBhcnQgYSB0cmVlLXdpZGUgY29u
dmVyc2lvbiwgYXMgZGVzY3JpYmVkIGluIGNvbW1pdCBmYzFkOGU3Y2NhMmQKKCJtbTogaW50cm9k
dWNlIHB1dF91c2VyX3BhZ2UqKCksIHBsYWNlaG9sZGVyIHZlcnNpb25zIikuCgpDYzogSm9lcmcg
Um9lZGVsIDxqb3JvQDhieXRlcy5vcmc+CkNjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRo
YXQuY29tPgpDYzogUmFkaW0gS3LEjW3DocWZIDxya3JjbWFyQHJlZGhhdC5jb20+CkNjOiBUaG9t
YXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0By
ZWRoYXQuY29tPgpDYzogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+CkNjOiBILiBQZXRl
ciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4KQ2M6IHg4NkBrZXJuZWwub3JnCkNjOiBrdm1Admdlci5r
ZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEpvaG4gSHViYmFyZCA8amh1YmJhcmRAbnZpZGlhLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vZXRuYXZpdi9ldG5hdml2X2dlbS5jIHwgNCArKy0tCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9ldG5hdml2L2V0bmF2aXZfZ2VtLmMgYi9kcml2ZXJzL2dwdS9k
cm0vZXRuYXZpdi9ldG5hdml2X2dlbS5jCmluZGV4IGU4Nzc4ZWJiNzJlNi4uYTAxNDRhNWVlMzI1
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vZXRuYXZpdi9ldG5hdml2X2dlbS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9ldG5hdml2L2V0bmF2aXZfZ2VtLmMKQEAgLTY4Niw3ICs2ODYsNyBA
QCBzdGF0aWMgaW50IGV0bmF2aXZfZ2VtX3VzZXJwdHJfZ2V0X3BhZ2VzKHN0cnVjdCBldG5hdml2
X2dlbV9vYmplY3QgKmV0bmF2aXZfb2JqKQogCQlyZXQgPSBnZXRfdXNlcl9wYWdlc19mYXN0KHB0
ciwgbnVtX3BhZ2VzLAogCQkJCQkgICF1c2VycHRyLT5ybyA/IEZPTExfV1JJVEUgOiAwLCBwYWdl
cyk7CiAJCWlmIChyZXQgPCAwKSB7Ci0JCQlyZWxlYXNlX3BhZ2VzKHB2ZWMsIHBpbm5lZCk7CisJ
CQlwdXRfdXNlcl9wYWdlcyhwdmVjLCBwaW5uZWQpOwogCQkJa3ZmcmVlKHB2ZWMpOwogCQkJcmV0
dXJuIHJldDsKIAkJfQpAQCAtNzEwLDcgKzcxMCw3IEBAIHN0YXRpYyB2b2lkIGV0bmF2aXZfZ2Vt
X3VzZXJwdHJfcmVsZWFzZShzdHJ1Y3QgZXRuYXZpdl9nZW1fb2JqZWN0ICpldG5hdml2X29iaikK
IAlpZiAoZXRuYXZpdl9vYmotPnBhZ2VzKSB7CiAJCWludCBucGFnZXMgPSBldG5hdml2X29iai0+
YmFzZS5zaXplID4+IFBBR0VfU0hJRlQ7CiAKLQkJcmVsZWFzZV9wYWdlcyhldG5hdml2X29iai0+
cGFnZXMsIG5wYWdlcyk7CisJCXB1dF91c2VyX3BhZ2VzKGV0bmF2aXZfb2JqLT5wYWdlcywgbnBh
Z2VzKTsKIAkJa3ZmcmVlKGV0bmF2aXZfb2JqLT5wYWdlcyk7CiAJfQogfQotLSAKMi4yMi4wCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkZXZlbCBtYWls
aW5nIGxpc3QKZGV2ZWxAbGludXhkcml2ZXJwcm9qZWN0Lm9yZwpodHRwOi8vZHJpdmVyZGV2Lmxp
bnV4ZHJpdmVycHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcml2ZXJkZXYtZGV2ZWwK
