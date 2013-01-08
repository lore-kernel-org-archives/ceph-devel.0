From: Gregory Farnum <greg@inktank.com>
Subject: Re: what could go wrong with two clusters on the same network?
Date: Tue, 8 Jan 2013 09:25:23 -0800
Message-ID: <CAPYLRziDmNMJc6soyTD-0E42Xu2hMZN3ZLN+ON-YsNYj0Vr9iA@mail.gmail.com>
References: <50E1662D.6000607@gmail.com>
	<50E1D924.3060505@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:38324 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab3AHRZY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 12:25:24 -0500
Received: by mail-qc0-f178.google.com with SMTP id j34so876334qco.37
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jan 2013 09:25:23 -0800 (PST)
In-Reply-To: <50E1D924.3060505@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Xiaopong Tran <xiaopong.tran@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Dec 31, 2012 at 10:27 AM, Wido den Hollander <wido@widodh.nl> wrote:
> Just make sure you use cephx (enabled by default in 0.55) so that you don't
> accidentally connect to the wrong cluster.

Use of cephx will provide an additional layer of protection for the
clients, but the OSDs and monitors (the only ones with disk state) do
record which cluster they belong to on first start-up, so if they end
up pointed to the wrong cluster they will refuse to connect. Just fyi!
:)
-Greg
