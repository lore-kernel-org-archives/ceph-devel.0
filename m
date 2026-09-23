Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97A83DC4CD
	for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2026 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152591; cv=pass; b=FQK4S/u3euEmHFfahSNdeq9o4IA2fiGfBigPu5Pjdh+WIUIfZkinaNm1umv/VpHhsdIuc5ONDhXaXplMylGuYvXiiyqQaOX+Wd8A1JIMfyXlsjY74QJkJh/efGnif7oPg0RW8j5H1OJR1AwjuCXY/xEJ/lfu2EFFwSZC2XmG7Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152591; c=relaxed/simple;
	bh=5kvMFjb0CXy9DCTbnOu16Fx+MbM9fr3IEglKf+sULjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWBR7+RnE2oAP73r5sNq5iZPQ7pJqr12Z6dZi9midOIvmhoM9zLA4ZeNmCpS0SreEas/brXWC6/XaHNKYgwIyJC5/nf/Kfliyo1r04hEdsD5j9XA9+Eeon9PLpXsfW0XhfdF2NQondbx+WPlSLJG/i18sLV5FAc0Tn2xiUOqQuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IyYgCDFD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MaMzwRp1; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyYgCDFD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaMzwRp1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790152577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6KLIeqQTcdleM37vRDraK9IY38FmA5+yIldm1sHSMo0=;
	b=IyYgCDFD2OGLxexNztJqAWq5TU2rAmKPbB9IJZDbWQb4KbbAGAG9j0TJnR1tjJ8ZkxyrNG
	X5KswKpkNimlbN51evu+W0sNllD7g+Qt2jFQofL+6+CONjYG+Di2zJlSNTxZdLUFeFwT3y
	HgWhKFqqTsfeWIw5icZakFyPaPwaS3c=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-r2vbDOF-MH6j0JX7DIT4nQ-1; Wed, 23 Sep 2026 04:36:16 -0400
X-MC-Unique: r2vbDOF-MH6j0JX7DIT4nQ-1
X-Mimecast-MFC-AGG-ID: r2vbDOF-MH6j0JX7DIT4nQ_1790152575
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7a9378b844dso281728137.1
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2026 01:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790152575; cv=none;
        d=google.com; s=arc-20260327;
        b=fwP5lZr9eHMxCjzQ2YP9Qlo7bmnc+h18LDvb8P8YepPANTG6Lyi/3hk1qzNYUV4ird
         UYB7A9zLuWysLM9zH51DZwgspoyw40u6zUPmabTIKEu+OEW9zUqfDdepkyhXO4Qf3T7W
         IZQ3GyGodh6VM3hbCRjQoGEH/iXNocPM02jwpr32gwTS6/86XPAL1E2HdwOuDq8HeEwC
         4uU8n7zfWANAueS9QqQAdpQrHf3XZmCjypGnYaQ+R93eMz4FVHhzaI+713C6ImK//hfR
         yAeSRPqWqnG9IyEJ0A4JYIwOebxbRRe2gFqazTtzId4xKzToIfMnZK+UIIkTbETnEXZ/
         lUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6KLIeqQTcdleM37vRDraK9IY38FmA5+yIldm1sHSMo0=;
        fh=N5GKSOPQyebEoNpE2RCKkbsxAwH2+42Yx3n2yaC9hxA=;
        b=kO+G5Ja+uQL/WLTOi8qNXpdNoBGpQp9//JDkUyQT1NUWarrk+ONuoCEik/l9hQzP2D
         d0eZTmONFh8OIX/jQBN12cfE+aoZOdtWfl/MkG84EnRwSBeefPHPP8eyDEcF7SQbPoxq
         NGlVvWbmRDYEsxXOBPAbR9lgi6wavK/M3GaRX44oBJK+As1zdKkPQZqnycUstpTE+xCn
         VNoKGhOaLLO3T9oe3AsZ+X4tPTUuaGnZggjOAyqYBS/nzWsJYc8EaVQQsn9/UoDV1kBu
         8vtbAu5KJ5Jkt8JGOvCCrNKawgshQI6mC8b13iR5Bna4Us7cN1e2ZuzGzqTCA6Eweuae
         9Z9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790152575; x=1790757375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6KLIeqQTcdleM37vRDraK9IY38FmA5+yIldm1sHSMo0=;
        b=MaMzwRp1/8UIOJm9S8mdEMH33icg0ssZ/Z22miJVZnMP+/HH5s5DJBRR/AXM4qujqE
         DpDvjXJxgb+iPd/MV/hK+ZKpiUcgWU3tTb9tA3yybQQWKeWQ7G4EKHvx4+AmXlGSx5mk
         BBaGhfVrPADRHiux/XRsgB5bZs7A51xuCupS5D/sauA9kP0y7HnSVzQXqo41EbSmCb9+
         bqF9m5ABPu6i306K53DZCpXQrjfLzZsbD+x3wsFEWFyBq1OoY6+OIMLuXqqlK/v5Gx0d
         iD8WTDOHHx2Bp4JaV9VFJn7gMXKHixWihH8FY7LRoSvvtvxTBbf6Iq6nIRgraJftcmIp
         FE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790152575; x=1790757375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6KLIeqQTcdleM37vRDraK9IY38FmA5+yIldm1sHSMo0=;
        b=KvToLVj6KoPw1/c9gE5s0xbt8Ee5oTkS+RLSIoUxaPjBMVCM9C7BwgaXI7qjmQvLkd
         KWRgq9Tkm807put9nOrJMYSUJ1+/nhP1lAvxTLXV5ncjJOLaVN/Vb+LZLBUpmRWtAwg9
         SZ+CI7E1Lt2O6onHxrSfGOFG7Wk1VX0sAQiW30kXilSYYeSvCIPD7SxyyLkCZKvPyuZG
         Al8OhTGxgrjXsuvVMxFJ6E2FrEzhGID87Kk6+xiSctV8nDE9Y4781gt539PE8+oa+by/
         zg7VW1sYYd+oYCYnxLPnjToP3tZ7kS41H716TqMYV1uKJRQYXwqVayVe+udwbtuCh1EB
         itAw==
