From: Jingyuan Luke <jyluke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph mds laggy and failed assert in function
	replay mds/journal.cc
Date: Sat, 26 Apr 2014 09:56:02 +0800
Message-ID: <CAEDpR-sMb4A3f60DDFewb9Bfu3XbeDP1gcSkSc6iJwCZLOUBxQ@mail.gmail.com>
References: <20DBB415DF55354C8FC7AF12F4AE7700132C91@MBX02-TPM.mimos.local>
	<CAPYLRzj2WdT4dGzh+LJ7fNwT4kiSg3ZHoM0ZpdyWG_uat6Qz3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0043233479=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAPYLRzj2WdT4dGzh+LJ7fNwT4kiSg3ZHoM0ZpdyWG_uat6Qz3w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0043233479==
Content-Type: multipart/alternative; boundary=089e0115ffc66fbbc404f7e86259

--089e0115ffc66fbbc404f7e86259
Content-Type: text/plain; charset=ISO-8859-1

Hi Greg,

Actually our cluster is pretty empty, but we suspect we had a temporary
network disconnection to one of our OSD, not sure if this caused the
problem.

Anyway we don't mind try the method you mentioned, how can we do that?

Regards,
Luke

On Saturday, April 26, 2014, Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> Hmm, it looks like your on-disk SessionMap is horrendously out of
> date. Did your cluster get full at some point?
>
> In any case, we're working on tools to repair this now but they aren't
> ready for use yet. Probably the only thing you could do is create an
> empty sessionmap with a higher version than the ones the journal
> refers to, but that might have other fallout effects...
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
>
> On Fri, Apr 25, 2014 at 2:57 AM, Mohd Bazli Ab Karim
> <bazli.abkarim-YhiXQ1Q1pWA@public.gmane.org> wrote:
> > More logs. I ran ceph-mds  with debug-mds=20.
> >
> > -2> 2014-04-25 17:47:54.839672 7f0d6f3f0700 10 mds.0.journal
> EMetaBlob.replay inotable tablev 4316124 <= table 4317932
> > -1> 2014-04-25 17:47:54.839674 7f0d6f3f0700 10 mds.0.journal
> EMetaBlob.replay sessionmap v8632368 -(1|2) == table 7239603 prealloc
> [1000041df86~1] used 1000041db9e
> >   0> 2014-04-25 17:47:54.840733 7f0d6f3f0700 -1 mds/journal.cc: In
> function 'void EMetaBlob::replay(MDS*, LogSegment*, MDSlaveUpdate*)' thread
> 7f0d6f3f0700 time 2014-04-25 17:47:54.839688 mds/journal.cc: 1303: FAILED
> assert(session)
> >
> > Please look at the attachment for more details.
> >
> > Regards,
> > Bazli
> >
> > From: Mohd Bazli Ab Karim
> > Sent: Friday, April 25, 2014 12:26 PM
> > To: 'ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <javascript:;>';
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <javascript:;>
> > Subject: Ceph mds laggy and failed assert in function replay
> mds/journal.cc
> >
> > Dear Ceph-devel, ceph-users,
> >
> > I am currently facing issue with my ceph mds server. Ceph-mds daemon
> does not want to bring up back.
> > Tried running that manually with ceph-mds -i mon01 -d but it shows that
> it stucks at failed assert(session) line 1303 in mds/journal.cc and aborted.
> >
> > Can someone shed some light in this issue.
> > ceph version 0.72.2 (a913ded2ff138aefb8cb84d347d72164099cfd60)
> >
> > Let me know if I need to send log with debug enabled.
> >
> > Regards,
> > Bazli
> >
> > ________________________________
> > DISCLAIMER:
> >
> >
> > This e-mail (including any attachments) is for the addressee(s) only and
> may be confidential, especially as regards personal data. If you are not
> the intended recipient, please note that any dealing, review, distribution,
> printing, copying or use of this e-mail is strictly prohibited. If you have
> received this email in error, please notify the sender immediately and
> delete the original message (including any attachments).
> >
> >
> > MIMOS Berhad is a research and development institution under the purview
> of the Malaysian Ministry of Science, Technology and Innovation. Opinions,
> conclusions and other information in this e-mail that do not relate to the
> official business of MIMOS Berhad and/or its subsidiaries shall be
> understood as neither given nor endorsed by MIMOS Berhad and/or its
> subsidiaries and neither MIMOS Berhad nor its subsidiaries accepts
> responsibility for the same. All liability arising from or in connection
> with computer viruses and/or corrupted e-mails is excluded to the fullest
> extent permitted by law.
> >
> >
> > ------------------------------------------------------------------
> > -
> > -
> > DISCLAIMER:
> >
> > This e-mail (including any attachments) is for the addressee(s)
> > only and may contain confidential information. If you are not the
> > intended recipient, please note that any dealing, review,
> > distribution, printing, copying or use of this e-mail is strictly
> > prohibited. If you have received this email in error, please notify
> > the sender  immediately and delete the original message.
> > MIMOS Berhad is a research and development institution under
> > the purview of the Malaysian Ministry of Science, Technology and
> > Innovation. Opinions, conclusions and other information in this e-
> > mail that do not relate to the official business of MIMOS Berhad
> > and/or its subsidiaries shall be understood as neither given nor
> > endorsed by MIMOS Berhad and/or its subsidiaries and neither
> > MIMOS Berhad nor its subsidiaries accepts responsibility for the
> > same. All liability arising from or in connection with computer
> > viruses and/or corrupted e-mails is excluded to the fullest extent
> > permitted by law.
> >
> >
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <javascript:;>
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <javascript:;>
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--089e0115ffc66fbbc404f7e86259
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Greg,<div><br></div><div>Actually our cluster is pretty empty, but we su=
spect we had a temporary network disconnection to one of our OSD, not sure =
if this caused the problem.=A0</div><div><br></div><div>Anyway we don&#39;t=
 mind try the method you mentioned, how can we do that?</div>
