From: john.hubbard@gmail.com
Subject: [PATCH v3 40/41] mm/mempolicy.c: convert put_page() to
 put_user_page*()
Date: Tue,  6 Aug 2019 18:33:39 -0700
Message-ID: <20190807013340.9706-41-jhubbard@nvidia.com>
References: <20190807013340.9706-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <20190807013340.9706-1-jhubbard@nvidia.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>, Anshuman Khandual <anshuman.khandual@arm.com>, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, Dominik Brodowski <linux@dominikbrodows>
List-Id: ceph-devel.vger.kernel.org

RnJvbTogSm9obiBIdWJiYXJkIDxqaHViYmFyZEBudmlkaWEuY29tPgoKRm9yIHBhZ2VzIHRoYXQg
d2VyZSByZXRhaW5lZCB2aWEgZ2V0X3VzZXJfcGFnZXMqKCksIHJlbGVhc2UgdGhvc2UgcGFnZXMK
dmlhIHRoZSBuZXcgcHV0X3VzZXJfcGFnZSooKSByb3V0aW5lcywgaW5zdGVhZCBvZiB2aWEgcHV0
X3BhZ2UoKSBvcgpyZWxlYXNlX3BhZ2VzKCkuCgpUaGlzIGlzIHBhcnQgYSB0cmVlLXdpZGUgY29u
dmVyc2lvbiwgYXMgZGVzY3JpYmVkIGluIGNvbW1pdCBmYzFkOGU3Y2NhMmQKKCJtbTogaW50cm9k
dWNlIHB1dF91c2VyX3BhZ2UqKCksIHBsYWNlaG9sZGVyIHZlcnNpb25zIikuCgpDYzogQW5kcmVh
IEFyY2FuZ2VsaSA8YWFyY2FuZ2VAcmVkaGF0LmNvbT4KQ2M6IEFuc2h1bWFuIEtoYW5kdWFsIDxh
bnNodW1hbi5raGFuZHVhbEBhcm0uY29tPgpDYzogRGF2aWQgUmllbnRqZXMgPHJpZW50amVzQGdv
b2dsZS5jb20+CkNjOiBEb21pbmlrIEJyb2Rvd3NraSA8bGludXhAZG9taW5pa2Jyb2Rvd3NraS5u
ZXQ+CkNjOiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5j
b20+CkNjOiBNaWNoYWwgSG9ja28gPG1ob2Nrb0BzdXNlLmNvbT4KQ2M6IFZsYXN0aW1pbCBCYWJr
YSA8dmJhYmthQHN1c2UuY3o+CkNjOiB6aG9uZyBqaWFuZyA8emhvbmdqaWFuZ0BodWF3ZWkuY29t
PgpTaWduZWQtb2ZmLWJ5OiBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52aWRpYS5jb20+Ci0tLQog
bW0vbWVtcG9saWN5LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9tbS9tZW1wb2xpY3kuYyBiL21tL21lbXBvbGljeS5j
CmluZGV4IGY0ODY5M2Y3NWIzNy4uNzZhOGU5MzVlMmU2IDEwMDY0NAotLS0gYS9tbS9tZW1wb2xp
Y3kuYworKysgYi9tbS9tZW1wb2xpY3kuYwpAQCAtODMyLDcgKzgzMiw3IEBAIHN0YXRpYyBpbnQg
bG9va3VwX25vZGUoc3RydWN0IG1tX3N0cnVjdCAqbW0sIHVuc2lnbmVkIGxvbmcgYWRkcikKIAll
cnIgPSBnZXRfdXNlcl9wYWdlc19sb2NrZWQoYWRkciAmIFBBR0VfTUFTSywgMSwgMCwgJnAsICZs
b2NrZWQpOwogCWlmIChlcnIgPj0gMCkgewogCQllcnIgPSBwYWdlX3RvX25pZChwKTsKLQkJcHV0
X3BhZ2UocCk7CisJCXB1dF91c2VyX3BhZ2UocCk7CiAJfQogCWlmIChsb2NrZWQpCiAJCXVwX3Jl
YWQoJm1tLT5tbWFwX3NlbSk7Ci0tIAoyLjIyLjAKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpYZW4tZGV2ZWwgbWFpbGluZyBsaXN0Clhlbi1kZXZlbEBs
aXN0cy54ZW5wcm9qZWN0Lm9yZwpodHRwczovL2xpc3RzLnhlbnByb2plY3Qub3JnL21haWxtYW4v
bGlzdGluZm8veGVuLWRldmVs
