From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: libuuid vs boost uuid
Date: Mon, 25 Nov 2013 19:46:11 -0800
Message-ID: <8A6E449F-E249-4655-B198-53ABA06BF1E4@inktank.com>
References: <6035A0D088A63A46850C3988ED045A4B665E1FB8@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1311082238350.4750@cobra.newdream.net> <6035A0D088A63A46850C3988ED045A4B665E29B6@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1311092120290.30944@cobra.newdream.net> <B4DA9072-EED6-48EE-94FE-4F24CCDFA1F8@inktank.com> <6035A0D088A63A46850C3988ED045A4B665EA2F6@BITCOM1.int.sbss.com.au> <3C1A0909-F08C-44EE-AF1A-61E91460C764@inktank.com> <6035A0D088A63A46850C3988ED045A4B665EA52D@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:48814 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab3KZDqP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Nov 2013 22:46:15 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so6887888pdj.11
        for <ceph-devel@vger.kernel.org>; Mon, 25 Nov 2013 19:46:14 -0800 (PST)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B665EA52D@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

James,

I=92m using uuid.begin()/end() to grab the 16-byte representation of th=
e UUID. Did you figure out how to populate a boost::uuid_t from the byt=
es? In particular, I=92m referring to FileJournal::decode.=20

Actually, I suppose that any Ceph usage of the 16-byte representation s=
hould be replaced using the Boost serialization of uuid_t?

Thanks,
-Noah

On Nov 13, 2013, at 2:33 PM, James Harper <james.harper@bendigoit.com.a=
u> wrote:

> Patch follows. When I wrote it I was just thinking it would be used f=
or win32 build, hence the #ifdef. As I said before, it compiles but I h=
aven't tested it. I can clean it up a bit and resend it with a signed-o=
ff-by if anyone wants to pick it up and follow it through sooner than I=
 can. I don't know how boost behaves if the uuid parse fails (exception=
 maybe?) so that would need resolving too.
>=20
> In addition, a bunch of ceph files include the libuuid header directl=
y, even though all the ones I've found don't appear to need it, so they=
 need to be fixed for a clean compile under win32, and to remove depend=
ency on libuuid. There may also be other cases that need work, in parti=
cular anything that memcpy's into the 16 byte uuid directly. See patch =
for MStatfsReply.h where a minor tweak was necessary.
>=20
> (if anyone is interested, I have librados and librbd compiling under =
mingw32, but I can't get boost to build its thread library so I don't g=
et a clean link, and there are probably other link errors too. I've run=
 out of time for doing much more on this for the moment)
