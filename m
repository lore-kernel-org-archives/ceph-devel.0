Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A8E434E42
	for <ceph-devel@vger.kernel.org>; Mon, 21 Sep 2026 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011433; cv=pass; b=qSuCWKfWqZqOP0eCapgBbQRcJQpePMtlqIN9dEm0v7uMsRokdjtTNBjkkCkr21lSlsWQR/AwHZGbVAX2kQ3e0iwTobs0qj+rnSF8opPEP2838SsfDLXJo6z3v+QQspuCM7Clt/qDeDLIR1WLBzinoWdNB76+pM6drXp9ap7nzrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011433; c=relaxed/simple;
	bh=zEZpuVKt4uOUbWnGXuev8F18wfoq2V3TN8wzOqd0kaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2qd0RTMYyjhTyXZHr1N+Vmv9PHWGfGBqtBsjtObqYPlmEVwGNm/7dw+mePWP0z1X5JW9Say46ccpoyvXmxhZ7tTZ2pMOJ72uuj00jWYDQktiEVriRZwoqN4WeFuB/MvoMYrgYVUOvuPzD9peQCnP2DyGoqW6XWR8cgu8JyYq4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcN7Hxl7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tv0Z4xkG; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcN7Hxl7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tv0Z4xkG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790011431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEZpuVKt4uOUbWnGXuev8F18wfoq2V3TN8wzOqd0kaw=;
	b=UcN7Hxl76Si+nrVgBEfILiVrkRxAUS4KB+1JKYPpnue6/jF2Z/gAQHwaEFNFGIyK0DDhJ3
	Bqqpo8tPXfErhHgG7vbG7jaEQeu7qfKTmlBiUfitu3ngVsJ8ihr/UjUC4bO3ESogY1XL8K
	ypd6QYFZkOVNGq1lKrU2UPCm50rtF7U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-LNuJ_fBNPn6clLyKChLobQ-1; Mon, 21 Sep 2026 13:23:49 -0400
X-MC-Unique: LNuJ_fBNPn6clLyKChLobQ-1
X-Mimecast-MFC-AGG-ID: LNuJ_fBNPn6clLyKChLobQ_1790011428
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c293a65b577so318037366b.2
        for <ceph-devel@vger.kernel.org>; Mon, 21 Sep 2026 10:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790011428; cv=none;
        d=google.com; s=arc-20260327;
        b=khTwbd5viKnFfGT1ijLbGDLMxxa+sqyz0CuGC2j+zVJlVnrlqixg25w73P+qndkyWL
         B9FArObDSzl7FHlqk3FkzfLFBShoXhmUW7D5Yz9yY8T5Of61XKADCXx/h8O/hqeSOKTy
         zpmkFW9LuGwnMvPoWPVF7V5vkXjanDFrtdUJsSqOe4Bj5hu5LsexVKHUprFrRlF0Gvk9
         Cqh0KoXlqC+cVZZBa7CJKvvZv0bQyIFZJh6KZZ0dEKn7RRq6h6ly+pXEw784ipDBnAQS
         eerRInNiwUteEA43O5XZ3e8pX3P8QIXyJ/Io1qWFO2P+OjggWSL2PEl6XS2R2EbxWMXu
         pKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zEZpuVKt4uOUbWnGXuev8F18wfoq2V3TN8wzOqd0kaw=;
        fh=8q/zrBAzVNnbTJg/dzjUK3kpK5B87A/Fb+P976BCfuA=;
        b=ZINyPWwOKlal/UuLMxwwINsR+LM1dqswNV0nuVdngR5fE/Z++KJf09b+G4Cz4gTk9+
         VV19m2/qW6spJTkGbOGyIYl/rVJOO15k7gaOTNt/35EfY/jXhKPTM20WLiRQtOhnqYKY
         f+8GrGmCdRkGgyMiap57L6DYbZ1mh62qfLTd/vyas2UD1GPjBBhVeELJCOER2ifERgAe
         eCiwqtKAE0HcWNlWZuxAtnUrCec9Q2OviHOItqvsDkqWYQmQxGZNMRkRj4EoPT5IVlAG
         0lG90RH1s114753hFPOg8gVHWd9nspee0x0JD2IgRCDvk1CwstG3eRE5ZcFFckWX7qdR
         B5qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790011428; x=1790616228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zEZpuVKt4uOUbWnGXuev8F18wfoq2V3TN8wzOqd0kaw=;
        b=Tv0Z4xkGD/3CDVs3MSbUsItbr222p+HZ96GQizX0Gbf1VCTsumhlzbwCz64Bmlq8Vl
         jp1W0Qc3AaTQ8EjKLVeLMlfdiZMx/j6+VSZqajVXEjNedm4r/jd2+bKc2ziccy4WxC/H
         MngXVcetXbgDzxzdw2iww/H8c89yd7BIzbOeTELygJ+eZs4d3GILDQTkrq+tZbMyKMzG
         5ftLxOTANrO6U2JBZZTFW1QiKI9xNnL5zpBVbyAIp3qHmwaOXEscXMYEu5y4/qI+nuoC
         3BrwnGK+52OxZAcqksuCV3V3iEsEgsJ4ACD8shLr30RgqB459ojqtqMSefzLwTdKdRuu
         O+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790011428; x=1790616228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zEZpuVKt4uOUbWnGXuev8F18wfoq2V3TN8wzOqd0kaw=;
        b=WZ/JsNodyZdhzJ+KGJRQes3X1feXfJ2xUcd2AD0JeC5At9pnnrR+fWopZoAGWC7pdv
         ydBjCJoK90BOpqxzyZda0jt2yEOc4Zyb9oZo7/SXXGIQwi8LhQU4jJaQpyFBL8ORg4+y
         whSMpoYzu8JmNAMzl3Ol2OD3xYPes+OgL1PGYWYTV+Y8Luak2Rnrjo2l+sDsk+2Nd/xR
         ujxAqadovPLS43hnTD14RNPrMOCVd+MUI0QCdyVZ1UopnQiGIPeUjzuWO3ameqzygn1U
         J2eiRnbCAfBUBWUKAzKyiqI6oi5d54lroNT+rDfpqu0jsaf/8LuDyLSFL3REMdjkolKs
         NA6w==
