Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F173339DBD3
	for <ceph-devel@vger.kernel.org>; Mon, 20 Apr 2026 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776719418; cv=pass; b=Jyx1eTm3fIToD9QuAJvMIR+2p8s1ZIXfWw0dvASTPUhNo6Gm072UdULCw/60CWr5KH0TOBXHf+ZATvPQfhPusLIo8HnYh5AiKwbSxLanOz+pOASHVogvx5wh40fYcw2yQV+71UYLxoEvikIM/5M7kDarY5dvcy2hxVlyPMi2IZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776719418; c=relaxed/simple;
	bh=KGi8qwfITO8KGEqVE1HjpFlI1Z7Qiz0/+Lnqzx4bwKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmotSyz8eivoXmW35ajdH2Gjjh+atkTyJuK2/ljCqa/pqhxNf5xlr9RmhCjKg9/1HFF9DACvfDS13fbo5F48EOXHYpfNXfXw5j0MJMZWIjrSb7+8cJi5tQHGI45UwRUasalFmfNfio0dVpOIMYAh7s2X54/wlaQSesUWe1AGXAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf209aCi; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf209aCi"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12713e56abdso2312217c88.1
        for <ceph-devel@vger.kernel.org>; Mon, 20 Apr 2026 14:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776719416; cv=none;
        d=google.com; s=arc-20240605;
        b=CToeh7/dZawXLIdzoEAwQh0tTdlvmcotllisbBRMg4rItd73zAsOv+81/3scVDrY1+
         p019CP8+ZPadiPtWMX3FeDte9WZygL3S6Tt/YUspRXaUQJ+QwiJxZJEaXA4TO6/Yh6+9
         Po4FPohKFt+cngax7NsGx/4Dr3RbjjHyezrFhruhVTreHrjZ4Jbid13di5i0kBxq50qK
         ihzND9PpdtBVrIQwFLSyxH5e7se3xwKrgOrg/TMTpxfYZbPH7D5EZ75D1REEd/1j/V4H
         Tcl/CC8WQ3IeGuhTH5OphNwrKPqQsKb97qUYfG4SyssLSUG4Dje0PVi/Y7zP2kbgxW2G
         bktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eeRJ46ZCFQw+/2BgWLsLfxIGW8IGkJirlSdjexBO+J8=;
        fh=ujeYQ2GZCQ/OpGnB8O+F/T2OE7o+Jx2cMEW4T00CP+s=;
        b=NTiTeavzx04SsWkpeaW/BVOjDkfmPenAIAe+pHb4XNOBSFIGiGcjGA2Jbt6225wRxm
         f6JcWN5TI1xjAxdFM4xgVf0TTUtZ7JhaeDGUkSH/FjYQrWW7DqWk4Wr2RF/6Ggd6sQ4N
         kvyAIR30ExC95LuDAt2n166wKdHldQFFaXr2xHSCJpFJ5MOjNY1MzOgD1ynxRp6vwwss
         XA7ckzb7xyHeO3/xcrXAJ84W75E++17bZbXIkOaFcavS8MJffE2rLR5B1pjAQJexnycv
         ortmvJ3M2EkZHY9WjD2NeQ+lZhF3CR1qIWohCS0xFpSq8cLjChxjyNtxzp72GpN3fjRd
         MbIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776719416; x=1777324216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeRJ46ZCFQw+/2BgWLsLfxIGW8IGkJirlSdjexBO+J8=;
        b=gf209aCioJm5wg9gSWQYScrh0QRauWlSoy3+ak2WkjDZkbeFAg1ypK8ujv/qXKFZtI
         GuAuA4OYeTvfrIckhaQvrZpvDGF9NW3vDg+ebBu1L/0WbJsNpeCWFbSjJg+VCuDjjLa7
         3WYrqDrqMcLPoWzObmEvqeCQSLLqGvTuqxUw7OD678E0A0gBEEOzdtbs0jUJuHaSYIVm
         bvdlWhfs+NFUeNY9g5e10aQQgbAnnp+/j3MQ/xplqDwtM+UhzuRL2GmM31LMEgUKQJ2V
         puawXR+YEScUG6bIKBZ2rEwwAmpa2BpsX9dCmAtWaSncKsk9rQp2bzm7W5MsLm3lHlgs
         HNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776719416; x=1777324216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eeRJ46ZCFQw+/2BgWLsLfxIGW8IGkJirlSdjexBO+J8=;
        b=WG7In8jHHr5QaD5qjPlfSLZIeoqQCt/ZF3tkPOqHPb3QH9BcZ6hz8eHlpqhoYKfvIb
         I9DR6ZeN/YgCcTYqQrHTYYcTR+HOSSQYBEenzEGswICjJjSarJV9/YlY41sc6JeeISeN
         jt8Zu57dl5seksdv/yNTkXNAQotPvStSxZfYpE11skGGzV547ruHgoo7zhZgrSiT6tCr
         xnX8iEVTxtiMxGg3Obb8UARz21yVv5K/01MiSye6khTBlQfNwwA4snnPfOqAIN9a06Bn
         UJ0ANCLCl5VAt+F5u/eKB27yt+uZ5aNqXVh6Ih5zmW8goMvJX/+kSbx8tcEL16dubTPy
         jpQw==
