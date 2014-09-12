From: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: OSD is crashing during delete operation
Date: Fri, 12 Sep 2014 21:02:26 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783E50B@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1697384427=="
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
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "Sage Weil
	(sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org)" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1697384427==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_755F6B91B3BE364F9BCA11EA3F9E0C6F2783E50BSACMBXIP02sdcor_"

--_000_755F6B91B3BE364F9BCA11EA3F9E0C6F2783E50BSACMBXIP02sdcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

We are facing a crash while deleting large number of objects. Here is the t=
race.

2014-09-12 13:48:06.820524 7fb56596d700 -1 os/FDCache.h: In function 'void =
FDCache::clear(const ghobject_t&)' thread 7fb56596d700 time 2014-09-12 13:4=
8:06.815407
os/FDCache.h: 89: FAILED assert(!registry[registry_id].lookup(hoid))

ceph version 0.84-998-gfcf8059 (fcf805972124dac1eae18b1cfd286790462b8ec8)
1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x=
8b) [0xa82a0b]
2: (FileStore::lfn_unlink(coll_t, ghobject_t const&, SequencerPosition cons=
t&, bool)+0x54b) [0x8918eb]
3: (FileStore::_remove(coll_t, ghobject_t const&, SequencerPosition const&)=
+0x8b) [0x891d8b]
4: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned long, in=
t, ThreadPool::TPHandle*)+0x25ce) [0x8a0fae]
5: (FileStore::_do_transactions(std::list<ObjectStore::Transaction*, std::a=
llocator<ObjectStore::Transaction*> >&, unsigned long, ThreadPool::TPHandle=
*)+0x44) [0x8a32a4]
6: (FileStore::_do_op(FileStore::OpSequencer*, ThreadPool::TPHandle&)+0x169=
) [0x8a3479]
7: (ThreadPool::worker(ThreadPool::WorkThread*)+0xac0) [0xa707b0]
8: (ThreadPool::WorkThread::entry()+0x10) [0xa72b30]
9: (()+0x7f6e) [0x7fb570cd7f6e]
10: (clone()+0x6d) [0x7fb56f2c59cd]

Is this a known issue ?

Thanks & Regards
Somnath


________________________________

PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).


--_000_755F6B91B3BE364F9BCA11EA3F9E0C6F2783E50BSACMBXIP02sdcor_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We are facing a crash while deleting large number of=
 objects. Here is the trace.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">2014-09-12 13:48:06.82=
0524 7fb56596d700 -1 os/FDCache.h: In function 'void FDCache::clear(const g=
hobject_t&amp;)' thread 7fb56596d700 time 2014-09-12 13:48:06.815407<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">os/FDCache.h: 89: FAIL=
ED assert(!registry[registry_id].lookup(hoid))<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p>&nbsp;</o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">ceph version 0.84-998-=
gfcf8059 (fcf805972124dac1eae18b1cfd286790462b8ec8)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">1: (ceph::__ceph_asser=
t_fail(char const*, char const*, int, char const*)&#43;0x8b) [0xa82a0b]<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">2: (FileStore::lfn_unl=
ink(coll_t, ghobject_t const&amp;, SequencerPosition const&amp;, bool)&#43;=
0x54b) [0x8918eb]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">3: (FileStore::_remove=
(coll_t, ghobject_t const&amp;, SequencerPosition const&amp;)&#43;0x8b) [0x=
891d8b]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">4: (FileStore::_do_tra=
nsaction(ObjectStore::Transaction&amp;, unsigned long, int, ThreadPool::TPH=
andle*)&#43;0x25ce) [0x8a0fae]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">5: (FileStore::_do_tra=
nsactions(std::list&lt;ObjectStore::Transaction*, std::allocator&lt;ObjectS=
tore::Transaction*&gt; &gt;&amp;, unsigned long, ThreadPool::TPHandle*)&#43=
;0x44) [0x8a32a4]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">6: (FileStore::_do_op(=
FileStore::OpSequencer*, ThreadPool::TPHandle&amp;)&#43;0x169) [0x8a3479]<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">7: (ThreadPool::worker=
(ThreadPool::WorkThread*)&#43;0xac0) [0xa707b0]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">8: (ThreadPool::WorkTh=
read::entry()&#43;0x10) [0xa72b30]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">9: (()&#43;0x7f6e) [0x=
7fb570cd7f6e]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"color:#1F497D">10: (clone()&#43;0x6d)=
 [0x7fb56f2c59cd]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Is this a known issue ?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Somnath<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"2"><br>
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this
 message in error and that any review, dissemination, distribution, or copy=
ing of this message is strictly prohibited. If you have received this commu=
nication in error, please notify the sender by telephone or e-mail (as show=
n above) immediately and destroy
 any and all copies of this message in your possession (whether hard copies=
 or electronically stored copies).<br>
<br>
</font>
</body>
</html>

--_000_755F6B91B3BE364F9BCA11EA3F9E0C6F2783E50BSACMBXIP02sdcor_--

--===============1697384427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1697384427==--