X-Gm-Message-State: AFuF++mJzRDF2quy74IxoGY8m3J1YpIUEU/pB1ZorwEwQeUh0ifCkgQz
	laWohXoFjxixutTNKvg6mL6QIFkRFl56HBikWuauzl482xAYHs77SOq/HU9oZtQyBgorVMOK2E9
	R1b1EZmbPX53n71r7MVBmJfUIAWFBZej97qNkrQUGjxNUu5zHTl78KcZINEQMyEdjBIyeybNRqg
	SF/phsWsPxvZb37woBMboqFGbjGxpb9v2KXdYMuw==
X-Gm-Gg: AYBFou3QXaPZJ/tpTIKILsY7pXfYF/dtw6+zeqWQKKDJfBMm1n08jhva8InrZL1d7xf
	i8w0QuZeSH/F33xcPR+KWUPdfIhJJL8/h4Po0r7DEm8pdDp0KS5B7+EesJCLdlNeTV9UW+/MdRM
	xy+zEAoQSing01dFuCClGdHu7K/4IB4XiOxujtbzc5PYHGyskD6HLNYiFJTpl6ulzXMxWFLUL6M
	cRlDidjlY8pE1fFVf7IHC9vA757RIiBLqIgqYmo
X-Received: by 2002:a05:6102:e0d:b0:7a7:196a:84e6 with SMTP id ada2fe7eead31-7ac1d4ed3a0mr1767476137.30.1790152575412;
        Wed, 23 Sep 2026 01:36:15 -0700 (PDT)
X-Received: by 2002:a05:6102:e0d:b0:7a7:196a:84e6 with SMTP id
 ada2fe7eead31-7ac1d4ed3a0mr1767467137.30.1790152575014; Wed, 23 Sep 2026
 01:36:15 -0700 (PDT)
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
In-Reply-To: <CAO8a2SjJ2u1BFPhnLohno9hy7qBgrFTb0rEHdHpBawQN+njb5Q@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 23 Sep 2026 11:36:04 +0300
X-Gm-Features: AclHuK9dsvwZTp_Wxo6nJ7VO7cg09hMCr9xBWXMoqhE7enfJsHf4ZoPwwRiBlVI
Message-ID: <CAO8a2Sie7eftzio6Dq6UWaTc3TLFa-tQvM2TSDnq_6saF0hqOA@mail.gmail.com>
Subject: Re: [BUG] cephfs kernel client 6.12.x: writes after ftruncate
 occasionally being lost, leaving hole in files
