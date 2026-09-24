Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FBD30C14A
	for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248443; cv=pass; b=MzvQ0/4m86aUyM5+k5uZnRd+a6RuQ0J4flvIiB/LixSLeRCKn+WLp6MxEVDid1ZHR0CRtAZZFIXIU4g8n84GJOKx4PJRwl4uwfmVjbL+FMZBFZZsHOCKxtCGr8PC8lAuHLsHUj7ZbPw9QTU/o5I3BUqwRtI9nzVwxfeC/+xHMTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248443; c=relaxed/simple;
	bh=wcmUsUc+lK2OqaxVNjA6Ab3lz4q5xdfubVGV3CIwo/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxTxxmfrWSMNoAaORItZK/A+oapwLbSSmGcs6bmZd45q9xKTUUccWd1BhAcB2JIfes+3v/+Y7KZmKhH8ihuUhpxmjRRVFd2++ZGYvso0YqfJYKe4ZkA67lKL/GHG44Vf8aft11W5oJ5nWGLRcR9ubOo/KJhxMGmRsj3q2gvvc28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rl3COmH2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvCn40vk; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rl3COmH2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvCn40vk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790248440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJDaVsQHG6iuJpjX8Whr6rSpj4MCaV1/FbNuUxZZMXc=;
	b=Rl3COmH2S4W7UT72WhsOpAZbsSls9HO3CCmGU+/U8a9M3GehJTj8eq47hSBI0smaafbQGP
	FyV9XVRLW62ny5xb/DfsOl8OMZyCXA9qJgkN/VLKGs2TczytidPGpoe6rqQrY4X3offTCj
	i+Jg9rkeGf7g0QylEqG5SdCN7UEncQ4=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-WajAZgZ6My2fdq7D_9wRMA-1; Thu, 24 Sep 2026 07:13:59 -0400
