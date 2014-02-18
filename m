From: Guang Yang <yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Ceph GET latency
Date: Tue, 18 Feb 2014 07:24:34 -0800 (PST)
Message-ID: <1392737074.11284.YahooMailNeo@web140905.mail.bf1.yahoo.com>
Reply-To: Guang Yang <yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0444796828=="
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
To: Ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0444796828==
Content-Type: multipart/alternative; boundary="661806066-1931857594-1392737074=:11284"

--661806066-1931857594-1392737074=:11284
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi ceph-users,=0AWe are using Ceph (radosgw) to store user generated images=
, as GET latency is critical for us, most recently I did some investigation=
 over the GET path to understand where time spend.=0A=0AI first confirmed t=
hat the latency came from OSD (read op), so that we instrumented code to tr=
ace the GET request (read op at OSD side, to be more specific, each object =
with size [512K + 4M * x] =C2=A0are splitted into [1 + x] chunks, each chun=
k needs one read op ), for each read op, it needs to go through the followi=
ng steps:=0A=C2=A0 =C2=A0 1. Dispatch and take by a op thread to process (p=
rocess not started).=0A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =
=C2=A0 =E2=80=93 20 ms, =C2=A0 =C2=A094%=0A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A020 =E2=80=93 50 ms, =C2=A0 =C2=A02%=0A=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A050 =E2=80=93 100 ms, =C2=A02%=0A=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 100ms+ =C2=A0 , =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 2%=0A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0For those having 20ms+ latency, =
half of them are due to waiting for pg lock (https://github.com/ceph/ceph/b=
lob/dumpling/src/osd/OSD.cc#L7089), another half are yet to be investigated=
.=0A=0A=C2=A0 =C2=A0 2. Get file xattr (=E2=80=98-=E2=80=98), which open th=
e file and populate fd cache (https://github.com/ceph/ceph/blob/dumpling/sr=
c/os/FileStore.cc#L230).=0A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0 =C2=A0 =E2=80=93 20 ms, =C2=A080%=0A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 20 =E2=80=93 50 ms, =C2=A0 8%=0A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 50 =E2=80=93 100 ms, 7%=0A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 100ms+ =C2=A0 , =C2=A0 =C2=A0 =C2=A05%=0A=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0The latency either comes from (from more to less): fil=
e path lookup (https://github.com/ceph/ceph/blob/dumpling/src/os/HashIndex.=
cc#L294), file open, or fd cache lookup /add.=0A=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0Currently objects are store in level 6 or level 7 folder (due to=C2=
=A0http://tracker.ceph.com/issues/7207, I stopped folder splitting).=0A=0A=
=C2=A0 =C2=A0 3. Get more xattrs, this is fast due to previous fd cache (ra=
rely > 1ms).=0A=0A=C2=A0 =C2=A0 4. Read the data.=0A=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =E2=80=93 20 ms, =C2=A0 84%=0A=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 20 =E2=80=93 50 ms, 10%=0A=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 50 =E2=80=93 100 ms, 4%=0A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 100ms+ =C2=A0 =C2=A0 =C2=A0 =C2=A0, 2%=0A=0AI decreased=C2=A0=
vfs_cache_pressure from its default value 100 to 5 to make VFS favor dentry=
/inode cache over page cache, unfortunately it does not help.=0A=0ALong sto=
ry short, most of the long latency read op comes from file system call (for=
 cold data), as our workload mainly stores objects less than 500KB, so that=
 it generates a large bunch of objects.=0A=0AI would like to ask if people =
experienced similar issue and if there is any suggestion I can try to boost=
 the GET performance. On the other hand, PUT could be sacrificed.=0A=0AThan=
ks,=0AGuang
--661806066-1931857594-1392737074=:11284
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:He=
lveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;fo=
nt-size:12pt"><div>Hi ceph-users,</div><div>We are using Ceph (radosgw) to =
store user generated images, as GET latency is critical for us, most recent=
ly I did some investigation over the GET path to understand where time spen=
d.</div><div><br></div><div class=3D"p1">I first confirmed that the latency=
 came from OSD (read op), so that we instrumented code to trace the GET req=
uest (read op at OSD side, to be more specific, each object with size [512K=
 + 4M * x] &nbsp;are splitted into [1 + x] chunks, each chunk needs one rea=
d op ), for each read op, it needs to go through the following steps:</div>=
<div class=3D"p1">&nbsp; &nbsp; 1. Dispatch and take by a op thread to proc=
ess (process not started).</div><div class=3D"p1">&nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;0 &nbsp; =E2=80=93 20 ms, &nbsp; &nbsp;94%</div><div
 class=3D"p1">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;20 =E2=80=93 =
50 ms, &nbsp; &nbsp;2%</div><div class=3D"p1">&nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp;50 =E2=80=93 100 ms, &nbsp;2%</div><div class=3D"p1">&nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 100ms+ &nbsp; , &nbsp; &nbsp;=
 &nbsp; &nbsp; 2%</div><div class=3D"p1">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
For those having 20ms+ latency, half of them are due to waiting for pg lock=
 (<span style=3D"color: rgb(0, 0, 255); text-decoration: underline;"><a hre=
f=3D"https://github.com/ceph/ceph/blob/dumpling/src/osd/OSD.cc#L7089">https=
://github.com/ceph/ceph/blob/dumpling/src/osd/OSD.cc#L7089</a></span>), ano=
ther half are yet to be investigated.</div><div class=3D"p2"><br></div><div=
 class=3D"p3"><span class=3D"s2">&nbsp; &nbsp; 2. Get file xattr (=E2=80=98=
-=E2=80=98), which open the file and populate fd cache (<a href=3D"https://=
git.corp.yahoo.com/cloud-object-storage/cloud-object-storage/blob/master/sr=
c/os/FileStore.cc#L219"><span
 class=3D"s3">https://github.com/ceph/ceph/blob/dumpling/src/os/FileStore.c=
c#L230</span></a>).</span></div><div class=3D"p1">&nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; 0 &nbsp; =E2=80=93 20 ms, &nbsp;80%</div><div class=
=3D"p1">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 20 =E2=80=93 50 ms=
, &nbsp; 8%</div><div class=3D"p1">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; 50 =E2=80=93 100 ms, 7%</div><div class=3D"p1">&nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; 100ms+ &nbsp; , &nbsp; &nbsp; &nbsp;5%</div><=
div class=3D"p1">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;The latency either comes=
 from (from more to less): file path lookup (<a href=3D"https://git.corp.ya=
hoo.com/cloud-object-storage/cloud-object-storage/blob/master/src/os/HashIn=
dex.cc#L294"><span class=3D"s1">https://github.com/ceph/ceph/blob/dumpling/=
src/os/HashIndex.cc#L294</span></a>), file open, or fd cache lookup /add.</=
div><div class=3D"p1" style=3D"font-size: 16px; font-family: HelveticaNeue,=
 'Helvetica Neue', Helvetica,
 Arial, 'Lucida Grande', sans-serif; background-color: transparent; font-st=
yle: normal;"><span style=3D"color: rgb(0, 0, 255);">&nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp;</span>Currently objects are store in level 6 or level 7 folder=
 (due to&nbsp;<a href=3D"http://tracker.ceph.com/issues/7207">http://tracke=
r.ceph.com/issues/7207</a>, I stopped folder splitting).</div><div class=3D=
"p2"><br></div><div class=3D"p1">&nbsp; &nbsp; 3. Get more xattrs, this is =
fast due to previous fd cache (rarely &gt; 1ms).</div><div class=3D"p2"><br=
></div><div class=3D"p1">&nbsp; &nbsp; 4. Read the data.</div><div class=3D=
"p1">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0 &nbsp; =E2=80=93 20 ms, &n=
bsp; 84%</div><div class=3D"p1">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2=
0 =E2=80=93 50 ms, 10%</div><div class=3D"p1">&nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; 50 =E2=80=93 100 ms, 4%</div><div style=3D"color: rgb(0, 0, 0)=
; font-size: 16px; font-family: HelveticaNeue, 'Helvetica Neue', Helvetica,=
 Arial, 'Lucida Grande',
 sans-serif; background-color: transparent; font-style: normal;">=0A=0A=0A=
=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A=
=0A</div><div class=3D"p1">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 100ms+=
 &nbsp; &nbsp; &nbsp; &nbsp;, 2%</div><div class=3D"p1"><br></div><div clas=
s=3D"p1" style=3D"color: rgb(0, 0, 0); font-size: 16px; font-family: Helvet=
icaNeue, 'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif; b=
ackground-color: transparent; font-style: normal;">=0A=0A=0A=0A=0A=0A=0A=0A=
</div><div class=3D"p1"><span class=3D"s1">I decreased&nbsp;</span>vfs_cach=
e_pressure from its default value 100 to 5 to make VFS favor dentry/inode c=
ache over page cache, unfortunately it does not help.</div><div class=3D"p1=
" style=3D"color: rgb(0, 0, 0); font-size: 16px; font-family: HelveticaNeue=
, 'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif; backgrou=
nd-color: transparent; font-style: normal;"><br></div><div class=3D"p1" sty=
le=3D"color: rgb(0, 0, 0); font-size: 16px; font-family: HelveticaNeue, 'He=
lvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif; background-co=
lor: transparent; font-style: normal;">=0A=0A=0A=0A=0A=0A=0A=0A</div><div c=
lass=3D"p1">Long story short, most of the long latency read op comes from f=
ile system call (for cold data), as our workload mainly stores objects less=
 than 500KB, so that it generates a large bunch of objects.</div><div class=
=3D"p1"><br></div><div class=3D"p1" style=3D"color: rgb(0, 0, 0); font-size=
: 16px; font-family: HelveticaNeue, 'Helvetica Neue', Helvetica, Arial, 'Lu=
cida Grande', sans-serif; background-color: transparent; font-style: normal=
;">I would like to ask if people experienced similar issue and if there is =
any suggestion I can try to boost the GET performance. On the other hand, P=
UT could be sacrificed.</div><div class=3D"p1" style=3D"color: rgb(0, 0, 0)=
; font-size: 16px; font-family: HelveticaNeue, 'Helvetica Neue', Helvetica,=
 Arial, 'Lucida Grande', sans-serif; background-color: transparent; font-st=
yle: normal;"><br></div><div class=3D"p1" style=3D"color: rgb(0, 0, 0); fon=
t-size: 16px; font-family: HelveticaNeue, 'Helvetica Neue', Helvetica,
 Arial, 'Lucida Grande', sans-serif; background-color: transparent; font-st=
yle: normal;">Thanks,</div><div class=3D"p1" style=3D"color: rgb(0, 0, 0); =
font-size: 16px; font-family: HelveticaNeue, 'Helvetica Neue', Helvetica, A=
rial, 'Lucida Grande', sans-serif; background-color: transparent; font-styl=
e: normal;">Guang</div></div></body></html>
--661806066-1931857594-1392737074=:11284--

--===============0444796828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0444796828==--
