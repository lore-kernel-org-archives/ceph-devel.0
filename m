From: Chuanyu <chuanyu@cs.nctu.edu.tw>
Subject: Re: "Radosgw installation and administration" docs
Date: Sun, 1 Jul 2012 20:22:34 +0000 (UTC)
Message-ID: <loom.20120701T222011-780@post.gmane.org>
References: <4FD71854.6060503@hastexo.com> <CAPUexz-nq-rs3CdougTBpiiur__W0royUcaMdYfpfamwkh7jNw@mail.gmail.com> <CAC-hyiEDLJTkDKXLgR64cPE5mcPvWUCs6kCCq+DiRaCtvDEEFQ@mail.gmail.com> <4FD78636.9080607@hastexo.com> <CAC-hyiF5PVR9nzjewG6VjPCGdjAeuio8Gqf9_juZKWRZZ1KpaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51936 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718Ab2GBAzK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 1 Jul 2012 20:55:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SlUuu-0005eG-Ih
	for ceph-devel@vger.kernel.org; Mon, 02 Jul 2012 02:55:08 +0200
Received: from 219-84-126-54-adsl-tpe.dynamic.so-net.net.tw ([219.84.126.54])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 02:55:04 +0200
Received: from chuanyu by 219-84-126-54-adsl-tpe.dynamic.so-net.net.tw with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 02:55:04 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Yehuda Sadeh <yehuda <at> inktank.com> writes:

