From: Andrei Mikhailovsky <andrei-930XJYlnu5nQT0dZR+AlfA@public.gmane.org>
Subject: Re: Preliminary RDMA vs TCP numbers
Date: Wed, 8 Apr 2015 19:16:40 +0100 (BST)
Message-ID: <13289231.842.1428516917655.JavaMail.andrei@tuchka>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD75D78@SACMBXIP01.sdcorp.global.sandisk.com>
	<CABYiri_ihguSripu=gs-MA7Qr8GRDk7H5hw5BNKf-9OSFu1z8g@mail.gmail.com>
	<6442513.754.1428484840531.JavaMail.andrei@tuchka>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2CD761B4@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0112480069=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD761B4-cXZ6iGhjG0il5HHZYNR2WTJ2aSJ780jGSxCzGc5ayCJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0112480069==
Content-Type: multipart/alternative;
	boundary="----=_Part_841_28200728.1428516917654"

------=_Part_841_28200728.1428516917654
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Somnath, 

Sounds very promising! I can't wait to try it on my cluster as I am currently using IPOIB instread of the native rdma. 

Cheers 

Andrei 

----- Original Message -----

> From: "Somnath Roy" <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
> To: "Andrei Mikhailovsky" <andrei-930XJYlnu5nQT0dZR+AlfA@public.gmane.org>, "Andrey Korolyov"
> <andrey-5vqebrSIFTo@public.gmane.org>
> Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, "ceph-devel"
> <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Sent: Wednesday, 8 April, 2015 5:23:23 PM
> Subject: RE: [ceph-users] Preliminary RDMA vs TCP numbers

> Andrei,
> Yes, I see it has lot of potential and I believe fixing the
> performance bottlenecks inside XIO messenger it should go further.
> We are working on it and will keep community posted..

> Thanks & Regards
> Somnath

> From: Andrei Mikhailovsky [mailto:andrei-930XJYlnu5nQT0dZR+AlfA@public.gmane.org]
> Sent: Wednesday, April 08, 2015 2:22 AM
> To: Andrey Korolyov
> Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; ceph-devel; Somnath Roy
> Subject: Re: [ceph-users] Preliminary RDMA vs TCP numbers

> Hi,

> Am I the only person noticing disappointing results from the
> preliminary RDMA testing, or am I reading the numbers wrong?

> Yes, it's true that on a very small cluster you do see a great
> improvement in rdma, but in real life rdma is used in large
> infrastructure projects, not on a few servers with a handful of
> osds. In fact, from what i've seen from the slides, the rdma
> implementation scales horribly to the point that it becomes slower
> the more osds you through at it.

> From my limited knowledge, i have expected a much higher performance
> gains with rdma, taking into account that you should have much lower
> latency and overhead and lower cpu utilisation when using this
> transport in comparison with tcp.

> Are we likely to see a great deal of improvement with ceph and rdma
> in a near future? Is there a roadmap for having a stable and
> reliable rdma protocol support?

> Thanks

> Andrei
> ----- Original Message -----

> > From: "Andrey Korolyov" < andrey-5vqebrSIFTo@public.gmane.org >
> 
> > To: "Somnath Roy" < Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org >
> 
> > Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org , "ceph-devel" <
> > ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org >
> 
> > Sent: Wednesday, 8 April, 2015 9:28:12 AM
> 
> > Subject: Re: [ceph-users] Preliminary RDMA vs TCP numbers
> 

> > On Wed, Apr 8, 2015 at 11:17 AM, Somnath Roy <
> > Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org > wrote:
> 
> > >
> 
> > > Hi,
> 
> > > Please find the preliminary performance numbers of TCP Vs RDMA
> > > (XIO) implementation (on top of SSDs) in the following link.
> 
> > >
> 
> > > http://www.slideshare.net/somnathroy7568/ceph-on-rdma
> 
> > >
> 
> > > The attachment didn't go through it seems, so, I had to use
> > > slideshare.
> 
> > >
> 
> > > Mark,
> 
> > > If we have time, I can present it in tomorrow's performance
> > > meeting.
> 
> > >
> 
> > > Thanks & Regards
> 
> > > Somnath
> 
> > >
> 

> > Those numbers are really impressive (for small numbers at least)!
> > What
> 
> > are TCP settings you using?For example, difference can be lowered
> > on
> 
> > scale due to less intensive per-connection acceleration on CUBIC on
> > a
> 
> > larger number of nodes, though I do not believe that it was a main
> 
> > reason for an observed TCP catchup on a relatively flat workload
> > such
> 
> > as fio generates.
> 
> > _______________________________________________
> 
> > ceph-users mailing list
> 
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> 
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> PLEASE NOTE: The information contained in this electronic mail
> message is intended only for the use of the designated recipient(s)
> named above. If the reader of this message is not the intended
> recipient, you are hereby notified that you have received this
> message in error and that any review, dissemination, distribution,
> or copying of this message is strictly prohibited. If you have
> received this communication in error, please notify the sender by
> telephone or e-mail (as shown above) immediately and destroy any and
> all copies of this message in your possession (whether hard copies
> or electronically stored copies).

