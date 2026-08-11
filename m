Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F313D43F0B3
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460227; cv=none; b=fmC67efvY2v7FOLulybRRczbUHgIZ+tqSZTTPubIzvQmUssl3TRkQcelxeQjoDxV3YalsdJLNEM4CizLPbT+Uo8Apegf9AbhUpsq+/n4Z1CLZBe3QbSWQ2UuZgUHY13iqaAE9HroDOdmM+DJXaDuR1ngoH7Amj5i8XOzgaCcBOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460227; c=relaxed/simple;
	bh=lCTPtFoxtcyLzZC5JIDhZpR9SAAGT/fE/e8C9bYONAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1v76UcLCKUDW9qKtWCOrUM0lvI6KauV3WoKpoFaoHvj2rWOubXNIUgIDicVSpIHHda9o8WuKKNZvFJY+cWyTjaDD8Dztp4dm6RBYO8RJMt4N8HoNDrdHjSbAjLdZEhLS9u8w0gd7r2i2rG9yvecb5yNzSO2xcvc2rHC+tJjdug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MB5ymmc/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+5kK3c5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MB5ymmc/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+5kK3c5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786460224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
	b=MB5ymmc/5BbjPSjNkffksWUAdgKsumScjh/bsKsdoAS03ses1gsg+zfmBAMnD7t9zkOhqG
	K6F544siAczYW+iaUHeEBtTGc4BU/qRZycpXX8MvhmCM9f2bO8K9vqi5cB6THTCyiGiZxa
	T9U3Kd+/9W7RySIPz+SyWr0QmF+d4TQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479--kuwdr5INRmYwAb-QZWqDQ-1; Tue, 11 Aug 2026 10:56:58 -0400
X-MC-Unique: -kuwdr5INRmYwAb-QZWqDQ-1
X-Mimecast-MFC-AGG-ID: -kuwdr5INRmYwAb-QZWqDQ_1786460218
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4a7c64fbbc6so3059134b6e.2
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786460218; x=1787065018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=M+5kK3c5QDDzifBHYYKrS45L62QhDCNS9q2Skcj2bwrSIj57XUwhA/Idu+XLDSkACZ
         3Rrx5ZRLFgnVBlSxtGww1jhZl2H4qZ+xqcf52kd1ftVSDII8c4xAzOBCqobt2a5wRZH+
         S6gz9QBEfPFofgIUQv/VJzqC5njDakqR3QmrKqsAZoxDOgRrjkXfKYAgq2XS0Bt3Ein7
         PJ6IRTmlHzbjDHAckU65Bgfdf1e4xtZZAyylGW8SwDI3/5R6dAFz9gahBtOOxuDgnFKi
         R35mzPQX/LCNype70CPyhttYpZUa0Jdou3/WudYRp9wm+spRkM/J+C0K0qP6+w5NH9+Y
         c/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786460218; x=1787065018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=ootTZ/P8xTqFrB7Iw0Dp5OWFULarNk/o5UYhGRLiSwyIRF6In2iiZQ3xOukcwR/wo1
         p+mhto1afjCLxRIw649dvC4MLPhpD/frhBU7hqqlYbZAvvNpriiKtmo8LdEb2FuOj4vJ
         q8Hvoy4n9dyGt6uZpAf7gusw4vEHjLnQ/2kVYjYWxeueB83q4OGt+CZ6knnUfjPM6Ovc
         1fG2m2nMJEplq5NCFlLAXsxQy7EWIB6pn78+HF//lWdEVMJDPpcoE4+euXpmUYD/L0OT
         w9OvZ2JXmNSBznDZ4wD/pAP4oIxTmDbvixK1mZEYsFAjHYOS/ihB+alU/xqJHeGC5IdP
         miXg==
X-Forwarded-Encrypted: i=1; AHgh+RrAJhCar2VSodclVzsBg7PHfzO1OzHtEjzgk+rnX0JPm/89J9hXIPfpIVW2iD7JQMAZTzYGuKPiPOoB@vger.kernel.org
X-Gm-Message-State: AOJu0YyQRESTi7jpp9ajwvGq9Z3XxYEEMyADViKSWQ+hM7+kJ+1rPaJC
	77scEcp+ICCFUQi1SZ1SDz+XptD7ak2MJNKLZIoqA/tkhxhLaR2AiqfFZskhu7crXcN9s1zpOC5
	qIJJN+QFZugweA196Kcx84nqG2OZy9KsdS0KAebznfrlRwWL1FiyKImb0e8Y6LMY=
X-Gm-Gg: AR+sD11dbtpZD70M7AuwmRRVVdLP76QrsGwUzU+bQXkX5GXIxtZ5Z3+pjGQUUao8R15
	rzTcbRvT6GP66efSHc8x50fajeIP1bmxpJjeQoli+J1BGY7WYswJmixtMjbeO77SM6ebyZGyOJw
	SR8XTgp8FEYatrtl2C07uFeLmZ0U4EVgfIc2V9BukBGM/ueoSbu8l8+lJK8HwjTcwv8YeVUJuuA
	tDcdmxAci+cOy5MzIDW1CD+RCJQZbpZzbzW8ouCnpBZhJ2wgqT39nIYdSy/TDTl5+TvkTonNJ3S
	4dc+t3l2JJMyxn9R1edeczPzi88nmIe9Xp0lbSqZYdSej1J6viXw/OTac/EYefc0POqNSQ==
X-Received: by 2002:a05:6808:3c4a:b0:497:df42:1de8 with SMTP id 5614622812f47-4b209d179a1mr219390b6e.1.1786460217716;
        Tue, 11 Aug 2026 07:56:57 -0700 (PDT)
X-Received: by 2002:a05:6808:3c4a:b0:497:df42:1de8 with SMTP id 5614622812f47-4b209d179a1mr219353b6e.1.1786460217282;
        Tue, 11 Aug 2026 07:56:57 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1fff65619sm928038b6e.8.2026.08.11.07.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:56:56 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: fs/ceph/dir: __{dir,dentry}_lease_check() returns an enum
Date: Tue, 11 Aug 2026 14:56:49 +0000
Message-Id: <20260811145649.2707379-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709104121.884183-1-max.kellermann@ionos.com>
References: <20260709104121.884183-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Max,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

