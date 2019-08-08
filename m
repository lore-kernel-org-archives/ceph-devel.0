From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 38/41] powerpc: convert put_page() to
 put_user_page*()
Date: Thu, 08 Aug 2019 15:42:34 +1000
Message-ID: <87k1botdpx.fsf@concordia.ellerman.id.au>
References: <20190807013340.9706-1-jhubbard@nvidia.com>
 <20190807013340.9706-39-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <20190807013340.9706-39-jhubbard@nvidia.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?utf-8?B?SsOpcsO0?= =?utf-8?B?bWU=?= Glisse <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org
List-Id: ceph-devel.vger.kernel.org

SGkgSm9obiwKCmpvaG4uaHViYmFyZEBnbWFpbC5jb20gd3JpdGVzOgo+IGRpZmYgLS1naXQgYS9h
cmNoL3Bvd2VycGMvbW0vYm9vazNzNjQvaW9tbXVfYXBpLmMgYi9hcmNoL3Bvd2VycGMvbW0vYm9v
azNzNjQvaW9tbXVfYXBpLmMKPiBpbmRleCBiMDU2Y2FlMzM4OGIuLmUxMjYxOTNiYTI5NSAxMDA2
NDQKPiAtLS0gYS9hcmNoL3Bvd2VycGMvbW0vYm9vazNzNjQvaW9tbXVfYXBpLmMKPiArKysgYi9h
cmNoL3Bvd2VycGMvbW0vYm9vazNzNjQvaW9tbXVfYXBpLmMKPiBAQCAtMjAzLDYgKzIwMiw3IEBA
IHN0YXRpYyB2b2lkIG1tX2lvbW11X3VucGluKHN0cnVjdCBtbV9pb21tdV90YWJsZV9ncm91cF9t
ZW1fdCAqbWVtKQo+ICB7Cj4gIAlsb25nIGk7Cj4gIAlzdHJ1Y3QgcGFnZSAqcGFnZSA9IE5VTEw7
Cj4gKwlib29sIGRpcnR5ID0gZmFsc2U7CgpJIGRvbid0IHRoaW5rIHlvdSBuZWVkIHRoYXQgaW5p
dGlhbGlzYXRpb24gZG8geW91PwoKPiAgCWlmICghbWVtLT5ocGFzKQo+ICAJCXJldHVybjsKPiBA
QCAtMjE1LDEwICsyMTUsOSBAQCBzdGF0aWMgdm9pZCBtbV9pb21tdV91bnBpbihzdHJ1Y3QgbW1f
aW9tbXVfdGFibGVfZ3JvdXBfbWVtX3QgKm1lbSkKPiAgCQlpZiAoIXBhZ2UpCj4gIAkJCWNvbnRp
bnVlOwo+ICAKPiAtCQlpZiAobWVtLT5ocGFzW2ldICYgTU1fSU9NTVVfVEFCTEVfR1JPVVBfUEFH
RV9ESVJUWSkKPiAtCQkJU2V0UGFnZURpcnR5KHBhZ2UpOwo+ICsJCWRpcnR5ID0gbWVtLT5ocGFz
W2ldICYgTU1fSU9NTVVfVEFCTEVfR1JPVVBfUEFHRV9ESVJUWTsKPiAtCQlwdXRfcGFnZShwYWdl
KTsKPiArCQlwdXRfdXNlcl9wYWdlc19kaXJ0eV9sb2NrKCZwYWdlLCAxLCBkaXJ0eSk7Cj4gIAkJ
bWVtLT5ocGFzW2ldID0gMDsKPiAgCX0KPiAgfQoKY2hlZXJzCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpYZW4tZGV2ZWwgbWFpbGluZyBsaXN0Clhlbi1k
ZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZwpodHRwczovL2xpc3RzLnhlbnByb2plY3Qub3JnL21h
aWxtYW4vbGlzdGluZm8veGVuLWRldmVs
