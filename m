Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703A3624BA
	for <ceph-devel@vger.kernel.org>; Tue, 31 Mar 2026 17:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978277; cv=pass; b=hc1s7E3GOgnvYM3kv7duuVz0yfq/Px/2M9dJNoTuX8q4kMvd53yfxFl8BZ85/m7QMX6rtye5ouXY3ivTpHiq8f75IkH7j7HAV7+070Hy2QKVuvY0jg/OLA8sKyizL/nk6zZQNZCmlNE9pxgg9skR/pv4Ck3KbqzucGLnXe3Qvyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978277; c=relaxed/simple;
	bh=czGlZHdCgqYarp1CuPTmxpm0D30D74dIZAoH1X6wYlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUTn8JueqTDOfVwwYV0rpgKC/14MKsWyn5GUi5+z2KQw8xC1rs+dBfBCRDCCXWqVRhY1pBKJVzajA1y3QZlCzyXpbkcTKCzt74uFDEBOxrGe+MrJRGnmP3GOqpjOqe76g7/R89x6cY6gsGFqBHLHbmSAMBFvt3l7w4ZmUVZqsyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M7XG0f/5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSeAMDW0; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7XG0f/5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSeAMDW0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774978275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C3pXvrZylAgqfmAiltUhgFZnAT0syPZ28xCCpchiRrY=;
	b=M7XG0f/54Gv5FuYgASUwT+17/nWviigHlaxyrwe/hY6KSORq9a7EcjS4W3CNXDWzieS52K
	ZtrePJHi1d4lpildfjKjwc1VPf+NJlyyBQNUjdA8Ai9NsG5wgEGAHkumlIV2z4YgDhqA9t
	WeF9Co57s8v6Azwhp3iWvBuueoFJlpg=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-SoQ6wpwMPlK4lqgaWDbg0g-1; Tue, 31 Mar 2026 13:31:14 -0400
X-MC-Unique: SoQ6wpwMPlK4lqgaWDbg0g-1
X-Mimecast-MFC-AGG-ID: SoQ6wpwMPlK4lqgaWDbg0g_1774978272
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-948476b92e8so2742050241.3
        for <ceph-devel@vger.kernel.org>; Tue, 31 Mar 2026 10:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774978272; cv=none;
        d=google.com; s=arc-20240605;
        b=jEvHrCts/XbKLm8zMqJzIlnKvJWA7TPsP/QRi6aQEa99UQ4bmquaCAgi2CtK0w5b0Y
         LHemNJsbXJsmy+h6iwZj/u5IVXiES6OlUPCqnbL7n9D4YLVZ6DeJD/WqbMXdLQ9HhiX3
         zDRM8Clx1basYT9EhgCtCgan+bL3ieOMFroTFicxZQufCV9SWd+H7/juIk4u3FCGbJpc
         MDvnnzxWIsigpqhd09MM8kLIc2mQogzLhnRjVdaQNWRe8YIwJEwhhJjfrWbPHuqcFlwX
         m+Eg11kJ3md80nknuHVDLEX3ismMLSJPgAzNw07yhCYZxP5zPvGYDcg3iV/Q5+Ll4HoV
         XOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C3pXvrZylAgqfmAiltUhgFZnAT0syPZ28xCCpchiRrY=;
        fh=t3ZzxrucLzNTI15N2A9WhHq4EJ77cKNW9JfVKCHFB9k=;
        b=G6bFZY01KPyBBfgiHwzSd6J5Mo90t6CUJFlVBtK+t18UtycBx/ea1avXnhHVFeGa0+
         M7LePvI7oH0Mq7b9rJElJ8GBPAvlSKQa1vUm+2H0QqKJM+JOU5OET0SjcMia5Vm8p0Gi
         xPbxwff2slxan4MfuxagZyk5EIII7yptfcrHp09X14KDhMGW1J5VH0iORjtqzYTXx5Sg
         JkzyrjRXFQKeV5n5K6e+Hc8FKEPrSsFnUELPEj1M82Akb8rFSmNRiR8xGczHQM31Jw66
         MpDsv8YukWHjIFTJOiFeedKl+eonaOnoTT+vVzR8BMDGNj++3XRe8gIb8DlBabcgn6e2
         9eQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774978272; x=1775583072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3pXvrZylAgqfmAiltUhgFZnAT0syPZ28xCCpchiRrY=;
        b=eSeAMDW0yaX4KQydHANT2y3YCgljL2Ku48wdQKKSDP6HaybJo43Ra6QQgh+R0Ynjog
         aP6wu1mqYETc3CSRcSzf8MGwXy8e47fko4SRa2PuHG4Jxzzdc4Q3CMH2dZ360TY2ltjp
         PU4dRasKm4pkaqAAsMx5faQFlEmPx6Ln9P01l80YN2ZHJEZT7lJ9JtfS977RSY93VwVg
         Bc39I7DFxDaCLz28Y3hhUwMOb61bqcQivDbtVatXY7iO/c+4Q4ztBnpmCBttIAXJuelZ
         v6YrMat+E+VJhRSVUdxNqya5UMDCEoL7SFqPVAX2JbXAkoP4OxnbSoS5F0J9cA6UThMd
         pR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774978272; x=1775583072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C3pXvrZylAgqfmAiltUhgFZnAT0syPZ28xCCpchiRrY=;
        b=CLVbokd/cfL1v6lLdVJgdb8cWAZbU4MZk1wkItFOi271Q7xCmPHscVTQptYhVOacbF
         UeyeMtmeOe4OEs1uWmOoOVuxzcoIFeQWtS7KTevQviegFEANCCei7XUGJJ2c63XgKzpE
         qtT/voi7i6sX0oF5yp0P4o5E8yOz5dnGz0Ynrgzo9S8m808d1noB9XERkRuHbrZmthZm
         pclb4tNbD7qzlv8XutcvcCj5wG8ii4P1Tr9vdgGpaG2b4hZUHNSvT+ZBwIgA3LtGzkSY
         uHsGMgyfpOedatYs01aWnKOCNe48tojtqktsd20CS7+UwbAahq6qi0T5GluADMVbywH9
         HagA==
