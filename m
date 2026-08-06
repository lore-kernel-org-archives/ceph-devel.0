Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EEB331EA6
	for <ceph-devel@vger.kernel.org>; Thu,  6 Aug 2026 04:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785989650; cv=pass; b=AfeE0/TmbVdGKHUkVXTzKWHjxSFYXdWULwUb9oheuednwbsj8LapSupZxd5q9tRHmQNGN8SQWJorNZWfLAHpc5taJV5oF2I/GmzP7N3ROJdRwiD1zs2wIsVyZYemE/D7o31AwsvjXUk4VCYlMEn2P2zkt23zf3bteoq5kCRrvco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785989650; c=relaxed/simple;
	bh=4KoVuR0FKjAyLw7oSaskp9kADRaZC5JRQSJuYyXXc3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnTN3xc3ZZYn4ms9wlVcLLH8aI1mDD8bskJ7hf5FEUHwY+6selzrrrA6FeuraAXf33sY1oY40Fz1IKxrPwx2Xd3SLTiPUZNxg8VL7/Nw9Mrqhnxebq5YkP/ib3A6rssNOSLrwkVtPEOrzHGijXXMLIpsFdsG08K3EffIPa23d2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUaceTPl; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUaceTPl"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52b4e988c77so10757421cf.3
        for <ceph-devel@vger.kernel.org>; Wed, 05 Aug 2026 21:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785989647; cv=none;
        d=google.com; s=arc-20260327;
        b=DPK9/1JEVbDkcxxfYSvSW69gXDoMj6QEYDciKLfqrt6mkkyHfv9lunnVhoYoAYOaYR
         RN7AMxfWYnfkLd2m9ACpCMZydA4DiSpibAqtgEXMMQVKlddSB/jlK0+539xd0oSp1YNH
         2ytO4Q2G+1EV6bEIJjTHEfT7KnqeVqZqOpi4qOf2FPht10iVP1eLAP1mOIrcNWlrW3Dy
         YzM1s3FGLEXKf5Ovo9TxjmqNLgne3eY+A2Wj8I2MjuKMvfhO2VtsjHA3YclpddZGssbO
         sHruZ3rTSB8irmB5XowqudbGaBrqU0bLWRhuyWx28QaGAOkI8qpplAzBnIwtafvZKXJu
         Zywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WZgGCxVJNCXz/4TMW05GJb1jnv5l9aLW1tckHMAdNM4=;
        fh=Tqm9KnGJUkZXoeOkGXl1eDl4fGTcrrxp0Krf+WXN+Mo=;
        b=D2BRPti3d3X8HOWjTOMSOYSKYMPC84qm6Vs4DP+BJ04U2I8nc3mo480L+/EnIaEjHP
         jdHR4ZJ33hx5Fe6xGToFijdoZnwtZOLthZLZHB8H1+S2TTyaTf9rYtOTJ2pH5csUiQaT
         Gsv3uIEuhB4NFDwKxppoHOkAIcz5OhPF/m0FMTmH8tC8SBdmytkSmJQY6VFTE4uTNn5f
         CeLDCaTW5aihUG871MJkhx/jteQvmPfip9TTjdgneL2BnpWkh77z9KA+Qw0HWzgUykkS
         XC5ydNqmWbvdwci0kkmDWXsH/4xM7ChJF1L7d3PhKF0c0pyMeyc3dL49qfDLWzTb+Xl3
         bxiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785989647; x=1786594447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WZgGCxVJNCXz/4TMW05GJb1jnv5l9aLW1tckHMAdNM4=;
        b=aUaceTPlDlFZnftPlp2zUiuVIBJC1cjMTNbX/E9wH9r1nGoTEcrQ2jmeusMErmGGdI
         UtAuc1ZkGzC4jiVxlKue68d5kczDLP1Sr4Xtqb119evAfBD3sb9m+RgKwqzlAMdclmYB
         pqYzYSX7nQ8tdQ5cBzVGncDwjirHiF7CUAdVIGig+FSbo381kCtSozpr1nu98RJDkxyc
         NRhF7lfQ34KqfzVithLpWDiVV6JL74q+esl7jg/4mLO8nJCOLcSs9r4UC1BPV+0emWT4
         SPSNayMD8a+3gU7ebG1pF+C2xSu6PYgtq9gi/OAyL8aJGdqGPhuKbcR+RZ24jgwdn/zz
         F2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785989647; x=1786594447;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WZgGCxVJNCXz/4TMW05GJb1jnv5l9aLW1tckHMAdNM4=;
        b=bTsgwA3tGKAfEsEbVf3qZJki2hcwBDYQLgWyLigbcoE1rNtqAUIzQvtOpqF/nvlVb0
         cHSULzPUM7Lmtps47XvdOv/lJkiLTECGrEfdl4uRfic8Ys+h1PICX6Vj50u4zzSOSB5B
         snO1NM/kJXHhb9vnShHmdQjXxGioSqMJy2mQdkJPKgPhO5tc6YS9HVZcJv0DKMKTfR8V
         ZpbFLnPrIdWwH8uTGdbhRFXMddLchWRilOyQi+UVTicci3SrjZ4RdcLAvSHYJDjDdDlX
         Ju5Ga5BpPD5OenBcKWCeHs0rNe2z2NRSSJGA+pBq8s7w2h0CUPFeefvDfyaJrDTptqu7
         aGEw==