>=20
> James
>=20
> diff --git a/src/include/uuid.h b/src/include/uuid.h
> index 942b807..201ac76 100644
> --- a/src/include/uuid.h
> +++ b/src/include/uuid.h
> @@ -8,6 +8,70 @@
> #include "encoding.h"
> #include <ostream>
>=20
> +#if defined(_WIN32)
> +
> +#include <boost/lexical_cast.hpp>
> +#include <boost/uuid/uuid.hpp>
> +#include <boost/uuid/uuid_generators.hpp>
> +#include <boost/uuid/uuid_io.hpp>
> +#include <string>
> +
> +struct uuid_d {
> +  boost::uuids::uuid uuid;
> +
> +  uuid_d() {
> +    uuid =3D boost::uuids::nil_uuid();
> +  }
> +
> +  bool is_zero() const {
> +    return uuid.is_nil();
> +    //return boost::uuids::uuid::is_nil(uuid);
> +  }
> +
> +  void generate_random() {
> +    boost::uuids::random_generator gen;
> +    uuid =3D gen();
> +  }
> +
> +  bool parse(const char *s) {
> +    boost::uuids::string_generator gen;
> +    uuid =3D gen(s);
> +    return true;
> +    // what happens if parse fails?
> +  }
> +  void print(char *s) {
> +    std::string str =3D boost::lexical_cast<std::string>(uuid);
> +    memcpy(s, str.c_str(), 37);
> +  }
> +
> +  void encode(bufferlist& bl) const {
> +    ::encode_raw(uuid, bl);
> +  }
> +  void decode(bufferlist::iterator& p) const {
> +    ::decode_raw(uuid, p);
> +  }
> +
> +  uuid_d& operator=3D(const uuid_d& r) {
> +    uuid =3D r.uuid;
> +    return *this;
> +  }
> +};
> +WRITE_CLASS_ENCODER(uuid_d)
> +
> +inline std::ostream& operator<<(std::ostream& out, const uuid_d& u) =
{
> +  //char b[37];
> diff --git a/src/include/uuid.h b/src/include/uuid.h
> index 942b807..201ac76 100644
> --- a/src/include/uuid.h
> +++ b/src/include/uuid.h
> @@ -8,6 +8,70 @@
> #include "encoding.h"
> #include <ostream>
>=20
> +#if defined(_WIN32)
> +
> +#include <boost/lexical_cast.hpp>
> +#include <boost/uuid/uuid.hpp>
> +#include <boost/uuid/uuid_generators.hpp>
> +#include <boost/uuid/uuid_io.hpp>
> +#include <string>
> +
> +struct uuid_d {
> +  boost::uuids::uuid uuid;
> +
> +  uuid_d() {
> +    uuid =3D boost::uuids::nil_uuid();
> +  }
> +
> +  bool is_zero() const {
> +    return uuid.is_nil();
> +    //return boost::uuids::uuid::is_nil(uuid);
> +  }
> +
> +  void generate_random() {
> +    boost::uuids::random_generator gen;
> +    uuid =3D gen();
> +  }
> +
> +  bool parse(const char *s) {
> +    boost::uuids::string_generator gen;
> +    uuid =3D gen(s);
> +    return true;
> +    // what happens if parse fails?
> +  }
> +  void print(char *s) {
> +    std::string str =3D boost::lexical_cast<std::string>(uuid);
> +    memcpy(s, str.c_str(), 37);
> +  }
> +
> +  void encode(bufferlist& bl) const {
> +    ::encode_raw(uuid, bl);
> +  }
> +  void decode(bufferlist::iterator& p) const {
> +    ::decode_raw(uuid, p);
> +  }
> +
> +  uuid_d& operator=3D(const uuid_d& r) {
> +    uuid =3D r.uuid;
> +    return *this;
> +  }
> +};
> +WRITE_CLASS_ENCODER(uuid_d)
> +
> +inline std::ostream& operator<<(std::ostream& out, const uuid_d& u) =
{
> +  //char b[37];
> +  //uuid_unparse(u.uuid, b);
> +  return out << u.uuid;
> +}
> +
> +inline bool operator=3D=3D(const uuid_d& l, const uuid_d& r) {
> +  return l.uuid =3D=3D r.uuid;
> +}
> +
> +inline bool operator!=3D(const uuid_d& l, const uuid_d& r) {
> +  return l.uuid !=3D r.uuid;
> +}
> +#else
> extern "C" {
> #include <uuid/uuid.h>
> #include <unistd.h>
> @@ -56,6 +120,6 @@ inline bool operator=3D=3D(const uuid_d& l, const =
uuid_d& r) {
> inline bool operator!=3D(const uuid_d& l, const uuid_d& r) {
>   return uuid_compare(l.uuid, r.uuid) !=3D 0;
> }
> -
> +#endif
>=20
> #endif
> diff --git a/src/messages/MStatfsReply.h b/src/messages/MStatfsReply.=
h
> index 8ceec9c..40a5bdd 100644
> --- a/src/messages/MStatfsReply.h
> +++ b/src/messages/MStatfsReply.h
> @@ -22,7 +22,7 @@ public:
>=20
>   MStatfsReply() : Message(CEPH_MSG_STATFS_REPLY) {}
>   MStatfsReply(uuid_d &f, tid_t t, epoch_t epoch) : Message(CEPH_MSG_=
STATFS_REPLY) {
> -    memcpy(&h.fsid, f.uuid, sizeof(h.fsid));
> +    memcpy(&h.fsid, &f.uuid, sizeof(h.fsid));
>     header.tid =3D t;
>     h.version =3D epoch;
>   }
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
