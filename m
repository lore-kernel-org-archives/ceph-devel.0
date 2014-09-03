From: Gregory Meno <gmeno-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [ceph-calamari] RFC: A preliminary Chinese version
	of Calamari
Date: Wed, 3 Sep 2014 08:55:11 -0400
Message-ID: <CAOWd=nAzfZv0ZcCpbT-Qnu0vtgCRidJ_LnBfNZD_VtizcTYSag@mail.gmail.com>
References: <54004BBA.30506@ubuntukylin.com>
Reply-To: gmeno-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1668090126=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <54004BBA.30506-qfb7ZC4agRC9jIzG8Sm66w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Li Wang <liwang-qfb7ZC4agRC9jIzG8Sm66w@public.gmane.org>
Cc: "ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1668090126==
Content-Type: multipart/alternative; boundary=001a11c1312813f228050228bff7

--001a11c1312813f228050228bff7
Content-Type: text/plain; charset=UTF-8

Li Wang,

Thank you for doing this!

Would you please change this so that calamari will display the correct
locale?

As it exists your branch will not display an all english version.

To merge upstream I would expect this to work so that both en and zh_CN
versions could work.

I made a branch that moves strings.l20n to the correct locale
https://github.com/ceph/calamari-clients/tree/zh_CN_version

Please let me know if there is anything I can do to help.

best regards,
Gregory


On Fri, Aug 29, 2014 at 5:45 AM, Li Wang <liwang-qfb7ZC4agRC9jIzG8Sm66w@public.gmane.org> wrote:

> Hi,
>   We have set up a preliminary Chinese version of Calamari at
> https://github.com/xiaoxianxia/calamari-clients-cn, major jobs done
> are translating the English words on the web interface into Chinese,
> we did not change the localization infrastructure, any help
> in this direction are appreciated,  also any suggestions, tests
> and technical involvement are welcome, to make it ready to
> be merged to the upstream.
>
> Cheers,
> Li Wang
> _______________________________________________
> ceph-calamari mailing list
> ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-calamari-ceph.com
>

--001a11c1312813f228050228bff7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Li Wang,<div><br></div><div>Thank you for doing this!</div=
><div><br></div><div>Would you please change this so that calamari will dis=
play the correct locale?<br></div><div><br></div><div>As it exists your bra=
nch will not display an all english version.</div>
<div><br></div><div>To merge upstream I would expect this to work so that b=
oth en and zh_CN versions could work.<br></div><div><br></div><div>I made a=
 branch that moves strings.l20n to the correct locale <a href=3D"https://gi=
thub.com/ceph/calamari-clients/tree/zh_CN_version">https://github.com/ceph/=
calamari-clients/tree/zh_CN_version</a><br>
</div><div><br></div><div>Please let me know if there is anything I can do =
to help.</div><div><br></div><div>best regards,</div><div>Gregory</div></di=
v><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri, Aug=
 29, 2014 at 5:45 AM, Li Wang <span dir=3D"ltr">&lt;<a href=3D"mailto:liwan=
g@ubuntukylin.com" target=3D"_blank">liwang-qfb7ZC4agRC9jIzG8Sm66w@public.gmane.org</a>&gt;</span> =
wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
=C2=A0 We have set up a preliminary Chinese version of Calamari at<br>
<a href=3D"https://github.com/xiaoxianxia/calamari-clients-cn" target=3D"_b=
lank">https://github.com/<u></u>xiaoxianxia/calamari-clients-<u></u>cn</a>,=
 major jobs done<br>
are translating the English words on the web interface into Chinese,<br>
we did not change the localization infrastructure, any help<br>
in this direction are appreciated,=C2=A0 also any suggestions, tests<br>
and technical involvement are welcome, to make it ready to<br>
be merged to the upstream.<br>
<br>
Cheers,<br>
Li Wang<br>
______________________________<u></u>_________________<br>
ceph-calamari mailing list<br>
<a href=3D"mailto:ceph-calamari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" target=3D"_blank">ceph-cala=
mari-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-calamari-ceph.com" targe=
t=3D"_blank">http://lists.ceph.com/<u></u>listinfo.cgi/ceph-calamari-<u></u=
>ceph.com</a><br>
</blockquote></div><br></div>

--001a11c1312813f228050228bff7--

--===============1668090126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1668090126==--
