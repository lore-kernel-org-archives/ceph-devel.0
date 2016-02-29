From: Josef Johansson <josef86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: v0.94.6 Hammer released
Date: Mon, 29 Feb 2016 14:40:29 +0100
Message-ID: <5F4A1905-4728-4760-8D43-1F6C94B34031@gmail.com>
References: <alpine.DEB.2.11.1602231059590.7485@cpach.fuggernut.com>
	<CABZ+qq=ZqhaL9uwobM1NZ7+AszUMqirHATLJZyRcowD1iDRsww@mail.gmail.com>
	<CAC-Np1yGWf02kVkJzPDi5hWEcm_L01jG-qev1WhMpNvgpHw8NA@mail.gmail.com>
	<EA4E4293-B9AF-44EA-ACAB-55A8A322C317@franksiler.com>
	<CAEYCsVKeOwOWp0yRmb5KHduqwUQ-fVUaMcQCaszmGaN-WDp=Gw@mail.gmail.com>
	<FE41C953-5D62-41E0-A1C5-97891B7A7438@franksiler.com>
	<1456736629334.47610@croc.ru>
	<191489558.55229005.1456744289131.JavaMail.zimbra@redhat.com>
	<1456745435596.21796@croc.ru>
	<CABZ+qqkD_w4xM-qNdxC_WkZbGPf+w0gHh2cgYnPF2-_0go5-SA@mail.gmail.com>
	<FB2D860E-F299-4096-9D97-79B84F79C2DB@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: multipart/mixed; boundary="===============1509584983=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <FB2D860E-F299-4096-9D97-79B84F79C2DB-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Cc: Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Franklin M. Siler" <me-yJlFm309LvW+XT7JhA+gdA@public.gmane.org>, Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============1509584983==
Content-Type: multipart/alternative; boundary="Apple-Mail=_E1D04C0B-144B-41EA-B750-E01A72346238"


--Apple-Mail=_E1D04C0B-144B-41EA-B750-E01A72346238
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Maybe the reverse is possible, where we as a community lend out =
computing resources that the central build system could use.

> On 29 Feb 2016, at 14:38, Josef Johansson <josef86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>=20
> Hi,
>=20
> There is also https://github.com/jordansissel/fpm/wiki =
<https://github.com/jordansissel/fpm/wiki>
>=20
> I find it quite useful for building deb/rpm.
>=20
> What would be useful for the community per se would be if you made a =
Dockerfile for each type of combination, i.e. Ubuntu trusty / 10.0.3 and =
so forth.
>=20
> That way anyone could just docker run =
ceph/compile-ubuntu-trusty-10.0.3 and that would be it.
>=20
> I don=E2=80=99t think that would even be tough to do.
>=20
> I=E2=80=99m unsure how well you can test that it=E2=80=99s not =
tampered with, but I assume it=E2=80=99s possible to solve, or at least =
set up trusts between a contributor and the repo.=20
>=20
> Regards,
> Josef
>=20
>> On 29 Feb 2016, at 14:28, Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org =
<mailto:dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>> wrote:
>>=20
>> On Mon, Feb 29, 2016 at 12:30 PM, Odintsov Vladislav =
<VlOdintsov-b5CV0i+qpxk@public.gmane.org <mailto:VlOdintsov-b5CV0i+qpxk@public.gmane.org>> wrote:
>>> Can you please provide right way for building rpm packages?
>>=20
>> It's documented here:
>> =
http://docs.ceph.com/docs/master/install/build-ceph/#rpm-package-manager =
<http://docs.ceph.com/docs/master/install/build-ceph/#rpm-package-manager>=

