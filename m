Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87235CB8B
	for <ceph-devel@vger.kernel.org>; Mon,  9 Mar 2026 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082998; cv=pass; b=V9MWDYXvCUnNSBg2FZgAVs2GTnovtGKOdrqvU2Db6RNE9kz5iUX7W1ib3NooV4/1KSaJoq9k658Tuus+fLBGTo4GmG+dB2+osGDJPR2qfNBH5laUg1SGUdS+MWMfLXAkBiJYYaAaBlYZD+VRxOVOa4xj6XNInXzXHr6dwbu7tzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082998; c=relaxed/simple;
	bh=OXPPcfI0w6kUdoA04ygt5Z9dpHTxne5EAIvXBYWTzdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1my1hszI0zr1ww7oodPWdqg80I1cVmssedsjC5bkWmz6fRZqIJrCbODPkpNtbkrejYNzaT0Rzd/ZL2xkv6bbljUMY/wL91w+cDmPH4+0bKehac7bp/qoxmopdUZA1fKJHsCGZHyTOAmyEtMNQcQyukHBamumgEP0RXAPWoqVHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glCfRu22; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glCfRu22"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bdfc4b191fso7377580eec.1
        for <ceph-devel@vger.kernel.org>; Mon, 09 Mar 2026 12:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773082996; cv=none;
        d=google.com; s=arc-20240605;
        b=Dj8rqLECkP8Wcss7fQ7OjVcBbmADdxAnDc8WVcs0CzPCMyWvyNHchNse8S9BCRaQCq
         TCy6kW5m7pROisR+HhpEFojMBUEX0koLNPfEtvfyBCISsZ3iAOR/zHb8gf9IsxL+hV3J
         a8/zFieJc9ZVbUfo/ZPYmQCuKrkLoG8ZcKSFTPlEQQfsBIlJU8d7YrTvrl4Ln36NsfTS
         8h5mb/Bi4OJsC+DRHZlOG/PlJvFBzxcY21uF+85avhbrZH+1q8Cm70laFgc++n8wLQhZ
         Mdq2syWPd6DTFoXJg45CuGb4oJkcIzEdwiglnjT4Oo15f6hdAeGyhg0hy5sPlEqkM37o
         bTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WTZmon5RCZKPp5j1dG7L4Dz0Cgc/ulj/Rn94Bmks9rs=;
        fh=FBgesWuv5taG5LgP/mAgmU5o+8GnVB+EqMDMRyA8WLA=;
        b=C/9tcuW34cNpZfiiIrmXJqfeEui9HK6VyqEjbSrEV8ANLel/lf38tVcT8ZijAibXrS
         taE5MlP3itJY29VBCZq/vyCfY0+yoTa4zbyDF+etZBNCXncgeWxbRkDSDbe4LMckjl53
         ZMLAG2Nxx2GXLfs0+i1jB/xXSRv8JCDUDvSM2I2u6DuG5KA6iZVVXP+nmN5HGA1Ga6/R
         haLxXeZgJ3mhY8HaUJBydZ9cronvbm87ywp2ODnN0TOhtfw8TSWtAGd+Y8dm5RY+a9SX
         UsUsd4ZPHfy2I5kxyyTTUsV3G0m6i1osk6EJiKuUH6UULt3/Dc3xS+EWyIOgyPzFexAk
         01Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773082996; x=1773687796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTZmon5RCZKPp5j1dG7L4Dz0Cgc/ulj/Rn94Bmks9rs=;
        b=glCfRu22HKqq9U8LlzgBG7DTTGXtG5PiMsUHe+Vq3dFKBkqEBuXyKmEVUEoUyVHJiv
         IWtsXhTUUb94Wnm4NvPqdPoNeHfpQTOoaB4Piu/bBw0QG6uGkSTbWtwUWGXcvUJ45bks
         63bFUcAOocL/BR5pYpR+u7JVY45FMqEEUtQaCeA0sIwp8XjP+m5ufrU+9e/U4DK94cLE
         B4gDuia5uvR1UQgbLJjVcLzvHYtB70FL4ZT0TOfTFWnfYQZQ/x+z81THFprYKhvAl8MZ
         IBlC+nKd9jJFoe4zi1M5g81W/BWhaltuwQu8GuemwWNuoozUGZm8DSM1DZm5cSEsRo3m
         tWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773082996; x=1773687796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WTZmon5RCZKPp5j1dG7L4Dz0Cgc/ulj/Rn94Bmks9rs=;
        b=sWSeAdapwO1Zb562mB2X922O7ruJvht3KJhgsqJJgolwKnZW6p8eQIWgQ9Hv10OBx3
         A8x9mlXgvbYuz9GrgfUndXBMWolx56ZMHv3l+8f+3qisnh6/Q7lO26x/evNghsmWd38c
         LZYQs6lcXiySl2ZlOu2o5OXzkKyi4H7YCTNS27cUEglGxqS9UWwjHpwwd2n9gW0IjSE0
         LXw8FV6biCJoPywILDZ+oaKvWMM8gCCcbfbM9tLRlWa9dTi5o6zt2h8U47Zvkh/t3axF
         wsqkL1HOYxLOrWLE4NGwBc5UYrUl/TRqnHaC0KbA1VRaCmKSvj53h3Ulw5QXsLT0JSNw
         MLbQ==
