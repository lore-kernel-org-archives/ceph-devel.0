From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Designing a cluster guide
Date: Mon, 21 May 2012 17:05:03 +0200
Message-ID: <4FBA599F.5050000@profihost.ag>
References: <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro>	<4FB8A3A5.5090809@profihost.ag>	<CAJafhzRKCcSr37HjviAKRoMztv+twd5r+4Z99heUSy40G1rjag@mail.gmail.com>	<4FB8B1CE.1080803@icukhosting.co.uk> <CAJafhzQp1SeGZUdUL5XszaRw-0bU0f38r3ghLgmTvZrF0oB_=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:55942 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab2EUPFD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 11:05:03 -0400
In-Reply-To: <CAJafhzQp1SeGZUdUL5XszaRw-0bU0f38r3ghLgmTvZrF0oB_=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <christian@brunner-muc.de>
Cc: Tim O'Donovan <tim@icukhosting.co.uk>, ceph-devel@vger.kernel.org

Am 21.05.2012 16:59, schrieb Christian Brunner:
> Apart from that you should calculate the sum of the IOPS your guests
> genereate. In the end everything has to be written on your backend
> storage and is has to be able to deliver the IOPS.
How to measure the IOPs of a dedicated actual system?

Stefan
