From: Tren Blackburn <tren@eotnetworks.com>
Subject: Re: Ceph journal
Date: Wed, 31 Oct 2012 14:24:55 -0700
Message-ID: <CANLRBoyLHrLP_hg6DSbESk=JhfHa5rzHiyLHcAotUokRe--xVA@mail.gmail.com>
References: <CAJH6TXgdkq8ZMUpZYaTActMQ9wS76u7F=OUSvWnt9bS-crJwZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:45405 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933351Ab2JaVY4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 17:24:56 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so2035833vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 14:24:55 -0700 (PDT)
In-Reply-To: <CAJH6TXgdkq8ZMUpZYaTActMQ9wS76u7F=OUSvWnt9bS-crJwZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Oct 31, 2012 at 2:18 PM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> In a multi replica cluster (for example, replica = 3) is safe to set
> journal on a tmpfs?
> As fa as I understood with journal enabled all writes are wrote on
> journal and then to disk in a second time.
> If node hangs when datas are still on journal (and journal is not on a
> permanent disk), some data lost could happens.
>
> In a multi replica environment, other nodes should be able to write
> the same datas to disk, right? I this case, using a journal on a tmpfs
> should be safe enough.

Unless you're using btrfs which writes to the journal and osd fs
concurrently, if you lose the journal device (such as due to a
reboot), you've lost the osd device, requiring it to be remade and
re-added.

This is what I understand at least. If I'm wrong one of the devs will
strike me down I'm sure ;)

t.
