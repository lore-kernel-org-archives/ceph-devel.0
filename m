From: Craig Lewis <clewis-04jk9TcbgGYP2IHM84UzcNBPR1lH4CV8@public.gmane.org>
Subject: Re: Translating a RadosGW object name into a filename
	on disk
Date: Tue, 19 Aug 2014 19:39:28 -0700
Message-ID: <CADHZLBaG+x_9M4GqWJxU3ypY9ykOKsaneBt4Qbjfk8gN28x0bg@mail.gmail.com>
References: <CADHZLBa+5dx+kojiSh+T7GmM_asCwhPTriTNr3ob2SUya+KFhw@mail.gmail.com>
	<CAPYLRzjaOZc+ZG4aibR18N6O3AW1JXU2440J+NSDHmxn4ircag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1867370763=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAPYLRzjaOZc+ZG4aibR18N6O3AW1JXU2440J+NSDHmxn4ircag-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1867370763==
Content-Type: multipart/alternative; boundary=047d7bb04ac08e74970501068442

--047d7bb04ac08e74970501068442
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Looks like I need to upgrade to Firefly to get ceph-kvstore-tool before I
can proceed.
I am getting some hits just from grepping the LevelDB store, but so far
nothing has panned out.

Thanks for the help!



On Tue, Aug 19, 2014 at 10:27 AM, Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> It's been a while since I worked on this, but let's see what I remember..=
.
>
> On Thu, Aug 14, 2014 at 11:34 AM, Craig Lewis <clewis-04jk9TcbgGYP2IHM84UzcNBPR1lH4CV8@public.gmane.org>
> wrote:
> > In my effort to learn more of the details of Ceph, I'm trying to
> > figure out how to get from an object name in RadosGW, through the
> > layers, down to the files on disk.
> >
> > clewis@clewis-mac ~ $ s3cmd ls s3://cpltest/
> > 2014-08-13 23:02        14M  28dde9db15fdcb5a342493bc81f91151
> > s3://cpltest/vmware-freebsd-tools.tar.gz
> >
> > Looking at the .rgw pool's contents tells me that the cpltest bucket
> > is default.73886.55:
> > root@dev-ceph0:/var/lib/ceph/osd/ceph-0/current# rados -p .rgw ls |
> grep cpltest
> > cpltest
> > .bucket.meta.cpltest:default.73886.55
>
> Okay, what you're seeing here are two different types, whose names I'm
> not going to get right:
> 1) The bucket link "cpltest", which maps from the name "cpltest" to a
> "bucket instance". The contents of cpltest, or one of its xattrs, are
> pointing at ".bucket.meta.cpltest:default.73886.55"
> 2) The "bucket instance" .bucket.meta.cpltest:default.73886.55. I
> think this contains the bucket index (list of all objects), etc.
>
> > The rados objects that belong to that bucket are:
> > root@dev-ceph0:~# rados -p .rgw.buckets ls | grep default.73886.55
> > default.73886.55__shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_1
> > default.73886.55__shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_3
> > default.73886.55_vmware-freebsd-tools.tar.gz
> > default.73886.55__shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_2
> > default.73886.55__shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_4
>
> Okay, so when you ask RGW for the object vmware-freebsd-tools.tar.gz
> from the cpltest bucket, it will look up (or, if we're lucky, have
> cached) the cpltest link, and find out that the "bucket prefix" is
> default.73886.55. It will then try and access the object
> "default.73886.55_vmware-freebsd-tools.tar.gz" (whose construction I
> hope is obvious =E2=80=94 bucket instance ID as a prefix, _ as a separate=
,
> then the object name). This RADOS object is called the "head" for the
> RGW object. In addition to (usually) the beginning bit of data, it
> will also contain some xattrs with things like a "tag" for any extra
> RADOS objects which include data for this RGW object. In this case,
> that tag is "RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ". (This construction is
> how we do atomic overwrites of RGW objects which are larger than a
> single RADOS object, in addition to a few other things.)
>
> I don't think there's any way of mapping from a shadow (tail) object
> name back to its RGW name. but if you look at the rados object xattrs,
> there might (? or might not) be an attr which contains the parent
> object in one form or another. Check that out.
>
> (Or, if you want to check out the source, I think all the relevant
> bits for this are somewhere in the
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
> > I know those shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_ files are the
> > rest of vmware-freebsd-tools.tar.gz.  I can infer that because this
> > bucket only has a single file (and the sum of the sizes matches).
> > With many files, I can't infer the link anymore.
> >
> > How do I look up that link?
> >
> > I tried reading the src/rgw/rgw_rados.cc, but I'm getting lost.
> >
> >
> >
> > My real goal is the reverse.  I recently repaired an inconsistent PG.
> > The primary replica had the bad data, so I want to verify that the
> > repaired object is correct.  I have a database that stores the SHA256
> > of every object.  If I can get from the filename on disk back to an S3
> > object, I can verify the file.  If it's bad, I can restore from the
> > replicated zone.
> >
> >
> > Aside from today's task, I think it's really handy to understand these
> > low level details.  I know it's been handy in the past, when I had
> > disk corruption under my PostgreSQL database.  Knowing (and
> > practicing) ahead of time really saved me a lot of downtime then.
> >
> >
> > Thanks for any pointers.
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--047d7bb04ac08e74970501068442
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Looks like I need to upgrade to Firefly to get ceph-kvstor=
e-tool before I can proceed.<div>I am getting some hits just from grepping =
the LevelDB store, but so far nothing has panned out.</div><div><br></div>

<div>Thanks for the help!<br></div><div><br></div></div><div class=3D"gmail=
_extra"><br><br><div class=3D"gmail_quote">On Tue, Aug 19, 2014 at 10:27 AM=
, Gregory Farnum <span dir=3D"ltr">&lt;<a href=3D"mailto:greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" =
target=3D"_blank">greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">It&#39;s been a while since I worked on this=
, but let&#39;s see what I remember...<br>
<div class=3D""><br>
On Thu, Aug 14, 2014 at 11:34 AM, Craig Lewis &lt;<a href=3D"mailto:clewis@=
centraldesktop.com">clewis-04jk9TcbgGYP2IHM84UzcNBPR1lH4CV8@public.gmane.org</a>&gt; wrote:<br>
&gt; In my effort to learn more of the details of Ceph, I&#39;m trying to<b=
r>
&gt; figure out how to get from an object name in RadosGW, through the<br>
&gt; layers, down to the files on disk.<br>
&gt;<br>
&gt; clewis@clewis-mac ~ $ s3cmd ls s3://cpltest/<br>
&gt; 2014-08-13 23:02=C2=A0 =C2=A0 =C2=A0 =C2=A0 14M=C2=A0 28dde9db15fdcb5a=
342493bc81f91151<br>
&gt; s3://cpltest/vmware-freebsd-tools.tar.gz<br>
&gt;<br>
&gt; Looking at the .rgw pool&#39;s contents tells me that the cpltest buck=
et<br>
&gt; is default.73886.55:<br>
&gt; root@dev-ceph0:/var/lib/ceph/osd/ceph-0/current# rados -p .rgw ls | gr=
ep cpltest<br>
&gt; cpltest<br>
&gt; .bucket.meta.cpltest:default.73886.55<br>
<br>
</div>Okay, what you&#39;re seeing here are two different types, whose name=
s I&#39;m<br>
not going to get right:<br>
1) The bucket link &quot;cpltest&quot;, which maps from the name &quot;cplt=
est&quot; to a<br>
&quot;bucket instance&quot;. The contents of cpltest, or one of its xattrs,=
 are<br>
