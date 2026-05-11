Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201344BCAC5
	for <ceph-devel@vger.kernel.org>; Mon, 11 May 2026 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527508; cv=pass; b=gF6ihfm71Mr55mpgUfp09MDt1mwRpDzbY7paPvdstnTMhTGZgEzAJUzN9rlyeihbOIMyUg91zodpohk9Qvrj+IUDb39LjsKwbcl3+qh2RlwmQjvJplEz9g7LS/k8Osv51mp1+Mntblm6O7iXMtJFMCVZUzx86hdyJ9j/RWiJcpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527508; c=relaxed/simple;
	bh=9sSB0EhUTvB5hKyC+ZuneNBhgYBd07nq4IenzQHFI7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VddnF6sqHnwGvIy7SL6fEv8bVbnLzqfSRU84xg0Gc/xTKRUJMsju7T6eUW1As8DpMHQeg4BqCK9Scii0MbsHR4Iwfc26waobAY35Z+N2S/ZIVgJY90F4pvZik+D1NNgEoZmBhgcUXAxkOUi5kkUouTP6Xmb6Cz/YXlbGdTMF4Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e70e7bUW; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e70e7bUW"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-95cc96eac66so2686017241.1
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2026 12:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778527506; cv=none;
        d=google.com; s=arc-20240605;
        b=QApn4kFdbNqIJ/lWMQKMzDdyGuKcMS8HGMTDjSvxaGhDqPoe9BGCVjzCdOFtaknsxC
         QrV6KckY3VNf/BLTCqVGt0oz1EvhKp5hqikkNJBfeVhnreYkBNjJEQK5axSd+z6zzb/9
         zZChmw6A2NhVp2C141DoxVKqA397N2TdClhWka3Lxmp52oi8ZnTC/c62TN17LgPJktEM
         FBU057dGvkvQ0gY8xZpB5qBw46fYmweBfCO8apOuf5U/4cMUBySXNNFgpEf9u/yorQxS
         Mq7fUOr++nhtMv4vr6Xa0psHL/Ks/PuOeksJSUJl9uTl9zvnskl2PD+D+c3YgVO5Ci+t
         4ECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H9OpB4btLSAX3CQpfr7KavcQq5hB7ARZxfh5AJxtYZA=;
        fh=jKxsyudKbFf4WNGVW9S+e2YQGMtlqTDcrVVI0/Dx83Q=;
        b=bJzsgdOOkBVNiu/xzP2NGZej3z8rhQopBj3Bk844yIDxYdA1ccj4sdSfnetJwykpHJ
         qPB0n0AVD0VIfTEushmjMEeYGoquT4v1IGGRZNrx55BO8QJ0Bf6LUqCBBtAPQ6iUMHTd
         TLS/+xZP4MEum5RyI9Q/AdJ+ijOCRmhK7TirxKKsAF2gA3/7uz0T3tdAsY1Vi1JUWMCH
         QtkyG7gBKV70WBYYMwnXAwPpr6ruRwZlJRdz3s3z1q25bn70dSgdcYtKZrL1bNu0QHfU
         ZYixrI8GDfDljJ3aQktFDhhjRPuWKSZxAVVbHiUzBlOMCQvNbeF9FXU3wpFGD+4eG9Tu
         NkHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778527506; x=1779132306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9OpB4btLSAX3CQpfr7KavcQq5hB7ARZxfh5AJxtYZA=;
        b=e70e7bUWTHWBB1bzcL+dYuB4JHCYCFHR24JCOr+Ct9e1LC7kjG84P76A32sCCA1h/K
         NyT3UHTQIyXqjjP0uALUc1gGKdqKAVXyqqXplCXicrnvj+Jjp7ET0hRH53M9GbWzdHoI
         RQkzJ0I7dYtlTGErS/KMZQte1IcaLox7E3f8DyOI/N1HOmQnjpqOgiRB6lMa9cqZuNIJ
         EuSWUNAGu8DvHIxDN4w4XKHeKcTr6pj9k9IggUmPwhC11dlYxLpRdaq0xDnM6yqF0S93
         +YNbSCC25cuyApdrNxc43L1yydS1cmgozJVYJSA5806AEz76toJkkufWff8oEhnYsnzU
         Hfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778527506; x=1779132306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H9OpB4btLSAX3CQpfr7KavcQq5hB7ARZxfh5AJxtYZA=;
        b=N2FcnBPxNxVVv8Ydnia+G37dx1ur0rEHdgvjGr1dQOK3wY1dN0h4lzmAyVKkiTeL/m
         8fbMzffqtjMOQJQHBOPIm5yVXVsH23rXduiSb/AVc8+18tH1e+hVyn+/o7ZcrWflTjEy
         VAq3IDyljfzM4gc9litsWH3kU2eeXCBNxEvXKQqn+62r+picJDbuJsEvhofgZU/M5aC9
         ZoxjqY8a9c4n4pO+R10daVdtJLGkf6kOIy0D1xOl2nK8LzhBYNSSg9Mou9U2GvCEZAMX
         Tj2SiQRLKI2XVfKAJ2HV+tbbex10ri5/sn4Y/QneZez1IqzzElWv2q9T+UShjL0e/T6S
         pSHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/fREJSNknvnyC+mjtqQYCjAlK2BkGYtF+5PLYXB+4s/gLBlUYNxiB1z4CXj2yGdEC+au1RCqjKM8P@vger.kernel.org
