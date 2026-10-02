Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958052D7DFE
	for <ceph-devel@vger.kernel.org>; Fri,  2 Oct 2026 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932521; cv=none; b=J22FGZG/zbyrd2/9r6fkeWeccQG3wIzW2unNuyiyH5lbqlgkG3RFcZe3Dq16c1AvL/crcpR+SL96A2gTKhEyTZTdS3FYWHJ7zaRJXmW1DKW++b2TssPdNVaP1+W/C/1neegMDMGVKYmXTQLV2JupbZvOvwa8XHPXHy5AzrhoJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932521; c=relaxed/simple;
	bh=nMn1O+PDMrNwRjty1x5wjfmZ+X54LGHrqWTJ4SVpj+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7P5t2Y9aCDF75loJPEWhZf/hFNpefFCF05bIYk9zkJStBxRCDfYfqjBkngNjW2qb31u7uTpWbXj1TPHCzGkZvyThskPLWSdZQBYOfY7vK1uTEbILWN2Yz63hNCSnMyT/sbM+1WYEw96qtl2EyWR7hmXWg0n9Bpl0CPErLasMeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCyqJHy0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgFqsTHm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCyqJHy0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgFqsTHm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790932518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmIgQWwjwTBclcrqQvixB4Voyr+ACRWufa3yKYILvsU=;
	b=TCyqJHy0rqvTG6iq2ddvXmRix5ayzd2f03OTeLFZ8bS+TopqkZZD75oAv1genwwIo4tPXT
	iYipFNSKsOPl5qHTjTGmQAcJkjFHnPoicv5OfdOZZTdx907l3jDyJo2Rhrs1YB6iJ+Zosx
	afgD8MECS7iF9YizHl9AzsaAv6Fv9pg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-tvo1D_I_MTyGjsPF7CIjcw-1; Fri, 02 Oct 2026 05:15:16 -0400
X-MC-Unique: tvo1D_I_MTyGjsPF7CIjcw-1
X-Mimecast-MFC-AGG-ID: tvo1D_I_MTyGjsPF7CIjcw_1790932516
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a22bf0so9412726a12.0
        for <ceph-devel@vger.kernel.org>; Fri, 02 Oct 2026 02:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790932515; x=1791537315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmIgQWwjwTBclcrqQvixB4Voyr+ACRWufa3yKYILvsU=;
        b=QgFqsTHmbIBCj6iiaQ1l0Ojg42GfweSiLDz/e3whH8tlarHBbVVtVIkCq/vkU7IDuu
         1qkYHw11qHWS/G05vVGXU9hSHoaPSYRdaqAZr9bJa+H4/CO6Oo2Rh7mcpSP2H6CTSERW
         Oi2OOt+Gh5DYJ2t9k0Q6ioA8vvM335h+ymqeEGlEQLatA52/z79aRPKOx3/M8uPoauNn
         ICIvj4utLyV0k9b9L0kqNND47hIUT5FPDJkcDmHezRNRgSm4ymu8tVLjHwtD4GLlbdIh
         3TWJf9YgmNWfvAdlWZuWVMyNnWOFjKq2YHs/0YFHnB1JmViuVHVAwwAM/jXuVhaYUABv
         ZuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932515; x=1791537315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zmIgQWwjwTBclcrqQvixB4Voyr+ACRWufa3yKYILvsU=;
        b=2Q4h1gCtRICyazltNhr7gVk67AfB6PoF2eeSatN7kIA8jBeIpN45TShGcex+idwGnU
         2cbbmtFeFaxdrczRXYbAwhOtyfswnUFCP7QnLBodDE8JZHrK/wB/hQc5MtLRq2Ea1Ob2
         vZEPK0v5WjrxyZkEUG4mORDkdjSMMsfJGViCpsEzdOhCkgPM8J9mCtD/ycq6mIam9NLg
         6zjqAUXypq7UoMTSZyH9L1COsZWnUtY+hItBH5Aq64sRLfXbsLHzY9+m9Om9ooyhe6NZ
         cAp+a1noznQxJR5rOb9vWyJK4bj87UD1qusQzE7sLtespoxE5V1B9rzF+zP4NRWTHcf3
         Rtfg==
X-Gm-Message-State: AFq9FYKVxLC7Yg5fXCiWcHFSuLZL6RMqgC3HRtmv5BxQfoMDtQZCqhig
	Ulq9Gd/jCfTiFutFg4eAkQh5KMvH9N0zqhp3Bpjt1eonoKm+fxiKTTSfYkCdzbVvvk4ggMXUBct
	XVV4HrbQ2y+eEXPc5z6TwL1HvEgBztCXm1S+lkRynAAKCx8IgAqpWsX9Nf9CiRY5YeKwdq82IaA
	==
X-Gm-Gg: AYBFou31mCdl8orxyAY/NBT7Iviwcjc9DLiwKBHxE7MYIiFzFbaDmnT50dXgW6fFcC1
	eYl8lbAUSzmWyYxv7tioU2jUHPKCYyBY1hPfUThxKHzLwVDzR1g7sPrNwIUKhpOKMVyI6JMucAH
	HXwq3CY6bflOPvlD9WTrb9H+yP5DaiicHG4EeVnLEtV1TNSd/TAH8co/92tRHY/PbHbQhAa8VCA
	UXqe9UrktqAtTdQYaQxIbbyL4ROHbYDpM1lW1/T9V7N/soLeSdinjiYE3/3YY8HqsJMSviMCCRZ
	Pc0LYt8nV012KQRZheZmtlgLsGBfdfcJdyV1LJmFpqbC9i79psBDsOO9bOkRKfuSbYN1zrK+tfw
	2N40PcwRc3rG+ZNRkdLcKG3tvTufimzQdXNrwmY/tawv7GovtoLnO8v2siZtS1/r/mCtzmR0pO1
	11NIRdf72I97sjsQ==
X-Received: by 2002:a05:6402:24ce:b0:6af:9a96:5324 with SMTP id 4fb4d7f45d1cf-6af9e35c495mr1132378a12.33.1790932515698;
        Fri, 02 Oct 2026 02:15:15 -0700 (PDT)
X-Received: by 2002:a05:6402:24ce:b0:6af:9a96:5324 with SMTP id 4fb4d7f45d1cf-6af9e35c495mr1132368a12.33.1790932515364;
        Fri, 02 Oct 2026 02:15:15 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6af9edb7f04sm576531a12.4.2026.10.02.02.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:15:14 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Dairui Zhang <zhangdairui@gmail.com>
Cc: ceph-devel@vger.kernel.org,
	security@kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Venky Shankar <vshankar@redhat.com>
Subject: Re: libceph: bound sparse-read consumption to received data in secure mode
Date: Fri,  2 Oct 2026 09:15:09 +0000
Message-Id: <20261002091509.1638081-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260920174525.1331992-1-zhangdairui@gmail.com>
References: <20260920174525.1331992-1-zhangdairui@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dairui,

NACK. Please respin.

  1. net/ceph/messenger_v2.c:1125: idx guard still copies last-page slack into a successful read
     Dairui, `idx >= in_enc_page_cnt` stops the OOB `in_enc_pages[idx]`
     walk, but it is not a bound on received bytes.
     Cap against the decrypted data segment, not the page count.

-- 
Alex Markuze