X-Forwarded-Encrypted: i=1; AJvYcCVgq+aodDgJXEfgFbUS0sI8T/6X2JdiTOYPLW8uxDeRqVkvPDG6xCfnbiIa0Uy3KtrMPYg9BpuKMAEU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3r8i0fw9SEEP/tn5gNiCDiTOwtW4PIEOqbobIHOGoxdlvHyjc
	lFPs4RgtCh1YxVwUhvx7a7uNafa0azmuNWxlhNHQMM6igZZNmimB4vDS3XUtWQ1n9NS9e+3xt6T
	M2EI/ulgaS/REJSfLSGnKuHb2dEQ5HZqJFh/LLDdoJhVe6mTu0kf/E8O/MJh8tppeYUcnvdbv9w
	QKT4ADmWYwqYe0op0CxMhyt3C0Bjsgpu6TZsHJDw==
X-Gm-Gg: ATEYQzySvs+8SXyqoJWleJFxzmjc1tHvlPoQCy4VV0Vmm/AJTcnIlc4EYaKtp3mTS/3
	F7x5toEkIvh3kDcHbm3DAg5H7uAXqpzIFaBvsIY7qzgK5x1Ln4OOqjQfr2yySF8o0ZbYW2dF/QY
	eqlLrjnWfKt2NSrSNmLpYFp5LjyVnC9Wym2sysLummQxJobahf+xxG5RJhQNzTcWcIZ4puVdLrU
	n7emQ==
X-Received: by 2002:a05:6102:f82:b0:5ff:a16b:93fc with SMTP id ada2fe7eead31-60567e38c48mr83876137.15.1774978272395;
        Tue, 31 Mar 2026 10:31:12 -0700 (PDT)
X-Received: by 2002:a05:6102:f82:b0:5ff:a16b:93fc with SMTP id
 ada2fe7eead31-60567e38c48mr83818137.15.1774978271923; Tue, 31 Mar 2026
 10:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330204652.178736-2-slava@dubeyko.com> <CAO8a2ShjuZaizXGptVMnZ2NKS1vixNpGRN5LT8cyGO5b1ktuag@mail.gmail.com>
 <d81eaee640f20cc8a166ea2d8b4dfc0518aba7fe.camel@ibm.com>
In-Reply-To: <d81eaee640f20cc8a166ea2d8b4dfc0518aba7fe.camel@ibm.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Tue, 31 Mar 2026 20:31:01 +0300
X-Gm-Features: AQROBzCfwdIBWjlU7rcIpwzC20dNVFT1FNd4rUcXnw44vJ91DOI703x0lY4PO1c
Message-ID: <CAO8a2SiNSW-wbOHUXo0rzm2DVGcbXiruEDuFYTkn_K3HYcX0hA@mail.gmail.com>
Subject: Re: [PATCH] libceph: cleanup in crush_do_rule() method
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>, Patrick Donnelly <pdonnell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As I said, nits; its your call.

