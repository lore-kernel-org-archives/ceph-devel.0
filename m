From: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: OSD is crashing while running admin socket
Date: Tue, 9 Sep 2014 00:11:12 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F27839A9D@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2096310958=="
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
To: "Sage Weil (sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org)" <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "Samuel Just
	(sam.just-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org)" <sam.just-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============2096310958==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_755F6B91B3BE364F9BCA11EA3F9E0C6F27839A9DSACMBXIP02sdcor_"

--_000_755F6B91B3BE364F9BCA11EA3F9E0C6F27839A9DSACMBXIP02sdcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Sage/Sam,

I faced a crash in OSD with latest Ceph master. Here is the log trace for t=
he same.

ceph version 0.85-677-gd5777c4 (d5777c421548e7f039bb2c77cb0df2e9c7404723)
1: ceph-osd() [0x990def]
2: (()+0xfbb0) [0x7f72ae6e6bb0]
3: (gsignal()+0x37) [0x7f72acc08f77]
4: (abort()+0x148) [0x7f72acc0c5e8]
5: (__gnu_cxx::__verbose_terminate_handler()+0x155) [0x7f72ad5146e5]
6: (()+0x5e856) [0x7f72ad512856]
7: (()+0x5e883) [0x7f72ad512883]
8: (()+0x5eaae) [0x7f72ad512aae]
9: (ceph::buffer::list::substr_of(ceph::buffer::list const&, unsigned int, =
unsigned int)+0x277) [0xa88747]
10: (ceph::buffer::list::write(int, int, std::ostream&) const+0x81) [0xa895=
41]
11: (operator<<(std::ostream&, OSDOp const&)+0x1f6) [0x717a16]
12: (MOSDOp::print(std::ostream&) const+0x172) [0x6e5e32]
13: (TrackedOp::dump(utime_t, ceph::Formatter*) const+0x223) [0x6b6483]
14: (OpTracker::dump_ops_in_flight(ceph::Formatter*)+0xa7) [0x6b7057]
15: (OSD::asok_command(std::string, std::map<std::string, boost::variant<st=
d::string, bool, long, double, std::vector<std::string, std::allocator<std:=
:string> >, boost::detail::variant::void_, boost::detail::variant::void_, b=
oost::detail::variant::void_, boost::detail::variant::void_, boost::detail:=
:variant::void_, boost::detail::variant::void_, boost::detail::variant::voi=
d_, boost::detail::variant::void_, boost::detail::variant::void_, boost::de=
tail::variant::void_, boost::detail::variant::void_, boost::detail::variant=
::void_, boost::detail::variant::void_, boost::detail::variant::void_, boos=
t::detail::variant::void_>, std::less<std::string>, std::allocator<std::pai=
r<std::string const, boost::variant<std::string, bool, long, double, std::v=
ector<std::string, std::allocator<std::string> >, boost::detail::variant::v=
oid_, boost::detail::variant::void_, boost::detail::variant::void_, boost::=
detail::variant::void_, boost::detail::variant::void_, boost::detail::varia=
nt::void_, boost::detail::variant::void_, boost::detail::variant::void_, bo=
ost::detail::variant::void_, boost::detail::variant::void_, boost::detail::=
variant::void_, boost::detail::variant::void_, boost::detail::variant::void=
_, boost::detail::variant::void_, boost::detail::variant::void_> > > >&, st=
d::string, std::ostream&)+0x1d7) [0x612cb7]
16: (OSDSocketHook::call(std::string, std::map<std::string, boost::variant<=
std::string, bool, long, double, std::vector<std::string, std::allocator<st=
d::string> >, boost::detail::variant::void_, boost::detail::variant::void_,=
 boost::detail::variant::void_, boost::detail::variant::void_, boost::detai=
l::variant::void_, boost::detail::variant::void_, boost::detail::variant::v=
oid_, boost::detail::variant::void_, boost::detail::variant::void_, boost::=
detail::variant::void_, boost::detail::variant::void_, boost::detail::varia=
nt::void_, boost::detail::variant::void_, boost::detail::variant::void_, bo=
ost::detail::variant::void_>, std::less<std::string>, std::allocator<std::p=
air<std::string const, boost::variant<std::string, bool, long, double, std:=
:vector<std::string, std::allocator<std::string> >, boost::detail::variant:=
:void_, boost::detail::variant::void_, boost::detail::variant::void_, boost=
::detail::variant::void_, boost::detail::variant::void_, boost::detail::var=
iant::void_, boost::detail::variant::void_, boost::detail::variant::void_, =
boost::detail::variant::void_, boost::detail::variant::void_, boost::detail=
::variant::void_, boost::detail::variant::void_, boost::detail::variant::vo=
id_, boost::detail::variant::void_, boost::detail::variant::void_> > > >&, =
std::string, ceph::buffer::list&)+0x67) [0x67c8b7]
17: (AdminSocket::do_accept()+0x1007) [0xa79817]
18: (AdminSocket::entry()+0x258) [0xa7b448]
19: (()+0x7f6e) [0x7f72ae6def6e]
20: (clone()+0x6d) [0x7f72acccc9cd]
NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to=
 interpret this.

