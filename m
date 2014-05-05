From: John Spray <john.spray-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: RADOS translator for GlusterFS
Date: Mon, 5 May 2014 17:41:04 +0100
Message-ID: <CAGd4Wr3sLmXdmFQMgVq1E=NV7K+c+MX9yfRopTN+SkYacX4b5Q@mail.gmail.com>
References: <980181538.654650.1399300829103.JavaMail.zimbra@redhat.com>
	<355696287.706122.1399303290204.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7890253208873659675=="
Return-path: <gluster-devel-bounces-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org>
In-Reply-To: <355696287.706122.1399303290204.JavaMail.zimbra-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://supercolony.gluster.org/mailman/options/gluster-devel>,
	<mailto:gluster-devel-request-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <http://supercolony.gluster.org/pipermail/gluster-devel/>
List-Post: <mailto:gluster-devel-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:gluster-devel-request-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <http://supercolony.gluster.org/mailman/listinfo/gluster-devel>,
	<mailto:gluster-devel-request-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org?subject=subscribe>
Sender: gluster-devel-bounces-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org
Errors-To: gluster-devel-bounces-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org
To: Jeff Darcy <jdarcy-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, gluster-devel-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============7890253208873659675==
Content-Type: multipart/alternative; boundary=001a11343f941e006b04f8a9cc43

--001a11343f941e006b04f8a9cc43
Content-Type: text/plain; charset=UTF-8

In terms of making something work really quickly, one approach would be to
base off the existing POSIX translator, use a local FS backed by an RBD
volume for the metadata, and store the file content directly using
librados.  That would avoid the need to invent a way to map
filesystem-style metadata to librados calls, while still getting reasonably
efficient data operations through to rados.

I would doubt this would be very slick, but it could be a fun hack!

John




On Mon, May 5, 2014 at 4:21 PM, Jeff Darcy <jdarcy-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Now that we're all one big happy family, I've been mulling over
> different ways that the two technology stacks could work together.  One
> idea would be to use some of the GlusterFS upper layers for their
> interface and integration possibilities, but then falling down to RADOS
> instead of GlusterFS's own distribution and replication.  I must
> emphasize that I don't necessarily think this is The Right Way for
> anything real, but I think it's an important experiment just to see what
> the problems are and how well it performs.  So here's what I'm thinking.
>
> For the Ceph folks, I'll describe just a tiny bit of how GlusterFS
> works.  The core concept in GlusterFS is a "translator" which accepts
> file system requests and generates file system requests in exactly the
> same form.  This allows them to be stacked in arbitrary orders, moved
> back and forth across the server/client divide, etc.  There are several
> broad classes of translators:
>
> * Some, such as FUSE or GFAPI, inject new requests into the translator
>   stack.
>
> * Some, such as "posix", satisfy requests by calling a server-local FS.
>
> * The "client" and "server" translators together get requests from one
>   machine to another.
>
> * Some translators *route* requests (one in to one of several out).
>
> * Some translators *fan out* requests (one in to all of several out).
>
> * Most are one in, one out, to add e.g. locks or caching etc.
>
> Of particular interest here are the DHT (routing/distribution) and AFR
> (fan-out/replication) translators, which mirror functionality in RADOS.
> My idea is to cut out everything from these on below, in favor of a
> translator based on librados instead.  How this works is pretty obvious
> for file data - just read and write to RADOS objects instead of to
> files.  It's a bit less obvious for metadata, especially directory
> entries.  One really simple idea is to store metadata as data, in some
> format defined by the translator itself, and have it handle the
> read/modify/write for adding/deleting entries and such.  That would be
> enough to get some basic performance tests done.  A slightly more
> sophisticated idea might be to use OSD class methods to do the
> read/modify/write, but I don't know much about that mechanism so I'm not
> sure that's even feasible.
>
> This is not something I'm going to be working on as part of my main job,
> but I'd like to get the experiment started in some of my "spare" time.
> Is there anyone else interested in collaborating, or are there any other
> obvious ideas I'm missing?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a11343f941e006b04f8a9cc43
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div>In terms of making something work really quickly,=
 one approach would be to base off the existing POSIX translator, use a loc=
