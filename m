From: Haomai Wang <haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Regarding key/value interface
Date: Fri, 12 Sep 2014 10:24:54 +0800
Message-ID: <CACJqLyZk7-v3S9KDtQSwcHJp_4tsHw6m2qxbNGR6sfhZD_mVCA@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783D176@SACMBXIP02.sdcorp.global.sandisk.com>
	<alpine.DEB.2.00.1409111825480.513@cobra.newdream.net>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2783D2E3@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0698436017=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783D2E3-cXZ6iGhjG0i+xgsn/SD5JjJ2aSJ780jGSxCzGc5ayCJWk0Htik3J/w@public.gmane.org>
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
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0698436017==
Content-Type: multipart/alternative; boundary=047d7bfe95229630ed0502d4fd5f

--047d7bfe95229630ed0502d4fd5f
Content-Type: text/plain; charset=UTF-8

On Fri, Sep 12, 2014 at 9:46 AM, Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
wrote:

> Make perfect sense Sage..
>
> Regarding striping of filedata, You are saying KeyValue interface will do
> the following for me?
>
> 1. Say in case of rbd image of order 4 MB, a write request coming to
> Key/Value interface, it will  chunk the object (say full 4MB) in smaller
> sizes (configurable ?) and stripe it as multiple key/value pair ?
>

Yes, and the stripe size can be configurated.


>
> 2. Also, while reading it will take care of accumulating and send it back.
>

Do you have any other idea? By the way, could you tell more about your
key/value interface. I'm doing some jobs for NVMe interface with intel NVMe
SSD.


