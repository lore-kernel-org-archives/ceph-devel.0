From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: scoping daemon-helper replacement effort
Date: Fri, 29 Jul 2016 10:57:49 -0600
Message-ID: <CALqRxCwCyQD1wciR7SR5fmz5Jj8vpSEPwGr1B8p1_Ku-vEry_g@mail.gmail.com>
References: <CALqRxCxebmt1Anng1JxT-EU0RH8vFBvHaYs-5dFkgzg-5aWpEA@mail.gmail.com>
 <579B8A76.7020606@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35503 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283AbcG2Q5u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 12:57:50 -0400
Received: by mail-vk0-f51.google.com with SMTP id w127so58574668vkh.2
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 09:57:50 -0700 (PDT)
In-Reply-To: <579B8A76.7020606@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 29, 2016 at 10:55 AM, Josh Durgin <jdurgin@redhat.com> wrote:
> We're not using it to write data to the daemons, but as a way to kill them
> automatically if our ssh connection dies.
>
> With fast reimaging in the works, this will be irrelevant. Even now,
> it's not really useful for the usual scheduled jobs where the nodes are
> rebooted on failure. So I wouldn't worry about (2).

Oh! That's a lot simpler then, thanks Josh.

Fast re-imaging would be fantastic.

- Ken