X-Gm-Message-State: AOJu0YyXAQ7oTR6GIIA89WaAM8DuQxzLanShr+mFg8uEhRF3ugwjIEoW
	9O1ze+KrHXe533VXDPMCZUH2G3YJ/6Dio36trvyWH/slVDD5WKJMDIaEJAUcE8q2Pwwh5kOe7nK
	vKzaiRnoorw648BJzz7WNb76K/CmPyrM=
X-Gm-Gg: Acq92OF/nz6YModsZ0NGSU+g8Fph0sOU57DBFsXWgej3P5uMAgY+rwC7Ex97uKulaA0
	oUf6JdxXYZ2cKeVpKCAX8oz4cJ3l/G4gorORqZNOqb+r9I3H2cGo+6RgodUtzJk5d6OIMAz3lCY
	jr7oW4Ikpa4Rf7BGsDxrFOLGDV3XTNZtEs5Hdr3udrBuCjb5mP7ZeVpBzOG1D80IQdgEkAU26OD
	3mtpgsi3r6U+ewswo08yzhoAqbJrrHxeE5lSRkVK5U+adbMzofZ1WBZ8lSMgaR1xI1hEXkS8Pod
	ELXvSRrnsf/4ZWlQVg==
X-Received: by 2002:a67:e109:0:b0:632:a084:c0f7 with SMTP id
 ada2fe7eead31-632a084c749mr4264181137.17.1778527505898; Mon, 11 May 2026
 12:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505090812.500588-1-raphael.zimmer@tu-ilmenau.de>
 <ba35c81180e74517613e3dad41e5f5a938be4137.camel@ibm.com> <ce329dd4-54b7-4bbd-ac9c-7ea18488e0e8@tu-ilmenau.de>
 <5e0fa20df4322f6facc80dc6270a59b0361de410.camel@ibm.com> <973d160a-2f8f-4afb-ac4d-233aa68c3994@tu-ilmenau.de>
In-Reply-To: <973d160a-2f8f-4afb-ac4d-233aa68c3994@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 11 May 2026 21:24:54 +0200
X-Gm-Features: AVHnY4JOqEkbL2SZ48geYIdvtFNUnxvIObSJeaJfL3O29FfhHuBGR3e-Xxx69LY
Message-ID: <CAOi1vP_V2s2181+nAbHM8_Eq7PYC7WwYHFs2v-N59e4HFz2Scg@mail.gmail.com>
Subject: Re: [PATCH] libceph: Fix potential out-of-bounds access in osdmap_decode()
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Alex Markuze <amarkuze@redhat.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 2:32=E2=80=AFPM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> On 06.05.26 8:14 PM, Viacheslav Dubeyko wrote:
> > On Wed, 2026-05-06 at 15:04 +0200, Raphael Zimmer wrote:
> >> On 05.05.26 8:55 PM, Viacheslav Dubeyko wrote:
> >>> On Tue, 2026-05-05 at 11:08 +0200, Raphael Zimmer wrote:
> >>>> When decoding osd_state and osd_weight from an incoming osdmap in
> >>>> osdmap_decode(), both are decoded for each osd, i.e., map->max_osd
> >>>> times. The ceph_decode_need() check only accounts for
> >>>> sizeof(*map->osd_weight) once. This can potentially result in an
> >>>> out-of-bounds memory access if the incoming message is corrupted suc=
h
> >>>> that the max_osd value exceeds the actual content of the osdmap mess=
age.
> >>>>
> >>>> This patch fixes the issue by changing the corresponding part in the
> >>>> ceph_decode_need() check to account for
> >>>> map->max_osd*sizeof(*map->osd_weight).
> >>>>
> >>>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> >>>> ---
> >>>>  net/ceph/osdmap.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> >>>> index 669348d883f0..2095e73ccf6c 100644
> >>>> --- a/net/ceph/osdmap.c
> >>>> +++ b/net/ceph/osdmap.c
> >>>> @@ -1705,7 +1705,7 @@ static int osdmap_decode(void **p, void *end, =
bool msgr2,
> >>>>    ceph_decode_need(p, end, 3*sizeof(u32) +
> >>>>                     map->max_osd*(struct_v >=3D 5 ? sizeof(u32) :
> >>>>                                                   sizeof(u8)) +
> >>>> -                                 sizeof(*map->osd_weight), e_inval)=
;
> >>>> +                   map->max_osd*sizeof(*map->osd_weight), e_inval);
> >>>
> >>> It's too complicated computation for one string, from my point of vie=
w. I think
> >>> we need to introduce a static inline function which will include this
> >>> computation. Also, 3*sizeof(u32) looks very bad for my taste. We need=
 to have
