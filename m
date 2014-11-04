From: Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: cephfs survey results
Date: Tue, 4 Nov 2014 17:32:07 +0100
Message-ID: <CA+z5DszTdW431==Dkcyi3ERiO_yH+vqriqcetn_eYOJySAsH2Q@mail.gmail.com>
References: <alpine.DEB.2.00.1411030649070.15135@cobra.newdream.net>
	<CA+z5DszyU+vDYWnLmvecZ9P6U=9uWOB28Eg7E7=vLtuUQz8Q4w@mail.gmail.com>
	<20141104163357.400f83d1@ghroth.non.3dart.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0865370599=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20141104163357.400f83d1-8+6u88+ljCDmz4jMrfixpVaTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mariusz Gronczewski <mariusz.gronczewski-EWQ+Go7UwTxWk0Htik3J/w@public.gmane.org>
Cc: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0865370599==
Content-Type: multipart/alternative; boundary=001a113493921a362605070b0147

--001a113493921a362605070b0147
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

(Sorry for top posting - on phone)

Related to some extent. Multimds will help when your small file issue is
metadata bound, but I was actually thinking of data path random io latency.
So begs the question as to what the survey meant by it...?
On 04/11/2014 4:34 pm, "Mariusz Gronczewski" <
mariusz.gronczewski-EWQ+Go7UwTxWk0Htik3J/w@public.gmane.org> wrote:

> On Tue, 4 Nov 2014 10:36:07 +1100, Blair Bethwaite
> <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> >
> > TBH I'm a bit surprised by a couple of these and hope maybe you guys
> > will apply a certain amount of filtering on this...
> >
> > fsck and quotas were there for me, but multimds and snapshots are what
> > I'd consider "icing" features - they're nice to have but not on the
> > critical path to using cephfs instead of e.g. nfs in a production
> > setting. I'd have thought stuff like small file performance and
> > gateway support was much more relevant to uptake and
> > positive/pain-free UX. Interested to hear others rationale here.
> >
>
> Those are related; if small file performance will be enough for one
> MDS to handle high load with a lot of small files (typical case of
> webserver), having multiple acive MDS will be less of a priority;
>
> And if someone currently have OSD on bunch of relatively weak nodes,
> again, having active-active setup with MDS will be more interesting to
> him than someone that can just buy new fast machine for it.
>
>
> --
> Mariusz Gronczewski, Administrator
>
> Efigence S. A.
> ul. Wo=C5=82oska 9a, 02-583 Warszawa
> T: [+48] 22 380 13 13
> F: [+48] 22 380 13 14
> E: mariusz.gronczewski-EWQ+Go7UwTxWk0Htik3J/w@public.gmane.org
> <mailto:mariusz.gronczewski-EWQ+Go7UwTxWk0Htik3J/w@public.gmane.org>
>

--001a113493921a362605070b0147
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">(Sorry for top posting - on phone)</p>
<p dir=3D"ltr">Related to some extent. Multimds will help when your small f=
ile issue is metadata bound, but I was actually thinking of data path rando=
m io latency. So begs the question as to what the survey meant by it...?</p=
>
<div class=3D"gmail_quote">On 04/11/2014 4:34 pm, &quot;Mariusz Gronczewski=
&quot; &lt;<a href=3D"mailto:mariusz.gronczewski-EWQ+Go7UwTxWk0Htik3J/w@public.gmane.org">mariusz.gron=
czewski-EWQ+Go7UwTxWk0Htik3J/w@public.gmane.org</a>&gt; wrote:<br type=3D"attribution"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">On Tue, 4 Nov 2014 10:36:07 +1100, Blair Bethwaite<br>
&lt;<a href=3D"mailto:blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<=
/a>&gt; wrote:<br>
<br>
&gt;<br>
&gt; TBH I&#39;m a bit surprised by a couple of these and hope maybe you gu=
ys<br>
&gt; will apply a certain amount of filtering on this...<br>
&gt;<br>
&gt; fsck and quotas were there for me, but multimds and snapshots are what=
<br>
&gt; I&#39;d consider &quot;icing&quot; features - they&#39;re nice to have=
 but not on the<br>
&gt; critical path to using cephfs instead of e.g. nfs in a production<br>
&gt; setting. I&#39;d have thought stuff like small file performance and<br=
>
&gt; gateway support was much more relevant to uptake and<br>
&gt; positive/pain-free UX. Interested to hear others rationale here.<br>
&gt;<br>
<br>
Those are related; if small file performance will be enough for one<br>
MDS to handle high load with a lot of small files (typical case of<br>
webserver), having multiple acive MDS will be less of a priority;<br>
<br>
And if someone currently have OSD on bunch of relatively weak nodes,<br>
again, having active-active setup with MDS will be more interesting to<br>
him than someone that can just buy new fast machine for it.<br>
<br>
<br>
--<br>
Mariusz Gronczewski, Administrator<br>
<br>
Efigence S. A.<br>
ul. Wo=C5=82oska 9a, 02-583 Warszawa<br>
T: <a href=3D"tel:%5B%2B48%5D%2022%20380%2013%2013" value=3D"+48223801313">=
[+48] 22 380 13 13</a><br>
F: <a href=3D"tel:%5B%2B48%5D%2022%20380%2013%2014" value=3D"+48223801314">=
[+48] 22 380 13 14</a><br>
E: <a href=3D"mailto:mariusz.gronczewski-EWQ+Go7UwTxWk0Htik3J/w@public.gmane.org">mariusz.gronczewski@=
efigence.com</a><br>
&lt;mailto:<a href=3D"mailto:mariusz.gronczewski-EWQ+Go7UwTxWk0Htik3J/w@public.gmane.org">mariusz.gron=
czewski-EWQ+Go7UwTxWk0Htik3J/w@public.gmane.org</a>&gt;<br>
</blockquote></div>

--001a113493921a362605070b0147--

--===============0865370599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0865370599==--