>>=20
>> For 0.94.6 you need to change the .spec file to use .tar.gz (because
>> there was no .bz2 published for some reason). And then also grab
>> init-ceph.in-fedora.patch from here:
>> =
https://raw.githubusercontent.com/ceph/ceph/master/rpm/init-ceph.in-fedora=
.patch =
<https://raw.githubusercontent.com/ceph/ceph/master/rpm/init-ceph.in-fedor=
a.patch>
>>=20
>> BTW, I've put our build here:
>> http://linuxsoft.cern.ch/internal/repos/ceph6-stable/x86_64/os/ =
<http://linuxsoft.cern.ch/internal/repos/ceph6-stable/x86_64/os/>
>> These are unsigned, untested and come with no warranty, no guarantees
>> of any sort. And IMHO, no third party build would ever to give that
>> warm fuzzy trust-it-with-my-data feeling like a ceph.com =
<http://ceph.com/> build would
>> ;)
>>=20
>> Moving forward, it would be great if the required community effort
>> could be put to work to get ceph.com <http://ceph.com/> el6 (and =
other) builds. For el6
>> in particular there is also the option to help out the Centos Storage
>> SIG to produce builds. I don't have a good feeling which direction is
>> better ... maybe both.
>>=20
>> -- Dan
>> CERN IT Storage Group
>>=20
>>=20
>>> ________________________________
>>> Regards,
>>>=20
>>> Vladislav Odintsov
>>>=20
>>> ________________________________________
>>> From: Shinobu Kinjo <skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org <mailto:skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>>
>>> Sent: Monday, February 29, 2016 14:11
>>> To: Odintsov Vladislav
>>> Cc: Franklin M. Siler; Xiaoxi Chen; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org =
<mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; ceph-users; Sage Weil
>>> Subject: Re: [ceph-users] v0.94.6 Hammer released
>>>=20
>>> Can we make any kind of general procedure to make packages so that =
almost everyone in community build packages by themselves and reduce =
developers work load caused by too much requirement -;
>>>=20
>>> Cheers,
>>> Shinobu
>>>=20
>>> ----- Original Message -----
>>> From: "Odintsov Vladislav" <VlOdintsov-b5CV0i+qpxk@public.gmane.org =
<mailto:VlOdintsov-b5CV0i+qpxk@public.gmane.org>>
>>> To: "Franklin M. Siler" <me-yJlFm309LvW+XT7JhA+gdA@public.gmane.org =
<mailto:me-yJlFm309LvW+XT7JhA+gdA@public.gmane.org>>, "Xiaoxi Chen" <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org =
<mailto:superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>>> Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =
"ceph-users" <ceph-users-Qp0mS5GaXlQ@public.gmane.org <mailto:ceph-users-Qp0mS5GaXlQ@public.gmane.org>>, "Sage =
Weil" <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org <mailto:sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>>
>>> Sent: Monday, February 29, 2016 6:04:02 PM
>>> Subject: Re: [ceph-users] v0.94.6 Hammer released
>>>=20
>>> Hi all,
>>>=20
>>> should we build el6 packages ourself or, it's hoped that these =
packages would be built officially by community?
>>>=20
>>> ________________________________
>>> Regards,
>>>=20
>>> Vladislav Odintsov
>>>=20
>>> ________________________________________
>>> From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org =
<mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> =
<ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org =
<mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>> on behalf of Franklin M. =
Siler <me-yJlFm309LvW+XT7JhA+gdA@public.gmane.org <mailto:me-yJlFm309LvW+XT7JhA+gdA@public.gmane.org>>
>>> Sent: Friday, February 26, 2016 05:03
>>> To: Xiaoxi Chen
>>> Cc: Alfredo Deza; Dan van der Ster; Sage Weil; =
ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; =
ceph-users
>>> Subject: Re: [ceph-users] v0.94.6 Hammer released
>>>=20
>>> On Feb 25, 2016, at 1839, Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org =
<mailto:superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>>>=20
>>>> Will we build package for ubuntu 12.04 (Precise)?
>>>> Seems it also doesnt show in the repo
>>>=20
>>> The Ceph packages provided by Ubuntu are old.  However, the Ceph =
project publishes its own packages.
>>>=20
>>> http://download.ceph.com/debian-hammer/dists/precise/ =
<http://download.ceph.com/debian-hammer/dists/precise/>
>>>=20
>>> so repo lines for sources.list would be, I think:
>>>=20
>>> deb http://download.ceph.com/debian-hammer/ precise main
>>> deb-src http://download.ceph.com/debian-hammer/ precise main
>>>=20
>>>=20
>>> Cheers,
>>>=20
>>> Frank Siler
>>> Siler Industrial Analytics
>>> 314.799.9405--
>>> To unsubscribe from this list: send the line "unsubscribe =
ceph-devel" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com =
<http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>


