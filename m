From: "archer.wudong" <archer.wudong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: why not add (offset,len) to pglog
Date: Fri, 25 Dec 2015 11:13:48 +0800
Message-ID: <567CB468.9090607@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0200107725=="
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
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0200107725==
Content-Type: multipart/alternative;
	boundary="====003__MESSAGE__ID__54yg6f6h6y456345===="

--====003__MESSAGE__ID__54yg6f6h6y456345====
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQpJIGhhdmUgZG91YnQgYWJvdXQgcGdsb2csIHRoZSBwZ2xvZyBjb250YWlucyAob3Asb2Jq
ZWN0LHZlcnNpb24pIGV0Yy4gd2hlbiBwZWVyaW5nLCB1c2UgcGdsb2cgdG8gY29uc3RydWN0IG1p
c3NpbmcgbGlzdCx0aGVuIHJlY292ZXIgdGhlIHdob2xlIG9iamVjdCBpbiBtaXNzaW5nIGxpc3Qg
ZXZlbiBpZiBkaWZmZXJlbnQgZGF0YSBhbW9uZyByZXBsaWNhcyBpcyBsZXNzIHRoZW4gYSB3aG9s
ZSBvYmplY3QgZGF0YShlZyw0TUIpLg0Kd2h5IG5vdCBhZGQgKG9mZnNldCxsZW4pIHRvIHBnbG9n
PyBJZiBzbywgdGhlIG1pc3NpbmcgbGlzdCBjYW4gY29udGFpbiAob2JqZWN0LCBvZmZzZXQsIGxl
biksIHRoZW4gd2UgY2FuIHJlZHVjZSByZWNvdmVyIGRhdGEuIA0KDQoyMDE1LTEyLTI1DQoNCg0K
DQphcmNoZXIud3Vkb25n
--====003__MESSAGE__ID__54yg6f6h6y456345====
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPFNUWUxFIHR5cGU9dGV4dC9jc3M+IDwhLS1AaW1wb3J0IHVy
bChzY3JvbGxiYXIuY3NzKTsgLS0+PC9TVFlMRT4NCg0KPE1FVEEgY29udGVudD0idGV4dC9odG1s
OyBjaGFyc2V0PXV0Zi04IiBodHRwLWVxdWl2PUNvbnRlbnQtVHlwZT4NCjxTVFlMRT4JCQlCTE9D
S1FVT1RFe21hcmdpbi1Ub3A6IDBweDsgbWFyZ2luLUJvdHRvbTogMHB4OyBtYXJnaW4tTGVmdDog
MmVtfQkJCWJvZHl7Rk9OVC1TSVpFOjEyLjFwdDsgQ09MT1I6IzAwMTsgRk9OVC1GQU1JTFk65a6L
5L2TLHNlcmlmO30JCTwvU1RZTEU+DQoNCjxNRVRBIG5hbWU9R0VORVJBVE9SIGNvbnRlbnQ9Ik1T
SFRNTCA4LjAwLjc2MDEuMTkwNTgiPjxCQVNFIA0KdGFyZ2V0PV9ibGFuaz48L0hFQUQ+DQo8Qk9E
WSANCnN0eWxlPSJMSU5FLUhFSUdIVDogMS4zOyBCT1JERVItUklHSFQtV0lEVEg6IDBweDsgTUFS
R0lOOiAxMnB4OyBCT1JERVItVE9QLVdJRFRIOiAwcHg7IEJPUkRFUi1CT1RUT00tV0lEVEg6IDBw
eDsgQk9SREVSLUxFRlQtV0lEVEg6IDBweCIgDQptYXJnaW5oZWlnaHQ9IjAiIG1hcmdpbndpZHRo
PSIwIj48U1RBVElPTkVSWT4NCjxESVY+PEZPTlQgY29sb3I9IzAwMDAwMCBzaXplPTMgZmFjZT3l
rovkvZM+SGksPC9GT05UPjwvRElWPg0KPERJVj48Rk9OVCBjb2xvcj0jMDAwMDAwIHNpemU9Mz5J
IGhhdmUgZG91YnQgYWJvdXQgcGdsb2csIHRoZSBwZ2xvZyBjb250YWlucyANCihvcCxvYmplY3Qs
dmVyc2lvbikgZXRjLiB3aGVuIHBlZXJpbmcsIHVzZSBwZ2xvZyB0byBjb25zdHJ1Y3QgbWlzc2lu
ZyBsaXN0LHRoZW4gDQpyZWNvdmVyIHRoZSB3aG9sZSBvYmplY3QgaW4gbWlzc2luZyBsaXN0IGV2
ZW4gaWYgZGlmZmVyZW50IGRhdGEgYW1vbmcgcmVwbGljYXMgDQppcyBsZXNzIHRoZW4gYSB3aG9s
ZSBvYmplY3QgZGF0YShlZyw0TUIpLjwvRk9OVD48L0RJVj4NCjxESVY+PEZPTlQgY29sb3I9IzAw
MDAwMCBzaXplPTM+d2h5IG5vdCBhZGQgKG9mZnNldCxsZW4pIHRvIHBnbG9nPyBJZiANCnNvLCZu
YnNwO3RoZSBtaXNzaW5nIGxpc3QgY2FuIGNvbnRhaW4gKG9iamVjdCwgb2Zmc2V0LCBsZW4pLCB0
aGVuIHdlIGNhbiByZWR1Y2UgDQpyZWNvdmVyIGRhdGEuJm5ic3A7PC9GT05UPjwvRElWPg0KPERJ
Vj4mbmJzcDs8L0RJVj4NCjxESVYgYWxpZ249bGVmdD48Rk9OVCBjb2xvcj0jYzBjMGMwIHNpemU9
MiANCmZhY2U9VmVyZGFuYT4yMDE1LTEyLTI1PC9GT05UPjwvRElWPjxGT05UIHNpemU9MiBmYWNl
PVZlcmRhbmE+DQo8SFIgc3R5bGU9IldJRFRIOiAxMjJweDsgSEVJR0hUOiAycHgiIGlkPVNpZ25O
YW1lSFIgYWxpZ249bGVmdCBTSVpFPTI+DQo8L0ZPTlQ+DQo8RElWPjxGT05UIGNvbG9yPSNjMGMw
YzAgc2l6ZT0yIGZhY2U9VmVyZGFuYT48U1BBTiANCmlkPV9GbGFzaFNpZ25OYW1lPmFyY2hlci53
dWRvbmc8L1NQQU4+PC9GT05UPjwvRElWPjwvU1RBVElPTkVSWT48L0JPRFk+PC9IVE1MPg==
--====003__MESSAGE__ID__54yg6f6h6y456345====--


--===============0200107725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0200107725==--
