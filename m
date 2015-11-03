From: "hzwulibin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <hzwulibin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [performance] why rbd_aio_write latency increase
	from 4ms to 7.3ms after the same test
Date: Tue, 3 Nov 2015 08:43:47 +0800
Message-ID: <201511030843428328313@gmail.com>
References: <5636F376.3090104@gmail.com>,
	<6F3FA899187F0043BA1827A69DA2F7CC03639832@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1794768861=="
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
To: =?UTF-8?B?Q2hlbiwgWGlhb3hp?= <xiaoxi.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.

--===============1794768861==
Content-Type: multipart/alternative;
	boundary="----=_001_NextPart741106821217_=----"

This is a multi-part message in MIME format.

------=_001_NextPart741106821217_=----
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

SGksDQoNClRoYW5rIHlvdSwgdGhhdCBtYWtlIHNlbnNlIGZvciB0ZXN0aW5nLCBidXQgaSdtIGFm
cmFpZCBub3QgaW4gbXkgY2FzZS4NCkV2ZW4gaSB0ZXN0IG9uIHRoZSB2b2x1bWUgdGhhdCBhbHJl
YWR5IHRlc3QgbWFueSB0aW1lcywgdGhlIElPUFMgd2lsbCBub3QgZ3Jvd2luZyB1cCANCmFnYWlu
LiBZZWFoLCBpIG1lYW4sIHRoaXMgVk0gaXMgYnJva2VuLCBJT1BTIG9mIHRoZSBWTSB3aWxsIG5l
dmVyIGdyb3dpbmcgdXAuLg0KDQpUaGFua3MhDQoNCg0KDQpoend1bGliaW5AZ21haWwuY29tDQog
DQpGcm9tOiBDaGVuLCBYaWFveGkNCkRhdGU6IDIwMTUtMTEtMDIgMTQ6MTENClRvOiBoend1bGli
aW47IGNlcGgtZGV2ZWw7IGNlcGgtdXNlcnMNClN1YmplY3Q6IFJFOiBbcGVyZm9ybWFuY2VdIHdo
eSByYmRfYWlvX3dyaXRlIGxhdGVuY3kgaW5jcmVhc2UgZnJvbSA0bXMgdG8gNy4zbXMgYWZ0ZXIg
dGhlIHNhbWUgdGVzdA0KUHJlLWFsbG9jYXRlZCB0aGUgdm9sdW1lIGJ5ICJERCIgYWNyb3NzIHRo
ZSBlbnRpcmUgUkJEIGJlZm9yZSB5b3UgZG8gYW55IHBlcmZvcm1hbmNlIHRlc3Q6KS4NCiANCklu
IHRoaXMgY2FzZSwgeW91IG1heSB3YW50IHRvIHJlLWNyZWF0ZSB0aGUgUkJELCBwcmUtYWxsb2Nh
dGUgYW5kIHRyeSBhZ2Fpbi4NCiANCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogY2VwaC1kZXZlbC1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpjZXBoLWRldmVsLQ0K
PiBvd25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBoend1bGliaW4NCj4gU2VudDog
TW9uZGF5LCBOb3ZlbWJlciAyLCAyMDE1IDE6MjQgUE0NCj4gVG86IGNlcGgtZGV2ZWw7IGNlcGgt
dXNlcnMNCj4gU3ViamVjdDogW3BlcmZvcm1hbmNlXSB3aHkgcmJkX2Fpb193cml0ZSBsYXRlbmN5
IGluY3JlYXNlIGZyb20gNG1zIHRvDQo+IDcuM21zIGFmdGVyIHRoZSBzYW1lIHRlc3QNCj4gDQo+
IEhpLA0KPiBzYW1lIGVudmlyb25tZW50LCBhZnRlciBhIHRlc3Qgc2NyaXB0LCB0aGUgaW8gbGF0
ZW5jeShnZXQgZnJvbSBzdWRvIGNlcGggLS0NCj4gYWRtaW4tZGFlbW9uIC9ydW4vY2VwaC9ndWVz
dHMvY2VwaC1jbGllbnQuKi5hc29rIHBlciBkdW1wKSBpbmNyZWFzZQ0KPiBmcm9tIGFib3V0IDRt
cyB0byA3LjNtcw0KPiANCj4gcWVtdSB2ZXJzaW9uOiBkZWJpYW4gMi4xLjINCj4ga2VybmVsOjMu
MTAuNDUtb3BlbnN0YWNrLWFtZDY0DQo+IHN5c3RlbTogZGViaWFuIDcuOA0KPiBjZXBoOiAwLjk0
LjUNCj4gVk0gQ1BVIG51bWJlcjogNCAgKGNwdSBNSHogOiAyNTk5Ljk5OCkNCj4gVk0gbWVtb3J5
IHNpemU6IDE2R0INCj4gOSBPU0Qgc3RvcmFnZSBzZXJ2ZXJzLCB3aXRoIDQgU1NEIE9TRCBvbiBl
YWNoLCB0b3RhbCAzNiBPU0RzLg0KPiANCj4gVGVzdCBzY3JpcHRzIGluIFZNOg0KPiAjIGNhdCBy
ZXByb2R1Y2Uuc2gNCj4gIyEvYmluL2Jhc2gNCj4gDQo+IHRpbWVzPTIwDQo+IGZvcigoaT0xO2k8
PSR0aW1lcztpKyspKQ0KPiBkbw0KPiAgICAgdG1wZGF0ZT1gZGF0ZSAiKyVGLSVUImANCj4gICAg
IGVjaG8NCj4gIj09PT09PT09PT09PT09PT09PT09PT09JHRtcGRhdGUoJGkvJHRpbWVzKT09PT09
PT09PT09PT09PT09PT0NCj4gPT09PSINCj4gICAgIHRtcD0kKChpJTIpKQ0KPiAgICAgaWYgW1sg
JHRtcCAtZXEgMCBdXTt0aGVuDQo+ICAgICAgICAgZWNobyAiIyMjIyMjIyMjIyMjIyMjIGZpbyAv
cm9vdC92ZGIuY2ZnICMjIyMjIyMjIyMjIyMjIyINCj4gICAgICAgICBmaW8gL3Jvb3QvdmRiLmNm
Zw0KPiAgICAgZWxzZQ0KPiAgICAgICAgIGVjaG8gIiMjIyMjIyMjIyMjIyMjIyBmaW8gL3Jvb3Qv
dmRjLmNmZyAjIyMjIyMjIyMjIyMjIyMiDQo+ICAgICAgICAgZmlvIC9yb290L3ZkYy5jZmcNCj4g
ICAgIGZpDQo+IGRvbmUNCj4gDQo+IA0KPiB0bXBkYXRlPWBkYXRlICIrJUYtJVQiYA0KPiBlY2hv
ICIjIyMjIyMjIyMjIyMjIyMgWyR0bXBkYXRlXSBmaW8gL3Jvb3QvdmRlLmNmZyAjIyMjIyMjIyMj
IyMjIyMiDQo+IGZpbyAvcm9vdC92ZGUuY2ZnDQo+IA0KPiANCj4gIyBjYXQgdmRiLmNmZw0KPiBb
Z2xvYmFsXQ0KPiBydz1yYW5kd3JpdGUNCj4gZGlyZWN0PTENCj4gbnVtam9icz02NA0KPiBpb2Vu
Z2luZT1zeW5jDQo+IGJzcmFuZ2U9NGstNGsNCj4gcnVudGltZT0xODANCj4gZ3JvdXBfcmVwb3J0
aW5nDQo+IA0KPiBbZGlzazAxXQ0KPiBmaWxlbmFtZT0vZGV2L3ZkYg0KPiANCj4gDQo+ICMgY2F0
IHZkYy5jZmcNCj4gW2dsb2JhbF0NCj4gcnc9cmFuZHdyaXRlDQo+IGRpcmVjdD0xDQo+IG51bWpv
YnM9NjQNCj4gaW9lbmdpbmU9c3luYw0KPiBic3JhbmdlPTRrLTRrDQo+IHJ1bnRpbWU9MTgwDQo+
IGdyb3VwX3JlcG9ydGluZw0KPiANCj4gW2Rpc2swMV0NCj4gZmlsZW5hbWU9L2Rldi92ZGMNCj4g
DQo+ICMgY2F0IHZkZC5jZmcNCj4gW2dsb2JhbF0NCj4gcnc9cmFuZHdyaXRlDQo+IGRpcmVjdD0x
DQo+IG51bWpvYnM9NjQNCj4gaW9lbmdpbmU9c3luYw0KPiBic3JhbmdlPTRrLTRrDQo+IHJ1bnRp
bWU9MTgwDQo+IGdyb3VwX3JlcG9ydGluZw0KPiANCj4gW2Rpc2swMV0NCj4gZmlsZW5hbWU9L2Rl
di92ZGQNCj4gDQo+ICMgY2F0IHZkZS5jZmcNCj4gW2dsb2JhbF0NCj4gcnc9cmFuZHdyaXRlDQo+
IGRpcmVjdD0xDQo+IG51bWpvYnM9NjQNCj4gaW9lbmdpbmU9c3luYw0KPiBic3JhbmdlPTRrLTRr
DQo+IHJ1bnRpbWU9MTgwDQo+IGdyb3VwX3JlcG9ydGluZw0KPiANCj4gW2Rpc2swMV0NCj4gZmls
ZW5hbWU9L2Rldi92ZGUNCj4gDQo+IEFmdGVyIHJ1biB0aGUgc2NyaXB0cyByZXByb2R1Y2Uuc2gs
IHRoZSBkaXNrcyBpbiB0aGUgVk0ncyBJT1BTIGN1dGRvd24gZnJvbQ0KPiAxMmsgdG8gNWssIHRo
ZSBsYXRlbmN5IGluY3JlYXNlIGZyb20gNG1zIHRvIDcuM21zLg0KPiANCj4gcnVuIHN0ZXBzOg0K
PiAxLiBjcmVhdGUgYSBWTQ0KPiAyLiBjcmVhdGUgZm91ciB2b2x1bWVzIGFuZCBhdHRhdGNoIHRv
IHRoZSBWTSAzLiBzaCByZXByb2R1Y2Uuc2ggNC4gaW4gdGhlDQo+IHJ1bnRpbWUgb2YgIHJlcHJv
ZHVjZS5zaCwgcnVuICJmaW8gdmRkLmNmZyIgb3IgImZpbyB2ZGUuY2ZnIiB0byBjaGVja3QgdGhl
DQo+IHBlcmZvcm1hbmNlDQo+IA0KPiBBZnRlciByZXByb2R1Y2Uuc2ggZmluaXNoZWQsIHBlcmZv
cm1hbmNlIGRvd24uDQo+IA0KPiANCj4gQW55b25lIGhhcyB0aGUgc2FtZSBwcm9ibGVtIG9yIGhh
cyBzb21lIGlkZWFzIGFib3V0IHRoaXM/DQo+IA0KPiBUaGFua3MhDQo+IC0tLS0tLS0tLS0tLS0t
DQo+IGh6d3VsaWJpbg0KPiAyMDE1LTExLTAyDQo+IHsubiArICAgICAgICslICBsendtICBiIOun
siAgciAgecepINevelggICAg3Kh9ICAgxqB6ICZqOit2ICAgICAgICB6WisgICt6ZiAgIGggICB+
ICAgIGkgICB6IHcgICA/DQo+ICYgKd+iIGYNCg==

