From: "Talyansky, Roman" <roman.talyansky@sap.com>
Subject: Re: Write operation is stuck
Date: Tue, 16 Feb 2010 18:27:46 +0100
Message-ID: <C6A64D82E3A5D24B949315CFBC1FA1AD072A0E1D74@DEWDFECCR01.wdf.sap.corp>
References: <C6A64D82E3A5D24B949315CFBC1FA1AD0729EFCD7D@DEWDFECCR01.wdf.sap.corp>
	<Pine.LNX.4.64.1002101332500.32089@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_C6A64D82E3A5D24B949315CFBC1FA1AD072A0E1D74DEWDFECCR01wd_"
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.1002101332500.32089@cobra.newdream.net>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@lists.sourceforge.net" <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

--_002_C6A64D82E3A5D24B949315CFBC1FA1AD072A0E1D74DEWDFECCR01wd_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Sage,

I am trying to reproduce the hang with the latest client and servers.
I am able to start the servers, however mount fails with input/output error=
 5. The dmesg listing shows the following info:

[17008.244739] ceph: loaded 0.18.0 (mon/mds/osd proto 15/30/22)
[17015.888143] ceph: mon0 10.55.147.70:6789 connection failed
[17025.880170] ceph: mon0 10.55.147.70:6789 connection failed
[17035.880121] ceph: mon0 10.55.147.70:6789 connection failed
[17045.880189] ceph: mon0 10.55.147.70:6789 connection failed
[17055.880130] ceph: mon0 10.55.147.70:6789 connection failed
[17065.880113] ceph: mon0 10.55.147.70:6789 connection failed
[17075.880170] ceph: mon0 10.55.147.70:6789 connection failed

The server is reachable, as the following command output shows:

$ nc 10.55.147.83 6789
ceph v027

I started running the experiments with ceph 0.18 using the configuration, w=
here clients and servers run on separate nodes. It turns out that the perfo=
rmance is extremely bad. Looking at dmesg trace I see ceph-related faults (=
the partial trace is attached to the email).

Any suggestions how to proceed are more than welcome.

Thanks,
Roman

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]=20
Sent: Wednesday, February 10, 2010 11:39 PM
To: Talyansky, Roman
Cc: ceph-devel@lists.sourceforge.net
Subject: Re: [ceph-devel] Write operation is stuck

Hi Roman,

On Wed, 10 Feb 2010, Talyansky, Roman wrote:

> Hello,
>=20
> Recently I ran three application  instances simultaneously over a mounted=
 CEPH file system and one of them got stuck calling a write operation.
> I had the following CEPH configuration:
> -       The nodes have Debian installation - lenny  , unstable
> -       Three nodes with osd servers
> -       Three client nodes
> -       One client node among the three mentioned above was located at a =
node where an osd server ran.
>=20
> Can the origin of the problem be the client collocated with an osd server=
?

The collocated client+osd can theoretically cause problems when you run=20
out of memory, but it doesn't sound like that's the case here.

> Can you help me to resolve this issue?

I assume the OSDs and MDS are all still running?

We fixed a number of bugs recently with multiple clients interacting with=20
the same files.  Is the hang reproducable?  Can you try it with the latest=
=20
unstable client and servers?  Or, enable mds debug logging and post that=20
somewhere (debug mds =3D 20, debug ms =3D 1)?

Thanks-
sage

--_002_C6A64D82E3A5D24B949315CFBC1FA1AD072A0E1D74DEWDFECCR01wd_
Content-Type: text/plain; name="trace.txt"
Content-Description: trace.txt
Content-Disposition: attachment; filename="trace.txt"; size=4287;
	creation-date="Tue, 16 Feb 2010 16:02:44 GMT";
	modification-date="Tue, 16 Feb 2010 16:02:54 GMT"
Content-Transfer-Encoding: base64

