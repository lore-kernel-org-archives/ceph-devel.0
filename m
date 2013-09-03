From: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph s3 allowed characters
Date: Tue, 3 Sep 2013 12:51:18 +0200
Message-ID: <CAMNMNTzzwpV4coRP-GkqXqxrNM35ieQdrDXUqxJuoB4qcyE+FA@mail.gmail.com>
References: <CAMNMNTxn3DCbVAnvY1K7PE7Z1oWy-4nM_XKT92+xYEBxKzd=Yg@mail.gmail.com>
	<CANtztVysF7AbZiMimU1zhyBPu35+xQhSvUU+PNRDb42ro2uhng@mail.gmail.com>
	<CAMNMNTyUucZ2ZZu_KwfX2mz77Zx45Lf1j9xRYRNDJWdgF1LkPw@mail.gmail.com>
	<CABBk=J8Jvkchj6JoY560u-mew2qLmBWsLwdnG3-p6s+Gu7fnfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0476135022=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABBk=J8Jvkchj6JoY560u-mew2qLmBWsLwdnG3-p6s+Gu7fnfg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============0476135022==
Content-Type: multipart/alternative; boundary=047d7b5d8d5ff4ab3104e578774f

--047d7b5d8d5ff4ab3104e578774f
Content-Type: text/plain; charset=ISO-8859-1

Thanks for your answer.

Regards
Dominik
On Aug 30, 2013 4:59 PM, "Yehuda Sadeh" <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> On Fri, Aug 30, 2013 at 7:44 AM, Dominik Mostowiec
> <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > (echo -n 'GET /dysk/files/test.test%
> 40op.pl/DOMIWENT%202013/Damian%20DW/dw/Specyfikacja%20istotnych%20warunk%F3w%20zam%F3wienia.doc
> > HTTP/1.0'; printf "\r\n\r\n") | nc localhost 88
> > HTTP/1.1 400 Bad Request
> > Date: Fri, 30 Aug 2013 14:10:07 GMT
> > Server: Apache/2.2.22 (Ubuntu)
> > Accept-Ranges: bytes
> > Content-Length: 83
> > Connection: close
> > Content-Type: application/xml
> >
> > <?xml version="1.0"
> > encoding="UTF-8"?><Error><Code>InvalidObjectName</Code></Error>
> >
>
>
> The object name needs to be utf8 encoded.
>
> Yehuda
>

--047d7b5d8d5ff4ab3104e578774f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Thanks for your answer.</p>
<p dir=3D"ltr">Regards<br>
Dominik</p>
<div class=3D"gmail_quote">On Aug 30, 2013 4:59 PM, &quot;Yehuda Sadeh&quot=
; &lt;<a href=3D"mailto:yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org">yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org</a>&gt; wrot=
e:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
On Fri, Aug 30, 2013 at 7:44 AM, Dominik Mostowiec<br>
&lt;<a href=3D"mailto:dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">dominikmostowiec-Re5JQEeQqe8@public.gmane.org=
m</a>&gt; wrote:<br>
&gt; (echo -n &#39;GET /dysk/files/test.test%<a href=3D"http://40op.pl/DOMI=
WENT%202013/Damian%20DW/dw/Specyfikacja%20istotnych%20warunk%F3w%20zam%F3wi=
enia.doc" target=3D"_blank">40op.pl/DOMIWENT%202013/Damian%20DW/dw/Specyfik=
acja%20istotnych%20warunk%F3w%20zam%F3wienia.doc</a><br>

&gt; HTTP/1.0&#39;; printf &quot;\r\n\r\n&quot;) | nc localhost 88<br>
&gt; HTTP/1.1 400 Bad Request<br>
&gt; Date: Fri, 30 Aug 2013 14:10:07 GMT<br>
&gt; Server: Apache/2.2.22 (Ubuntu)<br>
&gt; Accept-Ranges: bytes<br>
&gt; Content-Length: 83<br>
&gt; Connection: close<br>
&gt; Content-Type: application/xml<br>
&gt;<br>
&gt; &lt;?xml version=3D&quot;1.0&quot;<br>
&gt; encoding=3D&quot;UTF-8&quot;?&gt;&lt;Error&gt;&lt;Code&gt;InvalidObjec=
tName&lt;/Code&gt;&lt;/Error&gt;<br>
&gt;<br>
<br>
<br>
The object name needs to be utf8 encoded.<br>
<br>
Yehuda<br>
</blockquote></div>

--047d7b5d8d5ff4ab3104e578774f--

--===============0476135022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0476135022==--
