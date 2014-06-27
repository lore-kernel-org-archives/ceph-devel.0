From: fastsync <fastsync-9Onoh4P/yGk@public.gmane.org>
Subject: ceph-fuse command hangs only when the mon address is
	not local ip
Date: Fri, 27 Jun 2014 22:14:43 +0800 (CST)
Message-ID: <42312199.b605.146ddada696.Coremail.fastsync@163.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1434804150=="
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
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1434804150==
Content-Type: multipart/alternative;
	boundary="----=_Part_184388_1725982151.1403878483606"

------=_Part_184388_1725982151.1403878483606
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

dGhpcyBpcyB0aGUga2VybmVsIGNhbGwgc3RhY2suCnRoYW5rcy4KIAogCltyb290QGRldmxvbmcg
c291cmNlXSMgY2VwaC1mdXNlIC1tICAxOTIuMTY4LjE4LjEzMTo2Nzg5IC9vcHQvbWNlcGggICAg
ICA7IGlwIDEzMSBpcyBub3QgbG9jYWwgaXAuCmNlcGgtZnVzZVs0MzQ5MF06IHN0YXJ0aW5nIGNl
cGggY2xpZW50CmNlcGgtZnVzZVs0MzQ5MF06IGNlcGggbW91bnQgZmFpbGVkIHdpdGggKDExMCkg
Q29ubmVjdGlvbiB0aW1lZCBvdXQKY2VwaC1mdXNlWzQzNDg4XTogbW91bnQgZmFpbGVkOiAoMTEw
KSBDb25uZWN0aW9uIHRpbWVkIG91dAogCls8ZmZmZmZmZmY4MTBhM2I0OT5dIGZ1dGV4X3dhaXRf
cXVldWVfbWUrMHhiOS8weGYwCls8ZmZmZmZmZmY4MTBhNGMxOD5dIGZ1dGV4X3dhaXQrMHgxZjgv
MHgzODAKWzxmZmZmZmZmZjgxMGE2MzYxPl0gZG9fZnV0ZXgrMHgxMjEvMHhiMDAKWzxmZmZmZmZm
ZjgxMGE2ZGJiPl0gc3lzX2Z1dGV4KzB4N2IvMHgxNzAKWzxmZmZmZmZmZjgxMDBiMGYyPl0gc3lz
dGVtX2NhbGxfZmFzdHBhdGgrMHgxNi8weDFiCls8ZmZmZmZmZmZmZmZmZmZmZj5dIDB4ZmZmZmZm
ZmZmZmZmZmZmZgogCgpbPGZmZmZmZmZmODExOGZjZDk+XSBwb2xsX3NjaGVkdWxlX3RpbWVvdXQr
MHgzOS8weDYwCls8ZmZmZmZmZmY4MTE5MGIyYj5dIGRvX3N5c19wb2xsKzB4NDViLzB4NTIwCls8
ZmZmZmZmZmY4MTE5MGRlMT5dIHN5c19wb2xsKzB4NzEvMHgxMDAKWzxmZmZmZmZmZjgxMDBiMGYy
Pl0gc3lzdGVtX2NhbGxfZmFzdHBhdGgrMHgxNi8weDFiCls8ZmZmZmZmZmZmZmZmZmZmZj5dIDB4
ZmZmZmZmZmZmZmZmZmZmZg==
------=_Part_184388_1725982151.1403878483606
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXY+dGhpcyBpcyB0aGUga2VybmVsIGNhbGwgc3RhY2suPC9k
aXY+PGRpdj50aGFua3MuPC9kaXY+PGRpdj4mbmJzcDs8L2Rpdj48ZGl2PiZuYnNwOzwvZGl2Pjxk
aXY+W3Jvb3RAZGV2bG9uZyBzb3VyY2VdIyBjZXBoLWZ1c2UgLW0mbmJzcDsgMTkyLjE2OC4xOC4x
MzE6Njc4OSAvb3B0L21jZXBoJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7IDsgaXAgMTMx
IGlzIG5vdCBsb2NhbCBpcC48YnI+Y2VwaC1mdXNlWzQzNDkwXTogc3RhcnRpbmcgY2VwaCBjbGll
bnQ8YnI+Y2VwaC1mdXNlWzQzNDkwXTogY2VwaCBtb3VudCBmYWlsZWQgd2l0aCAoMTEwKSBDb25u
ZWN0aW9uIHRpbWVkIG91dDxicj5jZXBoLWZ1c2VbNDM0ODhdOiBtb3VudCBmYWlsZWQ6ICgxMTAp
IENvbm5lY3Rpb24gdGltZWQgb3V0PC9kaXY+PGRpdj4mbmJzcDs8L2Rpdj48ZGl2PlsmbHQ7ZmZm
ZmZmZmY4MTBhM2I0OSZndDtdIGZ1dGV4X3dhaXRfcXVldWVfbWUrMHhiOS8weGYwPGJyPlsmbHQ7
ZmZmZmZmZmY4MTBhNGMxOCZndDtdIGZ1dGV4X3dhaXQrMHgxZjgvMHgzODA8YnI+WyZsdDtmZmZm
ZmZmZjgxMGE2MzYxJmd0O10gZG9fZnV0ZXgrMHgxMjEvMHhiMDA8YnI+WyZsdDtmZmZmZmZmZjgx
MGE2ZGJiJmd0O10gc3lzX2Z1dGV4KzB4N2IvMHgxNzA8YnI+WyZsdDtmZmZmZmZmZjgxMDBiMGYy
Jmd0O10gc3lzdGVtX2NhbGxfZmFzdHBhdGgrMHgxNi8weDFiPGJyPlsmbHQ7ZmZmZmZmZmZmZmZm
ZmZmZiZndDtdIDB4ZmZmZmZmZmZmZmZmZmZmZjwvZGl2PjxkaXY+Jm5ic3A7PC9kaXY+PGRpdj48
YnI+WyZsdDtmZmZmZmZmZjgxMThmY2Q5Jmd0O10gcG9sbF9zY2hlZHVsZV90aW1lb3V0KzB4Mzkv
MHg2MDxicj5bJmx0O2ZmZmZmZmZmODExOTBiMmImZ3Q7XSBkb19zeXNfcG9sbCsweDQ1Yi8weDUy
MDxicj5bJmx0O2ZmZmZmZmZmODExOTBkZTEmZ3Q7XSBzeXNfcG9sbCsweDcxLzB4MTAwPGJyPlsm
bHQ7ZmZmZmZmZmY4MTAwYjBmMiZndDtdIHN5c3RlbV9jYWxsX2Zhc3RwYXRoKzB4MTYvMHgxYjxi
cj5bJmx0O2ZmZmZmZmZmZmZmZmZmZmYmZ3Q7XSAweGZmZmZmZmZmZmZmZmZmZmY8L2Rpdj48L2Rp
dj48YnI+PGJyPjxzcGFuIHRpdGxlPSJuZXRlYXNlZm9vdGVyIj48c3BhbiBpZD0ibmV0ZWFzZV9t
YWlsX2Zvb3RlciI+PC9zcGFuPjwvc3Bhbj4=
------=_Part_184388_1725982151.1403878483606--


--===============1434804150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1434804150==--
