From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 00/34] put_user_pages(): miscellaneous call sites
Date: Fri, 2 Aug 2019 16:52:27 +0200
Message-ID: <20190802145227.GQ25064@quack2.suse.cz>
References: <20190802022005.5117-1-jhubbard@nvidia.com>
 <20190802091244.GD6461@dhcp22.suse.cz>
 <20190802124146.GL25064@quack2.suse.cz>
 <20190802142443.GB5597@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190802142443.GB5597@bombadil.infradead.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, john.hubbard@gmail.com, linux-block@vger.kernel.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, linux-arm
List-Id: ceph-devel.vger.kernel.org

T24gRnJpIDAyLTA4LTE5IDA3OjI0OjQzLCBNYXR0aGV3IFdpbGNveCB3cm90ZToKPiBPbiBGcmks
IEF1ZyAwMiwgMjAxOSBhdCAwMjo0MTo0NlBNICswMjAwLCBKYW4gS2FyYSB3cm90ZToKPiA+IE9u
IEZyaSAwMi0wOC0xOSAxMToxMjo0NCwgTWljaGFsIEhvY2tvIHdyb3RlOgo+ID4gPiBPbiBUaHUg
MDEtMDgtMTkgMTk6MTk6MzEsIGpvaG4uaHViYmFyZEBnbWFpbC5jb20gd3JvdGU6Cj4gPiA+IFsu
Li5dCj4gPiA+ID4gMikgQ29udmVydCBhbGwgb2YgdGhlIGNhbGwgc2l0ZXMgZm9yIGdldF91c2Vy
X3BhZ2VzKigpLCB0bwo+ID4gPiA+IGludm9rZSBwdXRfdXNlcl9wYWdlKigpLCBpbnN0ZWFkIG9m
IHB1dF9wYWdlKCkuIFRoaXMgaW52b2x2ZXMgZG96ZW5zIG9mCj4gPiA+ID4gY2FsbCBzaXRlcywg
YW5kIHdpbGwgdGFrZSBzb21lIHRpbWUuCj4gPiA+IAo+ID4gPiBIb3cgZG8gd2UgbWFrZSBzdXJl
IHRoaXMgaXMgdGhlIGNhc2UgYW5kIGl0IHdpbGwgcmVtYWluIHRoZSBjYXNlIGluIHRoZQo+ID4g
PiBmdXR1cmU/IFRoZXJlIG11c3QgYmUgc29tZSBhdXRvbWFnaWMgdG8gZW5mb3JjZS9jaGVjayB0
aGF0LiBJdCBpcyBzaW1wbHkKPiA+ID4gbm90IG1hbmFnZWFibGUgdG8gZG8gaXQgZXZlcnkgbm93
IGFuZCB0aGVuIGJlY2F1c2UgdGhlbiAzKSB3aWxsIHNpbXBseQo+ID4gPiBiZSBuZXZlciBzYWZl
Lgo+ID4gPiAKPiA+ID4gSGF2ZSB5b3UgY29uc2lkZXJlZCBjb2NjaW5lbGUgb3Igc29tZSBvdGhl
ciBzY3JpcHRlZCB3YXkgdG8gZG8gdGhlCj4gPiA+IHRyYW5zaXRpb24/IEkgaGF2ZSBubyBpZGVh
IGhvdyB0byBkZWFsIHdpdGggZnV0dXJlIGNoYW5nZXMgdGhhdCB3b3VsZAo+ID4gPiBicmVhayB0
aGUgYmFsYW5jZSB0aG91Z2guCj4gPiAKPiA+IFllYWgsIHRoYXQncyB3aHkgSSd2ZSBiZWVuIHN1
Z2dlc3RpbmcgYXQgTFNGL01NIHRoYXQgd2UgbWF5IG5lZWQgdG8gY3JlYXRlCj4gPiBhIGd1cCB3
cmFwcGVyIC0gc2F5IHZhZGRyX3Bpbl9wYWdlcygpIC0gYW5kIHRyYWNrIHdoaWNoIHNpdGVzIGRy
b3BwaW5nCj4gPiByZWZlcmVuY2VzIGdvdCBjb252ZXJ0ZWQgYnkgdXNpbmcgdGhpcyB3cmFwcGVy
IGluc3RlYWQgb2YgZ3VwLiBUaGUKPiA+IGNvdW50ZXJwYXJ0IHdvdWxkIHRoZW4gYmUgbW9yZSBs
b2dpY2FsbHkgbmFtZWQgYXMgdW5waW5fcGFnZSgpIG9yIHdoYXRldmVyCj4gPiBpbnN0ZWFkIG9m
IHB1dF91c2VyX3BhZ2UoKS4gIFN1cmUgdGhpcyBpcyBub3QgY29tcGxldGVseSBmb29scHJvb2Yg
KHlvdSBjYW4KPiA+IGNyZWF0ZSBuZXcgY2FsbHNpdGUgdXNpbmcgdmFkZHJfcGluX3BhZ2VzKCkg
YW5kIHRoZW4ganVzdCBkcm9wIHJlZnMgdXNpbmcKPiA+IHB1dF9wYWdlKCkpIGJ1dCBJIHN1cHBv
c2UgaXQgd291bGQgYmUgYSBoaWdoIGVub3VnaCBiYXJyaWVyIGZvciBtaXNzZWQKPiA+IGNvbnZl
cnNpb25zLi4uIFRob3VnaHRzPwo+IAo+IEkgdGhpbmsgdGhlIEFQSSB3ZSByZWFsbHkgbmVlZCBp
cyBnZXRfdXNlcl9idmVjKCkgLyBwdXRfdXNlcl9idmVjKCksCj4gYW5kIEkga25vdyBDaHJpc3Rv
cGggaGFzIGJlZW4gcHV0dGluZyBzb21lIHdvcmsgaW50byB0aGF0LiAgVGhhdCBhdm9pZHMKPiBk
b2luZyByZWZjb3VudCBvcGVyYXRpb25zIG9uIGh1bmRyZWRzIG9mIHBhZ2VzIGlmIHRoZSBwYWdl
IGluIHF1ZXN0aW9uIGlzCj4gYSBodWdlIHBhZ2UuICBPbmNlIHBlb3BsZSBhcmUgc3dpdGNoZWQg
b3ZlciB0byB0aGF0LCB0aGV5IHdvbid0IGJlIHRlbXB0ZWQKPiB0byBtYW51YWxseSBjYWxsIHB1
dF9wYWdlKCkgb24gdGhlIGluZGl2aWR1YWwgY29uc3RpdHVlbnQgcGFnZXMgb2YgYSBidmVjLgoK
V2VsbCwgZ2V0X3VzZXJfYnZlYygpIGlzIGNlcnRhaW5seSBhIGdvb2QgQVBJIGZvciBvbmUgY2xh
c3Mgb2YgdXNlcnMgYnV0Cmp1c3QgbG9va2luZyBhdCB0aGUgYWJvdmUgc2VyaWVzLCB5b3UnbGwg
c2VlIHRoZXJlIGFyZSAqbWFueSogcGxhY2VzIHRoYXQKanVzdCBkb24ndCB3b3JrIHdpdGggYnZl
Y3MgYXQgYWxsIGFuZCB5b3UgbmVlZCBzb21ldGhpbmcgZm9yIHRob3NlLgoKCQkJCQkJCQlIb256
YQotLSAKSmFuIEthcmEgPGphY2tAc3VzZS5jb20+ClNVU0UgTGFicywgQ1IKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlz
dApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