<div><br></div><div>Regards,</div><div>Luke<br><br>On Saturday, April 26, 2=
014, Gregory Farnum &lt;<a href=3D"mailto:greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">greg-4GqslpFJ+cyIwRZHo2/mJg@public.gmane.org=
m</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Hmm, it looks like your on-disk SessionMap is horrendously out of<br>
date. Did your cluster get full at some point?<br>
<br>
In any case, we&#39;re working on tools to repair this now but they aren&#3=
9;t<br>
ready for use yet. Probably the only thing you could do is create an<br>
empty sessionmap with a higher version than the ones the journal<br>
refers to, but that might have other fallout effects...<br>
-Greg<br>
Software Engineer #42 @ <a href=3D"http://inktank.com" target=3D"_blank">ht=
tp://inktank.com</a> | <a href=3D"http://ceph.com" target=3D"_blank">http:/=
/ceph.com</a><br>
<br>
<br>
On Fri, Apr 25, 2014 at 2:57 AM, Mohd Bazli Ab Karim<br>
&lt;bazli.abkarim-YhiXQ1Q1pWA@public.gmane.org&gt; wrote:<br>
&gt; More logs. I ran ceph-mds =A0with debug-mds=3D20.<br>
&gt;<br>
&gt; -2&gt; 2014-04-25 17:47:54.839672 7f0d6f3f0700 10 mds.0.journal EMetaB=
lob.replay inotable tablev 4316124 &lt;=3D table 4317932<br>
&gt; -1&gt; 2014-04-25 17:47:54.839674 7f0d6f3f0700 10 mds.0.journal EMetaB=
lob.replay sessionmap v8632368 -(1|2) =3D=3D table 7239603 prealloc [100004=
1df86~1] used 1000041db9e<br>
&gt; =A0 0&gt; 2014-04-25 17:47:54.840733 7f0d6f3f0700 -1 mds/journal.cc: I=
n function &#39;void EMetaBlob::replay(MDS*, LogSegment*, MDSlaveUpdate*)&#=
39; thread 7f0d6f3f0700 time 2014-04-25 17:47:54.839688 mds/journal.cc: 130=
3: FAILED assert(session)<br>

