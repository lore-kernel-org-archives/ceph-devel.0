From: nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: v11.2.0 OSD crashing
 "src/os/bluestore/KernelDevice.cc: 541: FAILED assert((uint64_t)r == len) "
Date: Sun, 2 Apr 2017 00:20:45 +0530
Message-ID: <CALWuvY9yLpqiRckzF=txCYn+Th9Y==4Q8ak_48V0KVW2ywQKhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1705022365=="
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
To: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1705022365==
Content-Type: multipart/alternative; boundary=001a113cd1f05cd9b3054c1f67cf

--001a113cd1f05cd9b3054c1f67cf
Content-Type: text/plain; charset=UTF-8

Hello,

We are getting below trace on failed OSD's . Can you please explain from
the below code why this issue happening. We suspect it could be because of
underlying HW issue. We can't find anything from the syslogs. All the OSD
disk are in healthy condition.

Link :- https://fossies.org/linux/ceph/src/os/bluestore/KernelDevice.cc

===
2017-03-31 03:51:28.262403 7f71f3ed5940 -1
/home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/11.2.0/rpm/el7/BUILD/ceph-11.2.0/src/os/bluestore/
KernelDevice.cc: In function 'virtual int KernelDevice::read(uint64_t,
uint64_t, ceph::bufferlist*, IOContext*, bool)' thread 7f71f3ed5940 time
2017-03-31 03:51:28.256298
/home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/11.2.0/rpm/el7/BUILD/ceph-11.2.0/*src/os/bluestore/KernelDevice.cc:
541: FAILED assert((uint64_t)r == len)  =============>>>>>>>>>>>>>>>>>>>>>*

ceph version 11.2.0 (f223e27eeb35991352ebc1f67423d4ebc252adb7)
1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x85) [0x7f71f49b6b35]
2: (KernelDevice::read(unsigned long, unsigned long, ceph::buffer::list*,
IOContext*, bool)+0x7a0) [0x7f71f47fdf10]
3: (BlueFS::_read(BlueFS::FileReader*, BlueFS::FileReaderBuffer*, unsigned
long, unsigned long, ceph::buffer::list*, char*)+0x47a) [0x7f71f47c8d4a]
4: (BlueRocksSequentialFile::Read(unsigned long, rocksdb::Slice*,
char*)+0x36) [0x7f71f47ecd46]
5: (rocksdb::SequentialFileReader::Read(unsigned long, rocksdb::Slice*,
char*)+0x16) [0x7f71f48f4136]
6: (rocksdb::log::Reader::ReadMore(unsigned long*, int*)+0xd8)
[0x7f71f487d658]
7: (rocksdb::log::Reader::ReadPhysicalRecord(rocksdb::Slice*, unsigned
long*)+0x44) [0x7f71f487d734]
8: (rocksdb::log::Reader::ReadRecord(rocksdb::Slice*, std::string*,
rocksdb::WALRecoveryMode)+0xe8) [0x7f71f487d9e8]
9: (rocksdb::DBImpl::RecoverLogFiles(std::vector<unsigned long,
std::allocator<unsigned long> > const&, unsigned long*, bool)+0xdc8)
[0x7f71f4837a18]
10: (rocksdb::DBImpl::Recover(std::vector<rocksdb::ColumnFamilyDescriptor,
std::allocator<rocksdb::ColumnFamilyDescriptor> > const&, bool, bool,
bool)+0x866) [0x7f71f4839386]
11: (rocksdb::DB::Open(rocksdb::DBOptions const&, std::string const&, std
===

Thanks
Jayaram

--001a113cd1f05cd9b3054c1f67cf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>We are getting below =
trace on failed OSD&#39;s . Can you please explain from the below code why =
this issue happening. We suspect it could be because of underlying HW issue=
. We can&#39;t find anything from the syslogs. All the OSD disk are in heal=
thy condition.</div><div><br></div><div>Link :-=C2=A0<a href=3D"https://fos=
sies.org/linux/ceph/src/os/bluestore/KernelDevice.cc">https://fossies.org/l=
inux/ceph/src/os/bluestore/KernelDevice.cc</a></div><div><br></div>=3D=3D=
=3D<br><div><div><span style=3D"text-decoration:underline">2017</span>-03-3=
1 03:51:28.262403 7f71f3ed5940 -1 /home/jenkins-build/build/workspace/ceph-=
build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7=
/MACHINE_SIZE/huge/release/11.2.0/rpm/el7/BUILD/ceph-11.2.0/src/os/bluestor=
e/<span style=3D"text-decoration:underline">KernelDevice.cc</span>: In func=
tion &#39;virtual int KernelDevice::read(uint64_t, uint64_t, ceph::bufferli=
st*, IOContext*, bool)&#39; thread 7f71f3ed5940 time <span style=3D"text-de=
coration:underline">2017</span>-03-31 03:51:28.256298<br>/home/jenkins-buil=
d/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DI=
ST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/11.2.0/rpm/el7/BUILD/ceph=
-11.2.0/<b>src/os/bluestore/<span style=3D"text-decoration:underline">Kerne=
lDevice.cc</span>: 541: FAILED assert((uint64_t)r =3D=3D len) =C2=A0=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&g=
t;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</b><br><br> ceph version 11.2.0 =
(f223e27eeb35991352ebc1f67423d4ebc252adb7)<br> 1: (ceph::__ceph_assert_fail=
(char const*, char const*, int, char const*)+0x85) [0x7f71f49b6b35]<br> 2: =
(KernelDevice::read(unsigned long, unsigned long, ceph::buffer::list*, IOCo=
ntext*, bool)+0x7a0) [0x7f71f47fdf10]<br> 3: (BlueFS::_read(BlueFS::FileRea=
der*, BlueFS::FileReaderBuffer*, unsigned long, unsigned long, ceph::buffer=
::list*, char*)+0x47a) [0x7f71f47c8d4a]<br> 4: (BlueRocksSequentialFile::Re=
ad(unsigned long, rocksdb::Slice*, char*)+0x36) [0x7f71f47ecd46]<br> 5: (ro=
cksdb::SequentialFileReader::Read(unsigned long, rocksdb::Slice*, char*)+0x=
16) [0x7f71f48f4136]<br> 6: (rocksdb::log::Reader::ReadMore(unsigned long*,=
 int*)+0xd8) [0x7f71f487d658]<br> 7: (rocksdb::log::Reader::ReadPhysicalRec=
ord(rocksdb::Slice*, unsigned long*)+0x44) [0x7f71f487d734]<br> 8: (rocksdb=
::log::Reader::ReadRecord(rocksdb::Slice*, std::string*, rocksdb::WALRecove=
ryMode)+0xe8) [0x7f71f487d9e8]<br> 9: (rocksdb::DBImpl::RecoverLogFiles(std=
::vector&lt;unsigned long, std::allocator&lt;unsigned long&gt; &gt; const&a=
mp;, unsigned long*, bool)+0xdc8) [0x7f71f4837a18]<br> 10: (rocksdb::DBImpl=
::Recover(std::vector&lt;rocksdb::ColumnFamilyDescriptor, std::allocator&lt=
;rocksdb::ColumnFamilyDescriptor&gt; &gt; const&amp;, bool, bool, bool)+0x8=
66) [0x7f71f4839386]<br> 11: (rocksdb::DB::Open(rocksdb::DBOptions const&am=
p;, std::string const&amp;, std</div></div><div>=3D=3D=3D</div><div><br></d=
iv><div>Thanks</div><div>Jayaram</div></div>

--001a113cd1f05cd9b3054c1f67cf--

--===============1705022365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1705022365==--