On Tue, Mar 31, 2026 at 8:28=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Tue, 2026-03-31 at 20:19 +0300, Alex Markuze wrote:
> > Looks good, but here are a couple of nits:
> >
> >   1. The subject prefix uses libceph: but the file changed is
> > net/ceph/crush/mapper.c. The conventional prefix for CRUSH code is
> > crush: (which is also what the original commit you reference in the
> > Fixes tag uses). Something like crush: remove
> >    dead variable j from crush_do_rule() would be more accurate.
>
> Probably, it will be better to have "libceph/crush:" because crush is a
> subsystem of libceph. But I am OK with "crush:" if everyone can follow wh=
ich
> subsystem is under the fix.
>
> >   2. Small typo in the commit message: "This patch simply remove the
> > dead code" =E2=86=92 "removes".
> >
>
> I can address these comments in second version of the patch if you like. =
But it
> sounds like not major ones. So, I assume that I can leave the patch as it=
 is.
>
> Thanks,
> Slava.
>
> >
> >   Reviewed-by: Alex Markuze <amarkuze@redhat.com>
> >
> > On Mon, Mar 30, 2026 at 11:47=E2=80=AFPM Viacheslav Dubeyko <slava@dube=
yko.com> wrote:
> > >
> > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > >
> > > Commit 41ebcc0907c5 ("crush: remove forcefeed functionality") from
> > > May 7, 2012 (linux-next), leads to the following Smatch static
> > > checker warning:
> > >
> > >         net/ceph/crush/mapper.c:1015 crush_do_rule()
> > >         warn: iterator 'j' not incremented
> > >
> > > Before commit 41ebcc0907c5 ("crush: remove forcefeed functionality"),
> > > we had this logic:
> > >
> > >   j =3D 0;
> > >   if (osize =3D=3D 0 && force_pos >=3D 0) {
> > >       o[osize] =3D force_context[force_pos];
> > >       if (recurse_to_leaf)
> > >           c[osize] =3D force_context[0];
> > >       j++;           /* <-- this was the only increment, now gone */
> > >       force_pos--;
> > >   }
> > >   /* then crush_choose_*(..., o+osize, j, ...) */
> > >
> > > Now, the variable j is dead code =E2=80=94 a variable that is set
> > > and never meaningfully varied. This patch simply remove
> > > the dead code.
> > >
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Fixes: 41ebcc0907c5 ("crush: remove forcefeed functionality")
> > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > cc: Alex Markuze <amarkuze@redhat.com>
> > > cc: Ilya Dryomov <idryomov@gmail.com>
> > > cc: Patrick Donnelly <pdonnell@redhat.com>
> > > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > > ---
> > >  net/ceph/crush/mapper.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
> > > index 3a5bd1cd1e99..17b041779fb9 100644
> > > --- a/net/ceph/crush/mapper.c
> > > +++ b/net/ceph/crush/mapper.c
> > > @@ -911,7 +911,7 @@ int crush_do_rule(const struct crush_map *map,
> > >         int osize;
> > >         const struct crush_rule *rule;
> > >         __u32 step;
> > > -       int i, j;
> > > +       int i;
> > >         int numrep;
> > >         int out_size;
> > >         /*
> > > @@ -1012,7 +1012,6 @@ int crush_do_rule(const struct crush_map *map,
> > >                                         if (numrep <=3D 0)
> > >                                                 continue;
> > >                                 }
> > > -                               j =3D 0;
> > >                                 /* make sure bucket id is valid */
> > >                                 bno =3D -1 - w[i];
> > >                                 if (bno < 0 || bno >=3D map->max_buck=
ets) {
> > > @@ -1036,7 +1035,7 @@ int crush_do_rule(const struct crush_map *map,
> > >                                                 weight, weight_max,
> > >                                                 x, numrep,
> > >                                                 curstep->arg2,
> > > -                                               o+osize, j,
> > > +                                               o+osize, 0,
> > >                                                 result_max-osize,
> > >                                                 choose_tries,
> > >                                                 recurse_tries,
> > > @@ -1058,7 +1057,7 @@ int crush_do_rule(const struct crush_map *map,
> > >                                                 weight, weight_max,
> > >                                                 x, out_size, numrep,
> > >                                                 curstep->arg2,
> > > -                                               o+osize, j,
> > > +                                               o+osize, 0,
> > >                                                 choose_tries,
> > >                                                 choose_leaf_tries ?
> > >                                                    choose_leaf_tries =
: 1,
> > > --
> > > 2.53.0
> > >