al FS backed by an RBD volume for the metadata, and store the file content =
directly using librados. =C2=A0That would avoid the need to invent a way to=
 map filesystem-style metadata to librados calls, while still getting reaso=
nably efficient data operations through to rados.</div>
<div><br></div><div>I would doubt this would be very slick, but it could be=
 a fun hack!</div><div><br></div><div>John</div><div><br></div><div><br></d=
iv></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On M=
on, May 5, 2014 at 4:21 PM, Jeff Darcy <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:jdarcy-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">jdarcy-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> w=
rote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Now that we&#39;re all one big happy family,=
 I&#39;ve been mulling over<br>
different ways that the two technology stacks could work together. =C2=A0On=
e<br>
idea would be to use some of the GlusterFS upper layers for their<br>
interface and integration possibilities, but then falling down to RADOS<br>
instead of GlusterFS&#39;s own distribution and replication. =C2=A0I must<b=
r>
emphasize that I don&#39;t necessarily think this is The Right Way for<br>
anything real, but I think it&#39;s an important experiment just to see wha=
t<br>
the problems are and how well it performs. =C2=A0So here&#39;s what I&#39;m=
 thinking.<br>
<br>
For the Ceph folks, I&#39;ll describe just a tiny bit of how GlusterFS<br>
works. =C2=A0The core concept in GlusterFS is a &quot;translator&quot; whic=
h accepts<br>
file system requests and generates file system requests in exactly the<br>
same form. =C2=A0This allows them to be stacked in arbitrary orders, moved<=
br>
back and forth across the server/client divide, etc. =C2=A0There are severa=
l<br>
broad classes of translators:<br>
<br>
* Some, such as FUSE or GFAPI, inject new requests into the translator<br>
=C2=A0 stack.<br>
<br>
* Some, such as &quot;posix&quot;, satisfy requests by calling a server-loc=
al FS.<br>
<br>
* The &quot;client&quot; and &quot;server&quot; translators together get re=
quests from one<br>
=C2=A0 machine to another.<br>
<br>
* Some translators *route* requests (one in to one of several out).<br>
<br>
* Some translators *fan out* requests (one in to all of several out).<br>
<br>
* Most are one in, one out, to add e.g. locks or caching etc.<br>
<br>
Of particular interest here are the DHT (routing/distribution) and AFR<br>
(fan-out/replication) translators, which mirror functionality in RADOS.<br>
My idea is to cut out everything from these on below, in favor of a<br>
translator based on librados instead. =C2=A0How this works is pretty obviou=
s<br>
for file data - just read and write to RADOS objects instead of to<br>
files. =C2=A0It&#39;s a bit less obvious for metadata, especially directory=
<br>
entries. =C2=A0One really simple idea is to store metadata as data, in some=
<br>
format defined by the translator itself, and have it handle the<br>
read/modify/write for adding/deleting entries and such. =C2=A0That would be=
<br>
enough to get some basic performance tests done. =C2=A0A slightly more<br>
sophisticated idea might be to use OSD class methods to do the<br>
read/modify/write, but I don&#39;t know much about that mechanism so I&#39;=
m not<br>
sure that&#39;s even feasible.<br>
<br>
This is not something I&#39;m going to be working on as part of my main job=
,<br>
but I&#39;d like to get the experiment started in some of my &quot;spare&qu=
ot; time.<br>
Is there anyone else interested in collaborating, or are there any other<br=
>
obvious ideas I&#39;m missing?<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at =C2=A0<a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
</blockquote></div><br></div>

--001a11343f941e006b04f8a9cc43--

--===============7890253208873659675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Gluster-devel mailing list
Gluster-devel-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org
http://supercolony.gluster.org/mailman/listinfo/gluster-devel

--===============7890253208873659675==--
