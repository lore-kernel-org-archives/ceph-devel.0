From: Damien Churchill <damoxc@gmail.com>
Subject: Re: Determining RBD storage utilization
Date: Wed, 10 Oct 2012 18:28:17 +0100
Message-ID: <CAFtEh-fk1NHEOnmnG1aHpZhiNjApqyrsJOhrTrg9nWKxAiXG2Q@mail.gmail.com>
References: <CACkq2mr17KKvgE0tWTvfs0UqpwtBaEMo84Twfs+26duUmC62Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64520 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab2JJR2T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 13:28:19 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so1090617wib.1
        for <ceph-devel@vger.kernel.org>; Wed, 10 Oct 2012 10:28:17 -0700 (PDT)
In-Reply-To: <CACkq2mr17KKvgE0tWTvfs0UqpwtBaEMo84Twfs+26duUmC62Mw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 10 October 2012 18:10, Travis Rhoden <trhoden@gmail.com> wrote:
> Additionally, 500G - 7.5G != 467G (the number shown as Avail).  Why
> the huge discrepancy?  I don't expect the numbers to add up exact due
> to rounding from kB, MB, GB, etc, but they should be darn close, a la

ext4 keeps some reserved space, 5% by default, for when the disk is
full so you are still able to use the filesystem and clean it up.

500G * 0.05 = 25G
500G - (25G + 7.5G) = 467G

Can't tell you where the 7.5G comes from though!
