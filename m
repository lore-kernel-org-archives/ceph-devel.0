From: John Spray <john.spray@inktank.com>
Subject: Re: Erasure code properties in OSDMap
Date: Tue, 11 Mar 2014 12:21:39 +0000
Message-ID: <CAGd4Wr0_Bre-VXckOjkomoeyG8kCx9V_Q6CqSgYWDVhTAn2-sg@mail.gmail.com>
References: <531C5AD5.9060109@cloudwatt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:40252 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbaCKMVk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Mar 2014 08:21:40 -0400
Received: by mail-pa0-f50.google.com with SMTP id kq14so8766518pab.9
        for <ceph-devel@vger.kernel.org>; Tue, 11 Mar 2014 05:21:39 -0700 (PDT)
In-Reply-To: <531C5AD5.9060109@cloudwatt.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic.dachary@cloudwatt.com>
Cc: Samuel Just <sam.just@inktank.com>, Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

=46rom a high level view, what is the logical difference between the
crush ruleset and the properties object?  I'm thinking about how this
is exposed to users and tools, and it seems like both would be defined
as "the settings about data placement and encoding".  I certainly
understand the separation internally, I am just concerned about making
the interface we expose upwards more complicated by adding a new type
of object.

Is there really a need for a new type of properties object, instead of
storing these properties under the existing ruleset ID?

John


On Sun, Mar 9, 2014 at 12:13 PM, Loic Dachary
<loic.dachary@cloudwatt.com> wrote:
> Hi Sage & Sam,
>
> I quickly sketched the replacement of the pg_pool_t::properties map w=
ith a OSDMap::properties list of maps at https://github.com/dachary/cep=
h/commit/fe3819a62eb139fc3f0fa4282b4d22aecd8cd398 and explained how I s=
ee it at http://tracker.ceph.com/issues/7662#note-2
>
> It indeed makes things simpler, more consistent and easier to explain=
=2E I can provide an implementation this week if this seems reasonable =
to you.
>
> Cheers
>
> --
> Lo=C4=8Fc Dachary, Senior Developer
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