WzExMjY5MS41MTY1MzhdIGdlbmVyYWwgcHJvdGVjdGlvbiBmYXVsdDogMDAwMCBbIzczXSBTTVAN
ClsxMTI2OTEuNTIwNTE3XSBsYXN0IHN5c2ZzIGZpbGU6IC9zeXMvZGV2aWNlcy92aXJ0dWFsL25l
dC9sby9vcGVyc3RhdGUNClsxMTI2OTEuNTIwNTE3XSBDUFUgMQ0KWzExMjY5MS41MjA1MTddIE1v
ZHVsZXMgbGlua2VkIGluOiBjZXBoIGNyYzMyYyBsaWJjcmMzMmMgbmZzIGxvY2tkIGZzY2FjaGUg
bmZzX2FjbCBhdXRoX3JwY2dzcyBzdW5ycGMgYXV0b2ZzNCBleHQ0IGpiZDIgY3JjMTYgbG9vcCBw
YXJwb3J0X3BjIGZzY2htZCBpMmNfaTgwMQ0KIHBhcnBvcnQgaTJjX2NvcmUgc25kX2hkYV9jb2Rl
Y19yZWFsdGVrIGV2ZGV2IHRwbV9pbmZpbmVvbiBzbmRfaGRhX2ludGVsIHBzbW91c2Ugc2VyaW9f
cmF3IHRwbSBzbmRfaGRhX2NvZGVjIHNuZF9wY3NwIHNuZF9od2RlcCBzbmRfcGNtIHNuZF90aW1l
ciBzbmQgc291bmRjbw0KcmUgc25kX3BhZ2VfYWxsb2MgY29udGFpbmVyIHRwbV9iaW9zIHByb2Nl
c3NvciBleHQzIGpiZCBtYmNhY2hlIHNnIHNkX21vZCBjcmNfdDEwZGlmIHNyX21vZCBjZHJvbSBp
ZGVfcGNpX2dlbmVyaWMgaWRlX2NvcmUgYXRhX2dlbmVyaWMgdWhjaV9oY2QgZmxvcHB5IGF0YV9w
aQ0KaXggYnV0dG9uIGUxMDAwZSBpbnRlbF9hZ3AgYWdwZ2FydCBsaWJhdGEgZWhjaV9oY2Qgc2Nz
aV9tb2QgdXNiY29yZSBubHNfYmFzZSB0aGVybWFsIGZhbiB0aGVybWFsX3N5cyBbbGFzdCB1bmxv
YWRlZDogc2NzaV93YWl0X3NjYW5dDQpbMTEyNjkxLjUyMDUxN10gUGlkOiAzNzgwLCBjb21tOiBp
b3BsYXllcjIgVGFpbnRlZDogRyAgICAgIEQgICAgMi42LjMyLXRydW5rLWFtZDY0ICMxIEVTUFJJ
TU8gUDU5MjUNClsxMTI2OTEuNTIwNTE3XSBSSVA6IDAwMTA6WzxmZmZmZmZmZmEwM2E2ZjE2Pl0g
IFs8ZmZmZmZmZmZhMDNhNmYxNj5dIHplcm9fdXNlcl9zZWdtZW50KzB4NjIvMHg3NSBbY2VwaF0N
ClsxMTI2OTEuNTIwNTE3XSBSU1A6IDAwMTg6ZmZmZjg4MDAzNzg2MWM4OCAgRUZMQUdTOiAwMDAx
MDI0Ng0KWzExMjY5MS41MjA1MTddIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IDAwMDAwMDAw
ZmZmYThkODcgUkNYOiAwMDAwMDAwMDAwMDAxMDAwDQpbMTEyNjkxLjUyMDUxN10gUkRYOiA2ZGI2
ZGI2ZGI2ZGI2ZGI3IFJTSTogMDAwMDAwMDAwMDAwMDAwMCBSREk6IDc2ZjE5NzMyZWI3YmMwMDAN
ClsxMTI2OTEuNTIwNTE3XSBSQlA6IDAwMDAwMDAwMDAwMDEwMDAgUjA4OiAzMTIwMzkzNTMyMzgz
MTIwIFIwOTogZmZmZmZmZmY4MTQzOTBiMA0KWzExMjY5MS41MjA1MTddIFIxMDogZmZmZjg4MDEw
YjE1NzgwMCBSMTE6IGZmZmY4ODAwZDY4MDIwMDAgUjEyOiAwMDAwMDAwMGZmZmE4ZDg2DQpbMTEy
NjkxLjUyMDUxN10gUjEzOiAwMDAwMDAwMDAwMDAyMDAwIFIxNDogZmZmZjg4MDEwYTkxOGIxMCBS
MTU6IGZmZmY4ODAxMGE5MThiMTANClsxMTI2OTEuNTIwNTE3XSBGUzogIDAwMDA3ZjViZTI3ZmM5
MTAoMDAwMCkgR1M6ZmZmZjg4MDAwNTEwMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAw
DQpbMTEyNjkxLjUyMDUxN10gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAw
MDA4MDA1MDAzMw0KWzExMjY5MS41MjA1MTddIENSMjogMDAwMDdmNGJkM2E5Y2E5MCBDUjM6IDAw
MDAwMDAxMDk0NjEwMDAgQ1I0OiAwMDAwMDAwMDAwMDAwNmUwDQpbMTEyNjkxLjUyMDUxN10gRFIw
OiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAw
MDAwMDANClsxMTI2OTEuNTIwNTE3XSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAw
MGZmZmYwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMA0KWzExMjY5MS41MjA1MTddIFByb2Nlc3Mg
aW9wbGF5ZXIyIChwaWQ6IDM3ODAsIHRocmVhZGluZm8gZmZmZjg4MDAzNzg2MDAwMCwgdGFzayBm
ZmZmODgwMDM3OTQ1YmQwKQ0KWzExMjY5MS41MjA1MTddIFN0YWNrOg0KWzExMjY5MS41MjA1MTdd
ICAwMDAwMDEwMDAwMDAwMjMwIGZmZmZmZmZmYTAzYTZmOTMgMDAwMDAwMDAwMDAwMDAwMCAwMDAw
MDAwMWE4ZDg2MDAwDQpbMTEyNjkxLjUyMDUxN10gPDA+IDAwMDAwMDAwMDAwMDAwMDEgMDAwMDAw
MDAwMDAwMDAwMCAwMDAwMDAwMWE4ZDg2MDAwIGZmZmZmZmZmYTAzYTdiZjcNClsxMTI2OTEuNTIw
NTE3XSA8MD4gZmZmZjg4MDAwMDAwMDAwMCBmZmZmZmZmZmZmZmZmZmZmIGZmZmY4ODAxMGE5MThi
MTAgZmZmZjg4MDEwMDAwMDAwMg0KWzExMjY5MS41MjA1MTddIENhbGwgVHJhY2U6DQpbMTEyNjkx
LjUyMDUxN10gIFs8ZmZmZmZmZmZhMDNhNmY5Mz5dID8gemVyb19wYWdlX3ZlY3Rvcl9yYW5nZSsw
eDZhLzB4YTUgW2NlcGhdDQpbMTEyNjkxLjUyMDUxN10gIFs8ZmZmZmZmZmZhMDNhN2JmNz5dID8g
Y2VwaF9haW9fcmVhZCsweDMzZC8weDRhYSBbY2VwaF0NClsxMTI2OTEuNTIwNTE3XSAgWzxmZmZm
ZmZmZjgxMGViZjAxPl0gPyBkb19zeW5jX3JlYWQrMHhjZS8weDExMw0KWzExMjY5MS41MjA1MTdd
ICBbPGZmZmZmZmZmODEwNjc2ZDQ+XSA/IGhydGltZXJfdHJ5X3RvX2NhbmNlbCsweDNhLzB4NDMN
ClsxMTI2OTEuNTIwNTE3XSAgWzxmZmZmZmZmZjgxMDY0YWFlPl0gPyBhdXRvcmVtb3ZlX3dha2Vf
ZnVuY3Rpb24rMHgwLzB4MmUNClsxMTI2OTEuNTIwNTE3XSAgWzxmZmZmZmZmZjgxMDY3NmU5Pl0g
PyBocnRpbWVyX2NhbmNlbCsweGMvMHgxNg0KWzExMjY5MS41MjA1MTddICBbPGZmZmZmZmZmODEy
ZTYyYWE+XSA/IGRvX25hbm9zbGVlcCsweDZkLzB4YTMNClsxMTI2OTEuNTIwNTE3XSAgWzxmZmZm
ZmZmZjgxMDNhYTlhPl0gPyBwaWNrX25leHRfdGFzaysweDI0LzB4M2YNClsxMTI2OTEuNTIwNTE3
XSAgWzxmZmZmZmZmZjgxMGVjOTRhPl0gPyB2ZnNfcmVhZCsweGE2LzB4ZmYNClsxMTI2OTEuNTIw
NTE3XSAgWzxmZmZmZmZmZjgxMGVjYTVmPl0gPyBzeXNfcmVhZCsweDQ1LzB4NmUNClsxMTI2OTEu
NTIwNTE3XSAgWzxmZmZmZmZmZjgxMDEwYjAyPl0gPyBzeXN0ZW1fY2FsbF9mYXN0cGF0aCsweDE2
LzB4MWINClsxMTI2OTEuNTIwNTE3XSBDb2RlOiBiNiA2ZCBkYiBiNiA2ZCA0OSA4ZCAwNCAwMCA4
OSBmNyAyOSBmMSA0OCBjMSBmOCAwMyA0OCAwZiBhZiBjMiA0OCBjMSBlMCAwYyA0OCAwMSBjNyA0
OCBiOCAwMCAwMCAwMCAwMCAwMCA4OCBmZiBmZiA0OCAwMSBjNyAzMSBjMCA8ZjM+IGENCmEgNjUg
NDggOGIgMDQgMjUgYzggY2IgMDAgMDAgZmYgODggNDQgZTAgZmYgZmYgNTkgYzMgNDEgNTYNClsx
MTI2OTEuNTIwNTE3XSBSSVAgIFs8ZmZmZmZmZmZhMDNhNmYxNj5dIHplcm9fdXNlcl9zZWdtZW50
KzB4NjIvMHg3NSBbY2VwaF0NClsxMTI2OTEuNTIwNTE3XSAgUlNQIDxmZmZmODgwMDM3ODYxYzg4
Pg0KWzExMjY5MS44NzEyMzhdIC0tLVsgZW5kIHRyYWNlIDA5NDg2OTgzYThjZGJlMDQgXS0tLQ0K
WzExMjY5MS44NzYzMzFdIG5vdGU6IGlvcGxheWVyMlszNzgwXSBleGl0ZWQgd2l0aCBwcmVlbXB0
X2NvdW50IDENClsxMTI2OTEuODgxNDA5XSBCVUc6IHNjaGVkdWxpbmcgd2hpbGUgYXRvbWljOiBp
b3BsYXllcjIvMzc4MC8weDEwMDAwMDAxDQpbMTEyNjkxLjg4NjQ1Ml0gTW9kdWxlcyBsaW5rZWQg
aW46IGNlcGggY3JjMzJjIGxpYmNyYzMyYyBuZnMgbG9ja2QgZnNjYWNoZSBuZnNfYWNsIGF1dGhf
cnBjZ3NzIHN1bnJwYyBhdXRvZnM0IGV4dDQgamJkMiBjcmMxNiBsb29wIHBhcnBvcnRfcGMgZnNj
aG1kIGkyY19pODAxDQogcGFycG9ydCBpMmNfY29yZSBzbmRfaGRhX2NvZGVjX3JlYWx0ZWsgZXZk
ZXYgdHBtX2luZmluZW9uIHNuZF9oZGFfaW50ZWwgcHNtb3VzZSBzZXJpb19yYXcgdHBtIHNuZF9o
ZGFfY29kZWMgc25kX3Bjc3Agc25kX2h3ZGVwIHNuZF9wY20gc25kX3RpbWVyIHNuZCBzb3VuZGNv
DQpyZSBzbmRfcGFnZV9hbGxvYyBjb250YWluZXIgdHBtX2Jpb3MgcHJvY2Vzc29yIGV4dDMgamJk
IG1iY2FjaGUgc2cgc2RfbW9kIGNyY190MTBkaWYgc3JfbW9kIGNkcm9tIGlkZV9wY2lfZ2VuZXJp
YyBpZGVfY29yZSBhdGFfZ2VuZXJpYyB1aGNpX2hjZCBmbG9wcHkgYXRhX3BpDQppeCBidXR0b24g
ZTEwMDBlIGludGVsX2FncCBhZ3BnYXJ0IGxpYmF0YSBlaGNpX2hjZCBzY3NpX21vZCB1c2Jjb3Jl
IG5sc19iYXNlIHRoZXJtYWwgZmFuIHRoZXJtYWxfc3lzIFtsYXN0IHVubG9hZGVkOiBzY3NpX3dh
aXRfc2Nhbl0NClsxMTI2OTEuOTI4NDM0XSBQaWQ6IDM3ODAsIGNvbW06IGlvcGxheWVyMiBUYWlu
dGVkOiBHICAgICAgRCAgICAyLjYuMzItdHJ1bmstYW1kNjQgIzENClsxMTI2OTEuOTM4ODAyXSBD
YWxsIFRyYWNlOg0K

--_002_C6A64D82E3A5D24B949315CFBC1FA1AD072A0E1D74DEWDFECCR01wd_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
--_002_C6A64D82E3A5D24B949315CFBC1FA1AD072A0E1D74DEWDFECCR01wd_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--_002_C6A64D82E3A5D24B949315CFBC1FA1AD072A0E1D74DEWDFECCR01wd_--
