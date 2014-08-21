From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: RadosGW crashing on copy for one specific object
Date: Thu, 21 Aug 2014 11:38:14 +0200
Message-ID: <CAF6-1L7hSYHoNeKUCu466UHUVbVUAQ6mWzK3V9B6TTuqMkpRLA@mail.gmail.com>
References: <CAF6-1L4zXmczyvXyD=1ZKjO67BYDoPMa3JEaKn082y5WUZY39w@mail.gmail.com>
	<CABBk=J8qLc45ggoqdWEZVi3YF0Og9wuj_5tW_5Gng+bh65rUjg@mail.gmail.com>
	<CAF6-1L6GWKmncQXA_e4NzaFzLqefzQ4O1qikW0zG6k7BrrMvHg@mail.gmail.com>
	<CABBk=J8G=fWC5_m0qxAaYAH0UioYA++87S84J9+23B2BxNs39g@mail.gmail.com>
	<CABBk=J851yHsd05Lk7JzBk0jDFAM8HRKC0Yz7XmntrpFkCZh=Q@mail.gmail.com>
	<CABBk=J8B-Ph_Ju7uHOuXydXdSXw1tL4v1dvPvy7P=A19XtTTTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:46412 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbaHUJiP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Aug 2014 05:38:15 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so14030042pad.7
        for <ceph-devel@vger.kernel.org>; Thu, 21 Aug 2014 02:38:14 -0700 (PDT)
In-Reply-To: <CABBk=J8B-Ph_Ju7uHOuXydXdSXw1tL4v1dvPvy7P=A19XtTTTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,


> If by any chance you applied the previous patch, revert it, as it's
> wrong. This might fix the issue:
>
> diff --git a/src/rgw/rgw_rados.h b/src/rgw/rgw_rados.h
> index d50fb59..0f13590 100644
> --- a/src/rgw/rgw_rados.h
> +++ b/src/rgw/rgw_rados.h
> @@ -298,6 +298,9 @@ public:
>
>    bool has_tail() {
>      if (explicit_objs) {
> +      if (objs.size() =3D=3D 1) {
> +        return head_obj !=3D objs[0];
> +      }
>        return (objs.size() >=3D 2);
>      }
>      return (obj_size > head_size);
>
> Let me know if it works for you.

It doesn't build at all.

rgw/rgw_rados.h: In member function =E2=80=98bool RGWObjManifest::has_t=
ail()=E2=80=99:
rgw/rgw_rados.h:302:34: error: no match for =E2=80=98operator!=3D=E2=80=
=99 in
=E2=80=98((RGWObjManifest*)this)->RGWObjManifest::head_obj !=3D
((RGWObjManifest*)this)->RGWObjManifest::objs.std::map<_Key, _Tp,
_Compare, _Alloc>::operator[] [with _Key =3D long unsigned int, _Tp =3D
RGWObjManifestPart, _Compare =3D std::less<long unsigned int>, _Alloc =3D
std::allocator<std::pair<const long unsigned int, RGWObjManifestPart>
>, std::map<_Key, _Tp, _Compare, _Alloc>::mapped_type =3D
RGWObjManifestPart, std::map<_Key, _Tp, _Compare, _Alloc>::key_type =3D
long unsigned int]((* &0u))=E2=80=99
=2E..



Cheers,

   Sylvain
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
