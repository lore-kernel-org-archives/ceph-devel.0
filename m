From: =?GBK?B?xfQ=?= <wkp4666-KN7UnAbNpbg@public.gmane.org>
Subject: how to use rados_exec
Date: Tue, 12 Nov 2013 17:05:37 +0800 (CST)
Message-ID: <47c23d46.20e71.1424b8f1407.Coremail.wkp4666@126.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1219298258=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1219298258==
Content-Type: multipart/alternative;
	boundary="----=_Part_491316_1118743052.1384247137287"

------=_Part_491316_1118743052.1384247137287
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

IEhpIGFsbCEKICAgICAgIGxvbmcgdGltZSBubyBzZWUhCiAgICAgICBJICB3YW50IHRvIHVzZSB0
aGUgZnVuY3Rpb24gcmFkb3NfZXhlYywgIGFuZCBJIGZvdW5kICB0aGUgY2xhc3MgY2xzX2NyeXB0
by5jYyAgaW4gdGhlICBjb2RlIHNvdXJjZSBvZiBjZXBoOwpzbyBJICBydW4gdGhlIGZ1bnRpb24g
bGlrZSB0aGlzOgoKICAgICAgIHJhZG9zX2V4ZWMoaW9jdHgsICJmb29fb2JqZWN0IiwgImNyeXB0
byIgLCAibWQ1IiwgYnVmLCBzaXplb2YoYnVmKSxidWYyLCBzaXplb2YoYnVmMikgKQoKYW50IHRo
ZSBmdW5jdGlvbiByZXR1cm4gICBvcGVyYXRpb24gbm90IHN1cHBvcnQhCgogICAgIEkgY2hlY2sg
dGhlIHNvdXJjZSBvZiBjZXBoICwgYW5kIGZpbmQgdGhhdCAgY2xzX2NyeXB0by5jYyBpcyBub3Qg
YnVpbGSho2hvdyBjYW4gSSBidWxpZCB0aGUgY2xhc3MgYW5kIHJ1biBpdCEK
------=_Part_491316_1118743052.1384247137287
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6YXJpYWwiPjxkaXY+PGRpdj4mbmJzcDtIaSBhbGwhPGJyPiZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBsb25nIHRpbWUgbm8gc2VlITxicj4mbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgSSZuYnNwOyB3YW50IHRvIHVzZSB0aGUgZnVuY3Rp
b24gcmFkb3NfZXhlYywmbmJzcDsgYW5kIEkgZm91bmQmbmJzcDsgdGhlIGNsYXNzIGNsc19jcnlw
dG8uY2MmbmJzcDsgaW4gdGhlJm5ic3A7IGNvZGUgc291cmNlIG9mIGNlcGg7PGJyPnNvIEkmbmJz
cDsgcnVuIHRoZSBmdW50aW9uIGxpa2UgdGhpczo8YnI+PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyByYWRvc19leGVjKGlvY3R4LCAiZm9vX29iamVjdCIsICJjcnlwdG8i
ICwgIm1kNSIsIGJ1Ziwgc2l6ZW9mKGJ1ZiksYnVmMiwgc2l6ZW9mKGJ1ZjIpICk8YnI+PGJyPmFu
dCB0aGUgZnVuY3Rpb24gcmV0dXJuJm5ic3A7Jm5ic3A7IDxzcGFuIHN0eWxlPSJjb2xvcjogcmdi
KDI1NSwgMCwgMCk7Ij5vcGVyYXRpb24gbm90IHN1cHBvcnQ8L3NwYW4+ITxicj48YnI+Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7IEkgY2hlY2sgdGhlIHNvdXJjZSBvZiBjZXBoICwgYW5kIGZpbmQg
dGhhdCZuYnNwOyBjbHNfY3J5cHRvLmNjIGlzIG5vdCBidWlsZKGjaG93IGNhbiBJIGJ1bGlkIHRo
ZSBjbGFzcyBhbmQgcnVuIGl0ITxicj48L2Rpdj48L2Rpdj48L2Rpdj48YnI+PGJyPjxzcGFuIHRp
dGxlPSJuZXRlYXNlZm9vdGVyIj48c3BhbiBpZD0ibmV0ZWFzZV9tYWlsX2Zvb3RlciI+PC9zcGFu
Pjwvc3Bhbj4=
------=_Part_491316_1118743052.1384247137287--


--===============1219298258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1219298258==--
