From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
Subject: Note about rbd_aio_write usage
Date: Thu, 6 Jul 2017 14:26:33 +0200
Message-ID: <f5062e24-d138-a096-0171-79bc1259db7b@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

SGksCgpJZiB5b3UncmUgdXNpbmcgInJiZF9haW9fd3JpdGUoKSIgaW4geW91ciBjb2RlLCBiZSBh
d2FyZSBvZiB0aGUgZmFjdCB0aGF0IApiZWZvcmUgTHVtaW5vdXMgcmVsZWFzZSwgdGhpcyBmdW5j
dGlvbiBleHBlY3RzIGJ1ZmZlciB0byByZW1haW4gdW5jaGFuZ2VkIAp1bnRpbCB3cml0ZSBvcCBl
bmRzLCBhbmQgb24gTHVtaW5vdXMgYW5kIGxhdGVyIHRoaXMgZnVuY3Rpb24gaW50ZXJuYWxseSAK
Y29waWVzIHRoZSBidWZmZXIsIGFsbG9jYXRpbmcgbWVtb3J5IHdoZXJlIG5lZWRlZCwgZnJlZWlu
ZyBpdCBvbmNlIHdyaXRlIGlzIApkb25lLgoKSWYgeW91IHdyaXRlIGFuIGFwcCB0aGF0IG1heSBu
ZWVkIHRvIHdvcmsgd2l0aCBMdW1pbm91cyAqYW5kKiBwcmUtTHVtaW5vdXMgCnZlcnNpb25zIG9m
IGxpYnJiZCwgeW91IG1heSB3YW50IHRvIHByb3ZpZGUgYSB2ZXJzaW9uIGNoZWNrICh1c2luZyAK
cmJkX3ZlcnNpb24oKSBmb3IgZXhhbXBsZSkgc28gZWl0aGVyIHlvdXIgYnVmZmVycyB3b24ndCBj
aGFuZ2UgYmVmb3JlIHdyaXRlIAppcyBkb25lIG9yIHlvdSBkb24ndCBpbmN1ciBhIHBlbmFsdHkg
Zm9yIHVubmVjZXNzYXJ5IG1lbW9yeSBhbGxvY2F0aW9uIGFuZCAKY29weSBvbiB5b3VyIHNpZGUg
KHRob3VnaCBpdCdzIHByb2JhYmx5IHVuYXZvaWRhYmxlIHdpdGggY3VycmVudCBzdGF0ZSBvZiAK
THVtaW5vdXMpLgoKLS0gClBpb3RyIERhxYJlawpwaW90ci5kYWxla0Bjb3JwLm92aC5jb20KaHR0
cHM6Ly93d3cub3ZoLmNvbS91cy8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KY2VwaC11c2VycyBtYWlsaW5nIGxpc3QKY2VwaC11c2Vyc0BsaXN0cy5jZXBo
LmNvbQpodHRwOi8vbGlzdHMuY2VwaC5jb20vbGlzdGluZm8uY2dpL2NlcGgtdXNlcnMtY2VwaC5j
b20K
