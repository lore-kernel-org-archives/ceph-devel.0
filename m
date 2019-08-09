From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 00/34] put_user_pages(): miscellaneous call sites
Date: Fri, 9 Aug 2019 10:43:34 +0200
Message-ID: <20190809084334.GB17568@quack2.suse.cz>
References: <20190802091244.GD6461@dhcp22.suse.cz>
 <20190802124146.GL25064@quack2.suse.cz>
 <20190802142443.GB5597@bombadil.infradead.org>
 <20190802145227.GQ25064@quack2.suse.cz>
 <076e7826-67a5-4829-aae2-2b90f302cebd@nvidia.com>
 <20190807083726.GA14658@quack2.suse.cz>
 <20190807084649.GQ11812@dhcp22.suse.cz>
 <20190808023637.GA1508@iweiny-DESK2.sc.intel.com>
 <e648a7f3-6a1b-c9ea-1121-7ab69b6b173d@nvidia.com>
 <2807E5FD2F6FDA4886F6618EAC48510E79E79644@CRSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <2807E5FD2F6FDA4886F6618EAC48510E79E79644@CRSMSX101.amr.corp.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Weiny, Ira" <ira.weiny@intel.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Jan Kara <jack@suse.cz>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Michal Hocko <mhocko@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, "xen-devel@lists.xenproject.org" <xen-de>
List-Id: ceph-devel.vger.kernel.org

T24gVGh1IDA4LTA4LTE5IDE2OjI1OjA0LCBXZWlueSwgSXJhIHdyb3RlOgo+ID4gSSB0aG91Z2h0
IEknZCBjYXVnaHQgdGhpbmdzIGVhcmx5IGVub3VnaCB0byBnZXQgYXdheSB3aXRoIHRoZQo+ID4g
cmVuYW1lIGFuZCBkZWxldGlvbiBvZiB0aGF0LiBZb3UgY291bGQgZWl0aGVyOgo+ID4gCj4gPiBh
KSBvcGVuIGNvZGUgYW4gaW1wbGVtZW50YXRpb24gb2YgdmFkZHJfcHV0X3BhZ2VzX2RpcnR5X2xv
Y2soKSB0aGF0Cj4gPiBkb2Vzbid0IGNhbGwgYW55IG9mIHRoZSAqcHV0X3VzZXJfcGFnZXNfZGly
dHkqKCkgdmFyaWFudHMsIG9yCj4gPiAKPiA+IGIpIGluY2x1ZGUgbXkgZmlyc3QgcGF0Y2ggKCIi
KSBhcmUgcGFydCBvZiB5b3VyIHNlcmllcywgb3IKPiA+IAo+ID4gYykgYmFzZSB0aGlzIG9uIEFu
ZHJld3MncyB0cmVlLCB3aGljaCBhbHJlYWR5IGhhcyBtZXJnZWQgaW4gbXkgZmlyc3QgcGF0Y2gu
Cj4gPiAKPiAKPiBZZXAgSSBjYW4gZG8gdGhpcy4gIEkgZGlkIG5vdCByZWFsaXplIHRoYXQgQW5k
cmV3IGhhZCBhY2NlcHRlZCBhbnkgb2YKPiB0aGlzIHdvcmsuICBJJ2xsIGNoZWNrIG91dCBoaXMg
dHJlZS4gIEJ1dCBJIGRvbid0IHRoaW5rIGhlIGlzIGdvaW5nIHRvCj4gYWNjZXB0IHRoaXMgc2Vy
aWVzIHRocm91Z2ggaGlzIHRyZWUuICBTbyB3aGF0IGlzIHRoZSBFVEEgb24gdGhhdCBsYW5kaW5n
Cj4gaW4gTGludXMnIHRyZWU/Cj4gCj4gVG8gdGhhdCBwb2ludCBJJ20gc3RpbGwgbm90IHN1cmUg
d2hvIHdvdWxkIHRha2UgYWxsIHRoaXMgYXMgSSBhbSBub3cKPiB0b3VjaGluZyBtbSwgcHJvY2Zz
LCByZG1hLCBleHQ0LCBhbmQgeGZzLgoKTU0gdHJlZSB3b3VsZCBiZSBvbmUgY2FuZGlkYXRlIGZv
ciByb3V0aW5nIGJ1dCB0aGVyZSBhcmUgb3RoZXIgb3B0aW9ucyB0aGF0CndvdWxkIG1ha2Ugc2Vu
c2UgYXMgd2VsbCAtIERhbidzIHRyZWUsIFZGUyB0cmVlLCBvciBldmVuIEkgY2FuIHBpY2t1cCB0
aGUKcGF0Y2hlcyB0byBteSB0cmVlIGlmIG5lZWRlZC4gQnV0IGxldCdzIHdvcnJ5IGFib3V0IHRo
ZSByb3V0aW5nIGFmdGVyIHdlCmhhdmUgd29ya2luZyBhbmQgcmV2aWV3ZWQgcGF0Y2hlcy4uLgoK
CQkJCQkJCQlIb256YQotLSAKSmFuIEthcmEgPGphY2tAc3VzZS5jb20+ClNVU0UgTGFicywgQ1IK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
