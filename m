From: Florian Haas <florian@hastexo.com>
Subject: Re: Does radosgw really need to talk to an MDS?
Date: Mon, 2 Jul 2012 13:56:42 +0200
Message-ID: <CAPUexz9G7Y2dsyU3cTj19tAsVOhGx_fViHYJmnbeEVZJuCheVQ@mail.gmail.com>
References: <CAPUexz9T+qzyDwSs6f-Bq7_1d_jMfBBEwBHUpY+QdhZYTekmsQ@mail.gmail.com>
	<4FF1898E.7000202@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:45751 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab2GBL4n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 07:56:43 -0400
Received: by mail-qc0-f174.google.com with SMTP id o28so2839730qcr.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 04:56:42 -0700 (PDT)
In-Reply-To: <4FF1898E.7000202@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

On Mon, Jul 2, 2012 at 1:44 PM, Wido den Hollander <wido@widodh.nl> wrote:
> You are not allowing the RADOS Gateway to do anything on the MDS.
>
> There is no 'r',  'w' or 'x' permission which you are allowing. So there is
> nothing the rgw has access to on the MDS.

Yep, so we might as well leave off "--cap mds 'allow'"?

Florian