Steps to reproduce:
-----------------------


1.       Run ios

2.       While ios running , run the following command continuously.



"ceph --admin-daemon /var/run/ceph/ceph-osd.0.asok dump_ops_in_flight"


3.       At some point the osd will be crashed.

I think I have root caused it..


1.       OpTracker::RemoveOnDelete::operator() is calling op->_unregistered=
() which clears out message->data() and payload

2.       After that, if optracking is enabled we are calling unregister_inf=
light_op() which removed the op from the xlist.

3.       Now, while dumping ops, we are calling _dump_op_descriptor_unlocke=
d() from TrackedOP::dump, which tries to print the message.

4.       So, there is a race condition when it tries to print the message w=
hoes ops (data) field is already cleared.

Fix could be, call this op->_unregistered (in case optracking is enabled) a=
fter it is removed from xlist.

With this fix, I am not getting the crash anymore.

If my observation is correct, please let me know. I will raise a bug and wi=
ll fix that as part of the overall optracker performance improvement (I wil=
l submit that pull request soon).

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


--_000_755F6B91B3BE364F9BCA11EA3F9E0C6F27839A9DSACMBXIP02sdcor_
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
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
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
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
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
/* List Definitions */
@list l0
	{mso-list-id:47344550;
	mso-list-type:hybrid;
	mso-list-template-ids:1234063278 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1632980858;
	mso-list-type:hybrid;
	mso-list-template-ids:-525852980 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Sage/Sam,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I faced a crash in OSD with latest Ceph master. Here=
 is the log trace for the same.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">ceph version 0.85-677-gd5777c4 (d5777c421548e7f039bb=
2c77cb0df2e9c7404723)<o:p></o:p></p>
<p class=3D"MsoNormal">1: ceph-osd() [0x990def]<o:p></o:p></p>
<p class=3D"MsoNormal">2: (()&#43;0xfbb0) [0x7f72ae6e6bb0]<o:p></o:p></p>
<p class=3D"MsoNormal">3: (gsignal()&#43;0x37) [0x7f72acc08f77]<o:p></o:p><=
/p>
<p class=3D"MsoNormal">4: (abort()&#43;0x148) [0x7f72acc0c5e8]<o:p></o:p></=
p>
<p class=3D"MsoNormal">5: (__gnu_cxx::__verbose_terminate_handler()&#43;0x1=
55) [0x7f72ad5146e5]<o:p></o:p></p>
<p class=3D"MsoNormal">6: (()&#43;0x5e856) [0x7f72ad512856]<o:p></o:p></p>
<p class=3D"MsoNormal">7: (()&#43;0x5e883) [0x7f72ad512883]<o:p></o:p></p>
<p class=3D"MsoNormal">8: (()&#43;0x5eaae) [0x7f72ad512aae]<o:p></o:p></p>
<p class=3D"MsoNormal">9: (ceph::buffer::list::substr_of(ceph::buffer::list=
 const&amp;, unsigned int, unsigned int)&#43;0x277) [0xa88747]<o:p></o:p></=
p>
<p class=3D"MsoNormal">10: (ceph::buffer::list::write(int, int, std::ostrea=
m&amp;) const&#43;0x81) [0xa89541]<o:p></o:p></p>
<p class=3D"MsoNormal">11: (operator&lt;&lt;(std::ostream&amp;, OSDOp const=
&amp;)&#43;0x1f6) [0x717a16]<o:p></o:p></p>
<p class=3D"MsoNormal">12: (MOSDOp::print(std::ostream&amp;) const&#43;0x17=
2) [0x6e5e32]<o:p></o:p></p>
<p class=3D"MsoNormal">13: (TrackedOp::dump(utime_t, ceph::Formatter*) cons=
t&#43;0x223) [0x6b6483]<o:p></o:p></p>
<p class=3D"MsoNormal">14: (OpTracker::dump_ops_in_flight(ceph::Formatter*)=
&#43;0xa7) [0x6b7057]<o:p></o:p></p>
<p class=3D"MsoNormal">15: (OSD::asok_command(std::string, std::map&lt;std:=
:string, boost::variant&lt;std::string, bool, long, double, std::vector&lt;=
std::string, std::allocator&lt;std::string&gt; &gt;, boost::detail::variant=
::void_, boost::detail::variant::void_, boost::detail::variant::void_,
 boost::detail::variant::void_, boost::detail::variant::void_, boost::detai=
l::variant::void_, boost::detail::variant::void_, boost::detail::variant::v=
oid_, boost::detail::variant::void_, boost::detail::variant::void_, boost::=
detail::variant::void_, boost::detail::variant::void_,
 boost::detail::variant::void_, boost::detail::variant::void_, boost::detai=
l::variant::void_&gt;, std::less&lt;std::string&gt;, std::allocator&lt;std:=
:pair&lt;std::string const, boost::variant&lt;std::string, bool, long, doub=
le, std::vector&lt;std::string, std::allocator&lt;std::string&gt;
 &gt;, boost::detail::variant::void_, boost::detail::variant::void_, boost:=
:detail::variant::void_, boost::detail::variant::void_, boost::detail::vari=
ant::void_, boost::detail::variant::void_, boost::detail::variant::void_, b=
oost::detail::variant::void_, boost::detail::variant::void_,
 boost::detail::variant::void_, boost::detail::variant::void_, boost::detai=
l::variant::void_, boost::detail::variant::void_, boost::detail::variant::v=
oid_, boost::detail::variant::void_&gt; &gt; &gt; &gt;&amp;, std::string, s=
td::ostream&amp;)&#43;0x1d7) [0x612cb7]<o:p></o:p></p>
<p class=3D"MsoNormal">16: (OSDSocketHook::call(std::string, std::map&lt;st=
d::string, boost::variant&lt;std::string, bool, long, double, std::vector&l=
t;std::string, std::allocator&lt;std::string&gt; &gt;, boost::detail::varia=
nt::void_, boost::detail::variant::void_, boost::detail::variant::void_,
 boost::detail::variant::void_, boost::detail::variant::void_, boost::detai=
l::variant::void_, boost::detail::variant::void_, boost::detail::variant::v=
oid_, boost::detail::variant::void_, boost::detail::variant::void_, boost::=
detail::variant::void_, boost::detail::variant::void_,
 boost::detail::variant::void_, boost::detail::variant::void_, boost::detai=
l::variant::void_&gt;, std::less&lt;std::string&gt;, std::allocator&lt;std:=
:pair&lt;std::string const, boost::variant&lt;std::string, bool, long, doub=
le, std::vector&lt;std::string, std::allocator&lt;std::string&gt;
 &gt;, boost::detail::variant::void_, boost::detail::variant::void_, boost:=
:detail::variant::void_, boost::detail::variant::void_, boost::detail::vari=
ant::void_, boost::detail::variant::void_, boost::detail::variant::void_, b=
oost::detail::variant::void_, boost::detail::variant::void_,
 boost::detail::variant::void_, boost::detail::variant::void_, boost::detai=
l::variant::void_, boost::detail::variant::void_, boost::detail::variant::v=
oid_, boost::detail::variant::void_&gt; &gt; &gt; &gt;&amp;, std::string, c=
eph::buffer::list&amp;)&#43;0x67) [0x67c8b7]<o:p></o:p></p>
<p class=3D"MsoNormal">17: (AdminSocket::do_accept()&#43;0x1007) [0xa79817]=
<o:p></o:p></p>
<p class=3D"MsoNormal">18: (AdminSocket::entry()&#43;0x258) [0xa7b448]<o:p>=
</o:p></p>
<p class=3D"MsoNormal">19: (()&#43;0x7f6e) [0x7f72ae6def6e]<o:p></o:p></p>
<p class=3D"MsoNormal">20: (clone()&#43;0x6d) [0x7f72acccc9cd]<o:p></o:p></=
p>
<p class=3D"MsoNormal">NOTE: a copy of the executable, or `objdump -rdS &lt=
;executable&gt;` is needed to interpret this.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Steps to reproduce:<o:p></o:p></p>
<p class=3D"MsoNormal">-----------------------<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level=
1 lfo1"><![if !supportLists]><span style=3D"mso-list:Ignore">1.<span style=
=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></span><![endif]>Run ios<o:p></o:p></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level=
1 lfo1"><![if !supportLists]><span style=3D"mso-list:Ignore">2.<span style=
=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></span><![endif]>While ios running , run the following command conti=
nuously.<o:p></o:p></p>
<p class=3D"MsoListParagraph"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoListParagraph">&#8220;ceph --admin-daemon /var/run/ceph/ceph=
-osd.0.asok dump_ops_in_flight&#8221;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l0 level=
1 lfo1"><![if !supportLists]><span style=3D"mso-list:Ignore">3.<span style=
=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;
</span></span><![endif]>At some point the osd will be crashed.<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I think I have root caused it..<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l1 level=
1 lfo2"><![if !supportLists]><span style=3D"color:black"><span style=3D"mso=
-list:Ignore">1.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"color:black;background:white;=
mso-highlight:white">OpTracker::RemoveOnDelete::operator()</span><span styl=
e=3D"color:black"> is calling op-&gt;_unregistered() which clears out messa=
ge-&gt;data() and payload</span><span style=3D"color:black"><o:p></o:p></sp=
an></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l1 level=
1 lfo2"><![if !supportLists]><span style=3D"color:black"><span style=3D"mso=
-list:Ignore">2.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"color:black">After that, if o=
ptracking is enabled we are calling
<span style=3D"background:white;mso-highlight:white">unregister_inflight_op=
</span>() which removed the op from the xlist.</span><span style=3D"color:b=
lack"><o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l1 level=
1 lfo2"><![if !supportLists]><span style=3D"color:black"><span style=3D"mso=
-list:Ignore">3.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"color:black">Now, while dumpi=
ng ops, we are calling
<span style=3D"background:white;mso-highlight:white">_dump_op_descriptor_un=
locked</span>() from TrackedOP::dump, which tries to print the message.</sp=
an><span style=3D"color:black"><o:p></o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"text-indent:-.25in;mso-list:l1 level=
1 lfo2"><![if !supportLists]><span style=3D"color:black"><span style=3D"mso=
-list:Ignore">4.<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span style=3D"color:black">So, there is a r=
ace condition when it tries to print the message whoes ops (data) field is =
already cleared.</span><span style=3D"color:black"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Fix could be, call this op-&gt;_unregistered (in cas=
e optracking is enabled) after it is removed from xlist.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">With this fix, I am not getting the crash anymore.<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If my observation is correct, please let me know. I =
will raise a bug and will fix that as part of the overall optracker perform=
ance improvement (I will submit that pull request soon).<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Somnath<o:p></o:p></p>
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

--_000_755F6B91B3BE364F9BCA11EA3F9E0C6F27839A9DSACMBXIP02sdcor_--

--===============2096310958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2096310958==--