X-Gm-Message-State: AFuF++lztScZwirYQXlb1ygHhFEsvdVP0xiI66kxbACR+3piiMaN2HQd
	yrz6WTJF/qfcSXs4bo8FjIy2GeVlcrUUYd83pnlFJpXagZJG0DUQrN2KidNKGgoe8or+9Ht51G3
	mR+slzFSy+bz2N1Wt5HYFvCM4rngyDSs8XDvsat90rXFjyQVU0Wvz8WyCHSy1rxhGGw1KVJ3Vpl
	5epKT1a3q7ykVyBr5WQDNfXJ6D7VagYwdnnCvzqA==
X-Gm-Gg: AYBFou0EMMljyiLJBwM3vzQtzl9hnA+7DFfM055xk0e7mHielFmji6ixf2RItGcK2pO
	m8IpN3/AKUsW+IHE0nlWdxddAo1KWK90Jekg4T4KTa3b8cARIXf5/gxXbfBvaVG1CKgh8qr2XMA
	t+/9ZrBQFivbZ6UE6Oz5GF5xNBc7Lvzfi1RZLlPi2KU1pYSMvE/9CqKZ8QLst+fp9Tdr4xPbdqm
	w==
X-Received: by 2002:a17:906:794f:b0:c29:4357:2309 with SMTP id a640c23a62f3a-c2a1581070bmr935431166b.24.1790011428332;
        Mon, 21 Sep 2026 10:23:48 -0700 (PDT)
X-Received: by 2002:a17:906:794f:b0:c29:4357:2309 with SMTP id
 a640c23a62f3a-c2a1581070bmr935429266b.24.1790011427858; Mon, 21 Sep 2026
 10:23:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <GV2PR10MB61387727F5B89B621AD8307BDF842@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <GV2PR10MB61387727F5B89B621AD8307BDF842@GV2PR10MB6138.EURPRD10.PROD.OUTLOOK.COM>
From: Gregory Farnum <gfarnum@redhat.com>
Date: Mon, 21 Sep 2026 10:23:36 -0700
X-Gm-Features: AcwNN1VpLYu4989Z1hM-517JMxlY6A6h0I-tS5rXkdkPC-AwAW5bekWAQcH0Z_k
Message-ID: <CAJ4mKGYf8KDH368dfxp1d3GQ5boUcewYxcbdB1cWSt=JR8oy2A@mail.gmail.com>
Subject: Re: [BUG] cephfs kernel client 6.12.x: writes after ftruncate
 occasionally being lost, leaving hole in files
To: Domhnall McGuigan <dmcguigan@kx.com>, Alex Markuze <amarkuze@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Liz Norris <enorris@kx.com>, 
	Brendan McAllister <bmcallister@kx.com>, Pavlo Piatkovskyi <ppiatkovskyi@kx.com>, Pierre Kovalev <pierre@kx.com>, 
	Oleg Finkelshteyn <oleg@kx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eek. That's not good.

Hi Domhnall, does this system use the fscrypt functionality? (Probably not?=
)

@Alex Markuze, do these kernels correspond to any of the netfs bugs
that we know about (or any big patch series, so maybe there's one we
don't)?
-Greg



On Mon, Sep 21, 2026 at 9:24=E2=80=AFAM Domhnall McGuigan <dmcguigan@kx.com=
> wrote:
>
> Hello, we've been observing a rare but persistent issue where a truncate-=
then-write sequence to a file on cephfs (mounted with the kernel client) is=
 leading to half a megabyte of writes being lost, leaving an unallocated ho=
le in the file.
>
> Our application uses ftruncate() to shrink a file to a non-aligned offset=
, then writes several hundred KB from that offset (without fsync). Occasion=
ally (around once a fortnight) that data gets lost: a BlueStore onode dump =
shows an unallocated hole starting at the truncation point and ending on a =
page boundary. Later writes are stored normally. The client received no err=
ors, and no other clients had the file open.
>
> We've seen this on client kernels 6.12.79 and 6.12.83 (Amazon Linux 2023)=
, and 6.12.0-233 (el10). Ceph version was 19.2.3, deployed via rook-ceph, m=
ounted via the kernel client with default ceph-csi options, with a single a=
ctive MDS. We've seen this happen on multiple independent deployments but h=
aven't got a controlled reproduction yet.
>
> For full details, including the onode dump, see the issue I've opened on =
the tracker: https://tracker.ceph.com/issues/80704
>
> Does this match any known issues, and are there any steps we should take =
at the affected site to catch the next occurrence?
>
> Regards, Domhnall McGuigan
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
>

