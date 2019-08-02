From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 00/34] put_user_pages(): miscellaneous call sites
Date: Fri, 2 Aug 2019 14:41:46 +0200
Message-ID: <20190802124146.GL25064@quack2.suse.cz>
References: <20190802022005.5117-1-jhubbard@nvidia.com>
 <20190802091244.GD6461@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20190802091244.GD6461@dhcp22.suse.cz>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, john.hubbard@gmail.com, linux-block@vger.kernel.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.orglinux-
List-Id: ceph-devel.vger.kernel.org

T24gRnJpIDAyLTA4LTE5IDExOjEyOjQ0LCBNaWNoYWwgSG9ja28gd3JvdGU6Cj4gT24gVGh1IDAx
LTA4LTE5IDE5OjE5OjMxLCBqb2huLmh1YmJhcmRAZ21haWwuY29tIHdyb3RlOgo+IFsuLi5dCj4g
PiAyKSBDb252ZXJ0IGFsbCBvZiB0aGUgY2FsbCBzaXRlcyBmb3IgZ2V0X3VzZXJfcGFnZXMqKCks
IHRvCj4gPiBpbnZva2UgcHV0X3VzZXJfcGFnZSooKSwgaW5zdGVhZCBvZiBwdXRfcGFnZSgpLiBU
aGlzIGludm9sdmVzIGRvemVucyBvZgo+ID4gY2FsbCBzaXRlcywgYW5kIHdpbGwgdGFrZSBzb21l
IHRpbWUuCj4gCj4gSG93IGRvIHdlIG1ha2Ugc3VyZSB0aGlzIGlzIHRoZSBjYXNlIGFuZCBpdCB3
aWxsIHJlbWFpbiB0aGUgY2FzZSBpbiB0aGUKPiBmdXR1cmU/IFRoZXJlIG11c3QgYmUgc29tZSBh
dXRvbWFnaWMgdG8gZW5mb3JjZS9jaGVjayB0aGF0LiBJdCBpcyBzaW1wbHkKPiBub3QgbWFuYWdl
YWJsZSB0byBkbyBpdCBldmVyeSBub3cgYW5kIHRoZW4gYmVjYXVzZSB0aGVuIDMpIHdpbGwgc2lt
cGx5Cj4gYmUgbmV2ZXIgc2FmZS4KPiAKPiBIYXZlIHlvdSBjb25zaWRlcmVkIGNvY2NpbmVsZSBv
ciBzb21lIG90aGVyIHNjcmlwdGVkIHdheSB0byBkbyB0aGUKPiB0cmFuc2l0aW9uPyBJIGhhdmUg
bm8gaWRlYSBob3cgdG8gZGVhbCB3aXRoIGZ1dHVyZSBjaGFuZ2VzIHRoYXQgd291bGQKPiBicmVh
ayB0aGUgYmFsYW5jZSB0aG91Z2guCgpZZWFoLCB0aGF0J3Mgd2h5IEkndmUgYmVlbiBzdWdnZXN0
aW5nIGF0IExTRi9NTSB0aGF0IHdlIG1heSBuZWVkIHRvIGNyZWF0ZQphIGd1cCB3cmFwcGVyIC0g
c2F5IHZhZGRyX3Bpbl9wYWdlcygpIC0gYW5kIHRyYWNrIHdoaWNoIHNpdGVzIGRyb3BwaW5nCnJl
ZmVyZW5jZXMgZ290IGNvbnZlcnRlZCBieSB1c2luZyB0aGlzIHdyYXBwZXIgaW5zdGVhZCBvZiBn
dXAuIFRoZQpjb3VudGVycGFydCB3b3VsZCB0aGVuIGJlIG1vcmUgbG9naWNhbGx5IG5hbWVkIGFz
IHVucGluX3BhZ2UoKSBvciB3aGF0ZXZlcgppbnN0ZWFkIG9mIHB1dF91c2VyX3BhZ2UoKS4gIFN1
cmUgdGhpcyBpcyBub3QgY29tcGxldGVseSBmb29scHJvb2YgKHlvdSBjYW4KY3JlYXRlIG5ldyBj
YWxsc2l0ZSB1c2luZyB2YWRkcl9waW5fcGFnZXMoKSBhbmQgdGhlbiBqdXN0IGRyb3AgcmVmcyB1
c2luZwpwdXRfcGFnZSgpKSBidXQgSSBzdXBwb3NlIGl0IHdvdWxkIGJlIGEgaGlnaCBlbm91Z2gg
YmFycmllciBmb3IgbWlzc2VkCmNvbnZlcnNpb25zLi4uIFRob3VnaHRzPwoKCQkJCQkJCQlIb256
YQoKLS0gCkphbiBLYXJhIDxqYWNrQHN1c2UuY29tPgpTVVNFIExhYnMsIENSCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