X-MC-Unique: WajAZgZ6My2fdq7D_9wRMA-1
X-Mimecast-MFC-AGG-ID: WajAZgZ6My2fdq7D_9wRMA_1790248438
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c833d4bd04so580055e0c.3
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 04:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790248438; cv=none;
        d=google.com; s=arc-20260327;
        b=rIXv8d9xcyJHU+NvoG5DjXiz3tSumAGLgSl1fJIfGNsAS1zRuMsw6/uht03EwWlvLc
         5mJVw3r79mA4vare2xzJQBuqCKvX8gbDOw/jhxupjn25DLg5sUBG8mXJfPqj4ioTmjHV
         GGtmixIGtSiD1QT3yNQKVgUUdmHfaob/4QclX+JhM5bRL2kq9FI2Hm8WyNN2p6HoTbrU
         5gZOsBCWHO+dj1QurCyA1gqIgY4E7wJMcgRIEVizOE39GSIeRNAsRQ2CGTXfRRD3NiOR
         eojxsNlQ8G4LnpofdOhAp2KUs7o3S6Hvc76Fil9uGBZglc0ujiBfyROJAqnzm7K024EN
         IRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qJDaVsQHG6iuJpjX8Whr6rSpj4MCaV1/FbNuUxZZMXc=;
        fh=N5GKSOPQyebEoNpE2RCKkbsxAwH2+42Yx3n2yaC9hxA=;
        b=im5aAFcgM443Z8fcJhN0hT4llAwn3I/VHGDnzDl13xXcpNoYD2CjIskFv83t27Azs+
         lpu3AMY9ksOnobhHQ1fyoE5c2so5VPLRyNdoOXM4t3WDTX++juAG4U/N7nGhYuc9+ohl
         woSPtEcdRunl0BVPRsQcIhGugF3KlTvWFyn3paC98G5onqlJC55LHE/fou4ijsz0exGV
         elZBnwoylaNURQEFz3LYGusWHLlAFDTw5wVB8HCC0dCmZzvM+M4M/6rzfmHnq3EZo2/9
         XqR+BW09kXOM5oPmrcHLYR/pnxQXjoxT1cVeW774MC8lEzFT1SKtTec3GCwq+cIEbJza
         j1zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790248438; x=1790853238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qJDaVsQHG6iuJpjX8Whr6rSpj4MCaV1/FbNuUxZZMXc=;
        b=YvCn40vkAl8BHyx3z/DZLoZr7XUvih7GClJk8OkYSTySSjSfALN3SxxMYT5u2gAye7
         6aHZTn/t2J1o/QKchKm53LLZ1eua6T0KDtk60XKENAh7D5rpgyQUJZ6O++mUY/m3Eb+9
         pFbiOYRUZVwqI90hjmy+Y89TG33xXkDT9egiz2Yd4dL9KMx9cVndM8luVIvFi+PBByfw
         Eebctly35NXkWmRQ+IDYAWi94Ra5eFcFYI589MCtFOBriuEX7IFRqpMEBNVmxFs30Ut6
         fXsueVD0hym5472jxTBGXbZ7HNpvvv9fjS8uoQhCmgZWn5l2C2kYO+aX2G/2iicmC195
         HMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790248438; x=1790853238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qJDaVsQHG6iuJpjX8Whr6rSpj4MCaV1/FbNuUxZZMXc=;
        b=Ddqs4yWcpn+jRat/E+XR0jQXGA3rC8MQxspmRqsurrMiSZr/kDFT17BZDRiTVxtbzQ
         MTVFNiQGujsOYcdyBGpaMHX4Io8XZyT82ynMmtkFLw95f3h+Dr778fai1YfE8krUIkt+
         m5+h+/fdUrjWWXjGI3tg4GgMLAydm/e6oQ3DBAbHHk8YyCGQQALCXL1mobXBAruzlq+/
         wZVgs0L4lq14CiycCTrFM0gjB5FIdHW9rYnctyrqua5/eSTkXhalDvnfb+iXII80gC6T
         oEVxXO3I+Sq87lD2rQC8uTiPh1+V9z2uShecNhRfWCrhVtONSyWK4vTjG/XU8ez0Uf+p
         ojAg==
X-Gm-Message-State: AFuF++m/fAz/RSP7WZiQgjrgrcRZFHHpN1KemBLvil8TuZ2rE0GyNdDD
	NCwndsc8ysFgZU2Pi013YxbkVhswIHt22kxXsmZ+JML2RxOhEZVMrv2VcIKUHhXCwsOjZrPso90
	xRJJmJSkr2ZLG1Sfg2gvhN3hhzqoG8l0cViXHetVO+rGSsWocAuWOc3YhKIeWas8IC2EZQ2ry9M
	3/16WSxw51Q5nJAGTTXSElT74tlfPFZbXBbY+g6wMQUdT2Nw==
X-Gm-Gg: AYBFou2n/X+Y8YviduCf0j6ikI60jshW5qo1woZa/uPULmntOo9HCltvt7oPH177CrM
	FSP86ZSu7DMMQMqU95yms3Ig4GoZgO1TYrb2OPS9/0Lh93BmuOgbwqMmDJAfo7xw2JMB/QxT6Nu
	hbr0OojsI2wxpTZG6nbr+lQcMGnLKiAHQWfuoLm7MqPL4/Vl5mdoQRgALxioYqYdAUoRbO4XkXt
	5oao0MagSD8AOhNTxoi6VMNG1IJTsIWL/FUwVGu
X-Received: by 2002:a05:6102:a47:b0:7a5:4fe2:b380 with SMTP id ada2fe7eead31-7af1eff6903mr1050493137.26.1790248438457;
        Thu, 24 Sep 2026 04:13:58 -0700 (PDT)