>
>
> Thanks & Regards
> Somnath
>
>
> -----Original Message-----
> From: Sage Weil [mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Thursday, September 11, 2014 6:31 PM
> To: Somnath Roy
> Cc: Haomai Wang (haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org); ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org;
> ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: Regarding key/value interface
>
> Hi Somnath,
>
> On Fri, 12 Sep 2014, Somnath Roy wrote:
> >
> > Hi Sage/Haomai,
> >
> > If I have a key/value backend that support transaction, range queries
> > (and I don?t need any explicit caching etc.) and I want to replace
> > filestore (and leveldb omap) with that,  which interface you recommend
> > me to derive from , directly ObjectStore or  KeyValueDB ?
> >
> > I have already integrated this backend by deriving from ObjectStore
> > interfaces earlier (pre keyvalueinteface days) but not tested
> > thoroughly enough to see what functionality is broken (Basic
> > functionalities of RGW/RBD are working fine).
> >
> > Basically, I want to know what are the advantages (and disadvantages)
> > of deriving it from the new key/value interfaces ?
> >
> > Also, what state is it in ? Is it feature complete and supporting all
> > the ObjectStore interfaces like clone and all ?
>
> Everything is supported, I think, for perhaps some IO hints that don't
> make sense in a k/v context.  The big things that you get by using
> KeyValueStore and plugging into the lower-level interface are:
>
>  - striping of file data across keys
>  - efficient clone
>  - a zillion smaller methods that aren't conceptually difficult to
> implement bug tedious and to do so.
>
> The other nice thing about reusing this code is that you can use a leveldb
> or rocksdb backend as a reference for testing or performance or whatever.
>
> The main thing that will be a challenge going forward, I predict, is
> making storage of the object byte payload in key/value pairs efficient.  I
> think KeyValuestore is doing some simple striping, but it will suffer for
> small overwrites (like 512-byte or 4k writes from an RBD).  There are
> probably some pretty simple heuristics and tricks that can be done to
> mitigate the most common patterns, but there is no simple solution since
> the backends generally don't support partial value updates (I assume yours
> doesn't either?).  But, any work done here will benefit the other backends
> too so that would be a win..
>
> sage
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is
> intended only for the use of the designated recipient(s) named above. If
> the reader of this message is not the intended recipient, you are hereby
> notified that you have received this message in error and that any review,
> dissemination, distribution, or copying of this message is strictly
> prohibited. If you have received this communication in error, please notify
> the sender by telephone or e-mail (as shown above) immediately and destroy
> any and all copies of this message in your possession (whether hard copies
> or electronically stored copies).
>
>


-- 

Best Regards,

Wheat

--047d7bfe95229630ed0502d4fd5f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Fri, Sep 12, 2014 at 9:46 AM, Somnath Roy <span dir=3D"ltr">&lt;=
<a href=3D"mailto:Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">Somnath.Roy@sa=
ndisk.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Make per=
fect sense Sage..<br>
<br>
Regarding striping of filedata, You are saying KeyValue interface will do t=
he following for me?<br>
<br>
1. Say in case of rbd image of order 4 MB, a write request coming to Key/Va=
lue interface, it will=C2=A0 chunk the object (say full 4MB) in smaller siz=
es (configurable ?) and stripe it as multiple key/value pair ?<br></blockqu=
ote><div><br></div><div>Yes, and the stripe size can be configurated.=C2=A0=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
2. Also, while reading it will take care of accumulating and send it back.<=
br></blockquote><div><br></div><div>Do you have any other idea? By the way,=
 could you tell more about your key/value interface. I&#39;m doing some job=
s for NVMe interface with intel NVMe SSD.=C2=A0</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
<br>
<br>
Thanks &amp; Regards<br>
<span class=3D"HOEnZb"><font color=3D"#888888">Somnath<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
-----Original Message-----<br>
From: Sage Weil [mailto:<a href=3D"mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">sweil-H+wXaHxf7aJhl2p70BpVqQ@public.gmane.org=
m</a>]<br>
Sent: Thursday, September 11, 2014 6:31 PM<br>
To: Somnath Roy<br>
Cc: Haomai Wang (<a href=3D"mailto:haomaiwang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">haomaiwang@gmail.c=
om</a>); <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFLXfrYAhh+zQw@public.gmane.org=
.com</a>; <a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">ceph-devel-u79uwXL29TY@public.gmane.org=
nel.org</a><br>
Subject: Re: Regarding key/value interface<br>
<br>
Hi Somnath,<br>
<br>
On Fri, 12 Sep 2014, Somnath Roy wrote:<br>
&gt;<br>
&gt; Hi Sage/Haomai,<br>
&gt;<br>
&gt; If I have a key/value backend that support transaction, range queries<=
br>
&gt; (and I don?t need any explicit caching etc.) and I want to replace<br>
&gt; filestore (and leveldb omap) with that,=C2=A0 which interface you reco=
mmend<br>
&gt; me to derive from , directly ObjectStore or=C2=A0 KeyValueDB ?<br>
&gt;<br>
&gt; I have already integrated this backend by deriving from ObjectStore<br=
>
&gt; interfaces earlier (pre keyvalueinteface days) but not tested<br>
&gt; thoroughly enough to see what functionality is broken (Basic<br>
&gt; functionalities of RGW/RBD are working fine).<br>
&gt;<br>
&gt; Basically, I want to know what are the advantages (and disadvantages)<=
br>
&gt; of deriving it from the new key/value interfaces ?<br>
&gt;<br>
&gt; Also, what state is it in ? Is it feature complete and supporting all<=
br>
&gt; the ObjectStore interfaces like clone and all ?<br>
<br>
Everything is supported, I think, for perhaps some IO hints that don&#39;t =
make sense in a k/v context.=C2=A0 The big things that you get by using Key=
ValueStore and plugging into the lower-level interface are:<br>
<br>
=C2=A0- striping of file data across keys<br>
=C2=A0- efficient clone<br>
=C2=A0- a zillion smaller methods that aren&#39;t conceptually difficult to=
 implement bug tedious and to do so.<br>
<br>
The other nice thing about reusing this code is that you can use a leveldb =
or rocksdb backend as a reference for testing or performance or whatever.<b=
r>
<br>
The main thing that will be a challenge going forward, I predict, is making=
 storage of the object byte payload in key/value pairs efficient.=C2=A0 I t=
hink KeyValuestore is doing some simple striping, but it will suffer for sm=
all overwrites (like 512-byte or 4k writes from an RBD).=C2=A0 There are pr=
obably some pretty simple heuristics and tricks that can be done to mitigat=
e the most common patterns, but there is no simple solution since the backe=
nds generally don&#39;t support partial value updates (I assume yours doesn=
&#39;t either?).=C2=A0 But, any work done here will benefit the other backe=
nds too so that would be a win..<br>
<br>
sage<br>
<br>
</div></div><div class=3D"HOEnZb"><div class=3D"h5">_______________________=
_________<br>
<br>
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>







<p>Best Regards,</p><p>Wheat</p>
</div></div>

--047d7bfe95229630ed0502d4fd5f--

--===============0698436017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0698436017==--