------=_001_NextPart741106821217_=----
Content-Type: text/html;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3DUTF-8"><style>body { line-height: 1.5; }blockquote { margin-top: 0px; =
margin-bottom: 0px; margin-left: 0.5em; }body { font-size: 10.5pt; font-fa=
mily: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91; color: rgb(0, 0, 0); line-heig=
ht: 1.5; }</style></head><body>=0A<div><span></span>Hi,</div><div><br></di=
v><div>Thank you, that make sense for testing, but i'm afraid not in my ca=
se.</div><div>Even i test on the volume that already test many times, the =
IOPS will not growing up&nbsp;</div><div>again. Yeah, i mean, this VM is b=
roken, IOPS of the VM will never growing up..</div><div><br></div><div>Tha=
nks!</div>=0A<div><br></div><hr style=3D"width: 210px; height: 1px;" color=
=3D"#b5c4df" size=3D"1" align=3D"left">=0A<div><span><div style=3D"MARGIN:=
 10px; FONT-FAMILY: verdana; FONT-SIZE: 10pt"><div>hzwulibin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</di=
v></div></span></div>=0A<blockquote style=3D"margin-top: 0px; margin-botto=
m: 0px; margin-left: 0.5em;"><div>&nbsp;</div><div style=3D"border:none;bo=
rder-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0cm"><div style=3D"PADD=
ING-RIGHT: 8px; PADDING-LEFT: 8px; FONT-SIZE: 12px;FONT-FAMILY:tahoma;COLO=
R:#000000; BACKGROUND: #efefef; PADDING-BOTTOM: 8px; PADDING-TOP: 8px"><di=
v><b>From:</b>&nbsp;<a href=3D"mailto:xiaoxi.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org">Chen, Xiaoxi<=
/a></div><div><b>Date:</b>&nbsp;2015-11-02&nbsp;14:11</div><div><b>To:</b>=
&nbsp;<a href=3D"mailto:hzwulibin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">hzwulibin</a>; <a href=3D"mai=
lto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel</a>; <a href=3D"mailto:ceph-use=
rs-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users</a></div><div><b>Subject:</b>&nbsp;RE: [perf=
ormance] why rbd_aio_write latency increase from 4ms to 7.3ms after the sa=
me test</div></div></div><div><div>Pre-allocated the volume by "DD" across=
 the entire RBD before you do any performance test:).</div>=0A<div>&nbsp;<=
