From: <Kelvin_Huang-Rut2I95wrJDQT0dZR+AlfA@public.gmane.org>
Subject: Re: RBD performance test (write) problem
Date: Sun, 21 Apr 2013 11:01:41 +0000
Message-ID: <86F425174C7E4F418CCF4E62056152E5942CFB@GDC-CLDMBX-P01.whq.wistron>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0573125261=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: zh-TW
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-users-Qp0mS5GaXlQ@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Victor_CY_Chang-Rut2I95wrJDQT0dZR+AlfA@public.gmane.org, PJ_Lin-Rut2I95wrJDQT0dZR+AlfA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0573125261==
Content-Language: zh-TW
Content-Type: multipart/alternative;
	boundary="_000_86F425174C7E4F418CCF4E62056152E5942CFBGDCCLDMBXP01whqwi_"

--_000_86F425174C7E4F418CCF4E62056152E5942CFBGDCCLDMBXP01whqwi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
Have any comments about  1) or 2) ?

Thanks!!!



Hi Mark,

Sorry, reply too late, because I didn't receive this mail so missed this me=
ssage in the several days...
http://www.mail-archive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg00624.html


Your advice are very very helpful to me !!! thanks :)

I have done the following test and have some questions


1)      I concurrently use dd if=3D/dev/zero of=3D/dev/sd[b,c,d,e,f ...n] b=
s=3D4096k count=3D10000 oflag=3Ddirect , on each SATA disk

collectl show:
#<----CPU[HYPER]-----><----------Disks-----------><----------Network-------=
--->
#cpu sys inter  ctxsw KBRead  Reads KBWrit Writes   KBIn  PktIn  KBOut  Pkt=
Out
   0   0  2935    636      0      0 866560   2708      1      9      0     =
  1
   0   0  2939    718      0      0 865620   2708      2     14      1     =
  4
   0   0  2872    631      0      0 868480   2714      1      8      0     =
  1
   0   0  2937    621      0      0 864640   2702      1      9      0     =
  4

total write throughput about 860MB/s

use RADOS bench : rados -p rbd bench 300 write -t 256
collectl show:
#<----CPU[HYPER]-----><----------Disks-----------><----------Network-------=
--->
#cpu sys inter  ctxsw KBRead  Reads KBWrit Writes   KBIn  PktIn  KBOut  Pkt=
Out
  22  10  6991  17947      4      1   999K   3111      4     31     48     =
 22
  18   8  6151  16116      0      0  1003K   2858      8     40     23     =
 37
  19   9  6295  16031      8      2  1002K   2458      2     22     44     =
 17

total write throughput about 1000MB/s

the expander backplane running at 3.0Gb/s and 4-lane Mini-SAS port to conne=
ct : 4 * 3Gb/s =3D 12Gb/s ~=3D 1GB/s, so I think write throughput stuck on =
1000MB/s due to expander backplane that is bottleneck for sequential writes=
.
If expander backplane can running at 6.0Gb/s then total write throughput wi=
ll increase right?




2)
OSDs & journal setting:
a. OSDs filesystems are EXT4  , no use osd mkfs options
osd mkfs type =3D ext4
osd mount options ext4 =3D rw,data=3Dwriteback,errors=3Dremount-ro,noatime,=
nodiratime,user_xattr
filestore_xattr_use_omap =3D true

b. SSDs journal are raw disk that don't has filesystem and divided into two=
 partition (alignment)

LSI MegaRAID SAS 9260-4i setting:
a. every HDD : RAID0 , Write Policy: Write Back with BBU, Read Policy: Read=
Ahead, IO Policy: Direct, Disk cache: unchanged
b. every SSD  : RAID0 , Write Policy: Write Through, Read Policy: NoReadAhe=
ad, IO Policy: Direct, Disk cache: disabled

Because the last result are pool size=3D576, so i did a new test for pool s=
ize=3D2048 and 9 OSDs + 4 SSDs configuration !!

Read: rados -p testpool bench 300 seq -t 256
Write: rados  -p testpool bench 300 write -t 256 --no-cleanup


Rados Bench TEST (Read):
2x replication & 12 OSDs case: Bandwidth (MB/sec): Bandwidth (MB/sec):    1=
373.013
1x replication & 12 OSDs case: Bandwidth (MB/sec): Bandwidth (MB/sec):    1=
478.694

