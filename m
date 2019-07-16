From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: pools limit
Date: Tue, 16 Jul 2019 22:23:38 +0530
Message-ID: <CANA9Uk4Yt9oS7D31oR++f48ph8_KLAXH5ebeSeJAXUvyuF_NRQ@mail.gmail.com>
References: <CANA9Uk6ZyYY1HuFXEjvs4aT3zaf7YvDdCH20Rhgb_5U89em0MQ@mail.gmail.com>
 <CAD9yTbHdKtre8ZjnXTxV_=mE513djznyFP-dgiG+9MpQZxx_Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3429114846195070088=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAD9yTbHdKtre8ZjnXTxV_=mE513djznyFP-dgiG+9MpQZxx_Pg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Paul Emmerich <paul.emmerich-iZXOWb+A65A@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============3429114846195070088==
Content-Type: multipart/alternative; boundary="0000000000008cffa6058dcf380d"

--0000000000008cffa6058dcf380d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your reply..
Here, new pool creations and pg auto scale may cause rebalance..which
impact the ceph cluster performance..

Please share name space detail like how to use etc



On Tue, 16 Jul, 2019, 9:30 PM Paul Emmerich, <paul.emmerich-iZXOWb+A65A@public.gmane.org> wrote=
:

> 100+ pools work fine if you can get the PG count right (auto-scaler helps=
,
> there are some options that you'll need to tune for small-ish pools).
>
> But it's not a "nice" setup. Have you considered using namespaces instead=
?
>
>
> Paul
>
> --
> Paul Emmerich
>
> Looking for help with your Ceph cluster? Contact us at https://croit.io
>
> croit GmbH
> Freseniusstr. 31h
> 81247 M=C3=BCnchen
> www.croit.io
> Tel: +49 89 1896585 90
>
>
> On Tue, Jul 16, 2019 at 4:17 PM M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
>
> wrote:
>
>> Hello - I have created 10 nodes ceph cluster with 14.x version. Can you
>> please confirm below:
>>
>> Q1 - Can I create 100+ pool (or more) on the cluster? (the reason is -
>> creating a pool per project). Any limitation on pool creation?
>>
>> Q2 - In the above pool - I use 128 PG-NUM - to start with and enable
>> autoscale for PG_NUM, so that based on the data in the pool, PG_NUM will
>> increase by ceph itself.
>>
>> Let me know if any limitations for the above and any fore see issue?
>>
>> Thanks
>> Swami
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>

--0000000000008cffa6058dcf380d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks for=C2=A0your reply..<div dir=3D"auto">Here, new p=
ool creations and pg auto scale may cause rebalance..which impact the ceph =
cluster performance..</div><div dir=3D"auto"><br></div><div dir=3D"auto">Pl=
ease share name space detail like how to use etc</div><div dir=3D"auto"><br=
></div><div dir=3D"auto"><br></div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Tue, 16 Jul, 2019, 9:30 PM Paul Emmer=
ich, &lt;<a href=3D"mailto:paul.emmerich-iZXOWb+A65A@public.gmane.org">paul.emmerich-iZXOWb+A65A@public.gmane.org</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div=
>100+ pools work fine if you can get the PG count right (auto-scaler helps,=
 there are some options that you&#39;ll need to tune for small-ish pools).<=
/div><div><br></div><div><span class=3D"m_4867825757539453480gmail-contract=
-type"> <span class=3D"m_4867825757539453480gmail-contract-type"> <span cla=
ss=3D"m_4867825757539453480gmail-contract-type"> </span></span></span></div=
><div>But it&#39;s not a &quot;nice&quot; setup. Have you considered using =
namespaces instead?<br></div><div><br></div><div><br></div><div>Paul</div><=
div><br></div><div><div><div><div><div><div><div dir=3D"ltr" class=3D"m_486=
7825757539453480gmail_signature" data-smartmail=3D"gmail_signature">-- <br>=
Paul Emmerich<br><br>Looking for help with your Ceph cluster? Contact us at=
 <a href=3D"https://croit.io" target=3D"_blank" rel=3D"noreferrer">https://=
croit.io</a><br><br>croit GmbH<br>Freseniusstr. 31h<br>81247 M=C3=BCnchen<b=
r><a href=3D"http://www.croit.io" target=3D"_blank" rel=3D"noreferrer">www.=
croit.io</a><br>Tel: +49 89 1896585 90</div></div><br></div></div></div></d=
iv></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gma=
il_attr">On Tue, Jul 16, 2019 at 4:17 PM M Ranga Swami Reddy &lt;<a href=3D=
"mailto:swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">swamired=
dy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr">Hello - I have created 10 nodes ceph cluster w=
ith 14.x version. Can you please confirm below:<div><br></div><div>Q1 - Can=
 I create 100+ pool (or more) on the cluster? (the reason is - creating a p=
ool per project). Any limitation on pool creation?</div><div><br></div><div=
>Q2 - In the above pool - I use 128 PG-NUM - to start with and enable autos=
cale for PG_NUM, so that based on the data in the pool, PG_NUM will increas=
e by ceph itself.</div><div><br></div><div>Let me know if any limitations f=
or the above and any fore see issue?</div><div><br></div><div>Thanks</div><=
div>Swami</div></div>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank" rel=3D"noref=
errer">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">http://lists.ceph.com/listinfo.cgi/=
ceph-users-ceph.com</a><br>
</blockquote></div>
</blockquote></div>

--0000000000008cffa6058dcf380d--

--===============3429114846195070088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============3429114846195070088==--
