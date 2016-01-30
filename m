From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: compiling stops at od compare
Date: Sat, 30 Jan 2016 17:57:24 -0500 (EST)
Message-ID: <959618990.28815879.1454194644164.JavaMail.zimbra@redhat.com>
References: <56ACB8FF.5000605@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:44448 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756312AbcA3W53 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 30 Jan 2016 17:57:29 -0500
In-Reply-To: <56ACB8FF.5000605@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: ceph-devel@vger.kernel.org

Should we use std::min here (that might require a cast, iirc)?

Matt

----- Original Message -----
> From: "Willem Jan Withagen" <wjw@digiware.nl>
> To: ceph-devel@vger.kernel.org
> Sent: Saturday, January 30, 2016 8:22:07 AM
> Subject: compiling stops at od compare
>=20
> When trying to compile on CentOS 7, gcc =3D 4.8.3
>=20
> os/bluestore/BlueFS.cc: In member function =E2=80=98int
> BlueFS::_read(BlueFS::FileReader*, BlueFS::FileReaderBuffer*, uint64_=
t,
> size_t, ceph::bufferlist*, char*)=E2=80=99:
> os/bluestore/BlueFS.cc:731:31: warning: comparison between signed and
> unsigned integer expressions [-Wsign-compare]
>      int r =3D MIN((int)len, left);
>=20
> This MIN is used to determine the amount of buffer that is still left
> to be filed.
> And here len and left are both size_t..., suggesting that both cannot=
 be
> negative. So either both need to be promoted/cast, or neither.
>=20
> The cast (int)len suggests that len could be negative.
> The part where that could happen is at line 750:
>=20
>    off +=3D r;
>     len -=3D r;
>     ret +=3D r;
>=20
> So there the loop exit needs len to be exactly equal to r. Even if th=
e
> loop specifies while(len>0). if len gets "negative" it grows into
> something rather big.
>=20
> Now if len never gets negative then it also does not need to get cast=
 to
> int. If it does, then in the unsigned case it will always be larger t=
han
> left.
>=20
> So bottomline is that the cast serves no purpose?
> Removing it fixes compilation.
>=20
> --WjW
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
--=20
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
