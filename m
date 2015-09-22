From: Songbo Wang <songbo1227-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Important security noticed regarding release
	signing key
Date: Tue, 22 Sep 2015 16:38:49 +0800
Message-ID: <CAHRQ3VU1RFQL6AKh_CtOOeqg87wX7W5oa3n_3d8Ki9WFW=w5tw@mail.gmail.com>
References: <alpine.DEB.2.00.1509170925140.31198@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1433850428=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1509170925140.31198-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1433850428==
Content-Type: multipart/alternative; boundary=047d7bdc11be56ef84052051ed49

--047d7bdc11be56ef84052051ed49
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi, all,
        Since the last week=E2=80=98s attack, =E2=80=9Cceph.com/packages/ce=
ph-extras=E2=80=9D can
be opened never, but where can I get the releases of ceph-extra now?

Thanks and Regards,
WangSongbo

2015-09-18 0:29 GMT+08:00 Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Last week, Red Hat investigated an intrusion on the sites of both the Cep=
h
> community project (ceph.com) and Inktank (download.inktank.com), which
> were hosted on a computer system outside of Red Hat infrastructure.
>
> Ceph.com provided Ceph community versions downloads signed with a Ceph
> signing key (id 7EBFDD5D17ED316D). Download.inktank.comprovided releases
> of the Red Hat Ceph product for Ubuntu and CentOS operating systems signe=
d
> with an Inktank signing key (id 5438C7019DCEEEAD). While the investigatio=
n
> into the intrusion is ongoing, our initial focus was on the integrity of
> the software and distribution channel for both sites.
>
> To date, our investigation has not discovered any compromised code or
> binaries available for download on these sites. However, we cannot fully
> rule out the possibility that some compromised code or binaries were
> available for download at some point in the past. Further, we can no
> longer trust the integrity of the Ceph signing key, and therefore have
> created a new signing key (id E84AC2C0460F3994) for verifying downloads.
> This new key is committed to the ceph.git repository and is
> also available from
>
>         https://git.ceph.com/release.asc
>
> The new key should look like:
>
> pub   4096R/460F3994 2015-09-15
> uid                  Ceph.com (release key) <security-Qp0mS5GaXlQ@public.gmane.org>
>
> All future release git tags will be signed with this new key.
>
> This intrusion did not affect other Ceph sites such as download.ceph.com
> (which contained some older Ceph downloads) or git.ceph.com (which mirror=
s
> various source repositories), and is not known to have affected any other
> Ceph community infrastructure.  There is no evidence that build system or
> the Ceph github source repository were compromised.
>
> New hosts for ceph.com and download.ceph.com have been created and the
> sites have been rebuilt.  All content available on download.ceph.com as
> been verified, and all ceph.com URLs for package locations now redirect
> there.  There is still some content missing from download.ceph.com that
> will appear later today: source tarballs will be regenerated from git, an=
d
> older release packages are being resigned with the new release key DNS
> changes are still propogating so you may not see the new versions of the
> ceph.com and download.ceph.com sites for another hour or so.
>
> The download.inktank.com host has been retired and affected Red Hat
> customers have been notified, further information is available at
> https://securityblog.redhat.com/2015/09/17/.
>
> Users of Ceph packages should take action as a precautionary measure to
> download the newly-signed versions.  Please see the instructions below.
>
> The Ceph community would like to thank Kai Fabian for initially alerting
> us to this issue.
>
> Any questions can be directed to the email discussion lists or the #ceph
> IRC channel on irc.oftc.net.
>
> Thank you!
> sage
>
> - -----
>
> The following steps should be performed on all nodes with Ceph software
> installed.
>
> Replace APT keys (Debian, Ubuntu)
>
>         sudo apt-key del 17ED316D
>         curl https://git.ceph.com/release.asc | sudo apt-key add -
>
> Replace RPM keys (Fedora, CentOS, SUSE, etc.)
>
>         sudo rpm -e --allmatches gpg-pubkey-17ed316d-4fb96ee8
>         sudo rpm --import 'https://git.ceph.com/release.asc'
>
> Reinstalling packages (Fedora, CentOS, SUSE, etc.)
>
>         sudo yum clean metadata
>         sudo yum reinstall -y $(repoquery --disablerepo=3D --enablerepo=
=3Dceph
> \
>                 --queryformat=3D'%{NAME}' list '*')
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAlX66k0ACgkQ2kQg7SiJlcg0wQCfVy+/2BfoNqtCfAcbuNABczFx
> bpIAoLf8RTHisIn5wFvEb4Akym/UNn5l
> =3DSEws
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--047d7bdc11be56ef84052051ed49
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, all,<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Since the last we=
ek=E2=80=98s attack, =E2=80=9C<a href=3D"http://ceph.com/packages/ceph-extr=
as" target=3D"_blank">ceph.com/packages/ceph-extras</a>=E2=80=9D can be ope=
ned never, but where can I get the releases of ceph-extra now?</div><div><b=
r></div><div>Thanks and Regards,</div><div>WangSongbo</div></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">2015-09-18 0:29 GMT+08:00 S=
age Weil <span dir=3D"ltr">&lt;<a href=3D"mailto:sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org" target=
=3D"_blank">sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org</a>&gt;</span>:<br><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA1<br>
<br>
Last week, Red Hat investigated an intrusion on the sites of both the Ceph<=
br>
community project (<a href=3D"http://ceph.com" rel=3D"noreferrer" target=3D=
"_blank">ceph.com</a>) and Inktank (<a href=3D"http://download.inktank.com"=
 rel=3D"noreferrer" target=3D"_blank">download.inktank.com</a>), which<br>
