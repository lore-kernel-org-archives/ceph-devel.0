From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: scrub errors on rgw data pool
Date: Tue, 26 Nov 2019 12:00:43 +0530
Message-ID: <CANA9Uk6CyYfFuw-X82wgikjvPRWCe9sQxziB-oo0hW_So74pFA@mail.gmail.com>
References: <CANA9Uk4kmPqe6z17BUCnUuJyNcQkOqEcwXv+RLOsbKS-bmsyGw@mail.gmail.com>
 <1067131621.54855.1574735565028.JavaMail.zimbra@ufm.su>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4881720310633547688=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1067131621.54855.1574735565028.JavaMail.zimbra-TAHq1US7lqU@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Fyodor Ustinov <ufm-TAHq1US7lqU@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============4881720310633547688==
Content-Type: multipart/alternative; boundary="000000000000b2300305983a0515"

--000000000000b2300305983a0515
Content-Type: text/plain; charset="UTF-8"

Thanks for reply
Have you migrated all filestore OSDs from filestore backend to bluestore
backend?
Or
Have you upgraded from Luminious 12.2.11 to 14.x?

What helped here?


On Tue, Nov 26, 2019 at 8:03 AM Fyodor Ustinov <ufm-TAHq1US7lqU@public.gmane.org> wrote:

> Hi!
>
> I had similar errors in pools on SSD until I upgraded to nautilus (clean
> bluestore installation)
>
> ----- Original Message -----
> > From: "M Ranga Swami Reddy" <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > To: "ceph-users" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel" <
> ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> > Sent: Monday, 25 November, 2019 12:04:46
> > Subject: [ceph-users] scrub errors on rgw data pool
>
> > Hello - We are using the ceph 12.2.11 version (upgraded from Jewel
> 10.2.12 to
> > 12.2.11). In this cluster, we are having mix of filestore and bluestore
> OSD
> > backends.
> > Recently we are seeing the scrub errors on rgw buckets.data pool every
> day,
> > after scrub operation performed by Ceph. If we run the PG repair, the
> errors
> > will go way.
> >
> > Anyone seen the above issue?
> > Is the mix of filestore backend has bug/issue with 12.2.11 version (ie
> > Luminous).
> > Is the mix of filestore and bluestore OSDs cause this type of issue?
> >
> > Thanks
> > Swami
> >
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--000000000000b2300305983a0515
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for reply=C2=A0<div>Have=C2=A0you migrated all file=
store OSDs from filestore backend to bluestore backend?</div><div>Or</div><=
div>Have you upgraded from Luminious 12.2.11 to 14.x?</div><div><br></div><=
div>What helped here?</div><div><br></div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 26, 2019 at 8:03 AM F=
yodor Ustinov &lt;<a href=3D"mailto:ufm-TAHq1US7lqU@public.gmane.org">ufm-TAHq1US7lqU@public.gmane.org</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
<br>
I had similar errors in pools on SSD until I upgraded to nautilus (clean bl=
uestore installation)<br>
<br>
----- Original Message -----<br>
&gt; From: &quot;M Ranga Swami Reddy&quot; &lt;<a href=3D"mailto:swamireddy=
@gmail.com" target=3D"_blank">swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt; To: &quot;ceph-users&quot; &lt;<a href=3D"mailto:ceph-users-idqoXFIVOFLXfrYAhh+zQw@public.gmane.org=
.com" target=3D"_blank">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>&gt;, &quot;ceph-devel=
&quot; &lt;<a href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" target=3D"_blank">=
ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt;<br>
&gt; Sent: Monday, 25 November, 2019 12:04:46<br>
&gt; Subject: [ceph-users] scrub errors on rgw data pool<br>
<br>
&gt; Hello - We are using the ceph 12.2.11 version (upgraded from Jewel 10.=
2.12 to<br>
&gt; 12.2.11). In this cluster, we are having mix of filestore and bluestor=
e OSD<br>
&gt; backends.<br>
&gt; Recently we are seeing the scrub errors on rgw buckets.data pool every=
 day,<br>
&gt; after scrub operation performed by Ceph. If we run the PG repair, the =
errors<br>
&gt; will go way.<br>
&gt; <br>
&gt; Anyone seen the above issue?<br>
&gt; Is the mix of filestore backend has bug/issue with 12.2.11 version (ie=
<br>
&gt; Luminous).<br>
&gt; Is the mix of filestore and bluestore OSDs cause this type of issue?<b=
r>
&gt; <br>
&gt; Thanks<br>
&gt; Swami<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-us=
ers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=
=3D"noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-u=
sers-ceph.com</a><br>
</blockquote></div>

--000000000000b2300305983a0515--

--===============4881720310633547688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============4881720310633547688==--