2x replication & 8 OSDs + 4 SSDs (Journal) case: Bandwidth (MB/sec):    144=
2.543
1x replication & 8 OSDs + 4 SSDs (Journal) case: Bandwidth (MB/sec):    144=
8.407

2x replication & 9 OSDs + 3 SSDs (Journal) case: Bandwidth (MB/sec):    148=
5.175
1x replication & 9 OSDs + 3 SSDs (Journal) case: Bandwidth (MB/sec):    447=
.245



Rados Bench TEST (Write):
2x replication & 12 OSDs case: Bandwidth (MB/sec):     228.064
1x replication & 12 OSDs case: Bandwidth (MB/sec):     457.213

2x replication & 8 OSDs + 4 SSDs (Journal) case: Bandwidth (MB/sec):     22=
4.430
1x replication & 8 OSDs + 4 SSDs (Journal) case: Bandwidth (MB/sec):     48=
2.104

2x replication & 9 OSDs + 3 SSDs (Journal) case: Bandwidth (MB/sec):     23=
9
1x replication & 9 OSDs + 3 SSDs (Journal) case: Bandwidth (MB/sec):     48=
5

In Rados Bench TEST (Read), I originally expected more OSDs can increase th=
e read bandwidth but the results show about 1400MB/s on most case, this is =
cache intervention? because i didn't see any read operation on disk ...

In Rados Bench TEST (Write), I test 9 OSDs + 3 SSDs (Journal) configuration=
 and observing by collectl

# DISK STATISTICS (/sec)
#          <---------reads---------><---------writes---------><--------aver=
ages--------> Pct
#Name       KBytes Merged  IOs Size  KBytes Merged  IOs Size  RWSize  QLen =
 Wait SvcTim Util
sdc              0      0    0    0   47336    382  335  141     141     0 =
    2      0    7
sdd              0      0    0    0   65600      0  240  273     273     1 =
    4      0    7
sde              0      0    0    0   56440      0  207  273     272    64 =
  342      4   99
sdg              0      0    0    0   43544    450  326  134     133    39 =
  135      3   99
sdf              0      0    0    0   65600      0  240  273     273     0 =
    2      0    7
sdh              0      0    0    0   57400      0  210  273     273     0 =
    2      0    7
sdi              0      0    0    0   69012    227  251  275     274    90 =
  560      3   99
sdj              0      0    0    0   66944    424  308  217     217     1 =
    5      0    7
sdb              0      0    0    0   43496      0  159  274     273     6 =
   41      3   51

# DISK STATISTICS (/sec)
#          <---------reads---------><---------writes---------><--------aver=
ages--------> Pct
#Name       KBytes Merged  IOs Size  KBytes Merged  IOs Size  RWSize  QLen =
 Wait SvcTim Util
sdk              0      0    0    0  178016      0  599  297     297   219 =
  390      1   99
sdl              0      0    0    0  156540      0  536  292     292    27 =
   51      1   96
sdm              0      0    0    0  166724      0  578  288     288    31 =
   42      1   95

The write throughput of SSDs are increase to about ~170MB/s that may repres=
ent three SSDs for journal enough
but I don't understand why 9 OSDs + 3 SSDs can has more write bandwidth tha=
n 8 OSDs + 4 SSDs ... ?

Another question is 1x replication has 490MB/s bandwidth on a storage serve=
r, that mean if I have two storage server and 2x replication on each storag=
e server, then write bandwidth can reach 490MB/s ?



3)
I use HBA (LSI 9211-8i : LSISAS2008) instead of "smart" RAID card (LSI 9260=
-4i)

2x replication & 9 OSDs + 3 SSDs (Journal) case: Bandwidth (MB/sec):     24=
7.047
1x replication & 9 OSDs + 3 SSDs (Journal) case: Bandwidth (MB/sec):     49=
2.798

The result looks little better than use RAID card !!


4)
XFS:
osd mkfs type =3D xfs
osd mkfs options xfs =3D -f -i size=3D2048
osd mount options xfs =3D rw,inode64,noatime
filestore_xattr_use_omap =3D true

2x replication & 9 OSDs + 3 SSDs (Journal) case: Bandwidth (MB/sec):    248=
.327
1x replication & 9 OSDs + 3 SSDs (Journal) case: Bandwidth (MB/sec):    494=
.292