pointing at &quot;.bucket.meta.cpltest:default.73886.55&quot;<br>
2) The &quot;bucket instance&quot; .bucket.meta.cpltest:default.73886.55. I=
<br>
think this contains the bucket index (list of all objects), etc.<br>
<div class=3D""><br>
&gt; The rados objects that belong to that bucket are:<br>
&gt; root@dev-ceph0:~# rados -p .rgw.buckets ls | grep default.73886.55<br>
&gt; default.73886.55__shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_1<br>
&gt; default.73886.55__shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_3<br>
&gt; default.73886.55_vmware-freebsd-tools.tar.gz<br>
&gt; default.73886.55__shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_2<br>
&gt; default.73886.55__shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_4<br>
<br>
</div>Okay, so when you ask RGW for the object vmware-freebsd-tools.tar.gz<=
br>
from the cpltest bucket, it will look up (or, if we&#39;re lucky, have<br>
cached) the cpltest link, and find out that the &quot;bucket prefix&quot; i=
s<br>
default.73886.55. It will then try and access the object<br>
&quot;default.73886.55_vmware-freebsd-tools.tar.gz&quot; (whose constructio=
n I<br>
hope is obvious =E2=80=94 bucket instance ID as a prefix, _ as a separate,<=
br>
then the object name). This RADOS object is called the &quot;head&quot; for=
 the<br>