&gt;<br>
&gt; Please look at the attachment for more details.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Bazli<br>
&gt;<br>
&gt; From: Mohd Bazli Ab Karim<br>
&gt; Sent: Friday, April 25, 2014 12:26 PM<br>
&gt; To: &#39;<a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;,=
 &#39;ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&#39;)">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&#39;=
; <a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;ceph-u=
sers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&#39;)">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>

&gt; Subject: Ceph mds laggy and failed assert in function replay mds/journ=
al.cc<br>
&gt;<br>
&gt; Dear Ceph-devel, ceph-users,<br>
&gt;<br>
&gt; I am currently facing issue with my ceph mds server. Ceph-mds daemon d=
oes not want to bring up back.<br>
&gt; Tried running that manually with ceph-mds -i mon01 -d but it shows tha=
t it stucks at failed assert(session) line 1303 in mds/journal.cc and abort=
ed.<br>
&gt;<br>
&gt; Can someone shed some light in this issue.<br>
&gt; ceph version 0.72.2 (a913ded2ff138aefb8cb84d347d72164099cfd60)<br>
&gt;<br>
&gt; Let me know if I need to send log with debug enabled.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Bazli<br>
&gt;<br>
&gt; ________________________________<br>
&gt; DISCLAIMER:<br>
&gt;<br>
&gt;<br>
&gt; This e-mail (including any attachments) is for the addressee(s) only a=
nd may be confidential, especially as regards personal data. If you are not=
 the intended recipient, please note that any dealing, review, distribution=
, printing, copying or use of this e-mail is strictly prohibited. If you ha=
ve received this email in error, please notify the sender immediately and d=
elete the original message (including any attachments).<br>

&gt;<br>
&gt;<br>
&gt; MIMOS Berhad is a research and development institution under the purvi=
ew of the Malaysian Ministry of Science, Technology and Innovation. Opinion=
s, conclusions and other information in this e-mail that do not relate to t=
he official business of MIMOS Berhad and/or its subsidiaries shall be under=
stood as neither given nor endorsed by MIMOS Berhad and/or its subsidiaries=
 and neither MIMOS Berhad nor its subsidiaries accepts responsibility for t=
he same. All liability arising from or in connection with computer viruses =
and/or corrupted e-mails is excluded to the fullest extent permitted by law=
.<br>

&gt;<br>
&gt;<br>
&gt; ------------------------------------------------------------------<br>
&gt; -<br>
&gt; -<br>
&gt; DISCLAIMER:<br>
&gt;<br>
&gt; This e-mail (including any attachments) is for the addressee(s)<br>
&gt; only and may contain confidential information. If you are not the<br>
&gt; intended recipient, please note that any dealing, review,<br>
&gt; distribution, printing, copying or use of this e-mail is strictly<br>
&gt; prohibited. If you have received this email in error, please notify<br=
>
&gt; the sender =A0immediately and delete the original message.<br>
&gt; MIMOS Berhad is a research and development institution under<br>
&gt; the purview of the Malaysian Ministry of Science, Technology and<br>
&gt; Innovation. Opinions, conclusions and other information in this e-<br>
&gt; mail that do not relate to the official business of MIMOS Berhad<br>
&gt; and/or its subsidiaries shall be understood as neither given nor<br>
&gt; endorsed by MIMOS Berhad and/or its subsidiaries and neither<br>
&gt; MIMOS Berhad nor its subsidiaries accepts responsibility for the<br>
&gt; same. All liability arising from or in connection with computer<br>
&gt; viruses and/or corrupted e-mails is excluded to the fullest extent<br>
&gt; permitted by law.<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; ceph-users mailing list<br>
&gt; <a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;cep=
h-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org&#39;)">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
&gt; <a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" tar=
get=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><b=
r>
&gt;<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"javascript:;" onclick=3D"_e(event, &#39=
;cvml&#39;, &#39;majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&#39;)">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=
</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</blockquote></div>

--089e0115ffc66fbbc404f7e86259--

--===============0043233479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0043233479==--