X-Forwarded-Encrypted: i=1; AFNElJ+pbgDRqw53G0eb1YR+C8OpFK6ks3UzTXvgUpa80hzvpr9md4ZN2o59PmuVcKwM0xG5oyJTCwsfJ3Tu@vger.kernel.org
X-Gm-Message-State: AOJu0YxIPEnUPaXC7YWRXa21i/Bw2NY+JH5bU91Az6B1FomDjTq/50oP
	Ets+V3Cp8Byo/TAqf8wEoMR5iLRJujx0ICHoqCvaCd+4bVqLXwtQSyqgFERe2aSL3j03i/1NZFM
	vGAfzbUhHC9UvmaaCH0DmFFTshZFvSYy1znyV
X-Gm-Gg: AeBDieu3sP5q8w9C6Aj3l7gM9MrvweP7tN8bxhaqWYTk+bPPFUrYgBRscjYigqVj5l0
	BQshZzUdO7UtUqpUzotVE+242OqpvB3yz3Paxn3DIk2T/ddNen6XQeO7L15xpGfk8n/XL1R56Qw
	QiOmscuj/hi5yyXVdUQou4GM2eaYxpAiLCrmVHx0fqs/tF4BDQIw7LKuya5EjGvR0CNfnVU7aO4
	KCGhXbWaDyqbB0eBslzfrK3/9gBgu+NE198TBEqcLrKI79/arfN4div0MUhGH9aQjqkQouycK4r
	szA2FfIVYZzCqkU8/g==
X-Received: by 2002:a05:7022:fa2:b0:129:1d25:f1da with SMTP id
 a92af1059eb24-12c73ae91a5mr7210673c88.3.1776719415953; Mon, 20 Apr 2026
 14:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4f9fdcde-f5a8-43a8-9580-6ec3402c4185@tu-ilmenau.de>
 <20260320094154.1158656-1-raphael.zimmer@tu-ilmenau.de> <0959410fbce95fb8f5ac25de6c751421834ae923.camel@ibm.com>
 <395ea4e1-f83c-472a-b336-fba24368e5ce@tu-ilmenau.de> <9afcc984548bfb418f3fbab64dd98f5e14ed63c0.camel@ibm.com>
 <ec4a8bda-ca80-410f-8b97-413cf64d7f39@tu-ilmenau.de>
In-Reply-To: <ec4a8bda-ca80-410f-8b97-413cf64d7f39@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 20 Apr 2026 23:10:04 +0200
X-Gm-Features: AQROBzD2G4qrz99GmjS7T6zDG7iTtvnCJmMarcrxAq-h2saITMleLThfNmMSVvg
Message-ID: <CAOi1vP9TMrvTXj4W4Ve2K6BmWJDYo28mu40-h7iZCZo3b7hECg@mail.gmail.com>
Subject: Re: [PATCH] libceph: Fix slab-out-of-bounds access in auth message processing
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Alex Markuze <amarkuze@redhat.com>, 
	"security@kernel.org" <security@kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 5:45=E2=80=AFPM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> On 23.03.26 7:59 PM, Viacheslav Dubeyko wrote:
> > On Mon, 2026-03-23 at 12:39 +0100, Raphael Zimmer wrote:
> >> On 3/20/26 7:28 PM, Viacheslav Dubeyko wrote:
> >>> cc: ceph-devel@vger.kernel.org
> >>>
> >>> On Fri, 2026-03-20 at 10:41 +0100, Raphael Zimmer wrote:
> >>>> If a (potentially corrupted) message of type CEPH_MSG_AUTH_REPLY
> >>>> contains a positive value in its result field, it is treated as an
> >>>> error code by ceph_handle_auth_reply() and returned to
> >>>> handle_auth_reply(). Thereafter, an attempt is made to send the
> >>>> preallocated message of type CEPH_MSG_AUTH, where the returned value=
 is
