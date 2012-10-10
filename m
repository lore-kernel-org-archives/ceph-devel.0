From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: Determining RBD storage utilization
Date: Wed, 10 Oct 2012 13:49:05 -0400
Message-ID: <CACkq2mod_xtd8jsGM1Vkhfyn6+zoMrbNqnawpO-RGjKbZvy11Q@mail.gmail.com>
References: <CACkq2mr17KKvgE0tWTvfs0UqpwtBaEMo84Twfs+26duUmC62Mw@mail.gmail.com>
 <CAFtEh-fk1NHEOnmnG1aHpZhiNjApqyrsJOhrTrg9nWKxAiXG2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:53072 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160Ab2JJRt2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 13:49:28 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so710557qaa.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Oct 2012 10:49:27 -0700 (PDT)
In-Reply-To: <CAFtEh-fk1NHEOnmnG1aHpZhiNjApqyrsJOhrTrg9nWKxAiXG2Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Damien Churchill <damoxc@gmail.com>
Cc: ceph-devel@vger.kernel.org

Damien,

Thanks for solving that part of the mystery.  I can't believe I forgot
about that.  Thanks for the reminder and the clear explanation.

 - Travis

On Wed, Oct 10, 2012 at 1:28 PM, Damien Churchill <damoxc@gmail.com> wrote:
> On 10 October 2012 18:10, Travis Rhoden <trhoden@gmail.com> wrote:
>> Additionally, 500G - 7.5G != 467G (the number shown as Avail).  Why
>> the huge discrepancy?  I don't expect the numbers to add up exact due
>> to rounding from kB, MB, GB, etc, but they should be darn close, a la
>
> ext4 keeps some reserved space, 5% by default, for when the disk is
> full so you are still able to use the filesystem and clean it up.
>
> 500G * 0.05 = 25G
> 500G - (25G + 7.5G) = 467G
>
> Can't tell you where the 7.5G comes from though!