X-Received: by 2002:a05:6102:a47:b0:7a5:4fe2:b380 with SMTP id
 ada2fe7eead31-7af1eff6903mr1050475137.26.1790248437866; Thu, 24 Sep 2026
 04:13:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <GV2PR10MB61387727F5B89B621AD8307BDF842@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
 <CAJ4mKGYf8KDH368dfxp1d3GQ5boUcewYxcbdB1cWSt=JR8oy2A@mail.gmail.com>
 <CAO8a2ShV8X+z1=FPUjZ+voQi2SCsSdauwv2a2wS9dBzt+bk1bA@mail.gmail.com>
 <GV2PR10MB6138FA66DBC7CE7434418686DF832@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
 <CAO8a2Sj=iRe62a+pO-7wAdYUQa59KObRsop8zus+KXCxp9GF3g@mail.gmail.com>
 <GV2PR10MB6138225665859A9E2054D4CADF832@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
 <GV2PR10MB613812F687DC650520DF45B8DF832@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
 <CAO8a2SjJ2u1BFPhnLohno9hy7qBgrFTb0rEHdHpBawQN+njb5Q@mail.gmail.com>
 <CAO8a2Sie7eftzio6Dq6UWaTc3TLFa-tQvM2TSDnq_6saF0hqOA@mail.gmail.com> <GV2PR10MB6138AC7FB5C40F1A0C35496BDF822@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <GV2PR10MB6138AC7FB5C40F1A0C35496BDF822@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 24 Sep 2026 14:13:46 +0300
X-Gm-Features: AclHuK-GjIJIAWnVZI80Uk1f3Q-J-Fyb21lBVs6pxPFxdHQnfyLmvgrumswaBFg
Message-ID: <CAO8a2SiVduifBLiSW2fBUK+O8y1Efg5UU3RTfxVxpPFE1wf_iA@mail.gmail.com>
Subject: Re: [BUG] cephfs kernel client 6.12.x: writes after ftruncate
 occasionally being lost, leaving hole in files
To: Domhnall McGuigan <dmcguigan@kx.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Liz Norris <enorris@kx.com>, 
	Brendan McAllister <bmcallister@kx.com>, Pavlo Piatkovskyi <ppiatkovskyi@kx.com>, Pierre Kovalev <pierre@kx.com>, 
	Oleg Finkelshteyn <oleg@kx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's just a non contiguous set of patches that may have directly or
indirectly impacted ftrancate.
I can't say that any ftrancate issue is related to any refactoring.

On Wed, Sep 23, 2026 at 4:54=E2=80=AFPM Domhnall McGuigan <dmcguigan@kx.com=
> wrote:
>
> Thanks, Alex. I'm examining these now; am I right in thinking that most o=
r all of these commits are fixing issues that arose due to a refactor that =
landed after 6.12, so they don't explain why we're seeing these bugs in 6.1=
2?
>
> Regards, Domhnall
>
> -----Original Message-----
> From: Alex Markuze <amarkuze@redhat.com>
> Sent: 23 September 2026 09:36
> To: Domhnall McGuigan <dmcguigan@kx.com>
> Cc: ceph-devel@vger.kernel.org; Liz Norris <enorris@kx.com>; Brendan McAl=
lister <bmcallister@kx.com>; Pavlo Piatkovskyi <ppiatkovskyi@kx.com>; Pierr=
e Kovalev <pierre@kx.com>; Oleg Finkelshteyn <oleg@kx.com>
> Subject: Re: [BUG] cephfs kernel client 6.12.x: writes after ftruncate oc=
casionally being lost, leaving hole in files
>
> CAUTION: This email originated from outside of the organisation. Do not c=
lick links or open attachments unless you recognise the sender and know the=
 content is safe.
