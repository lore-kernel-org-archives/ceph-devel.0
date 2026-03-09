Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC17363086
	for <ceph-devel@vger.kernel.org>; Mon,  9 Mar 2026 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773087058; cv=pass; b=c5Z4VWWS5gtByzhO1bJAlXz+Q5pQ1FnVBkyFRHP6E03UQqw3NF1MpCrSZK8HVXCNqc0g1dhvLzqMUk1yhWBBAcDH5xpsb9iI5loIrVM8xjBUC0RGKReYGw+me2Qzzr/uHKxfu6uUxG3VqKHjNkPWevtHNFXWvwyzdpSSwTzC/Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773087058; c=relaxed/simple;
	bh=qfMj7z94Kb7iAuW32fAjjC6m+Xh1xFvLipd0vX2A/cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbpJnLLYpZSDIK+HCqhxMXKwbJn42orWaEoih+dASID4Js9gf3DXMNSDzYfV8ZHkU6PA0xUrU5WgdffEb/5usUmYvPnQSu62DsCOoLHAo2sD01EUGFUI29ke0FkhWPUMxDhXMIjXlFcRoxc13ddleNJ2QN9nb37HFOYmcO5N3v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AROyS9EB; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AROyS9EB"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1279eced0b9so11562688c88.0
        for <ceph-devel@vger.kernel.org>; Mon, 09 Mar 2026 13:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773087055; cv=none;
        d=google.com; s=arc-20240605;
        b=DQk0JUvlxMAlBen0Oxr3jUp00n/OPPG67eQxaCJzPKjN6dQUNxAGX+RXZqTF12JBCt
         ou6LEa5diXd2THrnM0lWrpxMYeaqmxNaoauZ9NJrmgRwu7TzOctJeJJuD183xMEBzogo
         rkh9EYQS/jCbIdrBYkd0AoQnaQGTmeWDssiDz7PiUI3+uuH2FqYZyNjLOVQw0O4Z24ct
         AHQ1ZSkIxqexEr/uQW/w14GqPOXk8XkJbxdeAz8VHXJWO3gLNbeU8N7NmLaPJF0BLQMa
         uIFN3fDv2RIrRlVxOgyRZ9LezrWU78PlVOaoYrYus+A7rr4VtBwY/pqgZFmGevWC5Pru
         wuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1twALPDtJkvFnbmJCIEJBYS4odQuPZso6658ISIzF+M=;
        fh=FBgesWuv5taG5LgP/mAgmU5o+8GnVB+EqMDMRyA8WLA=;
        b=Pg960d6CwHgjs++fZZteD/RG3CIVOFTEKkxItvH4U11L8MR1t48npRgcR2rwAIz8h9
         3/XebNd1VG145aVMLUe7aUkXbKO1kd5GXMecYLpF4esERWtFj/tmPoSSYTqLAE2M0Hu0
         D4D9/O/5Qd2e/L1DU1mPvDciz7ojjDPvlwLPD9SkXygr3ytNskL9s3mpDUaFmhNytjoE
         F3SvXrnRg9Z1h6SujwT6bJ4X1scwyIn/YryrSmJ8YZo+z0YC7ucqWPxU51h2iMFLZSyB
         z/QiNWcWLOdU/Cki0IZi1aCawYamel+rHg9NbFaw2z4AUQ2FR//T4JtLdVoL/DvSe9U9
         QVrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773087055; x=1773691855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1twALPDtJkvFnbmJCIEJBYS4odQuPZso6658ISIzF+M=;
        b=AROyS9EBOpQ7sQuY4WVCPGWB98ug60imq2soVQljEVolPgDCXKm32BRltfRWYL+O/A
         CAEY9haV7iGTXo81i2vYSrtgpvSch5w0/U9WSer9ILeghOqZxTHZzInpUtWwUfujNp0p
         IDDm2rXkaWXTOlcw5EbVj0dBpWh8m38kyOB24DqAohbZZKdr1DpkISMvf/wLvfbzt2Fi
         MKyb7hMo3jcx2gms+ZNImoW6cGnrIWa1K0troH038z2XSLNWTglY7kIYaH9j4lZPEoRz
         +E6fQPrTxFcCxYbSukMYXShwwU3gCVsMigmkhSqFHTFu/COup7ajs4MgnrE1zN2f8XmX
         3u1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773087055; x=1773691855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1twALPDtJkvFnbmJCIEJBYS4odQuPZso6658ISIzF+M=;
        b=BoptfY2gGY7rBxYlwthKvhr/VAMrMAFAZNO8VpsKafkaafkXJoNYATdBdYX3iKspj+
         Ij+QpHc0PhiIMjxcI4ey9eIpFYj4biBMaqxpXuBn2HGyqn5MZkN40kzq0An5n/OuzHIp
         Ib8E/X+n2d1/TUmFpHnXvCHO4dO2HgWaaDzo0V46rWZ2ZrdQyOedFwaJhYlVsxo4H7QL
         SJLVlqPxhzbEypLfhpmX0Klla58GlZwZ9eQHOOmxcWEcipOQj2MY64SKXDpLZRBzCwy4
         0spo7xNw1//fRaiJaZ0H4HdMzSbvbrdsubLc+7M1i6wF/sIO6z7kiBTA43fF97+jE49O
         AVnA==
