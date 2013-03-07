From: =?ISO-8859-1?Q?F=E9lix_Ortega_Hortig=FCela?= <fortegah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: CephFS First product release discussion
Date: Thu, 7 Mar 2013 14:11:33 +0100
Message-ID: <CAONotKO50GVHFzvueWczvv3qK8c_fcxr_v88OWZYP9LKU+S+jQ@mail.gmail.com>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
	<CANygib-U_MQi1TMmQuT_Q9MVwPfT+PzJwN=+BMcBK69WuRfu3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1798304738=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANygib-U_MQi1TMmQuT_Q9MVwPfT+PzJwN=+BMcBK69WuRfu3w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Neil Levine <neil.levine-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1798304738==
Content-Type: multipart/alternative; boundary=047d7ba9830249f56f04d7557324

--047d7ba9830249f56f04d7557324
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

I think stable mds daemon and fsck or a way to recover some of the data
once the mds crash is the only thing we need.

We are using ceph as a very big fs for doing nightly backups of our 3000+
servers. We have some front servers doing rsync over slow adsl lines,
saving all data on a very big cephfs mount. We have some kind of versioning
(with rsync --link-dest) and a custom software over all of this that allows
the user to copy his files or program uploads of the data.

We need to scale the storage quickly and to be able to recover one server
or disk malfunction searching minimum downtime. We don't need a lot of
speed (since the data lines we are using are slow).

It seems ceph is the perfect choice, but perhaps a Plan B for recovering
part of our data in case a catastrohpic failure arises is our most needed
feature.

Regards.

--
F=E9lix Ortega Hortig=FCela


On Wed, Mar 6, 2013 at 6:01 AM, Neil Levine <neil.levine-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote=
:

> As an extra request, it would be great if people explained a little
> about their use-case for the filesystem so we can better understand
> how the features requested map to the type of workloads people are
> trying.
>
> Thanks
>
> Neil
>
> On Tue, Mar 5, 2013 at 9:03 AM, Greg Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
> > This is a companion discussion to the blog post at
> http://ceph.com/dev-notes/cephfs-mds-status-discussion/ =97 go read that!
> >
> > The short and slightly alternate version: I spent most of about two
> weeks working on bugs related to snapshots in the MDS, and we started
> realizing that we could probably do our first supported release of CephFS
> and the related infrastructure much sooner if we didn't need to support a=
ll
> of the whizbang features. (This isn't to say that the base feature set is
> stable now, but it's much closer than when you turn on some of the other
> things.) I'd like to get feedback from you in the community on what minim=
um
> supported feature set would prompt or allow you to start using CephFS in
> real environments =97 not what you'd *like* to see, but what you *need* t=
o
> see. This will allow us at Inktank to prioritize more effectively and
> hopefully get out a supported release much more quickly! :)
> >
> > The current proposed feature set is basically what's left over after
> we've trimmed off everything we can think to split off, but if any of the
> proposed included features are also particularly important or don't matte=
r,
> be sure to mention them (NFS export in particular =97 it works right now =
but
> isn't in great shape due to NFS filehandle caching).
> >
> > Thanks,
> > -Greg
> >
> > Software Engineer #42 @ http://inktank.com | http://ceph.com
> >
> >
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--047d7ba9830249f56f04d7557324
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style>I think stable mds daemon and fsck or a way to =
recover some of the data once the mds crash is the only thing we need.</div=
><div style><br></div>We are using ceph as a very big fs for doing nightly =
backups of our 3000+ servers. We have some front servers doing rsync over s=
low adsl lines, saving all data on a very big cephfs mount. We have some ki=
nd of versioning (with rsync --link-dest) and a custom software over all of=
 this that allows the user to copy his files or program uploads of the data=
.<div>

<br></div><div style>We need to scale the storage quickly and to be able to=
 recover one server or disk malfunction searching minimum downtime. We don&=
#39;t need a lot of speed (since the data lines we are using are slow).</di=
v>

<div style><br></div><div style>It seems ceph is the perfect choice, but pe=
rhaps a Plan B for recovering part of our data in case a catastrohpic failu=
re arises is our most needed feature.</div><div style><br></div><div style>

Regards.</div></div><div class=3D"gmail_extra"><br clear=3D"all"><div>--<br=
>F=E9lix Ortega Hortig=FCela</div>
<br><br><div class=3D"gmail_quote">On Wed, Mar 6, 2013 at 6:01 AM, Neil Lev=
ine <span dir=3D"ltr">&lt;<a href=3D"mailto:neil.levine-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" target=
=3D"_blank">neil.levine-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">

As an extra request, it would be great if people explained a little<br>
about their use-case for the filesystem so we can better understand<br>
how the features requested map to the type of workloads people are<br>
trying.<br>
<br>
Thanks<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Neil<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
On Tue, Mar 5, 2013 at 9:03 AM, Greg Farnum &lt;<a href=3D"mailto:greg@inkt=
ank.com">greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt; wrote:<br>
&gt; This is a companion discussion to the blog post at <a href=3D"http://c=
eph.com/dev-notes/cephfs-mds-status-discussion/" target=3D"_blank">http://c=
eph.com/dev-notes/cephfs-mds-status-discussion/</a> =97 go read that!<br>
&gt;<br>
&gt; The short and slightly alternate version: I spent most of about two we=
eks working on bugs related to snapshots in the MDS, and we started realizi=
ng that we could probably do our first supported release of CephFS and the =
related infrastructure much sooner if we didn&#39;t need to support all of =
the whizbang features. (This isn&#39;t to say that the base feature set is =
stable now, but it&#39;s much closer than when you turn on some of the othe=
r things.) I&#39;d like to get feedback from you in the community on what m=
inimum supported feature set would prompt or allow you to start using CephF=
S in real environments =97 not what you&#39;d *like* to see, but what you *=
need* to see. This will allow us at Inktank to prioritize more effectively =
and hopefully get out a supported release much more quickly! :)<br>


&gt;<br>
&gt; The current proposed feature set is basically what&#39;s left over aft=
er we&#39;ve trimmed off everything we can think to split off, but if any o=
f the proposed included features are also particularly important or don&#39=
;t matter, be sure to mention them (NFS export in particular =97 it works r=
ight now but isn&#39;t in great shape due to NFS filehandle caching).<br>


&gt;<br>
&gt; Thanks,<br>
&gt; -Greg<br>
&gt;<br>
&gt; Software Engineer #42 @ <a href=3D"http://inktank.com" target=3D"_blan=
k">http://inktank.com</a> | <a href=3D"http://ceph.com" target=3D"_blank">h=
ttp://ceph.com</a><br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org=
</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" tar=
get=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><b=
r>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</div></div></blockquote></div><br></div>

--047d7ba9830249f56f04d7557324--

--===============1798304738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1798304738==--