#<----CPU[HYPER]-----><----------Disks-----------><----------Network-------=
--->
#cpu sys inter  ctxsw KBRead  Reads KBWrit Writes   KBIn  PktIn  KBOut  Pkt=
Out
  22   9  6416  21901      0      0  1004K   2514     10     39    113     =
 37
  20   9  6147  20391      0      0  1009K   2565      3     39     62     =
 32
  19   8  6488  19780      0      0  1006K   2448      7     31     21     =
 23
  21  10  6730  19695      0      0  1003K   2430      5     16      1     =
 11
  20   9  6755  19244      0      0   994K   2491      3     15     25     =
 12

Total write throughput also stuck on about 1GB/s, I think the same reason a=
s 1)


BTRFS:
osd mkfs type =3D btrfs
osd mkfs options btrfs =3D -l 16k -n 16k
osd mount options xfs =3D -o noatime

2x replication & 9 OSDs + 3 SSDs (Journal) case: Bandwidth (MB/sec):     24=
3.817
1x replication & 9 OSDs + 3 SSDs (Journal) case: Bandwidth (MB/sec):     48=
7.809

The results are same as EXT4 / XFS

Next time I will try to use 2nd controller and directly connect my disks an=
d SSDs

Thanks !! :)

-          Kelvin


--_000_86F425174C7E4F418CCF4E62056152E5942CFBGDCCLDMBXP01whqwi_
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
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:PMingLiU;
	panose-1:2 2 5 0 0 0 0 0 0 0;}
@font-face
	{font-family:PMingLiU;
	panose-1:2 2 5 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:PMingLiU;
	panose-1:2 2 5 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
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
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:24.0pt;
	margin-bottom:.0001pt;
	mso-para-margin-top:0cm;
	mso-para-margin-right:0cm;
	mso-para-margin-bottom:0cm;
	mso-para-margin-left:2.0gd;
	mso-para-margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:994184814;
	mso-list-type:hybrid;
	mso-list-template-ids:375676146 -1310849312 67698691 67698693 67698689 676=
98691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:5;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:18.0pt;
	text-indent:-18.0pt;
	font-family:"Calibri","sans-serif";
	mso-fareast-font-family:PMingLiU;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F06E;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:48.0pt;
	text-indent:-24.0pt;
	font-family:Wingdings;}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F075;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:72.0pt;
	text-indent:-24.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F06C;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:96.0pt;
	text-indent:-24.0pt;
	font-family:Wingdings;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F06E;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:120.0pt;
	text-indent:-24.0pt;
	font-family:Wingdings;}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F075;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:144.0pt;
	text-indent:-24.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F06C;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-24.0pt;
	font-family:Wingdings;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F06E;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:192.0pt;
	text-indent:-24.0pt;
	font-family:Wingdings;}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F075;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:216.0pt;
	text-indent:-24.0pt;
	font-family:Wingdings;}
@list l1
	{mso-list-id:1683317687;
	mso-list-type:hybrid;
	mso-list-template-ids:-415456430 -1354622830 67698713 67698715 67698703 67=
698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:18.0pt;
	text-indent:-18.0pt;}
@list l1:level2
	{mso-level-number-format:ideograph-traditional;
	mso-level-text:%2\3001;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:48.0pt;
	text-indent:-24.0pt;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:72.0pt;
	text-indent:-24.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:96.0pt;
	text-indent:-24.0pt;}
@list l1:level5
	{mso-level-number-format:ideograph-traditional;
	mso-level-text:%5\3001;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:120.0pt;
	text-indent:-24.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:144.0pt;
	text-indent:-24.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-24.0pt;}