were hosted on a computer system outside of Red Hat infrastructure.<br>
<br>
Ceph.com provided Ceph community versions downloads signed with a Ceph<br>
signing key (id 7EBFDD5D17ED316D). Download.inktank.comprovided releases<br=
>
of the Red Hat Ceph product for Ubuntu and CentOS operating systems signed<=
br>
with an Inktank signing key (id 5438C7019DCEEEAD). While the investigation<=
br>
into the intrusion is ongoing, our initial focus was on the integrity of<br=
>
the software and distribution channel for both sites.<br>
<br>
To date, our investigation has not discovered any compromised code or<br>
binaries available for download on these sites. However, we cannot fully<br=
>
rule out the possibility that some compromised code or binaries were<br>
available for download at some point in the past. Further, we can no<br>
longer trust the integrity of the Ceph signing key, and therefore have<br>
created a new signing key (id E84AC2C0460F3994) for verifying downloads.<br=
>
This new key is committed to the ceph.git repository and is<br>
also available from<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.ceph.com/release.asc" re=
l=3D"noreferrer" target=3D"_blank">https://git.ceph.com/release.asc</a><br>
<br>
The new key should look like:<br>
<br>
pub=C2=A0 =C2=A04096R/460F3994 2015-09-15<br>
uid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ceph.com =
(release key) &lt;<a href=3D"mailto:security-Qp0mS5GaXlQ@public.gmane.org">security-Qp0mS5GaXlQ@public.gmane.org</a=
>&gt;<br>
<br>
All future release git tags will be signed with this new key.<br>
<br>
This intrusion did not affect other Ceph sites such as <a href=3D"http://do=
wnload.ceph.com" rel=3D"noreferrer" target=3D"_blank">download.ceph.com</a>=
<br>
(which contained some older Ceph downloads) or <a href=3D"http://git.ceph.c=
om" rel=3D"noreferrer" target=3D"_blank">git.ceph.com</a> (which mirrors<br=
>
various source repositories), and is not known to have affected any other<b=
r>
Ceph community infrastructure.=C2=A0 There is no evidence that build system=
 or<br>