X-Gm-Message-State: AOJu0YxYRL1FkYYCxJnjl6ECVKTjinWskMfDPzFC+vrqRHcQa0HgivLK
	cpIikLVtTyCIHlP0eVVOy8U1lxnb/pqdprCzH+0P1vnOAszROz/BrXKAnz3wspxOaISFsJ/L1eA
	glW3o26RUYf2rZoa6UcRa/37WNiIrtro=
X-Gm-Gg: ATEYQzwmUg1AH/kywq9TXt2bGIMci9771nPLIHEC8amv+HzSnhsWoY/LwHUo3i/k/5l
	jl+1fil+Y3hdtQljuTeyhwIDvsGUeaNdQTnvCULlvIVoh1zExgmuswJZtUpRQUkZHvWN6rQCZ11
	em97V6Q5hOrwFfqdlC9cZd9TAHI4wDZy25qD2bpTf1xVm0FJ23fQHawHy1DAntXL9DGCji7f7x9
	jef9Huh1YoneQGj/8d2SE+n/sbpjfGdsu9Kit97MxwZjI08fjK1FVL8ikorlgadHagI09k/NLjR
	Nb8QAHk=
X-Received: by 2002:a05:7022:4191:b0:128:cf5c:535a with SMTP id
 a92af1059eb24-128cf5c575amr4095367c88.11.1773087054926; Mon, 09 Mar 2026
 13:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308220942.694505-1-idryomov@gmail.com> <3a512051f8108770e4eb79c486ec5692fe894bb5.camel@ibm.com>
In-Reply-To: <3a512051f8108770e4eb79c486ec5692fe894bb5.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 9 Mar 2026 21:10:43 +0100
X-Gm-Features: AaiRm53qbHg2uzN3gx1cwfP49cFosCstzV01DZr-2ohDtFjBsed7r6fQzsgfAH4
Message-ID: <CAOi1vP8YxxP1NJdY1yNP=Py+h77PRqGnXbCgf=bk7RnrkEWikQ@mail.gmail.com>
Subject: Re: [PATCH] libceph: admit message frames only in CEPH_CON_S_OPEN state
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>, Alex Markuze <amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:07=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
>
> On Sun, 2026-03-08 at 23:09 +0100, Ilya Dryomov wrote:
> > Similar checks are performed for all control frames, but an early check
> > for message frames was missing.  process_message() is already set up to
> > terminate the loop in case the state changes while con->ops->dispatch()
> > handler is being executed.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> > ---
> >  net/ceph/messenger_v2.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
> > index ed618435d33a..c4ddf7911f7d 100644
> > --- a/net/ceph/messenger_v2.c
> > +++ b/net/ceph/messenger_v2.c
> > @@ -2905,6 +2905,11 @@ static int __handle_control(struct ceph_connecti=
on *con, void *p)
> >       if (con->v2.in_desc.fd_tag !=3D FRAME_TAG_MESSAGE)
> >               return process_control(con, p, end);
> >
> > +     if (con->state !=3D CEPH_CON_S_OPEN) {
> > +             con->error_msg =3D "protocol error, unexpected message";
> > +             return -EINVAL;
> > +     }
> > +
> >       ret =3D process_message_header(con, p, end);
> >       if (ret < 0)
> >               return ret;
>
> I am slightly worried about this place [1]:
>
>         if (con->state =3D=3D CEPH_CON_S_V2_AUTH) {
>                 buf =3D alloc_conn_buf(con, ctrl_len);
>                 if (!buf)
>                         return -ENOMEM;
>
>                 memcpy(buf, con->v2.in_kvecs[0].iov_base, ctrl_len);
>                 return __handle_control(con, buf);
>         }
>
> It looks like we always return -EINVAL here because con->state =3D=3D
> CEPH_CON_S_V2_AUTH. Am I missing something here?

__handle_control() can be called in a few different states (i.e. under
a few different con->state values), including CEPH_CON_S_V2_AUTH.  When
__handle_control() is called from the above branch, it's expected to be
for a control frame.  This patch makes __handle_control() insist on
CEPH_CON_S_OPEN only for message frames (FRAME_TAG_MESSAGE) so it won't
always fail with EINVAL here.

Thanks,

                Ilya