@list l1:level8
	{mso-level-number-format:ideograph-traditional;
	mso-level-text:%8\3001;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:192.0pt;
	text-indent:-24.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:216.0pt;
	text-indent:-24.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-TW" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Hi all,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Have an=
y comments about &nbsp;1) or 2) ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">Thanks!=
!!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-=
family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"><o:p>&nbsp;</o:p></span><=
/p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Mark,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Sorry, reply too late, because =
I didn&#8217;t receive this mail so missed this message in the several days=
...<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><a href=3D"http://www.mail-arch=
ive.com/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg00624.html">http://www.mail-archive.co=
m/ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org/msg00624.html</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Your advice are very very helpf=
ul to me !!! thanks
</span><span lang=3D"EN-US" style=3D"font-family:Wingdings">J</span><span l=
ang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I have done the following test =
and have some questions<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;mso-para-margin-l=
eft:0gd;text-indent:-18.0pt;mso-list:l1 level1 lfo2">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">1=
)<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">I concurrently use dd i=
f=3D/dev/zero of=3D/dev/sd[b,c,d,e,f ...n] bs=3D4096k count=3D10000 oflag=
=3Ddirect , on each SATA disk<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">collectl show:<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#&lt;----CPU[HYPER]-----&gt;&lt=
;----------Disks-----------&gt;&lt;----------Network----------&gt;<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#cpu sys inter&nbsp; ctxsw KBRe=
ad&nbsp; Reads KBWrit Writes&nbsp;&nbsp; KBIn&nbsp; PktIn&nbsp; KBOut&nbsp;=
 PktOut<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; 0&nbsp;&nbsp; 0&nb=
sp; 2935&nbsp;&nbsp;&nbsp; 636&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0 866560&nbsp;&nbsp; 2708&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; 0&nbsp;&nbsp; 0&nb=
sp; 2939&nbsp;&nbsp;&nbsp; 718&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0 865620&nbsp;&nbsp; 2708&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
&nbsp;&nbsp;&nbsp;&nbsp; 14&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; 0&nbsp;&nbsp; 0&nb=
sp; 2872&nbsp;&nbsp;&nbsp; 631&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0 868480&nbsp;&nbsp; 2714&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp; 0&nbsp;&nbsp; 0&nb=
sp; 2937&nbsp;&nbsp;&nbsp; 621&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0 864640&nbsp;&nbsp; 2702&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 4<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">total write throughput about 86=
0MB/s <o:p>
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">use RADOS bench : rados -p rbd =
bench 300 write -t 256<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">collectl show:<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#&lt;----CPU[HYPER]-----&gt;&lt=
;----------Disks-----------&gt;&lt;----------Network----------&gt;<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#cpu sys inter&nbsp; ctxsw KBRe=
ad&nbsp; Reads KBWrit Writes&nbsp;&nbsp; KBIn&nbsp; PktIn&nbsp; KBOut&nbsp;=
 PktOut<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; 22&nbsp; 10&nbsp; 6991&n=