>
>
> Resending in plain text mode.
> Here Is a list of patches that maybe relevant
>
> -  Alex, 2025-12-14     0cc0169, 786f515
> -  Alex, 2026-08-13     67b220a
> - Slava, 2025-02-04    f08068d, ce80b76, 1551ec6, fd7449d
> - Slava, 2025-07-30    42dd3f7
> - Max, 2025-08-27      cce7c15
> - Max, 2026-09-04      949d74b
>
>
> On Wed, Sep 23, 2026 at 11:10=E2=80=AFAM Alex Markuze <amarkuze@redhat.co=
m> wrote:
> >
> > Here Is a list of patches that maybe relevant
> >
> > -  Alex, 2025-12-14     0cc0169, 786f515
> > -  Alex, 2026-08-13     67b220a
> > - Slava, 2025-02-04    f08068d, ce80b76, 1551ec6, fd7449d
> > - Slava, 2025-07-30    42dd3f7
> > - Max, 2025-08-27      cce7c15
> > - Max, 2026-09-04      949d74b
> >
> > On Tue, Sep 22, 2026 at 3:01=E2=80=AFPM Domhnall McGuigan <dmcguigan@kx=
.com> wrote:
> >>
> >> Sorry, sending this back to the mailing list because I forgot to use r=
eply-all.
> >>
> >> -----Original Message-----
> >> From: Domhnall McGuigan <dmcguigan@kx.com>
> >> Sent: 22 September 2026 12:50
> >> To: Alex Markuze <amarkuze@redhat.com>
> >> Subject: RE: [BUG] cephfs kernel client 6.12.x: writes after
> >> ftruncate occasionally being lost, leaving hole in files
> >>
> >> We haven't yet been able to reproduce the issue under controlled condi=
tions at all: the best we have is a deployment that seems to get a corrupti=
on about once a fortnight, writing 40GiB/day. Do you have links to the trun=
cate-related fixes you mentioned? I'm getting nowhere trying to find them m=
yself and they'd be very helpful to refer to.
> >>
> >> Regards, Domhnall
> >>
> >> From: Alex Markuze <amarkuze@redhat.com>
> >> Sent: 22 September 2026 12:39
> >> To: Domhnall McGuigan <dmcguigan@kx.com>
> >> Subject: Re: [BUG] cephfs kernel client 6.12.x: writes after
> >> ftruncate occasionally being lost, leaving hole in files
> >>
> >> We are using patchwork but it's not better than just going through the=
 patches with git log --follow.
> >>
> >> I would try running a fresh upstream kernel build and see if the probl=
em persists. If the test is fast a git bisect will land you on the patch yo=
u need.
> >>
> >> *********************************************************************
> >> *********************************************************************
> >> ***************************** This email, its contents and any files
> >> attached are a confidential communication and are intended only for th=
e named addressees indicated in the message. If you are not the named addre=
ssee or if you have received this email in error, you may not, without the =
consent of KX, copy, use or rely on any information or attachments in any w=
ay. Please notify the sender by return email and delete it from your email =
system.
> >> Unless separately agreed, KX does not accept any responsibility for th=
e accuracy or completeness of the contents of this email or its attachments=
. Please note that any views, opinion or advice contained in this communica=
tion are those of the sending individual and not those of KX and KX shall h=
ave no liability whatsoever in relation to this communication (or its conte=
nt) unless separately agreed.
> >> *********************************************************************
> >> *********************************************************************
> >> *****************************
>
> *************************************************************************=
***************************************************************************=
*******************
> This email, its contents and any files attached are a confidential commun=
ication and are intended only for the named addressees indicated in the mes=
sage. If you are not the named addressee or if you have received this email=
 in error, you may not, without the consent of KX, copy, use or rely on any=
 information or attachments in any way. Please notify the sender by return =
email and delete it from your email system.
> Unless separately agreed, KX does not accept any responsibility for the a=
ccuracy or completeness of the contents of this email or its attachments. P=
lease note that any views, opinion or advice contained in this communicatio=
n are those of the sending individual and not those of KX and KX shall have=
 no liability whatsoever in relation to this communication (or its content)=
 unless separately agreed.
> *************************************************************************=
***************************************************************************=
*******************