/div>=0A<div>In this case, you may want to re-create the RBD, pre-allocate=
 and try again.</div>=0A<div>&nbsp;</div>=0A<div>&gt; -----Original Messag=
e-----</div>=0A<div>&gt; From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:ce=
ph-devel-</div>=0A<div>&gt; owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of hzwulibin<=
/div>=0A<div>&gt; Sent: Monday, November 2, 2015 1:24 PM</div>=0A<div>&gt;=
 To: ceph-devel; ceph-users</div>=0A<div>&gt; Subject: [performance] why r=
bd_aio_write latency increase from 4ms to</div>=0A<div>&gt; 7.3ms after th=
e same test</div>=0A<div>&gt; </div>=0A<div>&gt; Hi,</div>=0A<div>&gt; sam=
e environment, after a test script, the io latency(get from sudo ceph --</=
div>=0A<div>&gt; admin-daemon /run/ceph/guests/ceph-client.*.asok per dump=
) increase</div>=0A<div>&gt; from about 4ms to 7.3ms</div>=0A<div>&gt; </d=
iv>=0A<div>&gt; qemu version: debian 2.1.2</div>=0A<div>&gt; kernel:3.10.4=
5-openstack-amd64</div>=0A<div>&gt; system: debian 7.8</div>=0A<div>&gt; c=
eph: 0.94.5</div>=0A<div>&gt; VM CPU number: 4&nbsp; (cpu MHz : 2599.998)<=
/div>=0A<div>&gt; VM memory size: 16GB</div>=0A<div>&gt; 9 OSD storage ser=
vers, with 4 SSD OSD on each, total 36 OSDs.</div>=0A<div>&gt; </div>=0A<d=
iv>&gt; Test scripts in VM:</div>=0A<div>&gt; # cat reproduce.sh</div>=0A<=
div>&gt; #!/bin/bash</div>=0A<div>&gt; </div>=0A<div>&gt; times=3D20</div>=
=0A<div>&gt; for((i=3D1;i&lt;=3D$times;i++))</div>=0A<div>&gt; do</div>=0A=
<div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; tmpdate=3D`date "+%F-%T"`</div>=0A<div>&=
gt;&nbsp;&nbsp;&nbsp;&nbsp; echo</div>=0A<div>&gt; "=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D$tmpdate($i/$times)=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>=0A<div>&gt; =3D=
=3D=3D=3D"</div>=0A<div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; tmp=3D$((i%2))</div>=
=0A<div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; if [[ $tmp -eq 0 ]];then</div>=0A<div=
>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo "##############=
# fio /root/vdb.cfg ###############"</div>=0A<div>&gt;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; fio /root/vdb.cfg</div>=0A<div>&gt;&nbsp;&nbs=
p;&nbsp;&nbsp; else</div>=0A<div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; echo "############### fio /root/vdc.cfg ###############"</div>=
=0A<div>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fio /root/vdc=
.cfg</div>=0A<div>&gt;&nbsp;&nbsp;&nbsp;&nbsp; fi</div>=0A<div>&gt; done</=
div>=0A<div>&gt; </div>=0A<div>&gt; </div>=0A<div>&gt; tmpdate=3D`date "+%=
F-%T"`</div>=0A<div>&gt; echo "############### [$tmpdate] fio /root/vde.cf=
g ###############"</div>=0A<div>&gt; fio /root/vde.cfg</div>=0A<div>&gt; <=
/div>=0A<div>&gt; </div>=0A<div>&gt; # cat vdb.cfg</div>=0A<div>&gt; [glob=
al]</div>=0A<div>&gt; rw=3Drandwrite</div>=0A<div>&gt; direct=3D1</div>=0A=
<div>&gt; numjobs=3D64</div>=0A<div>&gt; ioengine=3Dsync</div>=0A<div>&gt;=
 bsrange=3D4k-4k</div>=0A<div>&gt; runtime=3D180</div>=0A<div>&gt; group_r=