------=_Part_841_28200728.1428516917654
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: arial,helvetica,sans-serif; font-size: 10pt; colo=
r: #000000'>Somnath,<br><br>Sounds very promising! I can't wait to try it o=
n my cluster as I am currently using IPOIB instread of the native rdma.<br>=
<br>Cheers<br><br>Andrei<br><br><div><br></div><br><hr id=3D"zwchr"><blockq=
uote style=3D"border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; pa=
dding-left: 5px; color: rgb(0, 0, 0); font-weight: normal; font-style: norm=
al; text-decoration: none; font-family: Helvetica,Arial,sans-serif; font-si=
ze: 12pt;"><b>From: </b>"Somnath Roy" &lt;Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org&gt;<br><b=
>To: </b>"Andrei Mikhailovsky" &lt;andrei-930XJYlnu5nQT0dZR+AlfA@public.gmane.org&gt;, "Andrey Korolyov"=
 &lt;andrey-5vqebrSIFTo@public.gmane.org&gt;<br><b>Cc: </b>ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, "ceph-deve=
l" &lt;ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;<br><b>Sent: </b>Wednesday, 8 April, 2=
015 5:23:23 PM<br><b>Subject: </b>RE: [ceph-users] Preliminary RDMA vs TCP =
numbers<br><br>



<style><!--