bsp; 17947&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&=
nbsp;&nbsp; 999K&nbsp;&nbsp; 3111&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4&nbsp;&nbs=
p;&nbsp;&nbsp; 31&nbsp;&nbsp;&nbsp;&nbsp; 48&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
22<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; 18&nbsp;&nbsp; 8&nbsp; 6=
151&nbsp; 16116&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0&nbsp; 1003K&nbsp;&nbsp; 2858&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8&nbsp;&nbs=
p;&nbsp;&nbsp; 40&nbsp;&nbsp;&nbsp;&nbsp; 23&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
37<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; 19&nbsp;&nbsp; 9&nbsp; 6=
295&nbsp; 16031&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 2&nbsp; 1002K&nbsp;&nbsp; 2458&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbs=
p;&nbsp;&nbsp; 22&nbsp;&nbsp;&nbsp;&nbsp; 44&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
17<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">total write throughput about 10=
00MB/s <o:p>
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">the expander backplane running =
at 3.0Gb/s and 4-lane Mini-SAS port to connect : 4 * 3Gb/s =3D 12Gb/s ~=3D =
1GB/s, so I think write throughput stuck on 1000MB/s due to expander backpl=
ane that is bottleneck for sequential writes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">If expander backplane can runni=
ng at 6.0Gb/s then total write throughput will increase right?<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;mso-para-margin-l=
eft:0gd;text-indent:-18.0pt;mso-list:l1 level1 lfo2">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">2=
)<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">OSDs &amp; journal setting:<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">a. OSDs filesystems are EXT4&nb=
sp; , no use osd mkfs options<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">osd mkfs type =3D ext4<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">osd mount options ext4 =3D rw,d=
ata=3Dwriteback,errors=3Dremount-ro,noatime,nodiratime,user_xattr<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">filestore_xattr_use_omap =3D tr=
ue<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">b. SSDs journal are raw disk th=
at don't has filesystem and divided into two partition (alignment)<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">LSI MegaRAID SAS 9260-4i settin=
g:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">a. every HDD : RAID0 , Write Po=
licy: Write Back with BBU, Read Policy: ReadAhead, IO Policy: Direct, Disk =
cache: unchanged<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">b. every SSD&nbsp; : RAID0 , Wr=
ite Policy: Write Through, Read Policy: NoReadAhead, IO Policy: Direct, Dis=
k cache: disabled<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Because the last result are poo=
l size=3D576, so i did a new test for pool size=3D2048 and 9 OSDs &#43; 4 S=
SDs configuration !!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Read: rados -p testpool bench 3=
00 seq -t 256<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Write: rados&nbsp; -p testpool =
bench 300 write -t 256 --no-cleanup<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Rados Bench TEST (Read):<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2x replication &amp; 12 OSDs ca=
se: Bandwidth (MB/sec): Bandwidth (MB/sec):&nbsp;&nbsp;&nbsp; 1373.013
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1x replication &amp; 12 OSDs ca=
se: Bandwidth (MB/sec): Bandwidth (MB/sec): &nbsp;&nbsp;&nbsp;1478.694<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2x replication &amp; 8 OSDs &#4=
3; 4 SSDs (Journal) case: Bandwidth (MB/sec):&nbsp;&nbsp;&nbsp; 1442.543<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1x replication &amp; 8 OSDs &#4=
3; 4 SSDs (Journal) case: Bandwidth (MB/sec):&nbsp;&nbsp;&nbsp; 1448.407<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2x replication &amp; 9 OSDs &#4=
3; 3 SSDs (Journal) case: Bandwidth (MB/sec):&nbsp;&nbsp;&nbsp; 1485.175<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1x replication &amp; 9 OSDs &#4=
3; 3 SSDs (Journal) case: Bandwidth (MB/sec):&nbsp;&nbsp;&nbsp; 447.245<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Rados Bench TEST (Write):<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2x replication &amp; 12 OSDs ca=
se: Bandwidth (MB/sec):&nbsp;&nbsp;&nbsp;&nbsp; 228.064<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1x replication &amp; 12 OSDs ca=
se: Bandwidth (MB/sec):&nbsp;&nbsp;&nbsp;&nbsp; 457.213<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2x replication &amp; 8 OSDs &#4=
3; 4 SSDs (Journal) case: Bandwidth (MB/sec):&nbsp;&nbsp;&nbsp;&nbsp; 224.4=
30<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1x replication &amp; 8 OSDs &#4=
3; 4 SSDs (Journal) case: Bandwidth (MB/sec):&nbsp;&nbsp;&nbsp;&nbsp; 482.1=
04<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2x replication &amp; 9 OSDs &#4=
3; 3 SSDs (Journal) case: Bandwidth (MB/sec):&nbsp;&nbsp;&nbsp;&nbsp; 239<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1x replication &amp; 9 OSDs &#4=
3; 3 SSDs (Journal) case: Bandwidth (MB/sec):&nbsp;&nbsp;&nbsp;&nbsp; 485<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">In Rados Bench TEST (Read), I o=
riginally expected more OSDs can increase the read bandwidth but the result=
s show about 1400MB/s on most case, this is cache intervention? because i d=
idn't see any read operation on disk
 ...<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">In Rados Bench TEST (Write), I =
