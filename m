From: John Spray <john.spray@redhat.com>
Subject: Re: Consul
Date: Wed, 5 Nov 2014 15:07:06 +0000
Message-ID: <CAGd4Wr0ZT1Fey1z9Ju5RofL-oxJjkYywL_y7CZqm4bqkZ7BBgg@mail.gmail.com>
References: <54597169.2040006@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:56956 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197AbaKEPHJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Nov 2014 10:07:09 -0500
Received: by mail-la0-f43.google.com with SMTP id ge10so843675lab.30
        for <ceph-devel@vger.kernel.org>; Wed, 05 Nov 2014 07:07:06 -0800 (PST)
In-Reply-To: <54597169.2040006@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Consul is an interesting thing.  It had crossed my mind as a service
monitoring/discovery thing for cases where:
 * We have services other than Ceph in the IO path (e.g. apache, samba,=
 nfs)
 * The mons aren't happy (something to tell me which of my mons are up
even if there is no quorum)
 * There might be multiple Ceph clusters and you want one health state
reflecting both clusters

Most other monitoring tools (e.g. calamari) take the shortcut of
having a single central monitoring server -- something consul-esque
that is lighter-weight and more resilient could be a step forward for
cluster monitoring applications in more flexible and less enterprisey
environments.

The "whole separate service but it's lightweight so that's okay"
approach is embodied by Consul.  I think there is an alternative path
available that I think of as "we already have a consensus system,
let's make a way to plug monitoring applications on top of it" -- a
way to plug extra smarts into the mons could be interesting too.

John


On Wed, Nov 5, 2014 at 12:38 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ceph,
>
> While at the OpenStack summit Dan Bode spoke highly of Consul ( https=
://consul.io/intro/index.html ). Its scope is new to me. Each individua=
l feature is familiar but I'm not entirely sure if combining them into =
a single software is necessary. And I wonder how it could relate to Cep=
h. It is entirely possible that it does not even make sense to ask thes=
es questions ;-)
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
