From: yuelongguang <fastsync-9Onoh4P/yGk@public.gmane.org>
Subject: what is collection(COLL) and cid
Date: Mon, 4 Aug 2014 12:04:28 +0800 (CST)
Message-ID: <7803cb8c.b3ff.1479f3098f1.Coremail.fastsync@163.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0585630171=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0585630171==
Content-Type: multipart/alternative;
	boundary="----=_Part_184321_1139688458.1407125068017"

------=_Part_184321_1139688458.1407125068017
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

aGksYWxsCmxvb2sgYXQgdGhlIGNvZGUuCmNhc2UgVHJhbnNhY3Rpb246Ok9QX01LQ09MTDoKICAg
ICAgewogICAgICAgICAgICAgY29sbF90IGNpZCA9IGkuZ2V0X2NpZCgpOwogICAgICAuLi59CjEg
Lgp3aGF0IGlzIENPTEwgYW5kIGNpZD8gIAppcyBjb2xsIGlzIGEgcGcgYW5kIGNpZCBpcyBwZ2lk
PwogCjIuIHdoYXQgaXMgdGhlIHJlbGF0aW9uIGJldHdlZW4gY2lkIGFuZCAnY3VycmVudC9tZXRh
Jz8gICBvciB3aGF0IGlzIGluIGN1cnJlbnQvbWV0YT8KIAogCnRoYW5rcyB2ZXJ5IG11Y2gu
------=_Part_184321_1139688458.1407125068017
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXY+aGksYWxsPC9kaXY+PGRpdj5sb29rIGF0IHRoZSBjb2Rl
LjwvZGl2PjxkaXY+Y2FzZSBUcmFuc2FjdGlvbjo6T1BfTUtDT0xMOjxicj4mbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsgezxicj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtjb2xsX3QgY2lkID0g
aS5nZXRfY2lkKCk7PC9kaXY+PGRpdj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgLi4u
fTwvZGl2PjxkaXY+MSAuPC9kaXY+PGRpdj53aGF0IGlzIENPTEwgYW5kIGNpZD8mbmJzcDsmbmJz
cDsgPC9kaXY+PGRpdj5pcyBjb2xsIGlzIGEgcGcgYW5kIGNpZCBpcyBwZ2lkPzwvZGl2PjxkaXY+
Jm5ic3A7PC9kaXY+PGRpdj4yLiB3aGF0IGlzIHRoZSByZWxhdGlvbiBiZXR3ZWVuIGNpZCBhbmQg
J2N1cnJlbnQvbWV0YSc/Jm5ic3A7Jm5ic3A7IG9yIHdoYXQgaXMgaW4gY3VycmVudC9tZXRhPzwv
ZGl2PjxkaXY+Jm5ic3A7PC9kaXY+PGRpdj4mbmJzcDs8L2Rpdj48ZGl2PnRoYW5rcyB2ZXJ5IG11
Y2guPC9kaXY+PC9kaXY+PGJyPjxicj48c3BhbiB0aXRsZT0ibmV0ZWFzZWZvb3RlciI+PHNwYW4g
aWQ9Im5ldGVhc2VfbWFpbF9mb290ZXIiPjwvc3Bhbj48L3NwYW4+
------=_Part_184321_1139688458.1407125068017--


--===============0585630171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0585630171==--
