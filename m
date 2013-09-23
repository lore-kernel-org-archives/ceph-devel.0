From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: RE: CEPH Erasure Encoding + OSD Scalability
Date: Mon, 23 Sep 2013 15:43:56 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4A52736D1@PLOXCHG03.cern.ch>
References: <3472A07E6605974CBC9BC573F1BC02E4A527352B@PLOXCHG03.cern.ch>,<523FED54.8040208@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_3472A07E6605974CBC9BC573F1BC02E4A52736D1PLOXCHG03cernch_"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx30.cern.ch ([137.138.144.177]:9523 "EHLO CERNMX30.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566Ab3IWPn5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Sep 2013 11:43:57 -0400
In-Reply-To: <523FED54.8040208@dachary.org>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

--_002_3472A07E6605974CBC9BC573F1BC02E4A52736D1PLOXCHG03cernch_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Loic, =0A=
=0A=
I have modified the Jerasure unit test, to record the encoding & reconstruc=
tion performance and to store this value in the optional google-test xml ou=
tputfile. I have put (4,2) with a 4MB random object as default and one can =
pass a different object size via '--object-size=3D1000' (for 1G).=0A=
=0A=
It looks like this:=0A=
=0A=
./unittest_erasure_code_jerasure --gtest_filter=3D*.* --log-to-stderr=3Dtru=
e --gtest_output=3D"xml:erasure.xml" --object-size=3D1000=0A=
Note: Google Test filter =3D *.*=0A=
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 8 tests from 8 test cases.=0A=
[----------] Global test environment set-up.=0A=
[----------] 1 test from ErasureCodeTest/0, where TypeParam =3D ErasureCode=
JerasureReedSolomonVandermonde=0A=
[ RUN      ] ErasureCodeTest/0.encode_decode=0A=
[       OK ] ErasureCodeTest/0.encode_decode (35231 ms)=0A=
[----------] 1 test from ErasureCodeTest/0 (35231 ms total)=0A=
=0A=
[----------] 1 test from ErasureCodeTest/1, where TypeParam =3D ErasureCode=
JerasureReedSolomonRAID6=0A=
[ RUN      ] ErasureCodeTest/1.encode_decode=0A=
[       OK ] ErasureCodeTest/1.encode_decode (35594 ms)=0A=
[----------] 1 test from ErasureCodeTest/1 (35594 ms total)=0A=
=0A=
[----------] 1 test from ErasureCodeTest/2, where TypeParam =3D ErasureCode=
JerasureCauchyOrig=0A=
[ RUN      ] ErasureCodeTest/2.encode_decode=0A=
[       OK ] ErasureCodeTest/2.encode_decode (33009 ms)=0A=
[----------] 1 test from ErasureCodeTest/2 (33010 ms total)=0A=
=0A=
[----------] 1 test from ErasureCodeTest/3, where TypeParam =3D ErasureCode=
JerasureCauchyGood=0A=
[ RUN      ] ErasureCodeTest/3.encode_decode=0A=
[       OK ] ErasureCodeTest/3.encode_decode (31917 ms)=0A=
[----------] 1 test from ErasureCodeTest/3 (31920 ms total)=0A=
=0A=
[----------] 1 test from ErasureCodeTest/4, where TypeParam =3D ErasureCode=
JerasureLiberation=0A=
[ RUN      ] ErasureCodeTest/4.encode_decode=0A=
[       OK ] ErasureCodeTest/4.encode_decode (31801 ms)=0A=
[----------] 1 test from ErasureCodeTest/4 (31801 ms total)=0A=
=0A=
[----------] 1 test from ErasureCodeTest/5, where TypeParam =3D ErasureCode=
JerasureBlaumRoth=0A=
[ RUN      ] ErasureCodeTest/5.encode_decode=0A=
[       OK ] ErasureCodeTest/5.encode_decode (31927 ms)=0A=
[----------] 1 test from ErasureCodeTest/5 (31927 ms total)=0A=
=0A=
[----------] 1 test from ErasureCodeTest/6, where TypeParam =3D ErasureCode=
JerasureLiber8tion=0A=
[ RUN      ] ErasureCodeTest/6.encode_decode=0A=
[       OK ] ErasureCodeTest/6.encode_decode (31824 ms)=0A=
[----------] 1 test from ErasureCodeTest/6 (31824 ms total)=0A=
=0A=
[----------] 1 test from ErasureCodeTiming=0A=
[ RUN      ] ErasureCodeTiming.PropertyOutput=0A=
[ -TIMING- ] technique=3Dblaum_roth       speed [ encode ]=3D2.902 [GB/s]=
=0A=
[ -TIMING- ] technique=3Dblaum_roth       speed [   reco ]=3D1.701 [GB/s]=
=0A=
[ -TIMING- ] technique=3Dcauchy_good      speed [ encode ]=3D2.551 [GB/s]=
=0A=
[ -TIMING- ] technique=3Dcauchy_good      speed [   reco ]=3D1.571 [GB/s]=
=0A=
[ -TIMING- ] technique=3Dcauchy_orig      speed [ encode ]=3D1.401 [GB/s]=
=0A=
[ -TIMING- ] technique=3Dcauchy_orig      speed [   reco ]=3D0.911 [GB/s]=
=0A=
[ -TIMING- ] technique=3Dliber8tion       speed [ encode ]=3D2.861 [GB/s]=
=0A=
[ -TIMING- ] technique=3Dliber8tion       speed [   reco ]=3D1.822 [GB/s]=
=0A=
[ -TIMING- ] technique=3Dliberation       speed [ encode ]=3D2.863 [GB/s]=
=0A=
[ -TIMING- ] technique=3Dliberation       speed [   reco ]=3D1.815 [GB/s]=
=0A=
[ -TIMING- ] technique=3Dreed_sol_r6_op   speed [ encode ]=3D1.194 [GB/s]=
=0A=
[ -TIMING- ] technique=3Dreed_sol_r6_op   speed [   reco ]=3D0.489 [GB/s]=
=0A=
[ -TIMING- ] technique=3Dreed_sol_van     speed [ encode ]=3D0.600 [GB/s]=
=0A=
[ -TIMING- ] technique=3Dreed_sol_van     speed [   reco ]=3D0.429 [GB/s]=
=0A=
[       OK ] ErasureCodeTiming.PropertyOutput (0 ms)=0A=
[----------] 1 test from ErasureCodeTiming (0 ms total)=0A=
=0A=
[----------] Global test environment tear-down=0A=
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 8 tests from 8 test cases ran. (231307 ms =
total)=0A=
[  PASSED  ] 8 tests.=0A=
=0A=
=0A=
[----------] Global test environment tear-down=0A=
[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 8 tests from 8 test cases ran. (31351 ms t=
otal)=0A=
[  PASSED  ] 8 tests.=0A=
=0A=
And the XML:=0A=
=0A=
<testsuite name=3D"ErasureCodeTiming" tests=3D"1" failures=3D"0" disabled=
=3D"0" errors=3D"0" time=3D"0">=0A=
    <testcase name=3D"PropertyOutput" status=3D"run" time=3D"0" classname=
=3D"ErasureCodeTiming" jerasure::blaum_roth::encode=3D"2902" jerasure::blau=
m_roth::reco=3D"1700" jerasure::cauchy_good::encode=3D"2551" jerasure::cauc=
hy_good::reco=3D"1571" jerasure::cauchy_orig::encode=3D"1401" jerasure::cau=
chy_orig::reco=3D"910" jerasure::liber8tion::encode=3D"2861" jerasure::libe=
r8tion::reco=3D"1821" jerasure::liberation::encode=3D"2862" jerasure::liber=
ation::reco=3D"1814" jerasure::reed_sol_r6_op::encode=3D"1194" jerasure::re=
ed_sol_r6_op::reco=3D"489" jerasure::reed_sol_van::encode=3D"599" jerasure:=
:reed_sol_van::reco=3D"428" object-size=3D"1000000000" />=0A=
  </testsuite>=0A=
=0A=
Maybe you could use this directly for QA.=0A=
=0A=
Cheers Andreas.=0A=

--_002_3472A07E6605974CBC9BC573F1BC02E4A52736D1PLOXCHG03cernch_
Content-Type: text/x-c++src; name="TestErasureCodeJerasure.cc"
Content-Description: TestErasureCodeJerasure.cc
Content-Disposition: attachment; filename="TestErasureCodeJerasure.cc";
	size=6271; creation-date="Mon, 23 Sep 2013 15:43:00 GMT";
	modification-date="Mon, 23 Sep 2013 15:43:00 GMT"
Content-Transfer-Encoding: base64

Ly8gLSotIG1vZGU6QysrOyB0YWItd2lkdGg6ODsgYy1iYXNpYy1vZmZzZXQ6MjsgaW5kZW50LXRh
YnMtbW9kZTp0IC0qLSAKLy8gdmltOiB0cz04IHN3PTIgc21hcnR0YWIKLyoKICogQ2VwaCAtIHNj
YWxhYmxlIGRpc3RyaWJ1dGVkIGZpbGUgc3lzdGVtCiAqCiAqIENvcHlyaWdodCAoQykgMjAxMyBD
bG91ZHdhdHQgPGxpYnJlLmxpY2Vuc2luZ0BjbG91ZHdhdHQuY29tPgogKgogKiBBdXRob3I6IExv
aWMgRGFjaGFyeSA8bG9pY0BkYWNoYXJ5Lm9yZz4KICoKICogIFRoaXMgbGlicmFyeSBpcyBmcmVl
IHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IKICogIG1vZGlmeSBpdCB1
bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBMZXNzZXIgR2VuZXJhbCBQdWJsaWMKICogIExpY2Vu
c2UgYXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlcgog
KiAgdmVyc2lvbiAyLjEgb2YgdGhlIExpY2Vuc2UsIG9yIChhdCB5b3VyIG9wdGlvbikgYW55IGxh
dGVyIHZlcnNpb24uCiAqIAogKi8KCiNpbmNsdWRlICJnbG9iYWwvZ2xvYmFsX2luaXQuaCIKI2lu
Y2x1ZGUgIm9zZC9FcmFzdXJlQ29kZVBsdWdpbkplcmFzdXJlL0VyYXN1cmVDb2RlSmVyYXN1cmUu
aCIKI2luY2x1ZGUgImNvbW1vbi9jZXBoX2FyZ3BhcnNlLmgiCiNpbmNsdWRlICJjb21tb24vQ2xv
Y2suaCIKI2luY2x1ZGUgImNvbW1vbi9jZXBoX2NvbnRleHQuaCIKI2luY2x1ZGUgImdsb2JhbC9n
bG9iYWxfY29udGV4dC5oIgojaW5jbHVkZSAiZ3Rlc3QvZ3Rlc3QuaCIKCnR5cGVkZWYgc3RkOjpt
YXA8c3RkOjpzdHJpbmcsdXRpbWVfdD4gdGltaW5nX3Q7CnR5cGVkZWYgc3RkOjptYXA8c3RkOjpz
dHJpbmcsdGltaW5nX3QgPiB0aW1pbmdfbWFwX3Q7CnRpbWluZ19tYXBfdCB0aW1pbmc7CnVuc2ln
bmVkIG9iamVjdF9zaXplID0gNCoxMDAwKjEwMDBsbDsKCnRlbXBsYXRlIDx0eXBlbmFtZSBUPgpj
bGFzcyBFcmFzdXJlQ29kZVRlc3QgOiBwdWJsaWMgOjp0ZXN0aW5nOjpUZXN0IHsKIHB1YmxpYzoK
fTsKCnR5cGVkZWYgOjp0ZXN0aW5nOjpUeXBlczwKICBFcmFzdXJlQ29kZUplcmFzdXJlUmVlZFNv
bG9tb25WYW5kZXJtb25kZSwKICBFcmFzdXJlQ29kZUplcmFzdXJlUmVlZFNvbG9tb25SQUlENiwK
ICBFcmFzdXJlQ29kZUplcmFzdXJlQ2F1Y2h5T3JpZywKICBFcmFzdXJlQ29kZUplcmFzdXJlQ2F1
Y2h5R29vZCwKICBFcmFzdXJlQ29kZUplcmFzdXJlTGliZXJhdGlvbiwKICBFcmFzdXJlQ29kZUpl
cmFzdXJlQmxhdW1Sb3RoLAogIEVyYXN1cmVDb2RlSmVyYXN1cmVMaWJlcjh0aW9uCj4gSmVyYXN1
cmVUeXBlczsKVFlQRURfVEVTVF9DQVNFKEVyYXN1cmVDb2RlVGVzdCwgSmVyYXN1cmVUeXBlcyk7
CgpUWVBFRF9URVNUKEVyYXN1cmVDb2RlVGVzdCwgZW5jb2RlX2RlY29kZSkgewogIFR5cGVQYXJh
bSBqZXJhc3VyZTsKICBtYXA8c3RkOjpzdHJpbmcsc3RkOjpzdHJpbmc+IHBhcmFtZXRlcnM7CiAg
cGFyYW1ldGVyc1siZXJhc3VyZS1jb2RlLWsiXSA9ICI0IjsKICBwYXJhbWV0ZXJzWyJlcmFzdXJl
LWNvZGUtbSJdID0gIjIiOwoKICBpZiAoICgoc3RkOjpzdHJpbmcoamVyYXN1cmUudGVjaG5pcXVl
KT09ImxpYmVyYXRpb24iKSkgfHwKICAgICAgICgoc3RkOjpzdHJpbmcoamVyYXN1cmUudGVjaG5p
cXVlKT09ImJsYXVtX3JvdGgiKSkgKQogICAgcGFyYW1ldGVyc1siZXJhc3VyZS1jb2RlLXciXSA9
ICI3IjsKICBlbHNlCiAgICBwYXJhbWV0ZXJzWyJlcmFzdXJlLWNvZGUtdyJdID0gIjgiOwoKICBw
YXJhbWV0ZXJzWyJlcmFzdXJlLWNvZGUtcGFja2V0c2l6ZSJdID0gIjQwOTYiOwogIGplcmFzdXJl
LmluaXQocGFyYW1ldGVycyk7CgojZGVmaW5lIExBUkdFX0VOT1VHSCAoNypvYmplY3Rfc2l6ZSkK
CiAgYnVmZmVycHRyIGluX3B0cihMQVJHRV9FTk9VR0gpOwogIGluX3B0ci56ZXJvKCk7CiAgaW5f
cHRyLnNldF9sZW5ndGgoMCk7CiAgZm9yIChzaXplX3QgaT0wOyBpPCBvYmplY3Rfc2l6ZTsgaSsr
KSB7CiAgICBjaGFyIGMgPSByYW5kb20oKTsKICAgIGluX3B0ci5hcHBlbmQoJmMsMSk7CiAgfQoK
ICBidWZmZXJsaXN0IGluOwogIGluLnB1c2hfZnJvbnQoaW5fcHRyKTsKICBpbnQgd2FudF90b19l
bmNvZGVbXSA9IHsgMCwgMSwgMiwgMywgNCwgNSB9OwogIG1hcDxpbnQsIGJ1ZmZlcmxpc3Q+IGVu
Y29kZWQ7CgogIHRpbWluZ1tqZXJhc3VyZS50ZWNobmlxdWVdWyJlbmNvZGUtc3RhcnQiXSA9IGNl
cGhfY2xvY2tfbm93KDApOwogIEVYUEVDVF9FUSgwLCBqZXJhc3VyZS5lbmNvZGUoc2V0PGludD4o
d2FudF90b19lbmNvZGUsIHdhbnRfdG9fZW5jb2RlKzYpLAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmVuY29kZWQpKTsKCiAg
dGltaW5nW2plcmFzdXJlLnRlY2huaXF1ZV1bImVuY29kZS1zdG9wIl0gPSBjZXBoX2Nsb2NrX25v
dygwKTsKICBFWFBFQ1RfRVEoNnUsIGVuY29kZWQuc2l6ZSgpKTsKICB1bnNpZ25lZCBsZW5ndGgg
PSAgZW5jb2RlZFswXS5sZW5ndGgoKTsKICBFWFBFQ1RfRVEoMCwgc3RybmNtcChlbmNvZGVkWzBd
LmNfc3RyKCksIGluLmNfc3RyKCksIGxlbmd0aCkpOwogIEVYUEVDVF9FUSgwLCBzdHJuY21wKGVu
Y29kZWRbMV0uY19zdHIoKSwgaW4uY19zdHIoKSArIGxlbmd0aCwgaW4ubGVuZ3RoKCkgLSBsZW5n
dGgpKTsKCgogIC8vIGFsbCBjaHVua3MgYXJlIGF2YWlsYWJsZQogIHsKICAgIGludCB3YW50X3Rv
X2RlY29kZVtdID0geyAwLCAxIH07CiAgICBtYXA8aW50LCBidWZmZXJsaXN0PiBkZWNvZGVkOwog
ICAgRVhQRUNUX0VRKDAsIGplcmFzdXJlLmRlY29kZShzZXQ8aW50Pih3YW50X3RvX2RlY29kZSwg
d2FudF90b19kZWNvZGUrMiksCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5jb2Rl
ZCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZGVjb2RlZCkpOwogICAgLy8gYWx3
YXlzIGRlY29kZSBhbGwsIHJlZ2FyZGxlc3Mgb2Ygd2FudF90b19kZWNvZGUKICAgIEVYUEVDVF9F
USg2dSwgZGVjb2RlZC5zaXplKCkpOyAKICAgIEVYUEVDVF9FUShsZW5ndGgsIGRlY29kZWRbMF0u
bGVuZ3RoKCkpOwogICAgRVhQRUNUX0VRKDAsIHN0cm5jbXAoZGVjb2RlZFswXS5jX3N0cigpLCBp
bi5jX3N0cigpLCBsZW5ndGgpKTsKICAgIEVYUEVDVF9FUSgwLCBzdHJuY21wKGRlY29kZWRbMV0u
Y19zdHIoKSwgaW4uY19zdHIoKSArIGxlbmd0aCwgaW4ubGVuZ3RoKCkgLSBsZW5ndGgpKTsKICB9
CgogIC8vIHR3byBjaHVua3MgYXJlIG1pc3NpbmcgCiAgewogICAgbWFwPGludCwgYnVmZmVybGlz
dD4gZGVncmFkZWQgPSBlbmNvZGVkOwogICAgZGVncmFkZWQuZXJhc2UoMCk7CiAgICBkZWdyYWRl
ZC5lcmFzZSgxKTsKICAgIEVYUEVDVF9FUSg0dSwgZGVncmFkZWQuc2l6ZSgpKTsKICAgIGludCB3
YW50X3RvX2RlY29kZVtdID0geyAwLCAxIH07CiAgICBtYXA8aW50LCBidWZmZXJsaXN0PiBkZWNv
ZGVkOwogICAgdGltaW5nW2plcmFzdXJlLnRlY2huaXF1ZV1bInJlY28tc3RhcnQiXSA9IGNlcGhf
Y2xvY2tfbm93KDApOwogICAgRVhQRUNUX0VRKDAsIGplcmFzdXJlLmRlY29kZShzZXQ8aW50Pih3
YW50X3RvX2RlY29kZSwgd2FudF90b19kZWNvZGUrMiksCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZGVncmFkZWQsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmRlY29k
ZWQpKTsKICAgIHRpbWluZ1tqZXJhc3VyZS50ZWNobmlxdWVdWyJyZWNvLXN0b3AiXSA9IGNlcGhf
Y2xvY2tfbm93KDApOwogICAgLy8gYWx3YXlzIGRlY29kZSBhbGwsIHJlZ2FyZGxlc3Mgb2Ygd2Fu
dF90b19kZWNvZGUKICAgIEVYUEVDVF9FUSg2dSwgZGVjb2RlZC5zaXplKCkpOyAKICAgIEVYUEVD
VF9FUShsZW5ndGgsIGRlY29kZWRbMF0ubGVuZ3RoKCkpOwogICAgRVhQRUNUX0VRKDAsIHN0cm5j
bXAoZGVjb2RlZFswXS5jX3N0cigpLCBpbi5jX3N0cigpLCBsZW5ndGgpKTsKICAgIEVYUEVDVF9F
USgwLCBzdHJuY21wKGRlY29kZWRbMV0uY19zdHIoKSwgaW4uY19zdHIoKSArIGxlbmd0aCwgaW4u
bGVuZ3RoKCkgLSBsZW5ndGgpKTsKICB9CiAgICAKICB0aW1pbmdbamVyYXN1cmUudGVjaG5pcXVl
XVsiZW5jb2RlIl0gPSB0aW1pbmdbamVyYXN1cmUudGVjaG5pcXVlXVsiZW5jb2RlLXN0b3AiXS10
aW1pbmdbamVyYXN1cmUudGVjaG5pcXVlXVsiZW5jb2RlLXN0YXJ0Il07CiAgdGltaW5nW2plcmFz
dXJlLnRlY2huaXF1ZV1bInJlY28iXSA9IHRpbWluZ1tqZXJhc3VyZS50ZWNobmlxdWVdWyJyZWNv
LXN0b3AiXS10aW1pbmdbamVyYXN1cmUudGVjaG5pcXVlXVsicmVjby1zdGFydCJdOwoKfQoKY2xh
c3MgRXJhc3VyZUNvZGVUaW1pbmcgOiBwdWJsaWMgOjp0ZXN0aW5nOjpUZXN0IHsKIHB1YmxpYzoK
fTsKClRFU1RfRihFcmFzdXJlQ29kZVRpbWluZywgUHJvcGVydHlPdXRwdXQpIHsKICBmb3IgKHRp
bWluZ19tYXBfdDo6Y29uc3RfaXRlcmF0b3IgdGVjaG5pcXVlaXQ9dGltaW5nLmJlZ2luKCk7IHRl
Y2huaXF1ZWl0IT10aW1pbmcuZW5kKCk7ICsrdGVjaG5pcXVlaXQpIHsKICAgIGZvciAodGltaW5n
X3Q6OmNvbnN0X2l0ZXJhdG9yIG1vZGVpdD10ZWNobmlxdWVpdC0+c2Vjb25kLmJlZ2luKCk7IG1v
ZGVpdCE9dGVjaG5pcXVlaXQtPnNlY29uZC5lbmQoKTsgKyttb2RlaXQpIHsKICAgICAgY2hhciB0
aW1pbmdvdXRbNDA5Nl07CiAgICAgIGlmIChtb2RlaXQtPmZpcnN0LmZpbmQoIi1zdGFydCIpICE9
IHN0ZDo6c3RyaW5nOjpucG9zKQoJY29udGludWU7CiAgICAgIGlmIChtb2RlaXQtPmZpcnN0LmZp
bmQoIi1zdG9wIikgIT0gc3RkOjpzdHJpbmc6Om5wb3MpCgljb250aW51ZTsKICAgICAgZG91Ymxl
IHNwZWVkID0gb2JqZWN0X3NpemUvMTAwMDAwMGwvKChkb3VibGUpbW9kZWl0LT5zZWNvbmQpLzEw
MDAuMDsKICAgICAgc25wcmludGYodGltaW5nb3V0LAoJICAgICAgIHNpemVvZih0aW1pbmdvdXQp
LTEsIAoJICAgICAgICJbIC1USU1JTkctIF0gdGVjaG5pcXVlPSUtMTZzIHNwZWVkIFsgJTZzIF09
JTAyLjAzZiBbR0Ivc11cbiIsCgkgICAgICAgdGVjaG5pcXVlaXQtPmZpcnN0LmNfc3RyKCksCgkg
ICAgICAgbW9kZWl0LT5maXJzdC5jX3N0cigpLCAKCSAgICAgICBzcGVlZCk7CgogICAgICBjb3V0
IDw8IHRpbWluZ291dDsKICAgICAgc3RkOjpzdHJpbmcgcHJvcGVydHk9IHN0ZDo6c3RyaW5nKCJq
ZXJhc3VyZTo6IikgKyB0ZWNobmlxdWVpdC0+Zmlyc3QuY19zdHIoKSArICI6OiIgKyBtb2RlaXQt
PmZpcnN0LmNfc3RyKCk7CiAgICAgIFJlY29yZFByb3BlcnR5KHByb3BlcnR5LmNfc3RyKCksIHNw
ZWVkICoxMDAwKTsKICAgIH0KICB9ICAKICBSZWNvcmRQcm9wZXJ0eSgib2JqZWN0LXNpemUiLCBv
YmplY3Rfc2l6ZSk7Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikgewogIHZlY3Rv
cjxjb25zdCBjaGFyKj4gYXJnczsKICBhcmd2X3RvX3ZlYyhhcmdjLCAoY29uc3QgY2hhciAqKilh
cmd2LCBhcmdzKTsKCiAgZ2xvYmFsX2luaXQoTlVMTCwgYXJncywgQ0VQSF9FTlRJVFlfVFlQRV9D
TElFTlQsIENPREVfRU5WSVJPTk1FTlRfVVRJTElUWSwgMCk7CiAgY29tbW9uX2luaXRfZmluaXNo
KGdfY2VwaF9jb250ZXh0KTsKCiAgOjp0ZXN0aW5nOjpJbml0R29vZ2xlVGVzdCgmYXJnYywgYXJn
dik7CiAgCiAgZm9yIChpbnQgaT0wOyBpPCBhcmdjOyBpKyspIHsKICAgIHN0ZDo6c3RyaW5nIGFy
Zz1hcmd2W2ldOwogICAgaWYgKGFyZy5zdWJzdHIoMCwxNCk9PSItLW9iamVjdC1zaXplPSIpIHsK
ICAgICAgYXJnLmVyYXNlKDAsMTQpOwogICAgICBvYmplY3Rfc2l6ZSA9IGF0b2koYXJnLmNfc3Ry
KCkpKjEwMDAqMTAwMGxsOwogICAgfQogICAgaWYgKCAhb2JqZWN0X3NpemUgfHwgKG9iamVjdF9z
aXplID4gMjAwMDAwMDAwMGxsKSApIHsKICAgICAgZnByaW50ZihzdGRlcnIsImVycm9yOiAtLW9i
amVjdC1zaXplPU1CID09PiAoIDAgPCBNQiA8PSAyMDAwIClcbiIpOwogICAgICBleGl0KEVJTlZB
TCk7CiAgICB9CiAgfQogIHJldHVybiBSVU5fQUxMX1RFU1RTKCk7Cn0KCi8vIExvY2FsIFZhcmlh
YmxlczoKLy8gY29tcGlsZS1jb21tYW5kOiAiY2QgLi4vLi4gOyBtYWtlIC1qNCAmJiBtYWtlIHVu
aXR0ZXN0X2VyYXN1cmVfY29kZV9qZXJhc3VyZSAmJiB2YWxncmluZCAtLXRvb2w9bWVtY2hlY2sg
Li91bml0dGVzdF9lcmFzdXJlX2NvZGVfamVyYXN1cmUgLS1ndGVzdF9maWx0ZXI9Ki4qIC0tbG9n
LXRvLXN0ZGVycj10cnVlIC0tZGVidWctb3NkPTIwIFstLW9iamVjdC1zaXplPTRdIgovLyBFbmQ6
Cg==

--_002_3472A07E6605974CBC9BC573F1BC02E4A52736D1PLOXCHG03cernch_--