To: Domhnall McGuigan <dmcguigan@kx.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Liz Norris <enorris@kx.com>, 
	Brendan McAllister <bmcallister@kx.com>, Pavlo Piatkovskyi <ppiatkovskyi@kx.com>, Pierre Kovalev <pierre@kx.com>, 
	Oleg Finkelshteyn <oleg@kx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending in plain text mode.
Here Is a list of patches that maybe relevant

-  Alex, 2025-12-14     0cc0169, 786f515
-  Alex, 2026-08-13     67b220a
- Slava, 2025-02-04    f08068d, ce80b76, 1551ec6, fd7449d
- Slava, 2025-07-30    42dd3f7
- Max, 2025-08-27      cce7c15
- Max, 2026-09-04      949d74b


On Wed, Sep 23, 2026 at 11:10=E2=80=AFAM Alex Markuze <amarkuze@redhat.com>=
 wrote:
>
> Here Is a list of patches that maybe relevant
>
> -  Alex, 2025-12-14     0cc0169, 786f515
> -  Alex, 2026-08-13     67b220a
> - Slava, 2025-02-04    f08068d, ce80b76, 1551ec6, fd7449d
> - Slava, 2025-07-30    42dd3f7
> - Max, 2025-08-27      cce7c15
> - Max, 2026-09-04      949d74b
>
> On Tue, Sep 22, 2026 at 3:01=E2=80=AFPM Domhnall McGuigan <dmcguigan@kx.c=
om> wrote:
>>
>> Sorry, sending this back to the mailing list because I forgot to use rep=
ly-all.
>>
>> -----Original Message-----
>> From: Domhnall McGuigan <dmcguigan@kx.com>
>> Sent: 22 September 2026 12:50
>> To: Alex Markuze <amarkuze@redhat.com>
>> Subject: RE: [BUG] cephfs kernel client 6.12.x: writes after ftruncate o=
ccasionally being lost, leaving hole in files
>>
>> We haven't yet been able to reproduce the issue under controlled conditi=
ons at all: the best we have is a deployment that seems to get a corruption=
 about once a fortnight, writing 40GiB/day. Do you have links to the trunca=
te-related fixes you mentioned? I'm getting nowhere trying to find them mys=
elf and they'd be very helpful to refer to.
>>
>> Regards, Domhnall
>>
>> From: Alex Markuze <amarkuze@redhat.com>
>> Sent: 22 September 2026 12:39
>> To: Domhnall McGuigan <dmcguigan@kx.com>
>> Subject: Re: [BUG] cephfs kernel client 6.12.x: writes after ftruncate o=
ccasionally being lost, leaving hole in files
>>
>> We are using patchwork but it's not better than just going through the p=
atches with git log --follow.
>>
>> I would try running a fresh upstream kernel build and see if the problem=
 persists. If the test is fast a git bisect will land you on the patch you =
need.
>>
>> ************************************************************************=
***************************************************************************=
********************
>> This email, its contents and any files attached are a confidential commu=
nication and are intended only for the named addressees indicated in the me=
ssage. If you are not the named addressee or if you have received this emai=
l in error, you may not, without the consent of KX, copy, use or rely on an=
y information or attachments in any way. Please notify the sender by return=
 email and delete it from your email system.
>> Unless separately agreed, KX does not accept any responsibility for the =
accuracy or completeness of the contents of this email or its attachments. =
Please note that any views, opinion or advice contained in this communicati=
on are those of the sending individual and not those of KX and KX shall hav=
e no liability whatsoever in relation to this communication (or its content=
) unless separately agreed.
>> ************************************************************************=
***************************************************************************=
********************