eporting</div>=0A<div>&gt; </div>=0A<div>&gt; [disk01]</div>=0A<div>&gt; f=
ilename=3D/dev/vdb</div>=0A<div>&gt; </div>=0A<div>&gt; </div>=0A<div>&gt;=
 # cat vdc.cfg</div>=0A<div>&gt; [global]</div>=0A<div>&gt; rw=3Drandwrite=
</div>=0A<div>&gt; direct=3D1</div>=0A<div>&gt; numjobs=3D64</div>=0A<div>=
&gt; ioengine=3Dsync</div>=0A<div>&gt; bsrange=3D4k-4k</div>=0A<div>&gt; r=
untime=3D180</div>=0A<div>&gt; group_reporting</div>=0A<div>&gt; </div>=0A=
<div>&gt; [disk01]</div>=0A<div>&gt; filename=3D/dev/vdc</div>=0A<div>&gt;=
 </div>=0A<div>&gt; # cat vdd.cfg</div>=0A<div>&gt; [global]</div>=0A<div>=
&gt; rw=3Drandwrite</div>=0A<div>&gt; direct=3D1</div>=0A<div>&gt; numjobs=
=3D64</div>=0A<div>&gt; ioengine=3Dsync</div>=0A<div>&gt; bsrange=3D4k-4k<=
/div>=0A<div>&gt; runtime=3D180</div>=0A<div>&gt; group_reporting</div>=0A=
<div>&gt; </div>=0A<div>&gt; [disk01]</div>=0A<div>&gt; filename=3D/dev/vd=
d</div>=0A<div>&gt; </div>=0A<div>&gt; # cat vde.cfg</div>=0A<div>&gt; [gl=
obal]</div>=0A<div>&gt; rw=3Drandwrite</div>=0A<div>&gt; direct=3D1</div>=
=0A<div>&gt; numjobs=3D64</div>=0A<div>&gt; ioengine=3Dsync</div>=0A<div>&=
gt; bsrange=3D4k-4k</div>=0A<div>&gt; runtime=3D180</div>=0A<div>&gt; grou=
p_reporting</div>=0A<div>&gt; </div>=0A<div>&gt; [disk01]</div>=0A<div>&gt=
; filename=3D/dev/vde</div>=0A<div>&gt; </div>=0A<div>&gt; After run the s=
cripts reproduce.sh, the disks in the VM's IOPS cutdown from</div>=0A<div>=
&gt; 12k to 5k, the latency increase from 4ms to 7.3ms.</div>=0A<div>&gt; =
</div>=0A<div>&gt; run steps:</div>=0A<div>&gt; 1. create a VM</div>=0A<di=
v>&gt; 2. create four volumes and attatch to the VM 3. sh reproduce.sh 4. =
in the</div>=0A<div>&gt; runtime of&nbsp; reproduce.sh, run "fio vdd.cfg" =
or "fio vde.cfg" to checkt the</div>=0A<div>&gt; performance</div>=0A<div>=
&gt; </div>=0A<div>&gt; After reproduce.sh finished, performance down.</di=
v>=0A<div>&gt; </div>=0A<div>&gt; </div>=0A<div>&gt; Anyone has the same p=
roblem or has some ideas about this?</div>=0A<div>&gt; </div>=0A<div>&gt; =
Thanks!</div>=0A<div>&gt; --------------</div>=0A<div>&gt; hzwulibin</div>=
=0A<div>&gt; 2015-11-02</div>=0A<div>&gt; =04 {.n +&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; +%&nbsp; lzwm&nbsp; b =EB=A7=B2&nbsp; r&nbsp; y=C7=A9 =D7=AF=
zX&nbsp; =17&nbsp; =DC=A8}&nbsp;&nbsp; =C6=A0z &amp;j:+v&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; zZ+&nbsp; +zf&nbsp;&nbsp; h&nbsp;&nbsp; ~&nbsp;&n=
bsp;&nbsp; i&nbsp;&nbsp; z =1E w&nbsp;&nbsp; ?</div>=0A<div>&gt; &amp; )=
=DF=A2=1Bf</div>=0A</div></blockquote>=0A</body></html>
------=_001_NextPart741106821217_=------


--===============1794768861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1794768861==--