X-Gm-Message-State: AOJu0YzJu5/n9pD/YgEa/HfTfD5yJdUsxUcJsSV+EI+Tuyl5/tpeqPoj
	tZBNrgcPV1SeqC4LujpyJs6qvS7qnv4lwg2Im2t/pw33+hcTNRVne7vTYG7omVH1sFt8Y243yne
	VfiROp0DqrJQ2XqWooE35xrV55PsKpX4=
X-Gm-Gg: ATEYQzyYZBrbIQrnA8qnzddtDcVHE0uHHpzU9pD78AIN3z11PrL7hpDhy9vnOo14AZT
	H0PbXHJNx7NjaokFuUd2AO2O/lE4hz/BRvluCFc671skeHB7M9dRKVbHiy6xUjWKSVzXmJ0Gigl
	YKABWsq2kJLSh8cQfUP6ItPHBFBIqn40Ofs2p8dMslTGxMBgMTkFblkJNE7Lo3m76alh/vvT7Cv
	Yee5YdGnFtXvFWgv+HfLnp90NU9zQtTtMy6kINPFv/YpAXVCua6yLy6U71a/MoAPf6G6VYqo60T
	fmpLjR0=
X-Received: by 2002:a05:7022:10a:b0:128:ccb7:7fa3 with SMTP id
 a92af1059eb24-128ccb780c0mr3957056c88.34.1773082995830; Mon, 09 Mar 2026
 12:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308220804.694227-1-idryomov@gmail.com> <5815cbe7cb93857effc0757a765a15ef1a2e4cc9.camel@ibm.com>
In-Reply-To: <5815cbe7cb93857effc0757a765a15ef1a2e4cc9.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 9 Mar 2026 20:03:04 +0100
X-Gm-Features: AaiRm51HL0YRC2r_owJYJvilFlquT04-j0pi8bXswmVcN7m39-iJ4ATdFsp76cQ
Message-ID: <CAOi1vP8-fDD_nQQvbSrqrHzAa-OPqBpNjk3kd53UdqqVzRMR5Q@mail.gmail.com>
Subject: Re: [PATCH] libceph: prevent potential out-of-bounds reads in process_message_header()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>, Alex Markuze <amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 7:49=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
>
> On Sun, 2026-03-08 at 23:08 +0100, Ilya Dryomov wrote:
> > If the message frame is (maliciously) corrupted in a way that the
> > length of the control segment ends up being less than the size of the
> > message header or a different frame is made to look like a message
> > frame, out-of-bounds reads may ensue in process_message_header().
> >
> > Perform an explicit bounds check before decoding the message header.
> >
> > Cc: stable@vger.kernel.org
> > Reported-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> > ---
> >  net/ceph/messenger_v2.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
> > index 5ec3272cd2dd..ed618435d33a 100644
> > --- a/net/ceph/messenger_v2.c
> > +++ b/net/ceph/messenger_v2.c
> > @@ -2833,12 +2833,15 @@ static int process_message_header(struct ceph_c=
onnection *con,
> >                                 void *p, void *end)
> >  {
> >       struct ceph_frame_desc *desc =3D &con->v2.in_desc;
> > -     struct ceph_msg_header2 *hdr2 =3D p;
> > +     struct ceph_msg_header2 *hdr2;
> >       struct ceph_msg_header hdr;
> >       int skip;
> >       int ret;
> >       u64 seq;
> >
> > +     ceph_decode_need(&p, end, sizeof(*hdr2), bad);
> > +     hdr2 =3D p;
> > +
> >       /* verify seq# */
> >       seq =3D le64_to_cpu(hdr2->seq);
> >       if ((s64)seq - (s64)con->in_seq < 1) {
> > @@ -2869,6 +2872,10 @@ static int process_message_header(struct ceph_co=
nnection *con,
> >       WARN_ON(!con->in_msg);
> >       WARN_ON(con->in_msg->con !=3D con);
> >       return 1;
> > +
> > +bad:
> > +     pr_err("failed to decode message header\n");
> > +     return -EINVAL;
> >  }
> >
> >  static int process_message(struct ceph_connection *con)
>
> Mostly, looks good.
>
> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> But, I have one question. As far as I can see, process_message_header() i=
s
> called by __handle_control() [1]. And end pointer is calculated [2]:
>
> void *end =3D p + con->v2.in_desc.fd_lens[0];
>
> But fd_lens has integer data type [3]:
>
> struct ceph_frame_desc {
>         int fd_tag;  /* FRAME_TAG_* */
>         int fd_seg_cnt;
>         int fd_lens[CEPH_FRAME_MAX_SEGMENT_COUNT];  /* logical */
>         int fd_aligns[CEPH_FRAME_MAX_SEGMENT_COUNT];
> };
>
> Is it possible that end pointer will have value is smaller than p pointer=
 value
> because fd_lens value(s) is/are negative?

Hi Slava,

I don't think so.  fd_lens values are checked in decode_preamble() and
the fact that it's a signed integer type is accounted for there.

Thanks,

                Ilya