--Apple-Mail=_E1D04C0B-144B-41EA-B750-E01A72346238
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Maybe the reverse is possible, where we as a community lend =
out computing resources that the central build system could use.<div =
class=3D""><br class=3D""></div><div class=3D""><div><blockquote =
type=3D"cite" class=3D""><div class=3D"">On 29 Feb 2016, at 14:38, Josef =
Johansson &lt;<a href=3D"mailto:josef86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" =
class=3D"">josef86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><meta =
http-equiv=3D"Content-Type" content=3D"text/html charset=3Dutf-8" =
class=3D""><div style=3D"word-wrap: break-word; -webkit-nbsp-mode: =
space; -webkit-line-break: after-white-space;" class=3D"">Hi,<div =
class=3D""><br class=3D""></div><div class=3D"">There is also&nbsp;<a =
href=3D"https://github.com/jordansissel/fpm/wiki" =
class=3D"">https://github.com/jordansissel/fpm/wiki</a></div><div =
class=3D""><br class=3D""></div><div class=3D"">I find it quite useful =
for building deb/rpm.</div><div class=3D""><br class=3D""></div><div =
class=3D"">What would be useful for the community per se would be if you =
made a Dockerfile for each type of combination, i.e. Ubuntu trusty / =
10.0.3 and so forth.</div><div class=3D""><br class=3D""></div><div =
class=3D"">That way anyone could just docker run =
ceph/compile-ubuntu-trusty-10.0.3 and that would be it.</div><div =
class=3D""><div class=3D""><br class=3D""></div><div class=3D"">I =
don=E2=80=99t think that would even be tough to do.</div></div><div =
class=3D""><br class=3D""></div><div class=3D"">I=E2=80=99m unsure how =
well you can test that it=E2=80=99s not tampered with, but I assume =
it=E2=80=99s possible to solve, or at least set up trusts between a =
contributor and the repo.&nbsp;</div><div class=3D""><br =
class=3D""></div><div class=3D"">Regards,</div><div =
class=3D"">Josef</div><div class=3D""><br class=3D""></div><div =
class=3D""><div class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">On 29 Feb 2016, at 14:28, Dan van der Ster &lt;<a =
href=3D"mailto:dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org" class=3D"">dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">On Mon, Feb 29, 2016 at 12:30 PM, Odintsov =
Vladislav &lt;</span><a href=3D"mailto:VlOdintsov-b5CV0i+qpxk@public.gmane.org" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D"">VlOdintsov-b5CV0i+qpxk@public.gmane.org</a><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">&gt; wrote:</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">Can =
you please provide right way for building rpm packages?<br =
class=3D""></blockquote><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">It's documented here:</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><a =
href=3D"http://docs.ceph.com/docs/master/install/build-ceph/#rpm-package-m=
anager" style=3D"font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;" =
class=3D"">http://docs.ceph.com/docs/master/install/build-ceph/#rpm-packag=
e-manager</a><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: =
none; display: inline !important;" class=3D"">For 0.94.6 you need to =
change the .spec file to use .tar.gz (because</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: =
none; display: inline !important;" class=3D"">there was no .bz2 =
published for some reason). And then also grab</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: =
none; display: inline !important;" class=3D"">init-ceph.in-fedora.patch =
from here:</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><a =
href=3D"https://raw.githubusercontent.com/ceph/ceph/master/rpm/init-ceph.i=
n-fedora.patch" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D"">https://raw.githubusercontent.com/ceph/ceph/master/rpm/init-cep=
h.in-fedora.patch</a><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: =
none; display: inline !important;" class=3D"">BTW, I've put our build =
here:</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><a =
href=3D"http://linuxsoft.cern.ch/internal/repos/ceph6-stable/x86_64/os/" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" =
class=3D"">http://linuxsoft.cern.ch/internal/repos/ceph6-stable/x86_64/os/=
</a><br style=3D"font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">These are unsigned, untested and come with no =
warranty, no guarantees</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">of any sort. And IMHO, no third party build =
would ever to give that</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">warm fuzzy trust-it-with-my-data feeling like =
a<span class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"http://ceph.com/" style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D"">ceph.com</a><span style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>build would</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: =
none; display: inline !important;" class=3D"">;)</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">Moving forward, it would be great if the =
required community effort</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">could be put to work to get<span =
class=3D"Apple-converted-space">&nbsp;</span></span><a =
href=3D"http://ceph.com/" style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D"">ceph.com</a><span style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D""><span =
class=3D"Apple-converted-space">&nbsp;</span>el6 (and other) builds. For =
el6</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">in particular there is also the option to help =
out the Centos Storage</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">SIG to produce builds. I don't have a good =
feeling which direction is</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">better ... maybe both.</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">-- Dan</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">CERN IT Storage Group</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D"">________________________________<br class=3D"">Regards,<br =
class=3D""><br class=3D"">Vladislav Odintsov<br class=3D""><br =
class=3D"">________________________________________<br class=3D"">From: =
Shinobu Kinjo &lt;<a href=3D"mailto:skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" =
class=3D"">skinjo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br class=3D"">Sent: Monday, =
February 29, 2016 14:11<br class=3D"">To: Odintsov Vladislav<br =
class=3D"">Cc: Franklin M. Siler; Xiaoxi Chen; <a =
href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" =
class=3D"">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>; ceph-users; Sage Weil<br =
class=3D"">Subject: Re: [ceph-users] v0.94.6 Hammer released<br =
class=3D""><br class=3D"">Can we make any kind of general procedure to =
make packages so that almost everyone in community build packages by =
themselves and reduce developers work load caused by too much =
requirement -;<br class=3D""><br class=3D"">Cheers,<br =
class=3D"">Shinobu<br class=3D""><br class=3D"">----- Original Message =
-----<br class=3D"">From: "Odintsov Vladislav" &lt;<a =
href=3D"mailto:VlOdintsov-b5CV0i+qpxk@public.gmane.org" =
class=3D"">VlOdintsov-b5CV0i+qpxk@public.gmane.org</a>&gt;<br class=3D"">To: "Franklin M. =
Siler" &lt;<a href=3D"mailto:me-yJlFm309LvW+XT7JhA+gdA@public.gmane.org" =
class=3D"">me-yJlFm309LvW+XT7JhA+gdA@public.gmane.org</a>&gt;, "Xiaoxi Chen" &lt;<a =
href=3D"mailto:superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" =
class=3D"">superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br class=3D"">Cc: <a =
href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" =
class=3D"">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>, "ceph-users" &lt;<a =
href=3D"mailto:ceph-users-Qp0mS5GaXlQ@public.gmane.org" =
class=3D"">ceph-users-Qp0mS5GaXlQ@public.gmane.org</a>&gt;, "Sage Weil" &lt;<a =
href=3D"mailto:sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" class=3D"">sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br =
class=3D"">Sent: Monday, February 29, 2016 6:04:02 PM<br =
class=3D"">Subject: Re: [ceph-users] v0.94.6 Hammer released<br =
class=3D""><br class=3D"">Hi all,<br class=3D""><br class=3D"">should we =
build el6 packages ourself or, it's hoped that these packages would be =
built officially by community?<br class=3D""><br =
class=3D"">________________________________<br class=3D"">Regards,<br =
class=3D""><br class=3D"">Vladislav Odintsov<br class=3D""><br =
class=3D"">________________________________________<br class=3D"">From: =
<a href=3D"mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" =
class=3D"">ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> &lt;<a =
href=3D"mailto:ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" =
class=3D"">ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>&gt; on behalf of =
Franklin M. Siler &lt;<a href=3D"mailto:me-yJlFm309LvW+XT7JhA+gdA@public.gmane.org" =
class=3D"">me-yJlFm309LvW+XT7JhA+gdA@public.gmane.org</a>&gt;<br class=3D"">Sent: Friday, =
February 26, 2016 05:03<br class=3D"">To: Xiaoxi Chen<br class=3D"">Cc: =
Alfredo Deza; Dan van der Ster; Sage Weil; <a =
href=3D"mailto:ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" =
class=3D"">ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>; ceph-users<br =
class=3D"">Subject: Re: [ceph-users] v0.94.6 Hammer released<br =
class=3D""><br class=3D"">On Feb 25, 2016, at 1839, Xiaoxi Chen &lt;<a =
href=3D"mailto:superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" =
class=3D"">superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">Will we build package =
for ubuntu 12.04 (Precise)?<br class=3D"">Seems it also doesnt show in =
the repo<br class=3D""></blockquote><br class=3D"">The Ceph packages =
provided by Ubuntu are old. &nbsp;However, the Ceph project publishes =
its own packages.<br class=3D""><br class=3D""><a =
href=3D"http://download.ceph.com/debian-hammer/dists/precise/" =
class=3D"">http://download.ceph.com/debian-hammer/dists/precise/</a><br =
class=3D""><br class=3D"">so repo lines for sources.list would be, I =
think:<br class=3D""><br class=3D"">deb <a =
href=3D"http://download.ceph.com/debian-hammer/" =
class=3D"">http://download.ceph.com/debian-hammer/</a> precise main<br =
class=3D"">deb-src <a href=3D"http://download.ceph.com/debian-hammer/" =
class=3D"">http://download.ceph.com/debian-hammer/</a> precise main<br =
class=3D""><br class=3D""><br class=3D"">Cheers,<br class=3D""><br =
class=3D"">Frank Siler<br class=3D"">Siler Industrial Analytics<br =
class=3D"">314.799.9405--<br class=3D"">To unsubscribe from this list: =
send the line "unsubscribe ceph-devel" in<br class=3D"">the body of a =
message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" =
class=3D"">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br class=3D"">More majordomo =
info at &nbsp;<a href=3D"http://vger.kernel.org/majordomo-info.html" =
class=3D"">http://vger.kernel.org/majordomo-info.html</a><br =
class=3D"">_______________________________________________<br =
class=3D"">ceph-users mailing list<br class=3D""><a =
href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" =
class=3D"">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br =
class=3D"">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<br =
class=3D"">_______________________________________________<br =
class=3D"">ceph-users mailing list<br =
class=3D"">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org<br =
class=3D"">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<br =
class=3D""></blockquote><span style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" =
class=3D"">_______________________________________________</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: =
none; display: inline !important;" class=3D"">ceph-users mailing =
list</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><a =
href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D"">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><a =
href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" =
class=3D"">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a></div=
></blockquote></div><br =
class=3D""></div></div></div></blockquote></div><br =
class=3D""></div></body></html>=

--Apple-Mail=_E1D04C0B-144B-41EA-B750-E01A72346238--

--===============1509584983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1509584983==--
