From: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 00/12] block/bio, fs: convert put_page() to
	put_user_page*()
Date: Tue, 6 Aug 2019 23:38:59 -0700
Message-ID: <3ab1e69f-88c6-3e16-444d-cab78c3bf1d1@nvidia.com>
References: <20190724042518.14363-1-jhubbard@nvidia.com>
	<20190724061750.GA19397@infradead.org>
	<c35aa2bf-c830-9e57-78ca-9ce6fb6cb53b@nvidia.com>
	<20190807063448.GA6002@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190807063448.GA6002@infradead.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, linux-cifs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, v9fs-developer@lists.sourceforge.net, Eric Van Hensbergen <ericvh@gmail.com>, john.hubbard@gmail.com, linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>, Jens Axboe <axboe@kernel.dk>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, samba-technical@lists.samba.org, LKML <linux-kernel@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Anna Schumaker <anna.schumaker@netapp.com>
List-Id: ceph-devel.vger.kernel.org

T24gOC82LzE5IDExOjM0IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBNb24sIEF1
ZyAwNSwgMjAxOSBhdCAwMzo1NDozNVBNIC0wNzAwLCBKb2huIEh1YmJhcmQgd3JvdGU6Cj4+IE9u
IDcvMjMvMTkgMTE6MTcgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgouLi4KPj4+IEkgdGhp
bmsgd2UgY2FuIGRvIHRoaXMgaW4gYSBzaW1wbGUgYW5kIGJldHRlciB3YXkuICBXZSBoYXZlIDUg
SVRFUl8qCj4+PiB0eXBlcy4gIE9mIHRob3NlIElURVJfRElTQ0FSRCBhcyB0aGUgbmFtZSBzdWdn
ZXN0cyBuZXZlciB1c2VzIHBhZ2VzLCBzbwo+Pj4gd2UgY2FuIHNraXAgaGFuZGxpbmcgaXQuICBJ
VEVSX1BJUEUgaXMgcmVqZWN0ZWQg0ZZuIHRoZSBkaXJlY3QgSS9PIHBhdGgsCj4+PiB3aGljaCBs
ZWF2ZXMgdXMgd2l0aCB0aHJlZS4KPj4+Cj4+Cj4+IEhpIENocmlzdG9waCwKPj4KPj4gQXJlIHlv
dSB3b3JraW5nIG9uIGFueXRoaW5nIGxpa2UgdGhpcz8KPiAKPiBJIHdhcyBob3BpbmcgSSBjb3Vs
ZCBzdGVlciB5b3UgdG93YXJkcyBpdC4gIEJ1dCBpZiB5b3UgZG9uJ3Qgd2FudCB0byBkbwo+IGl0
IHlvdXJzZWxmIEknbGwgYWRkIGl0IHRvIG15IGV2ZXIgZ3Jvd2luZyB0b2RvIGxpc3QuCj4gCgpT
dXJlLCBJJ20gdXAgZm9yIHRoaXMuIFRoZSBidmVjLXJlbGF0ZWQgaXRlbXMgYXJlIHRoZSBuZXh0
IGxvZ2ljYWwgcGFydApvZiB0aGUgZ3VwL2RtYSBjb252ZXJzaW9ucyB0byB3b3JrIG9uLCBhbmQg
SSBqdXN0IHdhbnRlZCB0byBhdm9pZCBzb2x2aW5nIHRoZQpzYW1lIHByb2JsZW0gaWYgeW91IHdl
cmUgYWxyZWFkeSBpbiB0aGUgY29kZS4KCgo+PiBPciBvbiB0aGUgcHV0X3VzZXJfYnZlYygpIGlk
ZWE/Cj4gCj4gSSBoYXZlIGEgcHJvdG90eXBlIGZyb20gdHdvIG1vbnRoIGFnbzoKPiAKPiBodHRw
Oi8vZ2l0LmluZnJhZGVhZC5vcmcvdXNlcnMvaGNoL21pc2MuZ2l0L3Nob3J0bG9nL3JlZnMvaGVh
ZHMvZ3VwLWJ2ZWMKPiAKPiBidXQgdGhhdCBvbmx5IHN1cnZpdmVkIHRoZSBtb3N0IGJhc2ljIHRl
c3RpbmcsIHNvIGl0J2xsIG5lZWQgbW9yZSB3b3JrLAo+IHdoaWNoIEknbSBub3Qgc3VyZSB3aGVu
IEknbGwgZmluZCB0aW1lIGZvci4KPiAKCkknbGwgdGFrZSBhIHBlZWssIGFuZCBwcm9iYWJseSBw
ZXN0ZXIgeW91IHdpdGggYSBmZXcgcXVlc3Rpb25zIGlmIEkgZ2V0CmNvbmZ1c2VkLiA6KQoKdGhh
bmtzLAotLSAKSm9obiBIdWJiYXJkCk5WSURJQQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