the Ceph github source repository were compromised.<br>
<br>
New hosts for <a href=3D"http://ceph.com" rel=3D"noreferrer" target=3D"_bla=
nk">ceph.com</a> and <a href=3D"http://download.ceph.com" rel=3D"noreferrer=
" target=3D"_blank">download.ceph.com</a> have been created and the<br>
sites have been rebuilt.=C2=A0 All content available on <a href=3D"http://d=
ownload.ceph.com" rel=3D"noreferrer" target=3D"_blank">download.ceph.com</a=
> as<br>
been verified, and all <a href=3D"http://ceph.com" rel=3D"noreferrer" targe=
t=3D"_blank">ceph.com</a> URLs for package locations now redirect<br>
there.=C2=A0 There is still some content missing from <a href=3D"http://dow=
nload.ceph.com" rel=3D"noreferrer" target=3D"_blank">download.ceph.com</a> =
that<br>
will appear later today: source tarballs will be regenerated from git, and<=
br>
older release packages are being resigned with the new release key DNS<br>
changes are still propogating so you may not see the new versions of the<br=
>
<a href=3D"http://ceph.com" rel=3D"noreferrer" target=3D"_blank">ceph.com</=
a> and <a href=3D"http://download.ceph.com" rel=3D"noreferrer" target=3D"_b=
lank">download.ceph.com</a> sites for another hour or so.<br>
<br>
The <a href=3D"http://download.inktank.com" rel=3D"noreferrer" target=3D"_b=
lank">download.inktank.com</a> host has been retired and affected Red Hat<b=
r>
customers have been notified, further information is available at<br>
<a href=3D"https://securityblog.redhat.com/2015/09/17/" rel=3D"noreferrer" =
target=3D"_blank">https://securityblog.redhat.com/2015/09/17/</a>.<br>
<br>
Users of Ceph packages should take action as a precautionary measure to<br>
download the newly-signed versions.=C2=A0 Please see the instructions below=
.<br>
<br>
The Ceph community would like to thank Kai Fabian for initially alerting<br=
>
us to this issue.<br>
<br>
Any questions can be directed to the email discussion lists or the #ceph<br=
>
IRC channel on <a href=3D"http://irc.oftc.net" rel=3D"noreferrer" target=3D=
"_blank">irc.oftc.net</a>.<br>
<br>
Thank you!<br>
sage<br>
<br>
- -----<br>
<br>
The following steps should be performed on all nodes with Ceph software<br>
installed.<br>
<br>
Replace APT keys (Debian, Ubuntu)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sudo apt-key del 17ED316D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 curl <a href=3D"https://git.ceph.com/release.as=
c" rel=3D"noreferrer" target=3D"_blank">https://git.ceph.com/release.asc</a=
> | sudo apt-key add -<br>
<br>
Replace RPM keys (Fedora, CentOS, SUSE, etc.)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sudo rpm -e --allmatches gpg-pubkey-17ed316d-4f=
b96ee8<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sudo rpm --import &#39;<a href=3D"https://git.c=
eph.com/release.asc" rel=3D"noreferrer" target=3D"_blank">https://git.ceph.=
com/release.asc</a>&#39;<br>
<br>
Reinstalling packages (Fedora, CentOS, SUSE, etc.)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sudo yum clean metadata<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sudo yum reinstall -y $(repoquery --disablerepo=
=3D --enablerepo=3Dceph \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --queryformat=3D&#3=
9;%{NAME}&#39; list &#39;*&#39;)<br>
<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v1.4.10 (GNU/Linux)<br>
<br>
iEYEARECAAYFAlX66k0ACgkQ2kQg7SiJlcg0wQCfVy+/2BfoNqtCfAcbuNABczFx<br>
bpIAoLf8RTHisIn5wFvEb4Akym/UNn5l<br>
=3DSEws<br>
-----END PGP SIGNATURE-----<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe ceph-devel&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">major=
domo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/majord=
omo-info.html</a><br>
</blockquote></div><br></div>

--047d7bdc11be56ef84052051ed49--

--===============1433850428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1433850428==--