X-Forwarded-Encrypted: i=1; AHgh+RruIHEcIlZUlGtq0KL5c+Ln2cd+TxCOeinUo6K9ipXz06gjYSECKIDpCkA41NYtHUg5IfK+zoZ9iswH@vger.kernel.org
X-Gm-Message-State: AOJu0Yycv1ncpi50LRW7PzFZeeeq5TeqAVtVgrNmSsFi8rWsYwapnUQE
	8VMbGtPSzdfOftTj3/PwpWBtDokWGJq9hY/96x1CybrCWif3yTq7OzAcd3b6T1jLj9N+rWiHung
	7W18VXp+MrZSNS1GKdOhi6YPEdj1B6ts=
X-Gm-Gg: AR+sD10kslChDa75jtEldy6Xj8oWb354ndUivYRCO/kqzFbC+3dGteOOWCdplyLdCnx
	zykk8whrvvDNHO1dPhK2Y1ovms+InqpXPK+z6rCwqarlbBBaJzGSJyRx/lUOTCicmMFVH45Vj74
	Y4dmbtLdvlAkN5gyUCVyzGsWSrgOGX82H2wrq1w46ZXfzG4v1rpogo163cd1kushXMIsAS2Dj76
	KKnZLTSWnaU1QMKRtGQP+2ZEkOE+TdYS2/qlhRfYcO7kBUimGjdAjnxEYQmi0jTFozH9ZH2ULBQ
	RVeeU6UIcuGd687cHzU0ZARg9j5Bkt8GsIpX4CowG+0=
X-Received: by 2002:a05:622a:592:b0:528:32b1:c202 with SMTP id
 d75a77b69052e-52ce5f8f648mr109877071cf.7.1785989647526; Wed, 05 Aug 2026
 21:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783423648.git.edragain@163.com> <f9b8b94904378d14111606a3cfee801c60492681.1783423648.git.edragain@163.com>
 <f5c76ebace1493337d01385088c5ad066abc1689.camel@ibm.com> <235ac7b2-cb4d-474b-87f0-53a5962de59e@163.com>
 <522d0bf88c127d2c8ca4f4e5055e77e2918d4bd2.camel@ibm.com> <7a71431b-4c39-47cb-baac-0cbad03e13c9@163.com>
 <ee478394c5d2ec19dd0b5ce39adb9476c826cf39.camel@dubeyko.com>
 <c7648fd0-d311-4757-aeeb-f66d261e3fbf@163.com> <56b420789e339d168e825cc162ddaf6a66daeec2.camel@dubeyko.com>
 <ec157f1c-4ac6-4aec-8cd0-fd15fe3c7f5b@163.com>
In-Reply-To: <ec157f1c-4ac6-4aec-8cd0-fd15fe3c7f5b@163.com>
From: Yuan Tan <yuantan098@gmail.com>
Date: Wed, 5 Aug 2026 21:13:56 -0700
X-Gm-Features: AUfX_myTpivzzMBCHlOkHRT9SZJ1ZGwzYoPr_azBi7UaPGqxPGinedcCz_Y4EC8
Message-ID: <CAPuPA7JcgMO0JBccRBpaym7Q_fO4rDLz+s_RjRH+3Y_RT2XTJg@mail.gmail.com>
Subject: Re: [PATCH 1/1] libceph: use RCU to protect monmap in ceph_compare_options()
To: Yong Wang <edragain@163.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, "sage@newdream.net" <sage@newdream.net>, 
	"dstsmallbird@foxmail.com" <dstsmallbird@foxmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"enjou1224z@gmail.com" <enjou1224z@gmail.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 7:47=E2=80=AFPM Yong Wang <edragain@163.com> wrote:
>
>
>
> =E5=9C=A8 2026/7/29 7:15, Viacheslav Dubeyko =E5=86=99=E9=81=93:
> > Hi Yong,
> >
> > On Mon, 2026-07-27 at 11:35 +0800, Yong Wang wrote:
> >>
> >>
> >
> > <skipped>
> >
> >> Hi Slava,
> >>
> >> Thank you for your review.
> >>
> >> This patch has been sitting for quite a while, so I wanted to
> >> politely
> >> check whether there has been any progress on it, or if there is
> >> anything
> >> more I should do on my side to help move it forward.
> >>
> >
> > Ilya sends patches upstream. So, please, ping the Ilya.
> >
> > Thanks,
> > Slava.
> Hi Ilya,
>
> Following Slava's suggestion, I'm pinging you about this patch:
>
>   [PATCH 1/1] libceph: use RCU to protect monmap in ceph_compare_options(=
)
>
> I just wanted to ask about the current status of this
> patch. Please let me know if there is anything more I should do on my
> side to help move it forward.
>
> Thanks,
> Yong
>

Please do not send the same email multiple times, as this creates
unnecessary noise in the mailbox.
I suspect you may have encountered some delivery failure issues. It is
possible that one or two recipients=E2=80=99 email addresses have been
deactivated, causing the emails to bounce. Please simply ignore those
delivery failures.

I will also emphasize this in our internal documentation so everyone
in our team is aware.

To others, sorry for the noise. Some of our volunteers are not very
familiar with how to use email properly.
