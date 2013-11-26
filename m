From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: libuuid vs boost uuid
Date: Tue, 26 Nov 2013 08:44:26 -0800
Message-ID: <198E3512-2077-4ABA-B961-21E45A68642B@inktank.com>
References: <6035A0D088A63A46850C3988ED045A4B665E1FB8@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1311082238350.4750@cobra.newdream.net> <6035A0D088A63A46850C3988ED045A4B665E29B6@BITCOM1.int.sbss.com.au> <alpine.DEB.2.00.1311092120290.30944@cobra.newdream.net> <B4DA9072-EED6-48EE-94FE-4F24CCDFA1F8@inktank.com> <6035A0D088A63A46850C3988ED045A4B665EA2F6@BITCOM1.int.sbss.com.au> <3C1A0909-F08C-44EE-AF1A-61E91460C764@inktank.com> <6035A0D088A63A46850C3988ED045A4B665EA52D@BITCOM1.int.sbss.com.au> <8A6E449F-E249-4655-B198-53ABA06BF1E4@inktank.com> <6035A0D088A63A46850C3988ED045A4B66608B32@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:46114 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932303Ab3KZQoa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Nov 2013 11:44:30 -0500
Received: by mail-pd0-f177.google.com with SMTP id q10so7919724pdj.8
        for <ceph-devel@vger.kernel.org>; Tue, 26 Nov 2013 08:44:29 -0800 (PST)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B66608B32@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I put up a patch here for review

https://github.com/ceph/ceph/pull/875/files

It seems ok as long as boost doesn=92t ever try to change their interna=
l representation, which in this patch we reach in an grab for the 16 oc=
tet representation. Why not just grab a copy of libuuid from util-linux=
 and keep it in tree?

On Nov 25, 2013, at 9:52 PM, James Harper <james.harper@bendigoit.com.a=
u> wrote:

>>=20
>> James,
>>=20
>> I'm using uuid.begin()/end() to grab the 16-byte representation of t=
he UUID.
>> Did you figure out how to populate a boost::uuid_t from the bytes? I=
n
>> particular, I'm referring to FileJournal::decode.
>>=20
>> Actually, I suppose that any Ceph usage of the 16-byte representatio=
n should
>> be replaced using the Boost serialization of uuid_t?
>>=20
>=20
> As I said I haven't actually tested it, apart from that I have librbd=
 working under Windows now ("rbd ls" and "rbd export" both work but I d=
on't know if they actually do anything with uuid's...)
>=20
> My patch to MStatfsReply.h to make it compile is:
>=20
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
> So assuming this actually works, the uuid bytes are accessible as per=
 the above.
>=20
> James
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