> >>> some named constant here.
> >>>
> >>> Thanks,
> >>> Slava.
> >>>
> >>
> >> Hi Slava,
> >> for what exactly do you want to introduce a static inline function? Ju=
st
> >> for this computation?
> >
> > Yes. Why not? This is computation that has some meaning. And it can be
> > represented by function with name that could make the code more clean a=
nd
> > understandable, from my point of view.
> >
> >> The computation inside the call to ceph_decode_need() is done at many
> >> places. The 3*sizeof(u32) is a common pattern in the code, although it=
's
> >> not used consistently. Sometimes plain numbers are used. I don't follo=
w
> >> how you want to introduce a named constant. It means we need enough
> >> buffer space for three 32-bit values. In my opinion, creating a consta=
nt
> >> for "size of three 32-bit values" wouldn't make it more readable.
> >
> > What this 3 means? Why do we use exactly 3 here? Who can understand it?=
 From my
> > point of view, it is really bad practice of hardcoding some constant in=
 the
> > code. This constant has some meaning and this is why I see the point to=
 express
> > this meaning in the named constant. Even if this pattern is used multip=
le times,
> > then it doesn't mean that it's good practice. But, of course, you can b=
e not
> > agree with me. :)
> >
> >
> > Thanks,
> > Slava.
>
> I try to explain it with more context.
> First of all, I haven't written the code or designed these patterns. I
> can only share my impression based on looking at the code.
> In the libceph code, the common pattern when handling messages is to use
> the ceph_decode_{8,16,32,64} functions to decode a value from an
> incoming buffer and simultaneously advance the pointer to this buffer.
> This function does not include any bounds checks. Therefore, the
> ceph_decode_need() macro exists, which can be used to check whether
> there is enough space between the current pointer and the end of the
> buffer (or relevant part of the buffer) for decoding some values.
> Additionally, ceph_decode_{8,16,32,64}_safe() macros exist that already
> include these checks. For decoding single values, often these safe
> versions are used in the code. If multiple calls to decode happen in a
> row, the common pattern is to first call ceph_decode_need() with the sum
> of the sizes of all following ceph_decode operations and then simply use
> ceph_decode_{8,16,32,64}, so that the bounds check is only performed once=
.
>
> Now, looking at the check affected by this patch. It performs a bounds
> check for all subsequent calls to ceph_decode_{8,16,32,64} that happen
> directly inside osdmap_decode() before the next call to a different
> function. These are three single ceph_decode_32() calls and two calls
> that occur inside a for-loop, which has map->max_osd iterations in both
> cases.
> This is the meaning of this computation. If we move it into a static
> inline function, that would move it further away from the actual
> ceph_decode calls, possibly making it even harder to spot such small
> mistakes as the one fixed by this patch, in case the control flow is
> ever changed again. Furthermore, I can't think of a good name that would
> describe this computation here.
> The current bug was introduced in this commit: [1], when a pair of
> parentheses was removed. I decided not to use these parentheses again,
> but add an explicit multiplication with map->max_osd, because I find it
> easier to follow and closer to the control flow with two independent
> for-loops. The comment above seems to explain the part of the osd_map
> that the ceph_decode_need() accounts for. But it appears to be outdated
> since the mentioned commit. I could update it in a v2 of this patch and
> move the last part to a new comment at the correct position.
>
> Second, the 3*sizeof(u32) originates from the three single calls to
> ceph_decode_32(). I don't see any different meaning in it that would
> allow using a named constant with an explanatory name for it.
> However, as I mentioned, I haven't written the code, and maybe there is
> something about it that I missed. In this case, I would need more
> information and a suggestion on how we could refactor/rename it.
>
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Ddcbc919a5dc8c2629684a113a90c0b6fe10c3462
>

Hi Raphael,

The context here appears spot on to me!  I'm not sure it's worth
touching the comment since osd_addrs->client_addr array decoding is
split between that combined ceph_decode_need() and the loop that calls
either ceph_decode_entity_addrvec() or ceph_decode_entity_addr().  The
way (and where) it is, it actually captures the 3*sizeof(u32) bit.

Thanks,

                Ilya
