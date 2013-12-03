From: Andy McCrae <andy.mccrae-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Radosgw on Ubuntu vs CentOS
Date: Tue, 3 Dec 2013 16:08:10 +0000
Message-ID: <CAM2OCdMFbs0ZV4fHJun9CZ0S6p18s_2az683c-eAWW1EKB9Qiw@mail.gmail.com>
References: <CAM2OCdNxBuLExC1N_e3Cag0gZ=845eVmgcECSEokG4TrR60yhw@mail.gmail.com>
	<alpine.DEB.2.00.1312030804430.18059@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0483209082=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1312030804430.18059-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0483209082==
Content-Type: multipart/alternative; boundary=001a113397ceba70ca04eca380b8

--001a113397ceba70ca04eca380b8
Content-Type: text/plain; charset=ISO-8859-1

Tracked it down - its the start-stop-daemon command flag, -u isn't for user
change, that should be -c, so I'll submit a fix soon.


On Tue, Dec 3, 2013 at 4:06 PM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> On Tue, 3 Dec 2013, Andy McCrae wrote:
> > Hi ceph-users,
> > I've been playing around with radosgw and I notice there is an
> inconsistency
> > between the Ubuntu and CentOS startup scripts.
> >
> > On Ubuntu, if I run a start ceph-all (which will start radosgw), or I run
> > the init script /etc/init.d/radosgw start - the radosgw process starts up
> > fine, but running as root.
> >
> > On CentOS the init script starts radosgw as the "apache" user by default.
> >
> > I can see the Ubuntu init script is specifying "www-data" which would be
> in
> > keeping with the CentOS init script, but the process runs as root.
> >
> > + start-stop-daemon --start -u www-data -x /usr/bin/radosgw -- -n
> > client.radosgw.ubunTest
> > 2013-12-03 15:13:26.449087 7fee1d33b780 -1 WARNING: libcurl doesn't
> support
> > curl_multi_wait()
> > 2013-12-03 15:13:26.449093 7fee1d33b780 -1 WARNING: cross zone / region
> > transfer performance may be affected
> > root@ubunTest:~# ps -ef | grep radosgw
> > root     28528     1  0 15:13 ?        00:00:00 /usr/bin/radosgw -n
> > client.radosgw.ubunTest
> >
> >
> > The question is, do we consider this a bug in that radosgw shouldn't run
> as
> > root by default, or should the CentOS/RHEL (rpm) init scripts start
> radosgw
> > as root - I'd assume the former.
>
> I think it's a bug.  There is no real need for radosgw to run as root,
> except that it needs to log to /var/log/radosgw/*.  We should update the
> packaging (rpm and deb) to create a radosgw user (and/or a ceph group?)
> and then make the two environments behave consistently.
>
> Anyone with strong opinions in this area interested?
>
> sage
>

--001a113397ceba70ca04eca380b8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Tracked it down - its the start-stop-daemon command flag, =
-u isn&#39;t for user change, that should be -c, so I&#39;ll submit a fix s=
oon.</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On =
Tue, Dec 3, 2013 at 4:06 PM, Sage Weil <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt;</span> wro=
te:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
ue, 3 Dec 2013, Andy McCrae wrote:<br>
&gt; Hi ceph-users,<br>
&gt; I&#39;ve been playing around with radosgw and I notice there is an inc=
onsistency<br>
&gt; between the Ubuntu and CentOS startup scripts.<br>
&gt;<br>
&gt; On Ubuntu, if I run a start ceph-all (which will start radosgw), or I =
run<br>
&gt; the init script /etc/init.d/radosgw start - the radosgw process starts=
 up<br>
&gt; fine, but running as root.<br>
&gt;<br>
&gt; On CentOS the init script starts radosgw as the &quot;apache&quot; use=
r by default.<br>
&gt;<br>
&gt; I can see the Ubuntu init script is specifying &quot;www-data&quot; wh=
ich would be in<br>
&gt; keeping with the CentOS init script, but the process runs as root.<br>
&gt;<br>
&gt; + start-stop-daemon --start -u www-data -x /usr/bin/radosgw -- -n<br>
&gt; client.radosgw.ubunTest<br>
&gt; 2013-12-03 15:13:26.449087 7fee1d33b780 -1 WARNING: libcurl doesn&#39;=
t support<br>
&gt; curl_multi_wait()<br>
&gt; 2013-12-03 15:13:26.449093 7fee1d33b780 -1 WARNING: cross zone / regio=
n<br>
&gt; transfer performance may be affected<br>
&gt; root@ubunTest:~# ps -ef | grep radosgw<br>
&gt; root =A0 =A0 28528 =A0 =A0 1 =A00 15:13 ? =A0 =A0 =A0 =A000:00:00 /usr=
/bin/radosgw -n<br>
&gt; client.radosgw.ubunTest<br>
&gt;<br>
&gt;<br>
&gt; The question is, do we consider this a bug in that radosgw shouldn&#39=
;t run as<br>
&gt; root by default, or should the CentOS/RHEL (rpm) init scripts start ra=
dosgw<br>
&gt; as root - I&#39;d assume the former.<br>
<br>
</div></div>I think it&#39;s a bug. =A0There is no real need for radosgw to=
 run as root,<br>
except that it needs to log to /var/log/radosgw/*. =A0We should update the<=
br>
packaging (rpm and deb) to create a radosgw user (and/or a ceph group?)<br>
and then make the two environments behave consistently.<br>
<br>
Anyone with strong opinions in this area interested?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
sage<br>
</font></span></blockquote></div><br></div>

--001a113397ceba70ca04eca380b8--

--===============0483209082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0483209082==--