@font-face
=09{font-family:Helvetica;
=09panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
=09{font-family:Helvetica;
=09panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
=09{font-family:Tahoma;
=09panose-1:2 11 6 4 3 5 4 4 2 4;}

p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:12.0pt;
=09font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
p
=09{mso-style-priority:99;
=09margin:0in;
=09margin-bottom:.0001pt;
=09font-size:12.0pt;
=09font-family:"Times New Roman","serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
=09{mso-style-priority:99;
=09mso-style-link:"Balloon Text Char";
=09margin:0in;
=09margin-bottom:.0001pt;
=09font-size:8.0pt;
=09font-family:"Tahoma","sans-serif";}
span.EmailStyle18
=09{mso-style-type:personal-reply;
=09font-family:"Calibri","sans-serif";
=09color:#1F497D;}
span.BalloonTextChar
=09{mso-style-name:"Balloon Text Char";
=09mso-style-priority:99;
=09mso-style-link:"Balloon Text";
=09font-family:"Tahoma","sans-serif";}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-size:10.0pt;}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
--></style>

<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size: 11pt; font-family: &quot;C=
alibri&quot;,&quot;sans-serif&quot;; color: rgb(31, 73, 125);">Andrei,</spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size: 11pt; font-family: &quot;C=
alibri&quot;,&quot;sans-serif&quot;; color: rgb(31, 73, 125);">Yes, I see i=
t has lot of potential and I believe fixing the performance bottlenecks ins=
ide XIO messenger it should go further.</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size: 11pt; font-family: &quot;C=
alibri&quot;,&quot;sans-serif&quot;; color: rgb(31, 73, 125);">We are worki=
ng on it and will keep community posted..</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size: 11pt; font-family: &quot;C=
alibri&quot;,&quot;sans-serif&quot;; color: rgb(31, 73, 125);">&nbsp;</span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size: 11pt; font-family: &quot;C=
alibri&quot;,&quot;sans-serif&quot;; color: rgb(31, 73, 125);">Thanks &amp;=
 Regards</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size: 11pt; font-family: &quot;C=
alibri&quot;,&quot;sans-serif&quot;; color: rgb(31, 73, 125);">Somnath</spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size: 11pt; font-family: &quot;C=
alibri&quot;,&quot;sans-serif&quot;; color: rgb(31, 73, 125);">&nbsp;</span=
></p>
<div>
<div style=3D"border-right: medium none; border-width: 1pt medium medium; b=
order-style: solid none none; border-color: rgb(181, 196, 223) -moz-use-tex=
t-color -moz-use-text-color; padding: 3pt 0in 0in;">
<p class=3D"MsoNormal"><b><span style=3D"font-size: 10pt; font-family: &quo=
t;Tahoma&quot;,&quot;sans-serif&quot;;">From:</span></b><span style=3D"font=
-size: 10pt; font-family: &quot;Tahoma&quot;,&quot;sans-serif&quot;;"> Andr=
ei Mikhailovsky [mailto:andrei-930XJYlnu5nQT0dZR+AlfA@public.gmane.org]
<br>
<b>Sent:</b> Wednesday, April 08, 2015 2:22 AM<br>
<b>To:</b> Andrey Korolyov<br>
<b>Cc:</b> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; ceph-devel; Somnath Roy<br>
<b>Subject:</b> Re: [ceph-users] Preliminary RDMA vs TCP numbers</span></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;</p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: &quot;A=
rial&quot;,&quot;sans-serif&quot;; color: black;">Hi,<br>
<br>
Am I the only person noticing disappointing results from the preliminary RD=
MA testing, or am I reading the numbers wrong?
<br>
<br>
Yes, it's true that on a very small cluster you do see a great improvement =
in rdma, but in real life rdma is used in large infrastructure projects, no=
t on a few servers with a handful of osds. In fact, from what i've seen fro=
m the slides, the rdma implementation
 scales horribly to the point that it becomes slower the more osds you thro=
ugh at it.<br>
<br>
From my limited knowledge, i have expected a much higher performance gains =
with rdma, taking into account that you should have much lower latency and =
overhead and lower cpu utilisation when using this transport in comparison =
with tcp.<br>
<br>
Are we likely to see a great deal of improvement with ceph and rdma in a ne=
ar future? Is there a roadmap for having a stable and reliable rdma protoco=
l support?<br>
<br>
Thanks<br>
<br>
Andrei</span></p>
<div class=3D"MsoNormal" style=3D"text-align: center;" align=3D"center"><sp=
an style=3D"font-size: 10pt; font-family: &quot;Arial&quot;,&quot;sans-seri=
f&quot;; color: black;">
<hr id=3D"zwchr" align=3D"center" size=3D"2" width=3D"100%">
</span></div>
<blockquote style=3D"border-width: medium medium medium 1.5pt; border-style=
: none none none solid; border-color: -moz-use-text-color -moz-use-text-col=
or -moz-use-text-color rgb(16, 16, 255); padding: 0in 0in 0in 4pt; margin-l=
eft: 3.75pt; margin-top: 5pt; margin-bottom: 5pt;">
<p class=3D"MsoNormal"><b><span style=3D"font-family: &quot;Helvetica&quot;=
,&quot;sans-serif&quot;; color: black;">From:
</span></b><span style=3D"font-family: &quot;Helvetica&quot;,&quot;sans-ser=
if&quot;; color: black;">"Andrey Korolyov" &lt;<a href=3D"mailto:andrey@xde=
l.ru" target=3D"_blank">andrey-5vqebrSIFTo@public.gmane.org</a>&gt;<br>
<b>To: </b>"Somnath Roy" &lt;<a href=3D"mailto:Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org" tar=
get=3D"_blank">Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
<b>Cc: </b><a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">c=
eph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>, "ceph-devel" &lt;<a href=3D"mailto:ceph-devel=
@vger.kernel.org" target=3D"_blank">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;<br>
<b>Sent: </b>Wednesday, 8 April, 2015 9:28:12 AM<br>
<b>Subject: </b>Re: [ceph-users] Preliminary RDMA vs TCP numbers<br>
<br>
On Wed, Apr 8, 2015 at 11:17 AM, Somnath Roy &lt;<a href=3D"mailto:Somnath.=
Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote:<b=
r>
&gt;<br>
&gt; Hi,<br>
&gt; Please find the preliminary performance numbers of TCP Vs RDMA (XIO) i=
mplementation (on top of SSDs) in the following link.<br>
&gt;<br>
&gt; <a href=3D"http://www.slideshare.net/somnathroy7568/ceph-on-rdma" targ=
et=3D"_blank">http://www.slideshare.net/somnathroy7568/ceph-on-rdma</a><br>
&gt;<br>
&gt; The attachment didn't go through it seems, so, I had to use slideshare=
.<br>
&gt;<br>
&gt; Mark,<br>
&gt; If we have time, I can present it in tomorrow's performance meeting.<b=
r>
&gt;<br>
&gt; Thanks &amp; Regards<br>
&gt; Somnath<br>
&gt;<br>
<br>
Those numbers are really impressive (for small numbers at least)! What<br>
are TCP settings you using?For example, difference can be lowered on<br>
scale due to less intensive per-connection acceleration on CUBIC on a<br>
larger number of nodes, though I do not believe that it was a main<br>
reason for an observed TCP catchup on a relatively flat workload such<br>
as fio generates.<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-users@l=
ists.ceph.com</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a></spa=
n></p>
</blockquote>
<p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: &quot;A=
rial&quot;,&quot;sans-serif&quot;; color: black;">&nbsp;</span></p>
</div>
</div>
<br>
<hr>
<font color=3D"Gray" face=3D"Arial" size=3D"2"><br>
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
</blockquote><br></div></body></html>
------=_Part_841_28200728.1428516917654--

--===============0112480069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0112480069==--