test 9 OSDs &#43; 3 SSDs (Journal) configuration and observing by collectl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># DISK STATISTICS (/sec)<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &lt;---------reads---------&gt;&lt;---------writes=
---------&gt;&lt;--------averages--------&gt; Pct<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#Name&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; KBytes Merged&nbsp; IOs Size&nbsp; KBytes Merged&nbsp; IOs Size&=
nbsp; RWSize&nbsp; QLen&nbsp; Wait SvcTim Util<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">sdc&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; 47336&nbsp;&n=
bsp;&nbsp; 382&nbsp; 335&nbsp; 141&nbsp;&nbsp;&nbsp;&nbsp; 141&nbsp;&nbsp;&=
nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbs=
p;&nbsp;&nbsp; 7<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">sdd&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; 65600&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0&nbsp; 240&nbsp; 273&nbsp;&nbsp;&nbsp;&nbsp; 273&nb=
sp; &nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp; 4&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0&nbsp;&nbsp;&nbsp; 7<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">sde&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; 56440&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0&nbsp; 207&nbsp; 273&nbsp;&nbsp;&nbsp;&nbsp; 272&nb=
sp;&nbsp;&nbsp; 64&nbsp;&nbsp; 342&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4&nbsp;&nb=
sp; 99<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">sdg&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; 43544&nbsp;&n=
bsp;&nbsp; 450&nbsp; 326&nbsp; 134&nbsp;&nbsp;&nbsp;&nbsp; 133&nbsp;&nbsp;&=
nbsp; 39&nbsp;&nbsp; 135&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp; 99<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">sdf&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; 65600&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;0&nbsp; 240&nbsp; 273&nbsp;&nbsp;&nbsp;&nbsp; 273&nb=
sp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0&nbsp;&nbsp;&nbsp; 7<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">sdh&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; 57400&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0&nbsp; 210&nbsp; 273&nbsp;&nbsp;&nbsp;&nbsp; 273&nb=
sp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0&nbsp;&nbsp;&nbsp; 7<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">sdi&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; 69012&nbsp;&n=
bsp;&nbsp; 227&nbsp; 251&nbsp; 275&nbsp;&nbsp;&nbsp;&nbsp; 274&nbsp;&nbsp;&=
nbsp; 90&nbsp;&nbsp; 560&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp; 99<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">sdj&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; 66944&nbsp;&n=
bsp;&nbsp; 424&nbsp; 308&nbsp; 217&nbsp;&nbsp;&nbsp;&nbsp; 217&nbsp;&nbsp;&=
nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp; 5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbs=
p;&nbsp;&nbsp; 7<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">sdb&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; 43496&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0&nbsp; 159&nbsp; 274&nbsp;&nbsp;&nbsp;&nbsp; 273&nb=
sp;&nbsp;&nbsp;&nbsp; 6&nbsp;&nbsp;&nbsp; 41&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
3&nbsp;&nbsp; 51<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"># DISK STATISTICS (/sec)<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &lt;---------reads---------&gt;&lt;---------writes=
---------&gt;&lt;--------averages--------&gt; Pct<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#Name&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; KBytes Merged&nbsp; IOs Size&nbsp; KBytes Merged&nbsp; IOs Size&=
nbsp; RWSize&nbsp; QLen&nbsp; Wait SvcTim Util<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">sdk&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp; 178016&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0&nbsp; 599&nbsp; 297&nbsp;&nbsp;&nbsp;&nbsp; 297&nbsp;&n=
bsp; 219&nbsp;&nbsp; 390&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp; 99<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">sdl&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp; 156540&nbsp; &nbsp;=
&nbsp;&nbsp;&nbsp;0&nbsp; 536&nbsp; 292&nbsp;&nbsp;&nbsp;&nbsp; 292&nbsp;&n=
bsp;&nbsp; 27&nbsp;&nbsp;&nbsp; 51&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nb=
sp; 96<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">sdm&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; 0&nbsp; 166724&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0&nbsp; 578&nbsp; 288&nbsp;&nbsp;&nbsp;&nbsp; 288&nbsp;&n=
bsp;&nbsp; 31&nbsp;&nbsp;&nbsp; 42&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nb=
sp; 95<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The write throughput of SSDs ar=
e increase to about ~170MB/s that may represent three SSDs for journal enou=
gh
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">but I don't understand why 9 OS=
Ds &#43; 3 SSDs can has more write bandwidth than 8 OSDs &#43; 4 SSDs ... ?=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Another question is 1x replicat=
ion has 490MB/s bandwidth on a storage server, that mean if I have two stor=
age server and 2x replication on each storage server, then write bandwidth =
can reach 490MB/s ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;mso-para-margin-l=
eft:0gd;text-indent:-18.0pt;mso-list:l1 level1 lfo2">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">3=
)<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I use HBA (LSI 9211-8i : LSISAS=
2008) instead of &quot;smart&quot; RAID card (LSI 9260-4i)<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2x replication &amp; 9 OSDs &#4=
3; 3 SSDs (Journal) case: Bandwidth (MB/sec):&nbsp;&nbsp;&nbsp;&nbsp; 247.0=
47<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1x replication &amp; 9 OSDs &#4=
3; 3 SSDs (Journal) case: Bandwidth (MB/sec):&nbsp;&nbsp;&nbsp;&nbsp; 492.7=
98<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The result looks little better =
than use RAID card !!
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;mso-para-margin-l=
eft:0gd;text-indent:-18.0pt;mso-list:l1 level1 lfo2">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">4=
)<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">XFS: <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">osd mkfs type =3D xfs<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">osd mkfs options xfs =3D -f -i =
size=3D2048<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">osd mount options xfs =3D rw,in=
ode64,noatime<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">filestore_xattr_use_omap =3D tr=
ue<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2x replication &amp; 9 OSDs &#4=
3; 3 SSDs (Journal) case: Bandwidth (MB/sec): &nbsp;&nbsp;&nbsp;248.327<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1x replication &amp; 9 OSDs &#4=
3; 3 SSDs (Journal) case: Bandwidth (MB/sec):&nbsp;&nbsp;&nbsp; 494.292<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#&lt;----CPU[HYPER]-----&gt;&lt=
;----------Disks-----------&gt;&lt;----------Network----------&gt;<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">#cpu sys inter&nbsp; ctxsw KBRe=
ad&nbsp; Reads KBWrit Writes&nbsp;&nbsp; KBIn&nbsp; PktIn&nbsp; KBOut&nbsp;=
 PktOut<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; 22&nbsp;&nbsp; 9&nbsp; 6=