RGW object. In addition to (usually) the beginning bit of data, it<br>
will also contain some xattrs with things like a &quot;tag&quot; for any ex=
tra<br>
RADOS objects which include data for this RGW object. In this case,<br>
that tag is &quot;RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ&quot;. (This construction=
 is<br>
how we do atomic overwrites of RGW objects which are larger than a<br>
single RADOS object, in addition to a few other things.)<br>
<br>
I don&#39;t think there&#39;s any way of mapping from a shadow (tail) objec=
t<br>
name back to its RGW name. but if you look at the rados object xattrs,<br>
there might (? or might not) be an attr which contains the parent<br>
object in one form or another. Check that out.<br>
<br>
(Or, if you want to check out the source, I think all the relevant<br>
bits for this are somewhere in the<br>
-Greg<br>
Software Engineer #42 @ <a href=3D"http://inktank.com" target=3D"_blank">ht=
tp://inktank.com</a> | <a href=3D"http://ceph.com" target=3D"_blank">http:/=
/ceph.com</a><br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; I know those shadow__RpwwfOt2X-mhwU65Qa1OHDi--4OMGvQ_ files are the<br=
>
&gt; rest of vmware-freebsd-tools.tar.gz.=C2=A0 I can infer that because th=
is<br>
&gt; bucket only has a single file (and the sum of the sizes matches).<br>
&gt; With many files, I can&#39;t infer the link anymore.<br>
&gt;<br>
&gt; How do I look up that link?<br>
&gt;<br>
&gt; I tried reading the src/rgw/rgw_rados.cc, but I&#39;m getting lost.<br=
>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; My real goal is the reverse.=C2=A0 I recently repaired an inconsistent=
 PG.<br>
&gt; The primary replica had the bad data, so I want to verify that the<br>
&gt; repaired object is correct.=C2=A0 I have a database that stores the SH=
A256<br>
&gt; of every object.=C2=A0 If I can get from the filename on disk back to =
an S3<br>
&gt; object, I can verify the file.=C2=A0 If it&#39;s bad, I can restore fr=
om the<br>
&gt; replicated zone.<br>
&gt;<br>
&gt;<br>
&gt; Aside from today&#39;s task, I think it&#39;s really handy to understa=
nd these<br>
&gt; low level details.=C2=A0 I know it&#39;s been handy in the past, when =
I had<br>
&gt; disk corruption under my PostgreSQL database.=C2=A0 Knowing (and<br>
&gt; practicing) ahead of time really saved me a lot of downtime then.<br>
&gt;<br>
&gt;<br>
&gt; Thanks for any pointers.<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe ceph-de=
vel&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">=
majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html<=
/a><br>
</font></span></blockquote></div><br></div>

--047d7bb04ac08e74970501068442--

--===============1867370763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1867370763==--
