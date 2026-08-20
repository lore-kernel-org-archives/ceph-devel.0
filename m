Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429ED331EC0
	for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 07:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787210413; cv=none; b=O5GpXK0fM4QhCAx7WYQM3P+5fUQwUzP6euRnqWrdFmHDjCH2xC3qjW8zlS4XwnbbxCNmo5MXyuq55cfuEb0EaNV7kmPWgZxFe1e+Wxr8BO5n4HrGJbHwGfUdnQPZQGe07BKwggWKLNyjvCsBBLKJq1Pj6vguu4WuAdoGfNf+XpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787210413; c=relaxed/simple;
	bh=HO695xsih5k79IxbYxVx3imQYVeN1xxHcqE1PB57vGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m743SRAhS38qYGrXWNlEpwKaHYUmM07U0IHrwYKAutnyD8CJ32fVUhFqmfa/lb4IsFjCh5+TiDEryyA9BMm9KOB4FqIUPsjMxvXCGz1+hXEHzSVl6IKcHkXmVLPoTyWmD7/UtuTqZZk898zj6YT+2O2+LBUTWIc2NnbFeWtoeXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ptvg42pm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZSA03+XG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ptvg42pm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSA03+XG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787210411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HO695xsih5k79IxbYxVx3imQYVeN1xxHcqE1PB57vGE=;
	b=Ptvg42pmRC580G0GDHBL4idC7wQpmY1A5Ve0tJBdsghUXIATqUJn+2bpF1IVUEpQ+LwmLP
	Hwo1jzsW4DOQWl3T6198ahxShTxUh9/g04MO8ZlX9W6U1XTPplr+RMHxo5/rY99NtuEgi+
	v7Pbm0pJ+uFFi+pZvBC579igM/NoBAQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-3Aa_d_OdNV-W-Hv5F7sbHA-1; Thu, 20 Aug 2026 03:20:00 -0400
X-MC-Unique: 3Aa_d_OdNV-W-Hv5F7sbHA-1
X-Mimecast-MFC-AGG-ID: 3Aa_d_OdNV-W-Hv5F7sbHA_1787210399
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-698b899b53cso1644181a12.3
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787210399; x=1787815199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HO695xsih5k79IxbYxVx3imQYVeN1xxHcqE1PB57vGE=;
        b=ZSA03+XGFlPGZi33TiQIKpeLEo/15dzCjeW7+/4aiIFdeKfKwiStNbOjC0Ujd6MWDa
         6cZk47dHqpglk/ICFwt6BGfecvVAInwVpLwGq5JRpTfCHadXooIWR1SVatvQeVTcuce8
         4trmNUWo+Ee89zJw6TNV2ilLQs12JU2d+GiMLk9VqSwllb8NYtV70btrct4tv3HUD2Qj
         NrbPhm08To9DWQFpg+3sVBZ1OMXFa+wdpG+MlJoQfVCy0gsYODSHYQBGBLeVBvK486RS
         8zeCIQH0TxCR7EqHXZWwnQNYuhmQHmj1U8W+/8DYwY38OrXpqT9bbllyW9RMhFldj29b
         dDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787210399; x=1787815199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HO695xsih5k79IxbYxVx3imQYVeN1xxHcqE1PB57vGE=;
        b=ooy19X77c03XvHNtZxX4PfjHf8WfwYf+kP+Km2c4gL66C86FXgdgAweGt5U0sr0zTV
         ej7owB5j+jQ5M+NIqEPkPQKryXPdXkB6Nn+V3LknaYHw1KM4oahjYzTbHQikhtcJCC4p
         5eSlElrlX0ZkEYTWvPrmS/uNnmZQrbQXYChXZFEmLFeRjcrjKQVSjf6oBBmAquPSRiyq
         Fi+1NvErYaDsY1WYNDU8hPbRx0vAZInMtBj1vEQHf16TrOOb8BTu7IPreYwbMRbF7B7Z
         GThbxEjwKmgqxsgIwUZNOb9+V9YdAKdtVs/7o3m6RKAKx6BPp10AIc8YAYS6Sido4ofJ
         UraQ==
X-Gm-Message-State: AFuF++knzPPPoFUomqPB/+2adbdoR6VcSWCKsIsJkjK+kLcEOAgoa9CJ
	/K2ZR2dC08U4bJf4EK2JZKDNo4ZYPB6vrmHSdEZNx0w+Yr5A17opxRgmYCURTMZmVADGrPz5Q3Z
	BKBnBNVwWcKCD34CdWAM92UFqXv7P0LT8fWroBOq4C2BeIJHrW7zMl+3WBy5R6GmXUB3eWYFE0Q
	==
X-Gm-Gg: AR+sD10RC8zH8mg5iRTGt2yyEIcaoPJCFvxLFxS4BcDu8FfQt+P15hKH0s+XM5ffYWr
	r9xFqygifIHv6RzZrn6OMzp4U7oaulW46H4iAZofenWXwvxGCTwQMDEN7IhIylRyU+1XUO8s3km
	Hk2ejbJ2C7Pl1d1kglLvr3QbIsekRSyIU/DGhDkP01r+MSjcn8okx97SQLFvwdrPNdmKizyhZuJ
	NKydOkcS28zCHrWL/HbE1qNujTZn4BvMcTmz1VWMdQjOvW7dggjuSRx5piF6G/CneiyUMVS2FH1
	fmYZSObTuICXXFd8QuuHMIuyUsIbIuvPFEnc/uH4QNXQvH7oS4mUkeaw0p3yNruhB8nmQ1D2W19
	U/FbK+zYgDnTsoN8h/O33+RSASMwMDGtjmQ==
X-Received: by 2002:a05:6402:254e:b0:6a0:9468:a025 with SMTP id 4fb4d7f45d1cf-6a4032fcc9amr6866150a12.15.1787210398806;
        Thu, 20 Aug 2026 00:19:58 -0700 (PDT)
X-Received: by 2002:a05:6402:254e:b0:6a0:9468:a025 with SMTP id 4fb4d7f45d1cf-6a4032fcc9amr6866119a12.15.1787210398391;
        Thu, 20 Aug 2026 00:19:58 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9d52sm2018728a12.2.2026.08.20.00.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 00:19:57 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: xiubo.li@clyso.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v2] ceph: parallelize object copy in ceph_do_objects_copy()
Date: Thu, 20 Aug 2026 07:19:56 +0000
Message-Id: <20260820071956.2176369-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817-b4-ceph-copyfrom-v2-1-08029d1ad42a@clyso.com>
References: <20260817-b4-ceph-copyfrom-v2-1-08029d1ad42a@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

Thanks for the respin. Looks good.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

--
Alex Markuze