>=20
> On Tue, Jun 12, 2012 at 11:11 AM, Florian Haas <florian <at> hastexo.=
com>=20
wrote:
> > Hi Yehuda,
> >
> > thanks, that resolved a lot of questions for me. A few follow-up
> > comments below:
> >
> >>
> >> We currently use a slightly different rule:
> >>
> >> =C2=A0 RewriteRule =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^/(.*=
)
> >> /radosgw.fcgi?params=3D$1&%{QUERY_STRING}
> >> [E=3DHTTP_AUTHORIZATION:%{HTTP:Authorization},L]
> >
> > Could you explain what happened to "page"?
>=20
> Not really. I don't remember, was probably necessary originally and
> now it's not. Looking at the code, I think you can also drop the
> params=3D$1 part:
>=20
>   RewriteRule             ^/(.*) /radosgw.fcgi?%{QUERY_STRING}
> [E=3DHTTP_AUTHORIZATION:%{HTTP:Authorization},L]
>=20
> >
> >>> Also, for each of these, where would the logging output end up?
> >>> /var/log/ceph? Apache error log? If so, only if the Apache LogLev=
el is
> >>> more verbose than info? Syslog?
> >>
> >>
> >> The debug log would end up wherever you specified in the 'log file=
'
> >> config option.
> >
> > ... or syslog, if log file =3D "" and syslog =3D true. (iirc)
>=20
> Yeah. Whichever ceph logging scheme you're using.
>=20
> >
> >>> 6. Swift API: Keys
> >>>
> >>> Is it correct to assume that for any Swift client to work, we mus=
t set a
> >>> Swift key for the user, like so?
> >>>
> >>> radosgw-admin key create --key-type=3Dswift --uid=3D<user>
> >>>
> >>> If so, is the secret_key that that creates for the user:
> >>>
> >>> =C2=A0"swift_keys": [
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0{ "user": "<user>",
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"secret_key": "<longbase64hash>=
"}]}
> >>>
> >>>
> >>> ... the same key that the swift command line client expects to be=
 set
> >>> with th -K option?
> >>
> >> Yes.
> >
> > OK, but I realized that you apparently have to create a separate ke=
y
> > when creating a sub-user. Is that correct? Or is there a way for
> > sub-users to "inherit" the keys defined for their parent user?
> >
> >>> 7. Swift API: swift user name
> >>>
> >>> When we call "swift -U <user>", is that the verbatim user_id that=
 we've
> >>> defined with "radosgw-admin user create --uid=3D<user_id>"? Or do=
 we need
> >>> to set a prefix? Or define a separate Swift user ID?
> >>>
> >>
> >> In swift the terminology is a bit different. There is the account =
and
> >> under that there is the user. Since we already have a 'user' (whic=
h is
> >> actually the swift account), we created a 'subuser'. So a one line=
r
> >> user and swift-subuser creation would be as follows:
> >>
> >> # radosgw-admin user create --subuser=3Dyehuda:yehuda1
> >> --display-name=3DYehuda --key-type=3Dswift --access=3Dfull
> >
> > It seems there is some magic involved so that if you do "user creat=
e",
> > set --subuser=3D<prefix>:<sub> and don't set --uid, it creates a ne=
w
> > parent user named <prefix>. Is this meant to be stable? Or is the
>=20
> The <user>:<subuser> notation is stable.
>=20
> > supported way of doing things to always first create a user, and th=
en
> > use "subuser create" to create the subuser?
>=20
> Both are supported, but note that the 'user create' command requires =
a
> display-name to be specified, whereas the 'subuser create' doesn't. W=
e
> can change that later and only require the display-name if the user
> does not exist, but at the moment that's how it works.
>=20
> >
> >> { "user_id": "yehuda",
> >> =C2=A0 "rados_uid": 0,
> >> =C2=A0 "display_name": "Yehuda",
> >> =C2=A0 "email": "",
> >> =C2=A0 "suspended": 0,
> >> =C2=A0 "max_buckets": 1000,
> >> =C2=A0 "subusers": [
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 { "id": "yehuda:yehuda1",
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "permissions": "full-control"}]=
,
> >> =C2=A0 "keys": [],
> >> =C2=A0 "swift_keys": [
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 { "user": "yehuda:yehuda1",
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "secret_key": "7TD5f2QrwxkCnhth=
wowC4d9uEJ4mnX8nGsXjmnW8"}]}
> >>
> >
Hi Yehuda, Florian,

I follow the wiki, and steps which you discussed,
construct my ceph system with rados gateway,
and I can use libs3 to upload file via radosgw, (thanks a lot!)
but got "405 Method Not Allowed" when I use swift,

$ swift -v -A http://s3.paca.tw:80/auth -U paca:paca1 -K=20
UoJO4nFgdAoX+9nEftElIY+AMmDIkcrUBkycNKPA stat
Auth GET failed: http://s3.paca.tw:80/auth/tokens 405 Method Not Allowe=
d

( Because there has no test step on wiki,
 I follow the Florian's question, and guess the test command is above ?=
!)

my radosgw-admin config:
$ radosgw-admin user info --uid=3Dpaca
{ "user_id": "paca",
  "rados_uid": 0,
  "display_name": "chuanyu",
  "email": "chuanyu@cs.nctu.edu.tw",
  "suspended": 0,
  "subusers": [
        { "id": "paca:paca1",
          "permissions": "<none>"}],
  "keys": [
        { "user": "paca",
          "access_key": "DS932H4EI9HK7I1CTDNF",
          "secret_key": "Rn\/5FqHzRPZFN6f9R\/LuTqvG0AYjbHtrurrGydVk"}],
  "swift_keys": [
        { "user": "paca:paca1",
          "secret_key": "UoJO4nFgdAoX+9nEftElIY+AMmDIkcrUBkycNKPA"}]}

ceph.conf:
[client.radosgw.gateway]
    host =3D volume
    keyring =3D /etc/ceph/keyring/radosgw.gateway.keyring
    rgw socket path =3D /var/run/ceph/rgw.sock
    log file =3D ""
    syslog =3D true
    debug rgw =3D 20

my log:
http://pastebin.com/rhGhATmv

Any advice would be appreciate!
Tthanks,
Chuanyu
> >>> 10. radosgw "OpenStack user" information
> >>>
> >>> From the radosgw-admin man page:
> >>> =C2=A0 =C2=A0 =C2=A0 --os-user=3Dgroup:name
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The OpenStack use=
r (only needed for use with OpenStack)
> >>> =C2=A0 =C2=A0 =C2=A0 --os-secret=3Dkey
> >>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The OpenStack key
> >>
> >> Obsolete. That was the old way to configure swift users.
> >
> > OK. Should this be removed from the man page then?
>=20
> Yeah, should be updated.
>=20
> >
> > Silly question: If "auth supported =3D none", is it still required =
to run
> > the ceph-authtool and ceph-auth commands specified in radosgw(8)?
>=20
> Not for setting up radosgw.
>=20
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 log file =3D /var/log/radosgw/radosgw.=
log
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 debug rgw =3D 20
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rgw cache enabled =3D 1
> >> ; =C2=A0 =C2=A0 =C2=A0 rgw swift url =3D http://skinny
> >> ; =C2=A0 =C2=A0 =C2=A0 rgw swift url prefix =3D swift
> >
> > I ran across this option sifting through src/rgw, can you explain w=
hat
> > the URL prefix is used for?
>=20
> When authenticating the client, the swift_url and swift_prefix are
> concatenated and passed to the client as the storage URL, along with
> the token.
>=20
> Thanks,
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
