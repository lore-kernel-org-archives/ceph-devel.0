From: Wade Holler <wade.holler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dramatic performance drop at certain number of
	objects in pool
Date: Mon, 20 Jun 2016 18:48:18 +0000
Message-ID: <CA+e22Sc3iY5Lvp4oGwJ_wwpJsOJsWdB1thaHWEAuYP=bbGHAeg@mail.gmail.com>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
	<1450235390.2134.1466084299677@ox.pcextreme.nl>
	<CA+z5DszqHuevkAF3W01R=7AAeqVcyuHZTX0+bAvThgihvOjwuA@mail.gmail.com>
	<CA+z5Dsy4tbyiL71C8CQCTQ66tY1=9thSWdNA4BSn6=tNfGUE6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1853677841=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+z5Dsy4tbyiL71C8CQCTQ66tY1=9thSWdNA4BSn6=tNfGUE6w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1853677841==
Content-Type: multipart/alternative; boundary=001a113e3a8c67552b0535ba2635

--001a113e3a8c67552b0535ba2635
Content-Type: text/plain; charset=UTF-8

Thanks everyone for your replies.  I sincerely appreciate it. We are
testing with different pg_num and filestore_split_multiple settings.  Early
indications are .... well not great. Regardless it is nice to understand
the symptoms better so we try to design around it.

Best Regards,
Wade


On Mon, Jun 20, 2016 at 2:32 AM Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> On 20 June 2016 at 09:21, Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > slow request issues). If you watch your xfs stats you'll likely get
> > further confirmation. In my experience xs_dir_lookups balloons (which
> > means directory lookups are missing cache and going to disk).
>
> Murphy's a bitch. Today we upgraded a cluster to latest Hammer in
> preparation for Jewel/RHCS2. Turns out when we last hit this very
> problem we had only ephemerally set the new filestore merge/split
> values - oops. Here's what started happening when we upgraded and
> restarted a bunch of OSDs:
>
> https://au-east.erc.monash.edu.au/swift/v1/public/grafana-ceph-xs_dir_lookup.png
>
> Seemed to cause lots of slow requests :-/. We corrected it about
> 12:30, then still took a while to settle.
>
> --
> Cheers,
> ~Blairo
>

--001a113e3a8c67552b0535ba2635
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks everyone for your replies.=C2=A0 I sincerely apprec=
iate it. We are testing with different pg_num and filestore_split_multiple =
settings.=C2=A0 Early indications are .... well not great. Regardless it is=
 nice to understand the symptoms better so we try to design around it.<div>=
<br></div><div>Best Regards,</div><div>Wade</div><div><br></div></div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr">On Mon, Jun 20, 2016 at 2:32 AM =
Blair Bethwaite &lt;<a href=3D"mailto:blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">blair.beth=
waite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 2=
0 June 2016 at 09:21, Blair Bethwaite &lt;<a href=3D"mailto:blair.bethwaite=
@gmail.com" target=3D"_blank">blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; slow request issues). If you watch your xfs stats you&#39;ll likely ge=
t<br>
&gt; further confirmation. In my experience xs_dir_lookups balloons (which<=
br>
&gt; means directory lookups are missing cache and going to disk).<br>
<br>
Murphy&#39;s a bitch. Today we upgraded a cluster to latest Hammer in<br>
preparation for Jewel/RHCS2. Turns out when we last hit this very<br>
problem we had only ephemerally set the new filestore merge/split<br>
values - oops. Here&#39;s what started happening when we upgraded and<br>
restarted a bunch of OSDs:<br>
<a href=3D"https://au-east.erc.monash.edu.au/swift/v1/public/grafana-ceph-x=
s_dir_lookup.png" rel=3D"noreferrer" target=3D"_blank">https://au-east.erc.=
monash.edu.au/swift/v1/public/grafana-ceph-xs_dir_lookup.png</a><br>
<br>
Seemed to cause lots of slow requests :-/. We corrected it about<br>
12:30, then still took a while to settle.<br>
<br>
--<br>
Cheers,<br>
~Blairo<br>
</blockquote></div>

--001a113e3a8c67552b0535ba2635--

--===============1853677841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1853677841==--