416&nbsp; 21901&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0&nbsp; 1004K&nbsp;&nbsp; 2514&nbsp;&nbsp;&nbsp;&nbsp; 10&nbsp;&nbsp;&nb=
sp;&nbsp; 39&nbsp;&nbsp;&nbsp; 113&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 37<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; 20&nbsp;&nbsp; 9&nbsp; 6=
147&nbsp; 20391&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0&nbsp; 1009K&nbsp;&nbsp; 2565&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbs=
p;&nbsp;&nbsp; 39&nbsp;&nbsp;&nbsp;&nbsp; 62&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
32<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; 19&nbsp;&nbsp; 8&nbsp; 6=
488&nbsp; 19780&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0&nbsp; 1006K&nbsp;&nbsp; 2448&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7&nbsp;&nbs=
p;&nbsp;&nbsp; 31&nbsp;&nbsp;&nbsp;&nbsp; 21&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
23<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; 21&nbsp; 10&nbsp; 6730&n=
bsp; 19695&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&=
nbsp; 1003K&nbsp;&nbsp; 2430&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5&nbsp;&nbsp;&nb=
sp;&nbsp; 16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; 20&nbsp;&nbsp; 9&nbsp; 6=
755&nbsp; 19244&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0&nbsp; &nbsp;994K&nbsp;&nbsp; 2491&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp=
;&nbsp;&nbsp;&nbsp; 15&nbsp;&nbsp;&nbsp;&nbsp; 25&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 12<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Total write throughput also stu=
ck on about 1GB/s, I think the same reason as 1)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">BTRFS: <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">osd mkfs type =3D btrfs<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">osd mkfs options btrfs =3D -l 1=
6k -n 16k<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">osd mount options xfs =3D -o no=
atime<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2x replication &amp; 9 OSDs &#4=
3; 3 SSDs (Journal) case: Bandwidth (MB/sec):&nbsp;&nbsp;&nbsp;&nbsp; 243.8=
17<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1x replication &amp; 9 OSDs &#4=
3; 3 SSDs (Journal) case: Bandwidth (MB/sec):&nbsp;&nbsp;&nbsp;&nbsp; 487.8=
09<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">The results are same as EXT4 / =
XFS<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Next time I will try to use 2nd=
 controller and directly connect my disks and SSDs
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks !! </span><span lang=3D"=
EN-US" style=3D"font-family:Wingdings">J</span><span lang=3D"EN-US"><o:p></=
o:p></span></p>
<p class=3D"MsoListParagraph" style=3D"margin-left:18.0pt;mso-para-margin-l=
eft:0gd;text-indent:-18.0pt;mso-list:l0 level1 lfo4">
<![if !supportLists]><span lang=3D"EN-US"><span style=3D"mso-list:Ignore">-=
<span style=3D"font:7.0pt &quot;Times New Roman&quot;">&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><span lang=3D"EN-US">Kelvin<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>

--_000_86F425174C7E4F418CCF4E62056152E5942CFBGDCCLDMBXP01whqwi_--

--===============0573125261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0573125261==--