> >>>> interpreted as the size of the front segment to send. If the result
> >>>> value in the message is greater than the size of the memory buffer
> >>>> allocated for the front segment, an out-of-bounds access occurs, and
> >>>> the content of the memory region beyond this buffer is sent out.
> >>>>
> >>>> This patch fixes the issue by first adding a check that catches a
> >>>> positive value in the result field of the message and treats it as
> >>>> invalid, and second comparing the len parameter of
> >>>> __send_prepared_auth_request to front_alloc_len to prevent sending t=
he
> >>>> message if it exceeds the bounds of the allocation.
> >>>>
> >>>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> >>>> ---
> >>>>   net/ceph/auth.c       | 5 +++++
> >>>>   net/ceph/mon_client.c | 5 +++++
> >>>>   2 files changed, 10 insertions(+)
> >>>>
> >>>> diff --git a/net/ceph/auth.c b/net/ceph/auth.c
> >>>> index 3314705e5914..555b1fab4623 100644
> >>>> --- a/net/ceph/auth.c
> >>>> +++ b/net/ceph/auth.c
> >>>> @@ -215,6 +215,11 @@ int ceph_handle_auth_reply(struct ceph_auth_cli=
ent *ac,
> >>>>    ceph_decode_need(&p, end, sizeof(u32) * 3 + sizeof(u64), bad);
> >>>>    protocol =3D ceph_decode_32(&p);
> >>>>    result =3D ceph_decode_32(&p);
> >>>> +  if (result > 0) {
> >>>
> >>> Frankly speaking, it's hard to follow how this is correct without pro=
tocol
> >>> knowledge. Do we have any declarations of result possible values? Pro=
bably, we
> >>> need to have some comment that explain the situation in more details =
here?
> >>>
> >>
> >> Yes, it would be good to have an exact protocol specification. From wh=
at
> >> I can see in the code, the result value is either 0 for success or a
> >> negative Linux error code. Therefore, a positive value here would alwa=
ys
> >> indicate a malformed message. But maybe you know more?
> >
> > I would like to hear what Ilya can share here. :) He should know more. =
The
> > result > 0 looks not obvious to me. This is why I believe that, at mini=
mum, some
> > comments should make the code more easier to follow.
> >
>
> Hi,
> is there any update on this by now? Did you hear anything from Ilya?
> I don't think that it's good to have this disclosed but not fixed for a
> long time.

Hi Raphael,

I'd actually suggest treating result > 0 the same as result =3D=3D 0 for
consistency with CephxClientHandler::handle_response() in userspace.
I think this would mean adjusting

    if (result) {
            pr_err("auth protocol '%s' mauth authentication failed: %d\n",
                   ceph_auth_proto_name(ac->protocol), result);

to

    if (result < 0) {
            pr_err("auth protocol '%s' mauth authentication failed: %d\n",
                   ceph_auth_proto_name(ac->protocol), result);

instead of adding a new check.

For the __send_prepared_auth_request() bit, I'd go with a BUG_ON
because all "legit" callers should respect monc->m_auth->front_alloc_len
when composing the auth request buffer.  The only way to get there with
len > monc->m_auth->front_alloc_len should be a memory corruption or an
unsanitized input issue of the kind of that you have discovered and
there is no point in trying to sweep it under the rug at that point.

Thanks,

                Ilya

>
> Best regards,
> Raphael
>
> >>
> >>>> +          pr_err("unexpected result code in auth msg\n");
> >>>> +          ret =3D -EINVAL;
> >>>> +          goto out;
> >>>
> >>> Maybe, do you need jump to bad?
> >>>
> >>
> >> No, Ilya recently mentioned that this is intended for classic decoding
> >> errors. Here, a more specific error message should be emitted.
> >
> > OK.
> >
> >>
> >>>> +  }
> >>>>    global_id =3D ceph_decode_64(&p);
> >>>>    payload_len =3D ceph_decode_32(&p);
> >>>>    ceph_decode_need(&p, end, payload_len, bad);
> >>>> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> >>>> index d5080530ce0c..7206db5f7695 100644
> >>>> --- a/net/ceph/mon_client.c
> >>>> +++ b/net/ceph/mon_client.c
> >>>> @@ -174,6 +174,11 @@ int ceph_monmap_contains(struct ceph_monmap *m,=
 struct ceph_entity_addr *addr)
> >>>>    */
> >>>>   static void __send_prepared_auth_request(struct ceph_mon_client *m=
onc, int len)
> >>>>   {
> >>>> +  if (len > monc->m_auth->front_alloc_len) {
> >>>> +          pr_err("sending auth request failed, because len: %d exce=
eds allocation size: %d\n",
> >>>> +                  len, monc->m_auth->front_alloc_len);
> >>>
> >>> Is it proper place for this check? It looks like we fail to send some=
thing and
> >>> execution flow has no idea that we failed. Yes, system log will recei=
ve the
> >>> error message but the rest of the logic will continue business as usu=
al. Maybe,
> >>> you are right but is it not to late to simply complain here?
> >>>
> >>> And if we don't send the request, then could it affect the whole func=
tionality?
> >>> Could we introduce a race condition or deadlock here?
> >>>
> >>> Thanks,
> >>> Slava.
> >>>
> >>
> >> This check should never be true. It is just a common place where a
> >> severe data leakage can be prevented if anything went wrong before,
> >> because m_auth->front.iov_len is modified there. This would prevent
> >> another bug like this if the logic before was flawed. To fix the curre=
nt
> >> vulnerability, it is not absolutely necessary to have this.
> >>
> >> Maybe an assertion like a BUG_ON is also fine here. Otherwise, the
> >> handling of this function would most likely have to be changed at
> >> multiple places.
> >
> > Maybe, BUG_ON() looks like more proper solution if we should not be her=
e for
> > such case.
> >
> > Thanks,
> > Slava.
> >
>
